package wowp.hud.model.targetCapture.vo
{
   import wowp.hud.model.damage.HudDamageModel;
   import wowp.utils.string.time.concatNickname;
   
   public class CapturedTargetVO
   {
      
      public static const ENGINE_MODULE_STATE:String = "l_engine";
      
      public static const L_WIND_MODULE_STATE:String = "l_lWind";
      
      public static const R_WIND_MODULE_STATE:String = "l_rWind";
      
      public static const TAIL_MODULE_STATE:String = "l_tail";
      
      public static const TURRET_MODULE_STATE:String = "l_turret";
      
      public static const PILOT_MODULE_STATE:String = "l_pilot";
      
      public static const REAL_MODULES_ID:Array = [[HudDamageModel.MODULE_PLANE_LEFT_WING_ID],[HudDamageModel.MODULE_PLANE_RIGHT_WING_ID],[HudDamageModel.MODULE_PLANE_TAIL_ID],[HudDamageModel.MODULE_MOTOR_FRONT_ID,HudDamageModel.MODULE_MOTOR_BACK_ID,HudDamageModel.MODULE_MOTOR_LEFT_ID,HudDamageModel.MODULE_MOTOR_RIGHT_ID],[HudDamageModel.MODULE_MEMBER_GUNNER1_ID,HudDamageModel.MODULE_MEMBER_GUNNER2_ID,HudDamageModel.MODULE_GUN_ID,HudDamageModel.MODULE_CANNON_ID,HudDamageModel.MODULE_FIRE_ID],[HudDamageModel.MODULE_MEMBER_PILOT_ID]];
       
      public var distance:String;
      
      public var metric:String;
      
      public var name:String;
      
      public var health:int;
      
      public var level:int;
      
      public var icon:String;
      
      public var isAvatar:Boolean;
      
      public var type:String;
      
      public var firepowerState:int;
      
      public var maneuverabilityState:int;
      
      public var speedState:int;
      
      public var heightState:int;
      
      public var strengthState:int;
      
      public var newModules:Array;
      
      public function CapturedTargetVO()
      {
         this.newModules = [];
         super();
      }
      
      public static function getPositionBySlot(param1:int) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < REAL_MODULES_ID.length)
         {
            if(REAL_MODULES_ID[_loc2_].indexOf(param1) != -1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public static function getStrPositionByPosition(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return L_WIND_MODULE_STATE;
            case 1:
               return R_WIND_MODULE_STATE;
            case 2:
               return TAIL_MODULE_STATE;
            case 3:
               return ENGINE_MODULE_STATE;
            case 4:
               return TURRET_MODULE_STATE;
            case 5:
               return PILOT_MODULE_STATE;
            default:
               return ENGINE_MODULE_STATE;
         }
      }
      
      public function setData(param1:Object) : void
      {
         this.distance = param1.distance;
         this.metric = param1.metric;
         this.name = concatNickname(param1.name,param1.clanAbbrev);
         this.health = param1.health;
         this.level = param1.level;
         this.icon = param1.icon;
         this.isAvatar = param1.isAvatar;
         this.type = param1.type;
         this.firepowerState = param1.firepowerState;
         this.maneuverabilityState = param1.maneuverabilityState;
         this.speedState = param1.speedState;
         this.heightState = param1.heightState;
         this.strengthState = param1.strengthState;
      }
      
      public function getActualModules() : Array
      {
         var _loc2_:ModuleCapturedTarget = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc1_:Array = [];
         var _loc5_:Object = {};
         var _loc6_:int = 0;
         while(_loc6_ < this.newModules.length)
         {
            _loc2_ = this.newModules[_loc6_];
            _loc3_ = _loc2_.id;
            _loc4_ = _loc2_.state;
            if(_loc4_ >= 2)
            {
               _loc9_ = getPositionBySlot(_loc3_);
               if(_loc9_ != -1)
               {
                  if(_loc5_[_loc9_] != null)
                  {
                     if(_loc5_[_loc9_].state < _loc4_)
                     {
                        _loc5_[_loc9_].state = _loc4_;
                        _loc5_[_loc9_].index = _loc6_;
                     }
                  }
                  else
                  {
                     _loc5_[_loc9_] = new Object();
                     _loc5_[_loc9_].state = _loc4_;
                     _loc5_[_loc9_].index = _loc6_;
                  }
               }
            }
            _loc6_++;
         }
         var _loc7_:Array = new Array();
         for(_loc8_ in _loc5_)
         {
            _loc7_.push(_loc5_[_loc8_]);
         }
         _loc7_.sortOn("index",Array.NUMERIC);
         _loc6_ = 0;
         while(_loc6_ < _loc7_.length)
         {
            _loc1_.push(this.newModules[_loc7_[_loc6_].index]);
            _loc6_++;
         }
         return _loc1_;
      }
      
      public function getNewModule(param1:int, param2:String = "") : ModuleCapturedTarget
      {
         var _loc3_:ModuleCapturedTarget = null;
         var _loc4_:int = 0;
         for(; _loc4_ < this.newModules.length; _loc4_++)
         {
            if(this.newModules[_loc4_].id == param1 && this.newModules[_loc4_].position == param2)
            {
               if(_loc3_ != null)
               {
                  if(_loc3_.state < this.newModules[_loc4_].state)
                  {
                     _loc3_ = this.newModules[_loc4_];
                     continue;
                  }
               }
               _loc3_ = this.newModules[_loc4_];
               continue;
            }
         }
         return _loc3_;
      }
      
      public function clear() : void
      {
         while(this.newModules.length)
         {
            this.newModules.splice(0,1);
         }
         this.newModules = new Array();
      }
   }
}
