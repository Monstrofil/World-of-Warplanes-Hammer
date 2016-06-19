package wowp.hud.model.layout
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class HUDLayoutModel extends HUDModelComponent
   {
      
      public static const HUD_OLD:int = 0;
      
      public static const HUD_WOT:int = 1;
      
      public static const HUD_TUTORIAL:int = 3;
      
      public static const HUD_WAITING:int = 4;
       
      public var onStateChanged:Signal;
      
      public var onVisibleNickPlayersChanged:Signal;
      
      public var onLayoutChange:Signal;
      
      public var onAlternativeColorChange:Signal;
      
      public var onLayoutResize:Signal;
      
      public var onVisibleBlackoutChanged:Signal;
      
      public var isVisibleNickPlayers:Boolean = true;
      
      public var damagePanelMode:int;
      
      public var speedometerMode:int;
      
      public var variometerMode:int;
      
      public var weaponPanelMode:int;
      
      public var playerListMode:int;
      
      public var healthmeterMode:int;
      
      public var aviaHorizonMode:int;
      
      public var captureBaseMode:int;
      
      public var crosshairMode:int;
      
      public var targetWindowMode:int;
      
      public var headerMessagesMode:int;
      
      public var battleMessagesMode:int = 1;
      
      public var replayMessagesMode:int = 1;
      
      public var minimapMode:int;
      
      public var speedometerAndVariometer:Boolean;
      
      public var bombRocketPanelMode:int;
      
      public var forsageMode:int;
      
      public var equipmentPanelMode:int;
      
      public var replayPanelMode:int;
      
      public var spectatorHintMode:int;
      
      private var _setTargetCoordTimeout:uint;
      
      private var _isAlternativeColor:Boolean = false;
      
      private var _isBlackoutVisible:Boolean = false;
      
      private var _mapLimitX:int = 0;
      
      private var _mapLimitY:int = 0;
      
      private var _currentLayoutID:int;
      
      public function HUDLayoutModel()
      {
         this.onStateChanged = new Signal();
         this.onVisibleNickPlayersChanged = new Signal();
         this.onLayoutChange = new Signal();
         this.onAlternativeColorChange = new Signal();
         this.onLayoutResize = new Signal();
         this.onVisibleBlackoutChanged = new Signal();
         super();
      }
      
      public function get currentLayout() : int
      {
         return this._currentLayoutID;
      }
      
      public function set currentLayout(param1:int) : void
      {
         if(this._currentLayoutID != param1)
         {
            this.setLayout(param1);
         }
      }
      
      public function get isAlternativeColor() : Boolean
      {
         return this._isAlternativeColor;
      }
      
      public function get isBlackoutVisible() : Boolean
      {
         return this._isBlackoutVisible;
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.updateState",this.updateState);
         backend.addCallback("hud.switchVisibleNickPlayers",this.switchVisibleNickPlayers);
         backend.addCallback("hud.battleUIType",this.setLayout);
         backend.addCallback("hud.alternativeColor",this.setAlternativeColor);
      }
      
      override protected function onDispose() : void
      {
         clearTimeout(this._setTargetCoordTimeout);
      }
      
      public function setTargetWindowCoord(param1:Number, param2:Number) : void
      {
         clearTimeout(this._setTargetCoordTimeout);
         this._setTargetCoordTimeout = setTimeout(backend.call,1,"ui.ChangeMiniScreenPosition",param1,param2);
      }
      
      private function updateState(param1:Object) : void
      {
         var _loc2_:* = null;
         if(param1.hasOwnProperty("damagePanel"))
         {
            this.damagePanelMode = param1.damagePanel;
         }
         if(param1.hasOwnProperty("weaponPanel"))
         {
            this.weaponPanelMode = param1.weaponPanel;
         }
         if(param1.hasOwnProperty("speedometer"))
         {
            this.speedometerMode = param1.speedometer;
         }
         if(param1.hasOwnProperty("variometer"))
         {
            this.variometerMode = param1.variometer;
         }
         if(param1.hasOwnProperty("playerList"))
         {
            this.playerListMode = param1.playerList;
         }
         if(param1.hasOwnProperty("healthMeter"))
         {
            this.healthmeterMode = param1.healthMeter;
         }
         if(param1.hasOwnProperty("aviahorizont"))
         {
            this.aviaHorizonMode = param1.aviahorizont;
         }
         if(param1.hasOwnProperty("captureBase"))
         {
            this.captureBaseMode = param1.captureBase;
         }
         if(param1.hasOwnProperty("crosshair"))
         {
            this.crosshairMode = param1.crosshair;
         }
         if(param1.hasOwnProperty("targetWindow"))
         {
            this.targetWindowMode = param1.targetWindow;
         }
         if(param1.hasOwnProperty("headerMessages"))
         {
            this.headerMessagesMode = param1.headerMessages;
         }
         if(param1.hasOwnProperty("battleMessagesMode"))
         {
            this.battleMessagesMode = param1.battleMessagesMode;
         }
         if(param1.hasOwnProperty("replayMessagesMode"))
         {
            this.replayMessagesMode = param1.replayMessagesMode;
         }
         if(param1.hasOwnProperty("navWindow"))
         {
            this.minimapMode = param1.navWindow;
         }
         if(param1.hasOwnProperty("speedometerAndVariometer"))
         {
            this.speedometerAndVariometer = param1.speedometerAndVariometer;
         }
         if(param1.hasOwnProperty("bombRocketPanel"))
         {
            this.bombRocketPanelMode = param1.bombRocketPanel;
         }
         if(param1.hasOwnProperty("forsage"))
         {
            this.forsageMode = param1.forsage;
         }
         if(param1.hasOwnProperty("equipmentPanel"))
         {
            this.equipmentPanelMode = param1.equipmentPanel;
         }
         if(param1.hasOwnProperty("replayPanel"))
         {
            this.replayPanelMode = param1.replayPanel;
         }
         if(param1.hasOwnProperty("spectatorHint"))
         {
            this.spectatorHintMode = param1.spectatorHint;
         }
         trace("HUDLayoutModel::updateState:");
         for(_loc2_ in param1)
         {
            trace("    ",_loc2_,":  ",param1[_loc2_]);
         }
         this.onStateChanged.fire();
      }
      
      private function switchVisibleNickPlayers() : void
      {
         this.isVisibleNickPlayers = !this.isVisibleNickPlayers;
         this.onVisibleNickPlayersChanged.fire();
      }
      
      private function setLayout(param1:int) : void
      {
         trace("HUDLayuotModel::setLayout::" + param1);
         this._currentLayoutID = !!param1?int(param1):1;
         this.onLayoutChange.fire();
      }
      
      private function setAlternativeColor(param1:Boolean) : void
      {
         trace("setAlternativeColor = " + param1);
         this._isAlternativeColor = param1;
         this.onAlternativeColorChange.fire();
      }
      
      public function setMapLimitY(param1:int) : void
      {
         this._mapLimitY = param1;
         backend.callAsync("hud.setMinimapLimitPosition",this._mapLimitX,this._mapLimitY);
      }
      
      public function setMapLimit(param1:int, param2:int) : void
      {
         this._mapLimitX = param1;
         this.setMapLimitY(param2);
      }
      
      public function resize() : void
      {
         this.onLayoutResize.fire();
      }
      
      public function setVisibleBlackout(param1:Boolean) : void
      {
         this._isBlackoutVisible = param1;
         this.onVisibleBlackoutChanged.fire();
      }
   }
}
