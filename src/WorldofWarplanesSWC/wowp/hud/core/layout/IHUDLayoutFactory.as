package wowp.hud.core.layout
{
   public interface IHUDLayoutFactory
   {
       
      function get id() : String;
      
      function getLayout(param1:Class) : HUDLayout;
   }
}
