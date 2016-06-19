package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import wowp.hud.model.control.HUDControlModel;
   
   public class HUDSpectatorDefaultState extends HUDState
   {
       
      public function HUDSpectatorDefaultState()
      {
         super();
      }
      
      override protected function onEnter() : void
      {
         trace("HUDSpectatorDefaultState");
         model.spectator.onSpectatorMode.add(this.setSpectatorMode);
         model.spectator.onNeedFadein.add(this.setFadein);
         model.control.onShowCursor.add(this.enterCtrlState);
         model.control.onVisibilityChanged.add(this.visibilityChangedHandler);
         model.control.onShowHelp.add(this.showHelp);
         model.control.onShowPlayerList.add(this.showPlayerList);
         model.control.onEscPressed.add(this.escPressed);
         model.chat.onChangedVisible.add(this.setChatVisible);
         layout.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         model.control.showBackendGraphics();
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
            pushState(HUDChatSpectatorDefaultState);
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
         pushState(HUDMenuSpectatorDefaultState);
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
      
      protected function setFadein() : void
      {
         model.control.hideBackendGraphics(false,HUDControlModel.STATE_SPECTATORDEFAULT);
      }
      
      protected function enterCtrlState() : void
      {
         pushState(HUDCursorSpectatorDefaultState);
      }
      
      protected function visibilityChangedHandler() : void
      {
         if(!model.control.isHUDVisible)
         {
            model.loading.saveChatSettings();
            model.messages.saveBattleMessageSettings();
            pushState(HUDHiddenSpectatorDefaultState);
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
         pushState(HUDTabSpectatorDefaultState);
      }
   }
}
