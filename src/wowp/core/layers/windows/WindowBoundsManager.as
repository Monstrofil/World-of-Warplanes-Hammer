package wowp.core.layers.windows
{
   import flash.geom.Rectangle;
   import flash.display.DisplayObject;
   import wowp.hangar.events.UICommonEvents;
   import scaleform.clik.utils.Padding;
   import wowp.controls.IDraggingPadingAccessor;
   import flash.events.Event;
   import flash.display.DisplayObjectContainer;
   
   public class WindowBoundsManager
   {
       
      protected var _rectangle:Rectangle;
      
      protected var _windows:Vector.<DisplayObject>;
      
      public function WindowBoundsManager()
      {
         this._rectangle = new Rectangle();
         this._windows = new Vector.<DisplayObject>();
         super();
      }
      
      public function clear() : void
      {
         var _loc1_:DisplayObject = null;
         while(this._windows.length > 0)
         {
            _loc1_ = this._windows.pop();
            if(_loc1_)
            {
               _loc1_.removeEventListener(UICommonEvents.DRAG,this.windowDragHandler);
            }
         }
      }
      
      public function setSize(param1:Rectangle) : void
      {
         this._rectangle = param1;
         var _loc2_:int = 0;
         var _loc3_:int = this._windows.length;
         while(_loc2_ < _loc3_)
         {
            this.processWindow(this._windows[_loc2_]);
            _loc2_++;
         }
      }
      
      public function registerWindow(param1:DisplayObject) : void
      {
         if(this._windows.indexOf(param1) == -1)
         {
            this._windows.push(param1);
            param1.addEventListener(UICommonEvents.DRAG,this.windowDragHandler);
            this.processWindow(param1);
         }
      }
      
      public function removeWindow(param1:DisplayObject) : void
      {
         var _loc2_:int = this._windows.indexOf(param1);
         if(_loc2_ != -1)
         {
            this._windows.splice(_loc2_,1);
         }
      }
      
      public function processWindow(param1:DisplayObject) : void
      {
         var _loc3_:Padding = null;
         if(param1.stage == null)
         {
            return;
         }
         var _loc2_:Rectangle = param1.getBounds(param1.stage);
         if(param1 is IDraggingPadingAccessor)
         {
            _loc3_ = (param1 as IDraggingPadingAccessor).draggingPaddingAccessor;
            _loc2_.right = _loc2_.right - _loc3_.right;
            _loc2_.left = _loc2_.left + _loc3_.left;
            _loc2_.top = _loc2_.top + _loc3_.top;
            _loc2_.bottom = _loc2_.bottom - _loc3_.bottom;
         }
         if(_loc2_.left < this._rectangle.left)
         {
            param1.x = param1.x - int(_loc2_.left - this._rectangle.left);
         }
         if(_loc2_.right > this._rectangle.width)
         {
            param1.x = param1.x - int(_loc2_.right - this._rectangle.width);
         }
         if(_loc2_.top < this._rectangle.top)
         {
            param1.y = param1.y - int(_loc2_.top - this._rectangle.top);
         }
         if(_loc2_.bottom > this._rectangle.height)
         {
            param1.y = param1.y - int(_loc2_.bottom - this._rectangle.height);
         }
      }
      
      private function windowDragHandler(param1:Event) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:DisplayObjectContainer = null;
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(_loc2_)
         {
            _loc4_ = 0;
            _loc5_ = this._windows.length;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = this._windows[_loc4_] as DisplayObjectContainer;
               if(Boolean(_loc6_) && Boolean(_loc6_.contains(_loc2_)))
               {
                  this.processWindow(_loc6_);
                  break;
               }
               _loc4_++;
            }
         }
      }
   }
}
