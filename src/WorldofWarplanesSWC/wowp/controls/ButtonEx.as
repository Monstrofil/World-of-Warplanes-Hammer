package wowp.controls
{
   import scaleform.clik.controls.Button;
   import flash.display.Sprite;
   import wowp.utils.display.BitmapLoader;
   import flash.display.DisplayObject;
   import wowp.core.layers.tip.helper.TipsHelper;
   import wowp.utils.data.ioc.IUnitInjector;
   import flash.events.MouseEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.gfx.TextFieldEx;
   import scaleform.clik.utils.Constraints;
   import flash.events.KeyboardEvent;
   import wowp.core.eventPipe.EventPipe;
   import flash.events.FocusEvent;
   import flash.events.Event;
   import flash.ui.Keyboard;
   import scaleform.gfx.MouseEventEx;
   import scaleform.clik.events.ButtonEvent;
   import flash.display.MovieClip;
   
   public class ButtonEx extends Button
   {
       
      public var allowRollMouseEvents:Boolean = false;
      
      public var hit:Sprite;
      
      public var separator:Sprite;
      
      public var arrow:Sprite;
      
      public var mcIconLoader:BitmapLoader;
      
      private var _tip:DisplayObject;
      
      private var _tipHelper:TipsHelper;
      
      public var mcIcon:Sprite;
      
      public var mcSoon:wowp.controls.INovelty;
      
      public function ButtonEx()
      {
         super();
         if(_focusIndicator == null)
         {
            _focusIndicator = new MovieClip();
         }
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         this.data = data;
         mouseEnabled = Boolean(param1) || Boolean(this.allowRollMouseEvents);
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:Class = null;
         var _loc3_:IUnitInjector = null;
         super.data = param1;
         if(param1 != null)
         {
            if(Boolean(param1.hasOwnProperty("isLocked")) || Boolean(param1.hasOwnProperty("isAction")))
            {
               if(param1.isLocked)
               {
                  this.lockButton();
               }
               else
               {
                  this.unlockButton();
               }
            }
            if(param1.hasOwnProperty("enabled"))
            {
               super.enabled = param1.enabled;
            }
            if(param1.hasOwnProperty("showTooltipOnDisabled"))
            {
               if(enabled)
               {
                  addEventListener(MouseEvent.MOUSE_DOWN,this.handleMousePress,false,0,true);
                  addEventListener(MouseEvent.CLICK,this.handleMouseRelease,false,0,true);
                  addEventListener(MouseEvent.DOUBLE_CLICK,this.handleMouseRelease,false,0,true);
                  addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
               }
               else
               {
                  mouseEnabled = mouseChildren = param1.showTooltipOnDisabled;
                  removeEventListener(MouseEvent.MOUSE_DOWN,this.handleMousePress,false);
                  removeEventListener(MouseEvent.CLICK,this.handleMouseRelease,false);
                  removeEventListener(MouseEvent.DOUBLE_CLICK,this.handleMouseRelease,false);
                  removeEventListener(InputEvent.INPUT,this.handleInput,false);
               }
            }
            if(param1.hasOwnProperty("label"))
            {
               label = param1.label;
            }
            if(param1.hasOwnProperty("tooltip"))
            {
               this._tip = UIFactory.createToolTip(param1.tooltip);
               if(this._tipHelper != null)
               {
                  this._tipHelper.registerStaticTip(this,this._tip);
               }
            }
            if(param1.hasOwnProperty("tooltipClass"))
            {
               _loc2_ = param1.tooltipClass as Class;
               if(_loc2_)
               {
                  _loc3_ = param1.tooltipClassInjector as IUnitInjector;
                  this._tip = TooltipFactory.createTooltip(_loc2_,_loc3_);
                  if(this._tipHelper != null)
                  {
                     this._tipHelper.registerStaticTip(this,this._tip);
                  }
               }
            }
            if(param1.hasOwnProperty("preventAutosizing"))
            {
               preventAutosizing = param1.preventAutosizing;
            }
            validateNow();
            invalidateData();
            invalidateSize();
            if(this.mcSoon)
            {
               this.mcSoon.update(null,true);
            }
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(data)
         {
            if(Boolean(this.mcIconLoader) && Boolean(data.hasOwnProperty("bitmap")))
            {
               this.mcIconLoader.onResourceLoaded(data["bitmap"]);
            }
         }
         if(this.mcIcon)
         {
            this.mcIcon.scaleX = 1 / scaleX;
            this.mcIcon.scaleY = 1 / scaleY;
            this.mcIcon.x = width / 2;
         }
         if(this.mcSoon)
         {
            this.mcSoon.scaleX = 1 / scaleX;
            this.mcSoon.scaleY = 1 / scaleY;
         }
      }
      
      override protected function updateText() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Object = null;
         if(_label != null && textField != null)
         {
            textField.htmlText = _label;
         }
         if(super.data == null)
         {
            return;
         }
         if(super.data.hasOwnProperty("imageSubstitution"))
         {
            _loc1_ = [];
            if(super.data.imageSubstitution is Array)
            {
               _loc1_ = super.data.imageSubstitution as Array;
            }
            else
            {
               _loc1_ = [super.data.imageSubstitution];
            }
            for each(_loc2_ in _loc1_)
            {
               TextFieldEx.setImageSubstitutions(textField,_loc2_);
            }
         }
      }
      
      public function lockButton() : void
      {
         if(Boolean(data) && Boolean(data.hasOwnProperty("isAction")) && data.isAction == true)
         {
            statesDefault = Vector.<String>(["soon_","soon_locked_"]);
         }
         else
         {
            statesDefault = Vector.<String>(["locked_",""]);
         }
         statesSelected = Vector.<String>(["locked_selected_",""]);
         invalidateState();
      }
      
      public function unlockButton() : void
      {
         if(Boolean(data) && Boolean(data.hasOwnProperty("isAction")) && data.isAction == true)
         {
            statesDefault = Vector.<String>(["soon_"]);
         }
         else
         {
            statesDefault = Vector.<String>([""]);
         }
         statesSelected = Vector.<String>(["selected_","","soon_selected_"]);
         invalidateState();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.hit)
         {
            hitArea = this.hit;
            constraints.addElement("hit",this.hit,Constraints.ALL);
         }
         if(this.separator)
         {
            constraints.addElement("separator",this.separator,Constraints.LEFT);
         }
         if(this.arrow)
         {
            constraints.addElement("arrow",this.arrow,Constraints.RIGHT);
         }
         removeEventListener(InputEvent.INPUT,this.handleInput,false);
         addEventListener(KeyboardEvent.KEY_DOWN,this.keydownHandler,false,0,true);
         addEventListener(KeyboardEvent.KEY_UP,this.keydownHandler,false,0,true);
         new EventPipe().addEventListener(KeyboardEvent.KEY_UP,this.keydownHandler,true,0,true);
         addEventListener(FocusEvent.FOCUS_OUT,this.handleFocusOut,false,0,true);
      }
      
      private function removedFromStageHandler(param1:Event) : void
      {
         if(this._tipHelper)
         {
            this._tipHelper.dispose();
            this._tipHelper = null;
         }
      }
      
      private function addedToStageHandler(param1:Event) : void
      {
         this._tipHelper = new TipsHelper(stage);
         if(this._tip != null)
         {
            this._tipHelper.registerStaticTip(this,this._tip);
         }
      }
      
      private function handleFocusOut(param1:FocusEvent) : void
      {
         if(!enabled)
         {
            return;
         }
         if(_pressedByKeyboard)
         {
            handleRelease(0);
         }
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         if(_pressedByKeyboard)
         {
            return;
         }
         super.handleMouseRelease(param1);
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         if(_pressedByKeyboard)
         {
            return;
         }
         if(!enabled)
         {
            return;
         }
         if(this.mcSoon)
         {
            this.mcSoon.scaleX = this.mcSoon.scaleY = 0.1;
         }
         super.handleMousePress(param1);
      }
      
      private function keydownHandler(param1:KeyboardEvent) : void
      {
         if(_mouseDown > 0)
         {
            return;
         }
         if(param1.target != this)
         {
            if(param1.type == KeyboardEvent.KEY_UP)
            {
               if(_pressedByKeyboard)
               {
                  handleRelease(0);
               }
            }
         }
         else if(param1.keyCode == Keyboard.ENTER)
         {
            if(param1.type == KeyboardEvent.KEY_DOWN)
            {
               param1.preventDefault();
               param1.stopImmediatePropagation();
               handlePress(0);
            }
            if(param1.type == KeyboardEvent.KEY_UP)
            {
               if(_pressedByKeyboard)
               {
                  param1.preventDefault();
                  param1.stopImmediatePropagation();
                  handleRelease(0);
               }
            }
         }
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         if(this.mcSoon)
         {
            this.mcSoon.scaleX = this.mcSoon.scaleY = 0.1;
         }
         super.handleMouseRollOver(param1);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null?uint(0):uint(_loc2_.mouseIdx);
         if(this.mcSoon)
         {
            this.mcSoon.scaleX = this.mcSoon.scaleY = 0.1;
         }
         if(param1.buttonDown)
         {
            dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_OUT));
            if(Boolean(_mouseDown & 1 << _loc3_))
            {
               if(stage != null)
               {
                  stage.addEventListener(MouseEvent.MOUSE_UP,handleReleaseOutside,false,0,true);
               }
               else
               {
                  _autoRepeatEvent = null;
                  _mouseDown = _mouseDown ^ 1 << _loc3_;
               }
            }
            if(Boolean(lockDragStateChange) || !enabled)
            {
               return;
            }
            if(Boolean(_focused) || Boolean(_displayFocus))
            {
               setState(_focusIndicator == null?"release":"kb_release");
            }
            else
            {
               setState("out");
            }
         }
         else
         {
            if(!enabled)
            {
               return;
            }
            if(Boolean(_focused) || Boolean(_displayFocus))
            {
               if(_focusIndicator != null)
               {
                  setState("out");
               }
            }
            else
            {
               setState("out");
            }
         }
      }
      
      override protected function updateAfterStateChange() : void
      {
         if(!initialized)
         {
            return;
         }
         if(constraints != null && !constraintsDisabled)
         {
            if(textField)
            {
               constraints.updateElement("textField",textField);
            }
            if(this.hit)
            {
               constraints.updateElement("hit",this.hit);
            }
            if(this.separator)
            {
               constraints.updateElement("separator",this.separator);
            }
            if(this.arrow)
            {
               constraints.updateElement("arrow",this.arrow);
            }
         }
         if(this.mcSoon)
         {
            if(this.mcSoon.state == "empty")
            {
               this.mcSoon.update(null,true);
            }
         }
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(!enabled)
         {
            return;
         }
         super.handleInput(param1);
      }
   }
}
