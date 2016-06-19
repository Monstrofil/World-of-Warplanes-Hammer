package wowp.controls
{
   import wowp.utils.domain.getDefinition;
   import scaleform.clik.controls.Label;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import scaleform.clik.controls.Button;
   import wowp.controls.dialog.Dialog;
   import flash.display.DisplayObject;
   import scaleform.clik.core.UIComponent;
   import flash.events.IEventDispatcher;
   import wowp.core.layers.windows.events.ShowWindowEvent;
   import flash.events.Event;
   import wowp.core.layers.windows.events.HideWindowEvent;
   import wowp.core.LocalizationManager;
   import scaleform.clik.utils.Constraints;
   import wowp.core.eventPipe.EventPipe;
   import flash.display.Sprite;
   import scaleform.clik.utils.Padding;
   
   public class UIFactory
   {
      
      private static const COST_CONFIRMATION_CLASS:String = "comCostConfirmation";
      
      public static const TYPE_COST_CONFIRMATION_NO_MESSAGES:int = 0;
      
      public static const TYPE_COST_CONFIRMATION_REGULAR:int = 1;
      
      public static const TYPE_COST_CONFIRMATION_YES_NO_CANCEL:int = 2;
       
      public function UIFactory()
      {
         super();
      }
      
      public static function create(param1:String) : Object
      {
         return new (getDefinition(param1) as Class)();
      }
      
      public static function createLabel(param1:String, param2:String = "left") : Label
      {
         var _loc3_:Label = new (getDefinition("comLabelLeftBorder") as Class)();
         _loc3_.htmlText = param1;
         _loc3_.autoSize = param2;
         return _loc3_;
      }
      
      public static function createTextField(param1:Boolean = true, param2:String = "left") : TextField
      {
         var _loc3_:String = null;
         switch(param2)
         {
            case TextFieldAutoSize.RIGHT:
               _loc3_ = "RightTextFieldHolder";
               break;
            case TextFieldAutoSize.CENTER:
               _loc3_ = "CenterTextFieldHolder";
               break;
            default:
               _loc3_ = "LeftTextFieldHolder";
         }
         var _loc4_:TextField = new (getDefinition(_loc3_) as Class)().textField as TextField;
         _loc4_.autoSize = param2;
         _loc4_.multiline = param1;
         return _loc4_;
      }
      
      public static function createButton(param1:String) : Button
      {
         var _loc2_:Button = new (getDefinition("comBtnSmall") as Class)();
         var _loc3_:Button = new (getDefinition("comBtnSmall") as Class)();
         param1 = " " + param1 + " ";
         _loc2_.textField.text = param1;
         _loc2_.textField.autoSize = TextFieldAutoSize.LEFT;
         if(_loc2_.textField.width > _loc3_.textField.width)
         {
            _loc3_.autoSize = TextFieldAutoSize.CENTER;
         }
         _loc3_.label = param1;
         return _loc3_;
      }
      
      public static function createDialog(param1:String, param2:Array, param3:DisplayObject = null, param4:Boolean = true, param5:String = "comDialog") : Dialog
      {
         var _loc7_:Object = null;
         var _loc8_:Button = null;
         var _loc6_:Dialog = new (getDefinition(param5) as Class)();
         _loc6_.setTitle(param1);
         if(param3)
         {
            _loc6_.setContent(param3);
            if(param3 is UIComponent)
            {
               (param3 as UIComponent).validateNow();
            }
         }
         for each(_loc7_ in param2)
         {
            _loc8_ = UIFactory.createButton(_loc7_.label);
            _loc8_.name = _loc7_.event;
            _loc8_.data = _loc7_;
            _loc8_.validateNow();
            _loc6_.addButton(_loc8_);
         }
         if(!param4)
         {
            _loc6_.removeChild(_loc6_.closeBtn);
         }
         return _loc6_;
      }
      
      public static function createConfirmationDialog(param1:IEventDispatcher, param2:String, param3:String, param4:Function = null, param5:Function = null) : Dialog
      {
         var dlg:Dialog = null;
         var confirmHandler:Function = null;
         var cancelHandler:Function = null;
         var removedFromStageHandler:Function = null;
         var eventDispatcher:IEventDispatcher = param1;
         var title:String = param2;
         var message:String = param3;
         var onConfirm:Function = param4;
         var onCancel:Function = param5;
         confirmHandler = function(param1:Event):void
         {
            param1.stopImmediatePropagation();
            eventDispatcher.dispatchEvent(new HideWindowEvent(param1.currentTarget as DisplayObject));
            if(onConfirm != null)
            {
               onConfirm.apply();
            }
         };
         cancelHandler = function(param1:Event):void
         {
            param1.stopImmediatePropagation();
            eventDispatcher.dispatchEvent(new HideWindowEvent(param1.currentTarget as DisplayObject));
            if(onCancel != null)
            {
               onCancel.apply();
            }
         };
         removedFromStageHandler = function(param1:Event):void
         {
            dlg.removeEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
            dlg.removeEventListener(Event.CLOSE,cancelHandler);
            dlg.removeEventListener("YES",confirmHandler);
            dlg.removeEventListener("NO",cancelHandler);
         };
         dlg = createDialog(title,[{
            "label":LocalizationManager.getInstance().textByLocalizationID("disconnect_enter_button"),
            "event":"YES"
         },{
            "label":LocalizationManager.getInstance().textByLocalizationID("login_legacy_cancel"),
            "event":"NO"
         }],UIFactory.createLabel(message));
         dlg.addEventListener(Event.CLOSE,cancelHandler);
         dlg.addEventListener("YES",confirmHandler);
         dlg.addEventListener("NO",cancelHandler);
         var e:ShowWindowEvent = new ShowWindowEvent(dlg,Constraints.CENTER_H | Constraints.CENTER_V,true);
         e.putUnder = null;
         eventDispatcher.dispatchEvent(e);
         dlg.addEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
         return dlg;
      }
      
      public static function showAlert(param1:String, param2:String, param3:Function = null) : Dialog
      {
         var dlg:Dialog = null;
         var closeHandler:Function = null;
         var removedFromStageHandler:Function = null;
         var title:String = param1;
         var message:String = param2;
         var onClose:Function = param3;
         closeHandler = function(param1:Event):void
         {
            param1.stopImmediatePropagation();
            new EventPipe().dispatchEvent(new HideWindowEvent(param1.currentTarget as DisplayObject));
            if(onClose != null)
            {
               onClose.apply();
            }
         };
         removedFromStageHandler = function(param1:Event):void
         {
            dlg.removeEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
            dlg.removeEventListener(Event.CLOSE,closeHandler);
            dlg.removeEventListener("OK",closeHandler);
         };
         dlg = createDialog(title,[{
            "label":LocalizationManager.getInstance().textByLocalizationID("WING_BUTTON_OK"),
            "event":"OK"
         }],UIFactory.createLabel(message));
         dlg.addEventListener(Event.CLOSE,closeHandler);
         dlg.addEventListener("OK",closeHandler);
         var e:ShowWindowEvent = new ShowWindowEvent(dlg,Constraints.CENTER_H | Constraints.CENTER_V,true);
         e.putUnder = null;
         new EventPipe().dispatchEvent(e);
         dlg.addEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
         return dlg;
      }
      
      public static function createAlert(param1:String, param2:String, param3:Function = null) : Dialog
      {
         var closeHandler:Function = null;
         var title:String = param1;
         var message:String = param2;
         var onClose:Function = param3;
         closeHandler = function(param1:Event):void
         {
            if(onClose != null)
            {
               onClose.apply();
            }
         };
         var txt:TextField = UIFactory.createTextField(true,TextFieldAutoSize.CENTER);
         txt.htmlText = message;
         var dlg:Dialog = createDialog(title,[{
            "label":LocalizationManager.getInstance().textByLocalizationID("WING_BUTTON_OK"),
            "event":Event.CLOSE
         }],txt);
         dlg.centerButtons = true;
         dlg.addEventListener(Event.CLOSE,closeHandler,false,0,true);
         return dlg;
      }
      
      public static function createToolTip(param1:String, param2:Boolean = true, param3:Number = 25, param4:Array = null, param5:int = 0) : UIFactoryToolTip
      {
         if(param1 == "" || param1 == null)
         {
            return new UIFactoryToolTip();
         }
         return new UIFactoryToolTip(param1,param2,param3,param4,param5);
      }
      
      public static function createInfoTip(param1:DisplayObject, param2:Padding = null) : Sprite
      {
         var _loc3_:Sprite = new Sprite();
         _loc3_.mouseEnabled = _loc3_.mouseChildren = false;
         var _loc4_:Sprite = new (getDefinition("comBgModulesExtended") as Class)();
         if(param2 == null)
         {
            param2 = new Padding(15,15,15,15);
         }
         param1.x = param2.left;
         param1.y = param2.top;
         _loc4_.width = param2.horizontal + param1.width;
         _loc4_.height = param2.vertical + param1.height;
         _loc3_.addChild(_loc4_);
         _loc3_.addChild(param1);
         return _loc3_;
      }
      
      public static function createSpendDialog(param1:String, param2:String, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int = -1, param9:int = -1, param10:int = -1) : Dialog
      {
         var _loc16_:Array = null;
         var _loc11_:LocalizationManager = LocalizationManager.getInstance();
         var _loc12_:int = param6;
         if(_loc12_ > param5)
         {
            _loc12_ = param5;
         }
         var _loc13_:int = param5 - _loc12_;
         var _loc14_:Class = getDefinition(COST_CONFIRMATION_CLASS) as Class;
         var _loc15_:CostConfirmation = new _loc14_();
         if(param10 >= 0)
         {
            param10 = param10 + param6;
         }
         _loc15_.setInfo(param2,param3,param4,_loc12_,_loc13_,param7 == TYPE_COST_CONFIRMATION_NO_MESSAGES,param8,param9,param10);
         var _loc17_:Boolean = Boolean(_loc15_.isEnoughCredits) && Boolean(_loc15_.isEnoughGold) && Boolean(_loc15_.isEnoughXP);
         if(param7 == TYPE_COST_CONFIRMATION_YES_NO_CANCEL)
         {
            if(_loc17_)
            {
               _loc16_ = [{
                  "label":_loc11_.textByLocalizationID("BUTTON_YES"),
                  "event":"YES"
               },{
                  "label":_loc11_.textByLocalizationID("BUTTON_NO"),
                  "event":"NO"
               },{
                  "label":_loc11_.textByLocalizationID("BUTTON_CANCEL"),
                  "event":"CANCEL"
               }];
            }
            else
            {
               _loc16_ = [{
                  "label":_loc11_.textByLocalizationID("DISCONNECT_ENTER_BUTTON"),
                  "event":"NO"
               },{
                  "label":_loc11_.textByLocalizationID("BUTTON_CANCEL"),
                  "event":"CANCEL"
               }];
            }
         }
         else if(_loc17_)
         {
            _loc16_ = [{
               "label":_loc11_.textByLocalizationID("BUTTON_YES"),
               "event":"YES"
            },{
               "label":_loc11_.textByLocalizationID("BUTTON_NO"),
               "event":"NO"
            }];
         }
         else
         {
            _loc16_ = [{
               "label":_loc11_.textByLocalizationID("BUTTON_CANCEL"),
               "event":"CANCEL"
            }];
         }
         var _loc18_:Dialog = UIFactory.createDialog(param1,_loc16_,_loc15_);
         return _loc18_;
      }
   }
}
