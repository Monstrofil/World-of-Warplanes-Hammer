package wowp.hud.model.damage
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import wowp.hud.model.messages.vo.MessageVO;
   
   public class HudDamageModel extends HUDModelComponent
   {
      
      public static const MODULE_PLANE_LEFT_WING_ID:int = 0;
      
      public static const MODULE_PLANE_RIGHT_WING_ID:int = 1;
      
      public static const MODULE_PLANE_TAIL_ID:int = 2;
      
      public static const MODULE_PLANE_FUSELAGE_ID:int = 3;
      
      public static const MODULE_CANNON_ID:int = 4;
      
      public static const MODULE_GUN_ID:int = 5;
      
      public static const MODULE_PETROL_ID:int = 7;
      
      public static const MODULE_MEMBER_PILOT_ID:int = 8;
      
      public static const MODULE_MEMBER_GUNNER1_ID:int = 9;
      
      public static const MODULE_MEMBER_GUNNER2_ID:int = 10;
      
      public static const MODULE_FIRE_ID:int = 11;
      
      public static const MODULE_MOTOR_FRONT_ID:int = 6;
      
      public static const MODULE_MOTOR_BACK_ID:int = 12;
      
      public static const MODULE_MOTOR_LEFT_ID:int = 13;
      
      public static const MODULE_MOTOR_RIGHT_ID:int = 14;
      
      public static const ENGINE_TEMPERATURE:int = 24;
      
      public static const GUN_TEMPERATURE:int = 25;
      
      public static const STATE_ABSENT_ID:int = 0;
      
      public static const STATE_NORMAL_ID:int = 1;
      
      public static const STATE_REPAIRED_ID:int = 2;
      
      public static const STATE_DESTROYED_ID:int = 3;
       
      public var onDamageUpdated:Signal;
      
      public var temperatureUpdated:Signal;
      
      public var onDamageScheme:Signal;
      
      public var onArcUpdated:Signal;
      
      public var onGotMessage:Signal;
      
      private var _lastMessage:MessageVO;
      
      private var _moduleStates:Array;
      
      private var _damageScheme:int = 0;
      
      public var arcAngle:Number = 0;
      
      public var arcLivingTime:Number = 0;
      
      public var engineTemperatureState:Number = 1;
      
      public function HudDamageModel()
      {
         this.onDamageUpdated = new Signal();
         this.temperatureUpdated = new Signal();
         this.onDamageScheme = new Signal();
         this.onArcUpdated = new Signal();
         this.onGotMessage = new Signal();
         this._lastMessage = new MessageVO();
         this._moduleStates = [];
         super();
      }
      
      public function get lastMessage() : MessageVO
      {
         return this._lastMessage;
      }
      
      public function get damageScheme() : int
      {
         return this._damageScheme;
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.damagePanelInit",this.damagePanelInit);
         backend.addCallback("hud.damagePanelUpdate",this.damagePanelUpdate);
         backend.addCallback("hud.damagePanelFire",this.damagePanelFire);
         backend.addCallback("hud.showDamageDirection",this.showDamageDirectionArc);
         backend.addCallback("hud.messageDamage",this.showDamageMessage);
         backend.addCallback("hud.initDamageScheme",this.initDamageScheme);
         this.damagePanelInit(false);
      }
      
      private function updateModule(param1:int, param2:int) : void
      {
         this._moduleStates[param1] = param2;
      }
      
      public function updateTemperatureModule(param1:int, param2:int) : void
      {
         var _loc3_:int = this._moduleStates[param1];
         this._moduleStates[param1] = param2;
         this.temperatureUpdated.fire();
      }
      
      private function damagePanelInit(param1:Boolean = true) : void
      {
         this.updateModule(MODULE_PLANE_LEFT_WING_ID,STATE_ABSENT_ID);
         this.updateModule(MODULE_PLANE_RIGHT_WING_ID,STATE_ABSENT_ID);
         this.updateModule(MODULE_PLANE_TAIL_ID,STATE_ABSENT_ID);
         this.updateModule(MODULE_PLANE_FUSELAGE_ID,STATE_ABSENT_ID);
         this.updateModule(MODULE_CANNON_ID,STATE_ABSENT_ID);
         this.updateModule(MODULE_GUN_ID,STATE_NORMAL_ID);
         this.updateModule(MODULE_PETROL_ID,STATE_ABSENT_ID);
         this.updateModule(MODULE_FIRE_ID,STATE_NORMAL_ID);
         this.updateModule(MODULE_MEMBER_PILOT_ID,STATE_ABSENT_ID);
         this.updateModule(MODULE_MEMBER_GUNNER1_ID,STATE_ABSENT_ID);
         this.updateModule(MODULE_MEMBER_GUNNER2_ID,STATE_ABSENT_ID);
         this.updateModule(MODULE_MOTOR_FRONT_ID,STATE_ABSENT_ID);
         this.updateModule(MODULE_MOTOR_BACK_ID,STATE_ABSENT_ID);
         this.updateModule(MODULE_MOTOR_LEFT_ID,STATE_ABSENT_ID);
         this.updateModule(MODULE_MOTOR_RIGHT_ID,STATE_ABSENT_ID);
         this.updateModule(ENGINE_TEMPERATURE,STATE_NORMAL_ID);
         this.updateModule(GUN_TEMPERATURE,STATE_NORMAL_ID);
         if(param1)
         {
            this.onDamageUpdated.fire();
         }
      }
      
      private function damagePanelUpdate(param1:Array) : void
      {
         var _loc4_:Array = null;
         trace("---damagePanelUpdate--",param1);
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1[_loc3_];
            if(_loc4_.length >= 2)
            {
               if(_loc4_[0] != MODULE_MOTOR_FRONT_ID)
               {
                  this.updateModule(_loc4_[0],_loc4_[1]);
               }
               else
               {
                  switch(_loc4_[2])
                  {
                     case "Front":
                        this.updateModule(MODULE_MOTOR_FRONT_ID,_loc4_[1]);
                        break;
                     case "Back":
                        this.updateModule(MODULE_MOTOR_BACK_ID,_loc4_[1]);
                        break;
                     case "Left":
                        this.updateModule(MODULE_MOTOR_LEFT_ID,_loc4_[1]);
                        break;
                     case "Right":
                        this.updateModule(MODULE_MOTOR_RIGHT_ID,_loc4_[1]);
                  }
               }
            }
            _loc3_++;
         }
         this.onDamageUpdated.fire();
      }
      
      private function damagePanelFire(param1:Boolean) : void
      {
         this.updateModule(MODULE_FIRE_ID,!!param1?int(STATE_DESTROYED_ID):int(STATE_NORMAL_ID));
         this.onDamageUpdated.fire();
      }
      
      private function showDamageDirectionArc(param1:Number, param2:Number) : void
      {
         this.arcAngle = param1;
         this.arcLivingTime = param2;
         this.onArcUpdated.fire();
      }
      
      public function getModuleState(param1:int) : int
      {
         return this._moduleStates[param1];
      }
      
      public function getModulesState(param1:Array) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(this.getModuleState(param1[_loc3_]));
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function showDamageMessage(param1:String, param2:int) : void
      {
         this._lastMessage.message = param1;
         this._lastMessage.type = param2;
         this.onGotMessage.fire();
      }
      
      public function initDamageScheme(param1:int) : void
      {
         this._damageScheme = param1;
         this.onDamageScheme.fire();
      }
      
      public function get isFireStateDestroyed() : Boolean
      {
         return this.getModuleState(MODULE_FIRE_ID) == STATE_DESTROYED_ID;
      }
   }
}
