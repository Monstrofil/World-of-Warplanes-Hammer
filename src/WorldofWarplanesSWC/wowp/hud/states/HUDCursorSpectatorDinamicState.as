package wowp.hud.states
{
   public class HUDCursorSpectatorDinamicState extends HUDCursorState
   {
       
      public function HUDCursorSpectatorDinamicState()
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
      
      override protected function visibilityChangedHandler() : void
      {
         if(!model.control.isHUDVisible)
         {
            pushState(HUDHiddenSpectatorDinamicState);
         }
      }
   }
}
