package wowp.hud.states
{
   public class HUDHiddenSpectatorDefaultState extends HUDHiddenState
   {
       
      public function HUDHiddenSpectatorDefaultState()
      {
         super();
      }
      
      override protected function onEnter() : void
      {
         super.onEnter();
      }
      
      override protected function onExit() : void
      {
         super.onExit();
      }
      
      override protected function escPressed() : void
      {
         pushState(HUDMenuSpectatorDefaultState);
      }
   }
}
