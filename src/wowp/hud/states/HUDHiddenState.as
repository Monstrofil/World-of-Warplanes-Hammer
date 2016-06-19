package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import wowp.hud.model.control.HUDControlModel;
   
   public class HUDHiddenState extends HUDState
   {
       
      public function HUDHiddenState()
      {
         super();
      }
      
      override protected function onEnter() : void
      {
         model.control.hideBackendGraphics(false,HUDControlModel.STATE_HIDDEN);
         if(!model.replays.isEnableReplays)
         {
            model.control.mouseHide();
         }
         else
         {
            model.control.mouseShow();
         }
         model.control.onVisibilityChanged.add(this.visibilityChangeHandler);
         model.control.onShowCursor.add(this.showCursor);
         model.control.onHideCursor.add(this.hideCursor);
         model.control.onBattleResult.add(this.showBattleResults);
         model.control.onShowHelp.add(this.showHelp);
         model.control.onShowPlayerList.add(this.showPlayerList);
         model.control.onEscPressed.add(this.escPressed);
         model.replays.onCompletionMessageReplaysShow.add(this.showCompletionMessageReplays);
         model.spectator.onSpectatorMode.add(this.setSpectatorMode);
         if(model.control.isBattleResult)
         {
            this.showBattleResults();
         }
         this.visibilityChangeHandler();
      }
      
      override protected function onExit() : void
      {
         model.control.onVisibilityChanged.remove(this.visibilityChangeHandler);
         model.control.onShowCursor.remove(this.showCursor);
         model.control.onHideCursor.remove(this.hideCursor);
         model.control.onBattleResult.remove(this.showBattleResults);
         model.control.onShowHelp.remove(this.showHelp);
         model.control.onShowPlayerList.remove(this.showPlayerList);
         model.control.onEscPressed.remove(this.escPressed);
         model.replays.onCompletionMessageReplaysShow.remove(this.showCompletionMessageReplays);
         model.spectator.onSpectatorMode.remove(this.setSpectatorMode);
      }
      
      private function visibilityChangeHandler() : void
      {
         if(model.control.isHUDVisible)
         {
            model.control.showBackendGraphics();
            popState();
         }
      }
      
      private function showCursor() : void
      {
         if(model.replays.isEnableReplays)
         {
            model.control.mouseShow();
         }
      }
      
      private function hideCursor() : void
      {
         if(model.replays.isEnableReplays)
         {
            model.control.mouseHide();
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
         pushState(HUDTabState);
      }
      
      protected function escPressed() : void
      {
         pushState(HUDMenuState);
      }
      
      protected function showBattleResults() : void
      {
         changeState(HUDBattleResultsState);
      }
      
      protected function showCompletionMessageReplays() : void
      {
         pushState(HUDCompletionState);
      }
      
      protected function setSpectatorMode() : void
      {
         model.loading.saveChatSettings();
         model.messages.saveBattleMessageSettings();
         switch(model.spectator.spectatorMode)
         {
            case 0:
               pushState(HUDSpectatorInitState);
               break;
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
   }
}
