package wowp.hud.model.targetCapture.vo
{
   public class ModuleCapturedTarget
   {
       
      public var id:int = -1;
      
      public var state:int = -1;
      
      public var frameName:String = "";
      
      public var position:String = "";
      
      public var positionBySlot:int = -1;
      
      public function ModuleCapturedTarget()
      {
         super();
      }
      
      public function setData(param1:Array) : void
      {
         this.id = param1[0];
         this.state = param1[1];
         this.position = param1[2];
         this.frameName = param1[3];
         this.positionBySlot = param1[4];
      }
      
      public function toString() : String
      {
         return "MODULE CAPTURED TARGET:::id:" + this.id + " state:" + this.state + " position:" + this.position + " frameName:" + this.frameName;
      }
   }
}
