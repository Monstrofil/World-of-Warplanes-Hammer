package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import flash.events.KeyboardEvent;
   import wowp.hud.model.control.HUDControlModel;
   import flash.ui.Keyboard;
   
   public class HUDSpectatorDinamicState extends HUDState
   {
       
      public function HUDSpectatorDinamicState()
      {
         super();
      }
      
      override protected function onEnter() : void
      {
         trace("HUDSpectatorDinamicState");
         model.spectator.onSpectatorMode.add(this.setSpectatorMode);
         model.spectator.onNeedFadein.add(this.setFadein);
         model.control.onShowCursor.add(this.enterCtrlState);
         model.control.onVisibilityChanged.add(this.visibilityChangedHandler);
         model.control.onShowHelp.add(this.showHelp);
         model.control.onShowPlayerList.add(this.showPlayerList);
         model.control.onEscPressed.add(this.escPressed);
         model.chat.onChangedVisible.add(this.setChatVisible);
         layout.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         model.control.hideBackendGraphics(false,HUDControlModel.STATE_SPECTATORDINAMIC);
         model.control.mouseHide();
         this.setSpectatorMode();
      }
      
      override protected function onExit() : void
      {
         layout.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         model.spectator.onSpectatorMode.remove(this.setSpectatorMode);
         model.spectator.onNeedFadein.remove(this.setFadein);
         model.control.onShowCursor.remove(this.enterCtrlState);
         model.control.onVisibilityChanged.remove(this.visibilityChangedHandler);
         model.control.onShowHelp.remove(this.showHelp);
         model.control.onShowPlayerList.remove(this.showPlayerList);
         model.control.onEscPressed.remove(this.escPressed);
         model.chat.onChangedVisible.remove(this.setChatVisible);
      }
      
      protected function setChatVisible() : void
      {
         if(Boolean(model.chat.isChatVisibled) && !model.replays.isEnableReplays && Boolean(model.chat.isEnabled))
         {
            pushState(HUDChatSpectatorDinamicState);
         }
      }
      
      private function keyDownHandler(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case Keyboard.PAGE_UP:
               model.chat.pageUp();
               break;
            case Keyboard.PAGE_DOWN:
               model.chat.pageDown();
         }
      }
      
      protected function escPressed() : void
      {
         pushState(HUDMenuSpectatorDinamicState);
      }
      
      protected function close() : void
      {
         popState();
      }
      
      protected function setSpectatorMode() : void
      {
         model.loading.saveChatSettings();
         switch(model.spectator.spectatorMode)
         {
            case 0:
               pushState(HUDSpectatorInitState);
               break;
            case 1:
               pushState(HUDSpectatorDefaultState);
               break;
            case 3:
               pushState(HUDSpectatorCinemaState);
               break;
            case 4:
               pushState(HUDSpectatorFinalState);
         }
      }
      
      protected function setFadein() : void
      {
         model.control.hideBackendGraphics(false,HUDControlModel.STATE_SPECTATORDINAMIC);
      }
      
      protected function enterCtrlState() : void
      {
         pushState(HUDCursorSpectatorDinamicState);
      }
      
      protected function visibilityChangedHandler() : void
      {
         if(!model.control.isHUDVisible)
         {
            model.loading.saveChatSettings();
            model.messages.saveBattleMessageSettings();
            pushState(HUDHiddenSpectatorDinamicState);
         }
      }
      
      protected function showHelp() : void
      {
         if(Boolean(model) && Boolean(model.control.isHelpVisible))
         {
            pushState(HUDHelpState);
         }
      }
      
      protected function showPlayerList() : void
      {
         pushState(HUDTabSpectatorDinamicState);
      }
   }
}
