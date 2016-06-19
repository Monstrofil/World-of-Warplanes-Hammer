package wowp.hud.model.vo
{
   public class HUDDeviceRatioVO
   {
       
      public var xs:Number = 0.1;
      
      public var x1:Number = 0.2;
      
      public var x2:Number = 0.4;
      
      public var x3:Number = 0.6;
      
      public var x4:Number = 0.7;
      
      public var xf:Number = 0.8;
      
      public function HUDDeviceRatioVO()
      {
         super();
      }
      
      public function parse(param1:Object) : void
      {
         if(param1.hasOwnProperty("xs"))
         {
            this.xs = param1.xs;
         }
         if(param1.hasOwnProperty("x1"))
         {
            this.x1 = param1.x1;
         }
         if(param1.hasOwnProperty("x2"))
         {
            this.x2 = param1.x2;
         }
         if(param1.hasOwnProperty("x3"))
         {
            this.x3 = param1.x3;
         }
         if(param1.hasOwnProperty("x4"))
         {
            this.x4 = param1.x4;
         }
         if(param1.hasOwnProperty("xf"))
         {
            this.xf = param1.xf;
         }
      }
   }
}
