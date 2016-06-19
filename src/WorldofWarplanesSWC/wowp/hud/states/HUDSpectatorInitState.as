package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import wowp.hud.model.control.HUDControlModel;
   
   public class HUDSpectatorInitState extends HUDState
   {
       
      public function HUDSpectatorInitState()
      {
         super();
      }
      
      override protected function onEnter() : void
      {
         trace("HUDSpectatorInitState");
         model.spectator.onSpectatorMode.add(this.setSpectatorMode);
         model.control.onShowCursor.add(this.enterCtrlState);
         model.control.onEscPressed.add(this.escPressed);
         model.control.hideBackendGraphics(false,HUDControlModel.STATE_SPECTATORINIT);
         model.control.mouseHide();
         this.setSpectatorMode();
      }
      
      override protected function onExit() : void
      {
         model.spectator.onSpectatorMode.remove(this.setSpectatorMode);
         model.control.onShowCursor.remove(this.enterCtrlState);
         model.control.onEscPressed.remove(this.escPressed);
      }
      
      protected function escPressed() : void
      {
         pushState(HUDMenuSpectatorInitState);
      }
      
      protected function close() : void
      {
         popState();
      }
      
      protected function setSpectatorMode() : void
      {
         if(model.spectator.spectatorMode == -1)
         {
            this.close();
            return;
         }
         switch(model.spectator.spectatorMode)
         {
            case 1:
               pushState(HUDSpectatorDefaultState);
               break;
            case 2:
               pushState(HUDSpectatorDinamicState);
               break;
            case 3:
               pushState(HUDSpectatorCinemaState);
               break;
            case 4:
               pushState(HUDSpectatorFinalState);
         }
      }
      
      protected function enterCtrlState() : void
      {
         pushState(HUDCursorSpectatorInitState);
      }
   }
}
