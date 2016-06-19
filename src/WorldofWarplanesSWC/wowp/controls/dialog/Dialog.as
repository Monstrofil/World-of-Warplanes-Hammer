package wowp.controls.dialog
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import scaleform.clik.controls.Button;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import scaleform.clik.utils.Padding;
   import flash.text.TextFieldAutoSize;
   import flash.events.Event;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.KeyboardEvent;
   import flash.events.FocusEvent;
   import flash.utils.setTimeout;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   import scaleform.clik.events.InputEvent;
   import flash.display.InteractiveObject;
   import wowp.utils.display.ConstraintsInteger;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.utils.Constraints;
   
   public class Dialog extends UIComponent
   {
      
      public static var MAX_WIDTH:Number = 330;
      
      public static var MARGIN:Number = 6;
       
      public var txtTitle:TextField;
      
      public var closeBtn:Button;
      
      public var backGround:DisplayObject;
      
      public var buttons:Sprite;
      
      public var border:Sprite;
      
      public var content:Sprite;
      
      public var mcSeparator:Sprite;
      
      public var centerButtons:Boolean = false;
      
      private var _btns:Array;
      
      private var _tabOrderCounter:int = 1;
      
      private var _buttonXCounter:Number = 0;
      
      private var _padding:Padding;
      
      public function Dialog()
      {
         this._btns = [];
         super();
         name = "confirmationDialog";
         addEventListener(Event.RESIZE,this.resizeContentHandler);
         addEventListener("ENOUGH_RESOURCES",this.enoughResourcesHandler);
         addEventListener("NOT_ENOUGH_RESOURCES",this.notEnoughResourcesHandler);
         constraints = new ConstraintsInteger(this,ConstrainMode.REFLOW);
         if(this.closeBtn)
         {
            this.closeBtn.addEventListener(ButtonEvent.CLICK,this.closeHandler,false,0,true);
            constraints.addElement("closeBtn",this.closeBtn,Constraints.TOP | Constraints.RIGHT);
         }
         if(this.txtTitle)
         {
            this.txtTitle.mouseEnabled = false;
            constraints.addElement("txtTitle",this.txtTitle,Constraints.TOP | Constraints.LEFT);
         }
         if(this.mcSeparator)
         {
            constraints.addElement("mcSeparator",this.mcSeparator,Constraints.TOP | Constraints.RIGHT);
         }
         while(this.buttons.numChildren > 0)
         {
            this.buttons.removeChild(this.buttons.getChildAt(0));
         }
         addChild(this.buttons);
         var _loc1_:Rectangle = this.content.getBounds(this);
         var _loc2_:Rectangle = getBounds(this);
         this._padding = new Padding(_loc1_.top - _loc2_.top,_loc2_.right - _loc1_.right,_loc2_.bottom - _loc1_.bottom,_loc1_.left - _loc2_.left);
         this.content.scaleX = this.content.scaleY = 1;
      }
      
      public function setTitle(param1:String) : void
      {
         this.txtTitle.text = param1;
         this.txtTitle.autoSize = TextFieldAutoSize.LEFT;
      }
      
      private function enoughResourcesHandler(param1:Event) : void
      {
         var _loc2_:Button = this._btns[0] as Button;
         if(_loc2_)
         {
            _loc2_.enabled = true;
         }
      }
      
      private function notEnoughResourcesHandler(param1:Event) : void
      {
         var _loc2_:Button = this._btns[0] as Button;
         if(_loc2_)
         {
            _loc2_.enabled = false;
         }
      }
      
      public function setContent(param1:DisplayObject) : void
      {
         this.content.addChild(param1);
      }
      
      public function addButton(param1:Button) : void
      {
         param1.addEventListener(ButtonEvent.CLICK,this.buttonPressedHandler,false,0,true);
         this.buttons.addChild(param1);
         param1.x = this._buttonXCounter;
         param1.tabIndex = this._tabOrderCounter++;
         this._buttonXCounter = this._buttonXCounter + (param1.width + MARGIN);
         this._btns[this._btns.length] = param1;
      }
      
      override protected function configUI() : void
      {
         var focusedButton:Button = null;
         addEventListener(KeyboardEvent.KEY_DOWN,this.inputHandler,false,100);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         addEventListener(FocusEvent.FOCUS_IN,this.focusInHandler);
         tabEnabled = false;
         tabChildren = false;
         focusedButton = this.buttons.getChildAt(0) as Button;
         if(focusedButton)
         {
            setTimeout(function():void
            {
               if(stage)
               {
                  stage.focus = focusedButton;
               }
            },1);
         }
         this.redraw();
      }
      
      private function resizeContentHandler(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         this.redraw();
      }
      
      public function redraw() : void
      {
         var _loc1_:int = this.backGround.width;
         var _loc2_:int = this.backGround.height;
         this.content.y = Math.round(this._padding.top);
         var _loc3_:Number = this.backGround.height - this.buttons.y;
         this.backGround.height = Math.round(this._padding.vertical + this.content.height);
         this.backGround.width = Math.round(this._padding.horizontal + (this.content.width > this.buttons.width?this.content.width:this.buttons.width));
         if(this.border)
         {
            this.border.height = this.border.height + (this.backGround.height - _loc2_);
            this.border.width = this.border.width + (this.backGround.width - _loc1_);
         }
         var _loc4_:Rectangle = this.content.getBounds(this.content);
         this.content.x = Math.round((this.backGround.width - _loc4_.width) / 2) - _loc4_.left;
         this.buttons.y = Math.round(this.backGround.height - _loc3_);
         if(this.centerButtons)
         {
            this.buttons.x = Math.round((this.backGround.width - this.buttons.width) / 2);
         }
         else if(this.border)
         {
            this.buttons.x = Math.round(this.border.x + this.border.width - this.buttons.width - (this.border.height - this.buttons.y - this.buttons.height + this.border.y));
         }
         else
         {
            this.buttons.x = Math.round(this.backGround.width - this._padding.right - this.buttons.width);
         }
         constraints.update(this.backGround.width,this.backGround.height);
      }
      
      private function inputHandler(param1:KeyboardEvent) : void
      {
         if(param1.type == KeyboardEvent.KEY_DOWN)
         {
            if(param1.keyCode == Keyboard.ESCAPE)
            {
               param1.stopImmediatePropagation();
               this.closeHandler();
            }
         }
      }
      
      private function buttonPressedHandler(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(Boolean(_loc2_.data) && _loc2_.data.event != null)
         {
            dispatchEvent(new Event(_loc2_.data.event,true,true));
         }
      }
      
      private function closeHandler(param1:Event = null) : void
      {
         dispatchEvent(new Event(Event.CLOSE,true,true));
      }
      
      private function removedFromStageHandler(param1:Event) : void
      {
         removeEventListener(InputEvent.INPUT,handleInput);
         removeEventListener(KeyboardEvent.KEY_DOWN,this.inputHandler);
      }
      
      private function focusInHandler(param1:FocusEvent) : void
      {
         if(Boolean(param1.relatedObject == null) && Boolean(stage) && this._btns.length > 0)
         {
            stage.focus = this._btns[0] as InteractiveObject;
            param1.stopImmediatePropagation();
            param1.preventDefault();
         }
      }
   }
}
