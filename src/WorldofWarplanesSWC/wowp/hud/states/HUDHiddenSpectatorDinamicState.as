package wowp.hud.states
{
   public class HUDHiddenSpectatorDinamicState extends HUDHiddenState
   {
       
      public function HUDHiddenSpectatorDinamicState()
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
         pushState(HUDMenuSpectatorDinamicState);
      }
   }
}
