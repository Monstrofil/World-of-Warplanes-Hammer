package wowp.hud.model.player
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import wowp.utils.string.time.concatNickname;
   
   public class HudPlayerModel extends HUDModelComponent
   {
       
      public var onPlaneTypeUpdated:Signal;
      
      public var onPlaneNameUpdated:Signal;
      
      public var onMaxHealthUpdated:Signal;
      
      public var onNickNameUpdated:Signal;
      
      private var _planeType:int;
      
      private var _planeName:String = "";
      
      private var _maxHealth:Number = 0;
      
      private var _nickname:String = "";
      
      public var health:Number = 0;
      
      public function HudPlayerModel()
      {
         this.onPlaneTypeUpdated = new Signal();
         this.onPlaneNameUpdated = new Signal();
         this.onMaxHealthUpdated = new Signal();
         this.onNickNameUpdated = new Signal();
         super();
      }
      
      public function get planeType() : int
      {
         return this._planeType;
      }
      
      public function get planeName() : String
      {
         return this._planeName;
      }
      
      public function get maxHealth() : Number
      {
         return this._maxHealth;
      }
      
      public function get nickName() : String
      {
         return this._nickname;
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.playerTaskSetup",this.setPlaneType);
         backend.addCallback("hud.healthmeterInit",this.initAll);
         backend.addCallback("hud.healthmeterUpdatePlaneName",this.setPlane);
         backend.addCallback("hud.healthmeterUpdate",this.setHealth);
      }
      
      private function setPlaneType(param1:int) : void
      {
         this._planeType = param1;
         this.onPlaneTypeUpdated.fire();
      }
      
      private function initAll(param1:String, param2:String, param3:String, param4:Number, param5:Number) : void
      {
         this._nickname = concatNickname(param1,param2);
         this.onNickNameUpdated.fire();
         this._maxHealth = param4;
         this.onMaxHealthUpdated.fire();
         this.setPlane(param3);
         this.setHealth(param5);
      }
      
      private function setPlane(param1:String) : void
      {
         this._planeName = param1;
         this.onPlaneNameUpdated.fire();
      }
      
      private function setHealth(param1:Number) : void
      {
         this.health = param1;
      }
   }
}
