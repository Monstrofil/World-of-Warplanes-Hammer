package wowp.hud.model.loading.vo
{
   import wowp.core.base.BaseVO;
   
   public class VehicleCompareVO extends BaseVO
   {
       
      public var firepower:int;
      
      public var maneuverability:int;
      
      public var speed:int;
      
      public var height:int;
      
      public var hp:int;
      
      public var firepowerState:int;
      
      public var maneuverabilityState:int;
      
      public var speedState:int;
      
      public var heightState:int;
      
      public var hpState:int;
      
      public var firepowerText:String;
      
      public var maneuverabilityText:String;
      
      public var speedText:String;
      
      public var heightText:String;
      
      public var hpText:String;
      
      public var description:Array;
      
      public var planeName:String;
      
      public var planeIconPath:String;
      
      public var typeIconPath:String;
      
      public var isEnemy:Boolean;
      
      public function VehicleCompareVO(param1:Object)
      {
         super(param1);
      }
      
      public function toString() : String
      {
         return "[VehicleCompareVO firepower=" + this.firepower + " maneuverability=" + this.maneuverability + " speed=" + this.speed + " height=" + this.height + " firepowerState=" + this.firepowerState + " maneuverabilityState=" + this.maneuverabilityState + " speedState=" + this.speedState + " heightState=" + this.heightState + " firepowerText=" + this.firepowerText + " maneuverabilityText=" + this.maneuverabilityText + " speedText=" + this.speedText + " heightText=" + this.heightText + " planeName=" + this.planeName + " planeIconPath=" + this.planeIconPath + " isEnemy=" + this.isEnemy + " description=" + this.description + "]";
      }
   }
}
