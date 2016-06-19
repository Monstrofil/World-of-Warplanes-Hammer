package wowp.hud.core.layout
{
   public class HUDDefaultLayoutFactory implements IHUDLayoutFactory
   {
       
      public function HUDDefaultLayoutFactory()
      {
         super();
      }
      
      public function get id() : String
      {
         return "default factory";
      }
      
      public function getLayout(param1:Class) : HUDLayout
      {
         return new HUDLayout();
      }
   }
}
