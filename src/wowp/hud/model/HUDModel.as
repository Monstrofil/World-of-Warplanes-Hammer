package wowp.hud.model
{
   import flash.events.EventDispatcher;
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.backend.IBackend;
   import wowp.hud.model.chat.ChatModel;
   import wowp.hud.model.aviahorizon.AviaHorizonModel;
   import wowp.hud.model.domination.HudDominationModel;
   import wowp.hud.model.crosshair.HudCrosshairModel;
   import wowp.hud.model.damage.HudDamageModel;
   import wowp.hud.model.speedometer.HudSpeedometerModel;
   import wowp.hud.model.variometer.HudVariometerModel;
   import wowp.hud.model.messages.HudMessagesModel;
   import wowp.hud.model.player.HudPlayerModel;
   import wowp.hud.model.targetCapture.HudTargetCapture;
   import wowp.hud.model.weapons.HudWeaponsModel;
   import wowp.hud.model.equipments.HudEquipmentsModel;
   import wowp.hud.model.players.HUDPlayersModel;
   import wowp.hud.model.labels.HUDLabelsModel;
   import wowp.hud.model.time.HUDTimeModel;
   import wowp.hud.model.control.HUDControlModel;
   import wowp.hud.model.map.HUDMapModel;
   import wowp.hud.model.radar.HUDRadarModel;
   import wowp.hud.model.tutorial.HUDTutorialModel;
   import wowp.hud.model.layout.HUDLayoutModel;
   import wowp.hud.model.loading.HUDLoadingModel;
   import wowp.hud.model.replays.HudReplaysModel;
   import wowp.hud.model.spectator.HUDSpectatorModel;
   import wowp.hud.model.skills.HUDSkillsModel;
   import flash.events.Event;
   import wowp.utils.backend.Backend;
   
   public class HUDModel extends EventDispatcher
   {
      
      public static const MODEL_INITIALIZED:String = "wowp.hud.model.HUDModel.MODEL_INITIALIZED";
      
      public static const DISPOSE:String = "wowp.hud.model.HUDModel.DISPOSE";
       
      private var _modelComponents:Vector.<HUDModelComponent>;
      
      private var _backend:IBackend;
      
      public var chat:ChatModel;
      
      public var aviahorizon:AviaHorizonModel;
      
      public var domination:HudDominationModel;
      
      public var crosshair:HudCrosshairModel;
      
      public var damage:HudDamageModel;
      
      public var speedometer:HudSpeedometerModel;
      
      public var variometer:HudVariometerModel;
      
      public var messages:HudMessagesModel;
      
      public var player:HudPlayerModel;
      
      public var targetCapture:HudTargetCapture;
      
      public var weapons:HudWeaponsModel;
      
      public var equipments:HudEquipmentsModel;
      
      public var players:HUDPlayersModel;
      
      public var labels:HUDLabelsModel;
      
      public var time:HUDTimeModel;
      
      public var control:HUDControlModel;
      
      public var map:HUDMapModel;
      
      public var radar:HUDRadarModel;
      
      public var tutorial:HUDTutorialModel;
      
      public var layout:HUDLayoutModel;
      
      public var loading:HUDLoadingModel;
      
      public var replays:HudReplaysModel;
      
      public var spectator:HUDSpectatorModel;
      
      public var skills:HUDSkillsModel;
      
      public function HUDModel()
      {
         var _loc1_:HUDModelComponent = null;
         this._modelComponents = new Vector.<HUDModelComponent>();
         this._backend = new Backend();
         this.chat = new ChatModel();
         this.aviahorizon = new AviaHorizonModel();
         this.domination = new HudDominationModel();
         this.crosshair = new HudCrosshairModel();
         this.damage = new HudDamageModel();
         this.speedometer = new HudSpeedometerModel();
         this.variometer = new HudVariometerModel();
         this.messages = new HudMessagesModel();
         this.player = new HudPlayerModel();
         this.targetCapture = new HudTargetCapture();
         this.weapons = new HudWeaponsModel();
         this.equipments = new HudEquipmentsModel();
         this.players = new HUDPlayersModel();
         this.labels = new HUDLabelsModel();
         this.time = new HUDTimeModel();
         this.control = new HUDControlModel();
         this.map = new HUDMapModel();
         this.radar = new HUDRadarModel();
         this.tutorial = new HUDTutorialModel();
         this.layout = new HUDLayoutModel();
         this.loading = new HUDLoadingModel();
         this.replays = new HudReplaysModel();
         this.spectator = new HUDSpectatorModel();
         this.skills = new HUDSkillsModel();
         super();
         this._backend.addCallback("dispose",this.gotDispose);
         this._backend.addCallback("init",this.initData);
         this._modelComponents.push(this.chat);
         this._modelComponents.push(this.aviahorizon);
         this._modelComponents.push(this.domination);
         this._modelComponents.push(this.crosshair);
         this._modelComponents.push(this.damage);
         this._modelComponents.push(this.speedometer);
         this._modelComponents.push(this.variometer);
         this._modelComponents.push(this.messages);
         this._modelComponents.push(this.player);
         this._modelComponents.push(this.targetCapture);
         this._modelComponents.push(this.weapons);
         this._modelComponents.push(this.equipments);
         this._modelComponents.push(this.players);
         this._modelComponents.push(this.labels);
         this._modelComponents.push(this.time);
         this._modelComponents.push(this.control);
         this._modelComponents.push(this.map);
         this._modelComponents.push(this.tutorial);
         this._modelComponents.push(this.layout);
         this._modelComponents.push(this.radar);
         this._modelComponents.push(this.loading);
         this._modelComponents.push(this.replays);
         this._modelComponents.push(this.spectator);
         this._modelComponents.push(this.skills);
         for each(_loc1_ in this._modelComponents)
         {
            _loc1_.init(this,this._backend);
         }
      }
      
      protected function initData(... rest) : void
      {
      }
      
      public function init() : void
      {
         dispatchEvent(new Event(MODEL_INITIALIZED,true));
         this._backend.call("initialized");
      }
      
      public function dispose() : void
      {
         var _loc1_:HUDModelComponent = null;
         for each(_loc1_ in this._modelComponents)
         {
            _loc1_.dispose();
         }
         this._backend.dispose();
      }
      
      private function gotDispose() : void
      {
         trace("HUDModel::gotDispose");
         dispatchEvent(new Event(DISPOSE,true));
      }
   }
}
