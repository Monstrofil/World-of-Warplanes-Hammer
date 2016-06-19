package wowp.hud.model.replays
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import wowp.core.shared.ISharedObject;
   import wowp.core.shared.BackendSharedObject;
   
   public class HudReplaysModel extends HUDModelComponent
   {
       
      private const PANEL_SHOW:String = "panelShown";
      
      private const MESSAGE_SHOW:String = "messageShown";
      
      public var onEnableReplaysChanged:Signal;
      
      public var onPanelReplaysChanged:Signal;
      
      public var onShowPanelReplays:Signal;
      
      public var onHidePanelReplays:Signal;
      
      public var onToolTipsReplaysChanged:Signal;
      
      public var onSpeedReplaysChanged:Signal;
      
      public var onTimeCurrentReplaysChanged:Signal;
      
      public var onTimeMaxReplaysChanged:Signal;
      
      public var onProgressReplaysChanged:Signal;
      
      public var onPauseReplaysChanged:Signal;
      
      public var onButtonsEnableReplaysChanged:Signal;
      
      public var onMessageReplaysChanged:Signal;
      
      public var onCompletionMessageReplaysShow:Signal;
      
      private var _isEnableReplays:Boolean = false;
      
      private var _isShowPanel:Boolean = false;
      
      private var _isNeedShowPanel:Boolean = false;
      
      private var _toolTips:Array;
      
      private var _textSpeedReplays:String;
      
      private var _textTimeCurrentReplays:String;
      
      private var _textTimeMaxReplays:String;
      
      private var _valueProgressReplays:int;
      
      private var _isPauseReplays:Boolean = false;
      
      private var _isButtonsEnableReplays:Array;
      
      private var _messageReplays:String;
      
      private var _isMessageEnable:Boolean;
      
      private var _so:ISharedObject;
      
      public function HudReplaysModel()
      {
         this.onEnableReplaysChanged = new Signal();
         this.onPanelReplaysChanged = new Signal();
         this.onShowPanelReplays = new Signal();
         this.onHidePanelReplays = new Signal();
         this.onToolTipsReplaysChanged = new Signal();
         this.onSpeedReplaysChanged = new Signal();
         this.onTimeCurrentReplaysChanged = new Signal();
         this.onTimeMaxReplaysChanged = new Signal();
         this.onProgressReplaysChanged = new Signal();
         this.onPauseReplaysChanged = new Signal();
         this.onButtonsEnableReplaysChanged = new Signal();
         this.onMessageReplaysChanged = new Signal();
         this.onCompletionMessageReplaysShow = new Signal();
         this._toolTips = [];
         this._isButtonsEnableReplays = [true,true,true,true,true,true,true,true];
         super();
      }
      
      public function get isEnableReplays() : Boolean
      {
         return this._isEnableReplays;
      }
      
      public function get isShowPanel() : Boolean
      {
         return this._isShowPanel;
      }
      
      public function set isShowPanel(param1:Boolean) : void
      {
         this._isShowPanel = param1;
         this.onPanelReplaysChanged.fire();
      }
      
      public function get isNeedShowPanel() : Boolean
      {
         return this._isNeedShowPanel;
      }
      
      public function set isNeedShowPanel(param1:Boolean) : void
      {
         this._isNeedShowPanel = param1;
      }
      
      public function get toolTips() : Array
      {
         return this._toolTips;
      }
      
      public function get textSpeedReplays() : String
      {
         return this._textSpeedReplays;
      }
      
      public function get textTimeCurrentReplays() : String
      {
         return this._textTimeCurrentReplays;
      }
      
      public function get textTimeMaxReplays() : String
      {
         return this._textTimeMaxReplays;
      }
      
      public function get valueProgressReplays() : int
      {
         return this._valueProgressReplays;
      }
      
      public function get isPauseReplays() : Boolean
      {
         return this._isPauseReplays;
      }
      
      public function get isButtonsEnableReplays() : Array
      {
         return this._isButtonsEnableReplays;
      }
      
      public function get messageReplays() : String
      {
         return this._messageReplays;
      }
      
      public function get isMessageEnable() : Boolean
      {
         if(!this._so.read(this.MESSAGE_SHOW))
         {
            this._so.write(this.MESSAGE_SHOW,true);
            this._isMessageEnable = true;
         }
         else
         {
            this._isMessageEnable = false;
         }
         return this._isMessageEnable;
      }
      
      public function set isMessageEnable(param1:Boolean) : void
      {
         this._isMessageEnable = param1;
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.setEnableReplays",this.setEnableReplays);
         backend.addCallback("hud.showPanelReplays",this.showPanelReplays);
         backend.addCallback("hud.hidePanelReplays",this.hidePanelReplays);
         backend.addCallback("hud.setToolTipsReplays",this.setToolTipsReplays);
         backend.addCallback("hud.setSpeedReplays",this.setSpeedReplays);
         backend.addCallback("hud.setTimeCurrentReplays",this.setTimeCurrentReplays);
         backend.addCallback("hud.setTimeMaxReplays",this.setTimeMaxReplays);
         backend.addCallback("hud.setProgressReplays",this.setProgressReplays);
         backend.addCallback("hud.setPauseReplays",this.setPauseReplays);
         backend.addCallback("hud.setButtonsEnableReplays",this.setButtonsEnableReplays);
         backend.addCallback("hud.setMessageReplays",this.setMessageReplays);
         backend.addCallback("hud.showCompletionMessage",this.showCompletionMessage);
         this._so = new BackendSharedObject();
      }
      
      private function setEnableReplays() : void
      {
         this._isEnableReplays = true;
         this.onEnableReplaysChanged.fire();
      }
      
      public function showPanelReplays() : void
      {
         if(!this._so.read(this.PANEL_SHOW))
         {
            this._so.write(this.PANEL_SHOW,true);
            this._isNeedShowPanel = true;
            this.onShowPanelReplays.fire();
         }
      }
      
      private function hidePanelReplays() : void
      {
         this._isNeedShowPanel = false;
         this.onHidePanelReplays.fire();
      }
      
      private function setToolTipsReplays(param1:Array) : void
      {
         this._toolTips = param1;
         this.onToolTipsReplaysChanged.fire();
      }
      
      private function setSpeedReplays(param1:String) : void
      {
         this._textSpeedReplays = param1;
         this.onSpeedReplaysChanged.fire();
      }
      
      private function setTimeCurrentReplays(param1:String) : void
      {
         this._textTimeCurrentReplays = param1;
         this.onTimeCurrentReplaysChanged.fire();
      }
      
      private function setTimeMaxReplays(param1:String) : void
      {
         this._textTimeMaxReplays = param1;
         this.onTimeMaxReplaysChanged.fire();
      }
      
      private function setProgressReplays(param1:int) : void
      {
         this._valueProgressReplays = param1;
         this.onProgressReplaysChanged.fire();
      }
      
      private function setPauseReplays(param1:Boolean) : void
      {
         this._isPauseReplays = param1;
         this.onPauseReplaysChanged.fire();
      }
      
      private function setButtonsEnableReplays(param1:Array) : void
      {
         this._isButtonsEnableReplays = param1;
         this.onButtonsEnableReplaysChanged.fire();
      }
      
      private function setMessageReplays(param1:String) : void
      {
         this._messageReplays = param1;
         this.onMessageReplaysChanged.fire();
      }
      
      private function showCompletionMessage() : void
      {
         this._isNeedShowPanel = true;
         this.onShowPanelReplays.fire();
      }
      
      public function setAction(param1:int) : void
      {
         backend.callAsync("hud.pressButtonReplays",param1);
      }
      
      public function setPosition(param1:int) : void
      {
         backend.callAsync("hud.setPositionReplays",param1);
      }
   }
}
