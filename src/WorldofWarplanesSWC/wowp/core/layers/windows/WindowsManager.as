package wowp.core.layers.windows
{
   import flash.display.Sprite;
   import scaleform.clik.utils.Padding;
   import flash.utils.Dictionary;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import wowp.core.layers.windows.events.ShowWindowEvent;
   import wowp.core.layers.windows.events.HideWindowEvent;
   import flash.events.FocusEvent;
   import scaleform.gfx.SystemEx;
   import scaleform.clik.core.UIComponent;
   import flash.geom.Rectangle;
   import scaleform.clik.utils.Constraints;
   import flash.display.DisplayObject;
   import wowp.core.layers.context.events.RemoveContextMenuEvent;
   import flash.events.MouseEvent;
   import wowp.chat.IChatWindow;
   import flash.utils.describeType;
   import flash.display.Stage;
   import flash.display.InteractiveObject;
   import wowp.utils.domain.getDefinition;
   
   public class WindowsManager extends Sprite implements IWindowsManager
   {
      
      private static var _counter:uint = 0;
       
      private var _stagePadding:Padding;
      
      private var _boundsManager:wowp.core.layers.windows.WindowBoundsManager;
      
      private var _modal:Sprite;
      
      private var _middleContainer:Sprite;
      
      private var _regular:Sprite;
      
      private var _blocker:Sprite;
      
      private var _align:Dictionary;
      
      private var _prevWidth:Number;
      
      private var _prevHeight:Number;
      
      public function WindowsManager()
      {
         this._stagePadding = new Padding();
         this._boundsManager = new wowp.core.layers.windows.WindowBoundsManager();
         this._align = new Dictionary();
         super();
         mouseEnabled = false;
         this._regular = new Sprite();
         this._regular.mouseEnabled = false;
         this._regular.name = "regularWindows";
         addChild(this._regular);
         this._blocker = new getDefinition("ComDimmer",loaderInfo)() as Sprite;
         this._middleContainer = new Sprite();
         this._middleContainer.mouseEnabled = false;
         this._middleContainer.name = "middleContainer";
         addChild(this._middleContainer);
         this._modal = new Sprite();
         this._modal.name = "modalWindows";
         this._modal.mouseEnabled = false;
         addChild(this._modal);
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      public function get stagePadding() : Padding
      {
         return this._stagePadding;
      }
      
      public function set stagePadding(param1:Padding) : void
      {
         this._stagePadding = param1;
         this.resizeHandler(null);
      }
      
      public function get middleContainer() : DisplayObjectContainer
      {
         return this._middleContainer;
      }
      
      private function addedToStageHandler(param1:Event) : void
      {
         this._prevWidth = stage.stageWidth;
         this._prevHeight = stage.stageHeight;
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         stage.addEventListener(Event.RESIZE,this.resizeHandler);
         this.resizeHandler(null);
         stage.addEventListener(ShowWindowEvent.TYPE,this.showWindowHandler);
         stage.addEventListener(HideWindowEvent.TYPE,this.hideWindowHandler);
         stage.addEventListener(FocusEvent.FOCUS_OUT,this.focusInvalidateHandler);
         stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.focusInvalidateHandler);
         stage.addEventListener(FocusEvent.KEY_FOCUS_CHANGE,this.focusInvalidateHandler);
         stage.focus = null;
      }
      
      private function removedFromStageHandler(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         stage.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         stage.removeEventListener(Event.RESIZE,this.resizeHandler);
         stage.removeEventListener(ShowWindowEvent.TYPE,this.showWindowHandler);
         stage.removeEventListener(HideWindowEvent.TYPE,this.hideWindowHandler);
         stage.removeEventListener(FocusEvent.FOCUS_OUT,this.focusInvalidateHandler);
         stage.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.focusInvalidateHandler);
         stage.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE,this.focusInvalidateHandler);
         if(stage.focus)
         {
            stage.focus.removeEventListener(Event.REMOVED_FROM_STAGE,this.focusedRemovedFromStageHandler);
         }
         this._boundsManager.clear();
      }
      
      private function showWindowHandler(param1:ShowWindowEvent) : void
      {
         trace("[HANGAR] WindowsManager::showWindow:",param1.window + " " + SystemEx.describeType(param1.window),", isModal:",param1.isModal,", openOnBottom:",param1.openOnBottom);
         if(param1.window is UIComponent)
         {
            (param1.window as UIComponent).validateNow();
         }
         if(param1.isModal)
         {
            this.addModalWindow(param1.window,param1.edges,param1.putUnder);
         }
         else
         {
            this.addWindow(param1.window,param1.edges,param1.sortOnMouseDown,param1.openOnBottom);
         }
         var _loc2_:Rectangle = param1.window.getBounds(param1.window);
         if((param1.edges & Constraints.CENTER_H) > 0)
         {
            param1.window.x = int(stage.stageWidth / 2 - (_loc2_.right + _loc2_.left) / 2);
         }
         if((param1.edges & Constraints.CENTER_V) > 0)
         {
            param1.window.y = int(stage.stageHeight / 2 - (_loc2_.bottom + _loc2_.top) / 2);
         }
         this.focusInvalidateHandler(null);
      }
      
      private function hideWindowHandler(param1:HideWindowEvent) : void
      {
         trace("[HANGAR] WindowsManager::hideWindow:",param1.window + " " + SystemEx.describeType(param1.window));
         if(param1.window.parent == this._modal)
         {
            this.removeModalWindow(param1.window);
         }
         else if(param1.window.parent == this._regular)
         {
            this.removeWindow(param1.window);
         }
         else
         {
            trace("[HANGAR] Can\'t find given window:",param1.window);
         }
      }
      
      private function registerWindow(param1:DisplayObject, param2:uint = 0) : void
      {
         if(param1.name == null || param1.name == "")
         {
            param1.name = uint(_counter++).toString();
         }
         this._align[param1] = param2;
         this.nameIt(param1);
      }
      
      public function addWindow(param1:DisplayObject, param2:uint = 0, param3:Boolean = true, param4:Boolean = false) : void
      {
         dispatchEvent(new RemoveContextMenuEvent());
         if(param1.parent != this._regular)
         {
            if(param3)
            {
               param1.addEventListener(MouseEvent.MOUSE_DOWN,this.windowMouseDownHandler);
            }
            this._regular.addChild(param1);
         }
         this.registerWindow(param1,param2);
         if(param4)
         {
            this.bringToBottom(param1);
         }
         else
         {
            this.bringToTop(param1);
         }
         this._boundsManager.registerWindow(param1);
      }
      
      public function addChatWindow(param1:IChatWindow) : void
      {
         var _loc3_:int = 0;
         var _loc2_:DisplayObject = param1 as DisplayObject;
         if(param1.isTop)
         {
            this.addWindow(_loc2_,0,false);
         }
         else
         {
            _loc3_ = this._regular.numChildren - 2;
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            this.registerWindow(_loc2_);
            this._regular.addChildAt(_loc2_,_loc3_);
         }
      }
      
      private function nameIt(param1:DisplayObject) : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         try
         {
            _loc2_ = describeType(param1).@name.toString();
            _loc3_ = _loc2_.split("::");
            if(_loc3_.length > 1)
            {
               param1.name = "mc" + _loc3_[1];
            }
            else
            {
               param1.name = "mc" + _loc2_;
            }
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      public function removeWindow(param1:DisplayObject) : void
      {
         if(param1.parent == this._regular)
         {
            this._boundsManager.removeWindow(param1);
            if(param1.hasEventListener(MouseEvent.MOUSE_DOWN))
            {
               param1.removeEventListener(MouseEvent.MOUSE_DOWN,this.windowMouseDownHandler);
            }
            this._regular.removeChild(param1);
            delete this._align[param1];
            stage.focus = null;
         }
         else
         {
            trace("[HANGAR] RegularWindowsManager: can\'t find given window",param1);
         }
      }
      
      public function bringToTop(param1:DisplayObject) : void
      {
         if(param1.parent == this._regular)
         {
            this._regular.setChildIndex(param1,this._regular.numChildren - 1);
         }
         else
         {
            trace("[HANGAR] WindowsManager::bringToTop: can\'t find given window",param1);
         }
         stage.focus = null;
      }
      
      public function bringToBottom(param1:DisplayObject) : void
      {
         if(param1.parent == this._regular)
         {
            this._regular.setChildIndex(param1,0);
         }
         else
         {
            trace("[HANGAR] WindowsManager::bringToBottom: can\'t find given window",param1);
         }
         if(this._regular.numChildren == 1)
         {
            stage.focus = null;
         }
      }
      
      public function closeAllModal() : void
      {
         var _loc2_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < this._modal.numChildren)
         {
            _loc1_.push(this._modal.getChildAt(_loc2_));
            _loc2_++;
         }
         for each(_loc3_ in _loc1_)
         {
            _loc3_.dispatchEvent(new Event(Event.CLOSE));
         }
         _loc2_ = 0;
         while(_loc2_ < this._modal.numChildren)
         {
            _loc1_.push(this._modal.getChildAt(_loc2_));
            _loc2_++;
         }
         for each(_loc3_ in _loc1_)
         {
            this.removeModalWindow(_loc3_);
         }
      }
      
      public function addModalWindow(param1:DisplayObject, param2:uint = 0, param3:String = null) : void
      {
         var _loc4_:int = 0;
         var _loc5_:DisplayObject = null;
         dispatchEvent(new RemoveContextMenuEvent());
         if(param3 != null)
         {
            _loc4_ = 0;
            while(_loc4_ < this._modal.numChildren)
            {
               _loc5_ = this._modal.getChildAt(_loc4_);
               if(_loc5_)
               {
                  if(_loc5_.name == param3)
                  {
                     this._modal.addChildAt(param1,_loc4_);
                     break;
                  }
               }
               _loc4_++;
            }
         }
         if(param1.parent != this._modal)
         {
            this._modal.addChild(param1);
         }
         if(this._modal.getChildAt(this._modal.numChildren - 1) == param1)
         {
            this.block(param1);
         }
         this.registerWindow(param1,param2);
      }
      
      public function removeModalWindow(param1:DisplayObject) : void
      {
         if(param1.parent == this._modal)
         {
            this._modal.removeChild(param1);
            delete this._align[param1];
            this.unblock();
            stage.focus = null;
         }
         else
         {
            trace("[HANGAR] WindowsManager: can\'t find given modal window",param1);
         }
      }
      
      private function windowMouseDownHandler(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.currentTarget as DisplayObject;
         if(_loc2_ != null && _loc2_.parent != null && _loc2_.parent.getChildIndex(_loc2_) != _loc2_.parent.numChildren - 1)
         {
            this.bringToTop(_loc2_);
         }
      }
      
      public function updateDimmer(param1:Stage) : void
      {
         this._blocker.width = param1.stageWidth + 4;
         this._blocker.height = param1.stageHeight + 4;
         this._blocker.x = this._blocker.y = -2;
      }
      
      private function block(param1:DisplayObject) : void
      {
         if(param1.parent != this._modal)
         {
            return;
         }
         this.removeBlocker();
         this.updateDimmer(stage);
         var _loc2_:int = this._modal.getChildIndex(param1);
         this._modal.addChildAt(this._blocker,_loc2_);
      }
      
      private function removeBlocker() : void
      {
         if(this._blocker.parent)
         {
            this._blocker.parent.removeChild(this._blocker);
         }
      }
      
      private function unblock() : void
      {
         this.removeBlocker();
         if(this._modal.numChildren > 0)
         {
            this.block(this._modal.getChildAt(this._modal.numChildren - 1));
         }
      }
      
      private function resizeHandler(param1:Event) : void
      {
         var _loc4_:* = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:uint = 0;
         if(this._modal.numChildren > 0)
         {
            this.updateDimmer(stage);
         }
         var _loc2_:Number = stage.stageWidth - this._prevWidth;
         var _loc3_:Number = stage.stageHeight - this._prevHeight;
         for(_loc4_ in this._align)
         {
            _loc5_ = _loc4_ as DisplayObject;
            if(_loc5_)
            {
               _loc6_ = this._align[_loc5_];
               if((_loc6_ & Constraints.CENTER_H) > 0)
               {
                  _loc5_.x = _loc5_.x + _loc2_ / 2;
               }
               if((_loc6_ & Constraints.CENTER_V) > 0)
               {
                  _loc5_.y = _loc5_.y + _loc3_ / 2;
               }
               if((_loc6_ & Constraints.BOTTOM) > 0)
               {
                  _loc5_.y = _loc5_.y + _loc3_;
               }
               if((_loc6_ & Constraints.RIGHT) > 0)
               {
                  _loc5_.x = _loc5_.x + _loc2_;
               }
               if(_loc5_ is UIComponent)
               {
                  (_loc5_ as UIComponent).validateNow();
               }
            }
         }
         this._boundsManager.setSize(new Rectangle(this._stagePadding.left,this._stagePadding.top,stage.stageWidth - this._stagePadding.right,stage.stageHeight - this._stagePadding.bottom));
         this._prevWidth = stage.stageWidth;
         this._prevHeight = stage.stageHeight;
      }
      
      private function focusInvalidateHandler(param1:FocusEvent) : void
      {
         stage.addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      
      private function validateFocus() : void
      {
         var _loc1_:InteractiveObject = null;
         if(stage.focus == null || stage.focus.stage == null)
         {
            if(this._modal.numChildren > 0)
            {
               stage.focus = this._modal.getChildAt(this._modal.numChildren - 1) as InteractiveObject;
            }
            else if(this._regular.numChildren > 0)
            {
               stage.focus = this._regular.getChildAt(this._regular.numChildren - 1) as InteractiveObject;
            }
            else
            {
               stage.focus = parent;
            }
         }
         if(stage.focus != null && this._modal.numChildren > 0)
         {
            _loc1_ = this._modal.getChildAt(this._modal.numChildren - 1) as InteractiveObject;
            if(_loc1_ != stage.focus)
            {
               if(_loc1_ is DisplayObjectContainer)
               {
                  if(!(_loc1_ as DisplayObjectContainer).contains(stage.focus))
                  {
                     stage.focus = _loc1_;
                  }
               }
               else
               {
                  stage.focus = _loc1_;
               }
            }
         }
         trace("[HANGAR] WindowsManager::setFocus:",stage.focus == null?"null":stage.focus.name + " " + SystemEx.describeType(stage.focus));
         if(stage.focus)
         {
            stage.focus.addEventListener(Event.REMOVED_FROM_STAGE,this.focusedRemovedFromStageHandler,false,0,true);
         }
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         stage.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         this.validateFocus();
      }
      
      private function focusedRemovedFromStageHandler(param1:Event) : void
      {
         if(stage)
         {
            if(stage.focus == param1.currentTarget)
            {
               stage.focus = null;
            }
         }
      }
   }
}
