package wowp.hud.model.control
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   
   public class HUDControlModel extends HUDModelComponent
   {
      
      public static const STATE_UNDEFINED:int = 0;
      
      public static const STATE_BATTLERESULTS:int = 1;
      
      public static const STATE_CHAT:int = 2;
      
      public static const STATE_FASTCOMMANDSMENU:int = 3;
      
      public static const STATE_HELP:int = 4;
      
      public static const STATE_HIDDEN:int = 5;
      
      public static const STATE_MENU:int = 6;
      
      public static const STATE_NORMAL:int = 7;
      
      public static const STATE_SETTINGS:int = 8;
      
      public static const STATE_SPECTATORCINEMA:int = 9;
      
      public static const STATE_SPECTATORDEFAULT:int = 10;
      
      public static const STATE_SPECTATORDINAMIC:int = 11;
      
      public static const STATE_SPECTATORFINAL:int = 12;
      
      public static const STATE_SPECTATORINIT:int = 13;
      
      public static const STATE_TAB:int = 14;
      
      public static const STATE_TUTORIAL:int = 15;
       
      public var stageWidth:int;
      
      public var stageHeight:int;
      
      public var onEscPressed:Signal;
      
      public var onAltPressed:Signal;
      
      public var onHideCursor:Signal;
      
      public var onShowCursor:Signal;
      
      public var onBattleResult:Signal;
      
      public var onVisibilityChanged:Signal;
      
      public var onShowHelp:Signal;
      
      public var onHelpEnabled:Signal;
      
      public var onShowPlayerList:Signal;
      
      public var onHidePlayerList:Signal;
      
      public var onHideBackendGraphics:Signal;
      
      public var onShowBackendGraphics:Signal;
      
      public var fps:int;
      
      public var ping:int;
      
      public var packetsLost:int;
      
      private var _isHUDVisible:Boolean = true;
      
      private var _isBattleResult:Boolean = false;
      
      private var _isCursorVisible:Boolean = false;
      
      private var _isBackendGraphicsVisible:Boolean = false;
      
      private var _isHelpVisible:Boolean = false;
      
      private var _isAltPress:Boolean = false;
      
      private var _isPlayerListShown:Boolean = false;
      
      private var _isHelpEnabled:Boolean = true;
      
      public function HUDControlModel()
      {
         this.onEscPressed = new Signal();
         this.onAltPressed = new Signal();
         this.onHideCursor = new Signal();
         this.onShowCursor = new Signal();
         this.onBattleResult = new Signal();
         this.onVisibilityChanged = new Signal();
         this.onShowHelp = new Signal();
         this.onHelpEnabled = new Signal();
         this.onShowPlayerList = new Signal();
         this.onHidePlayerList = new Signal();
         this.onHideBackendGraphics = new Signal();
         this.onShowBackendGraphics = new Signal();
         super();
      }
      
      public function get isHUDVisible() : Boolean
      {
         return this._isHUDVisible;
      }
      
      public function get isBattleResult() : Boolean
      {
         return this._isBattleResult;
      }
      
      public function get isCursorVisible() : Boolean
      {
         return this._isCursorVisible;
      }
      
      public function get isBackendGraphicsVisible() : Boolean
      {
         return this._isBackendGraphicsVisible;
      }
      
      public function set isBackendGraphicsVisible(param1:Boolean) : void
      {
         this._isBackendGraphicsVisible = param1;
      }
      
      public function get isHelpVisible() : Boolean
      {
         return this._isHelpVisible;
      }
      
      public function set isHelpVisible(param1:Boolean) : void
      {
         this._isHelpVisible = param1;
      }
      
      public function get isAltPress() : Boolean
      {
         return this._isAltPress;
      }
      
      public function get isPlayerListShown() : Boolean
      {
         return this._isPlayerListShown;
      }
      
      public function get isHelpEnabled() : Boolean
      {
         return this._isHelpEnabled;
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.escButtonPressed",this.escPressHandler);
         backend.addCallback("hud.additionalPlayersInfo",this.altPressHandler);
         backend.addCallback("hud.battleResultShow",this.showBattleResults);
         backend.addCallback("hud.setVisibility",this.setVisibility);
         backend.addCallback("hud.onShowHelp",this.showHelpRequest);
         backend.addCallback("hud.onVisibilityTeams",this.playerListRequest);
         backend.addCallback("hud.onVisibilityCursor",this.onCursorVisibility);
         backend.addCallback("hud.updateEngineStates",this.updateEngineStates);
         backend.addCallback("hud.helpEnabled",this.helpEnabled);
      }
      
      private function escPressHandler() : void
      {
         trace("HUDControlModel::escPressHandler");
         this.onEscPressed.fire();
      }
      
      private function altPressHandler(param1:Boolean) : void
      {
         trace("HUDControlModel::altPressHandler");
         this._isAltPress = param1;
         this.onAltPressed.fire();
      }
      
      private function onCursorVisibility(param1:Boolean) : void
      {
         trace("HUDControlModel::onCursorVisibility:",param1);
         if(this._isCursorVisible != param1)
         {
            this._isCursorVisible = param1;
            if(param1)
            {
               this.onShowCursor.fire();
            }
            else
            {
               this.onHideCursor.fire();
            }
         }
      }
      
      private function showBattleResults() : void
      {
         trace("HUDControlModel::showBattleResults");
         this._isBattleResult = true;
         this.onBattleResult.fire();
      }
      
      private function setVisibility(param1:Boolean) : void
      {
         trace("HUDControlModel::setVisibility:",param1);
         if(this._isHUDVisible != param1)
         {
            this._isHUDVisible = param1;
            this.onVisibilityChanged.fire();
         }
      }
      
      private function showHelpRequest(param1:Boolean) : void
      {
         trace("HUDControlModel::showHelpRequest");
         if(this._isHelpEnabled)
         {
            this._isHelpVisible = param1;
            this.onShowHelp.fire();
         }
      }
      
      private function playerListRequest(param1:Boolean) : void
      {
         trace("HUDControlModel::playerListRequest:",param1);
         this._isPlayerListShown = param1;
         if(param1)
         {
            this.onShowPlayerList.fire();
         }
         else
         {
            this.onHidePlayerList.fire();
         }
      }
      
      private function updateEngineStates(param1:int, param2:int, param3:int) : void
      {
         this.ping = param2;
         this.fps = param1;
         this.packetsLost = param3;
      }
      
      private function helpEnabled(param1:Boolean) : *
      {
         this._isHelpEnabled = param1;
         this.onHelpEnabled.fire();
      }
      
      public function mouseShow() : void
      {
         backend.call("hud.requestShowCursor");
      }
      
      public function mouseHide() : void
      {
         backend.callAsync("hud.requestHideCursor");
      }
      
      public function gotoHangar() : void
      {
         backend.call("hud.requestBackToHangar");
      }
      
      public function gotoWindows() : void
      {
         backend.call("hud.requestExit");
      }
      
      public function startDispatchKeys() : void
      {
         backend.call("hud.requestStartDispatchKeyInput");
      }
      
      public function stopDispatchKeys() : void
      {
         backend.call("hud.requestStopDispatchKeyInput");
      }
      
      public function showBackendGraphics() : void
      {
         if(!this._isBackendGraphicsVisible)
         {
            this._isBackendGraphicsVisible = true;
            backend.call("hud.requestShowBackendGraphics");
            this.onShowBackendGraphics.fire();
         }
      }
      
      public function hideBackendGraphics(param1:Boolean = false, param2:int = 0) : void
      {
         if(Boolean(this._isBackendGraphicsVisible) || Boolean(param1))
         {
            this._isBackendGraphicsVisible = false;
            backend.call("hud.requestHideBackendGraphics",param2);
            this.onHideBackendGraphics.fire();
         }
      }
      
      public function showHud() : void
      {
         backend.call("hud.show");
      }
      
      public function hideHud() : void
      {
         backend.call("hud.hide");
      }
      
      public function helpDeInitialized() : void
      {
         backend.call("help.deInitialized");
      }
      
      public function setCursor(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         trace("HUDControlModel::setCursor:",param1,param2);
         if(this.stageHeight != 0 && this.stageWidth != 0)
         {
            _loc3_ = this.stageWidth / 2;
            _loc4_ = this.stageHeight / 2;
            param1 = (param1 - _loc3_) / _loc3_;
            param2 = -(param2 - _loc4_) / _loc4_;
            backend.call("hud.requestSetCursorPosition",param1,param2);
         }
      }
      
      public function togglePauseMenu(param1:Boolean) : void
      {
         backend.call("UI.togglePauseMenu",param1);
      }
   }
}
