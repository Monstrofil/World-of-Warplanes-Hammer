package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   
   public class HUDCursorState extends HUDState
   {
       
      public function HUDCursorState()
      {
         super();
      }
      
      override protected function onEnter() : void
      {
         model.control.mouseShow();
         layout.mouseEnabled = true;
         layout.mouseChildren = true;
         model.control.onBattleResult.add(this.showBattleResults);
         model.control.onVisibilityChanged.add(this.visibilityChangedHandler);
         model.control.onHideCursor.add(this.close);
         model.replays.onCompletionMessageReplaysShow.add(this.showCompletionMessageReplays);
         model.spectator.onSpectatorMode.add(this.setSpectatorMode);
         model.chat.onChangedVisible.add(this.setChatVisible);
      }
      
      override protected function onExit() : void
      {
         model.control.onBattleResult.remove(this.showBattleResults);
         model.control.onVisibilityChanged.remove(this.visibilityChangedHandler);
         model.control.onHideCursor.remove(this.close);
         model.replays.onCompletionMessageReplaysShow.remove(this.showCompletionMessageReplays);
         model.spectator.onSpectatorMode.remove(this.setSpectatorMode);
         model.chat.onChangedVisible.remove(this.setChatVisible);
      }
      
      protected function close() : void
      {
         popState();
      }
      
      protected function setChatVisible() : void
      {
         if(Boolean(model.chat.isChatVisibled) && !model.replays.isEnableReplays && model.spectator.spectatorMode == -1)
         {
            changeState(HUDChatState);
         }
      }
      
      protected function showBattleResults() : void
      {
         changeState(HUDBattleResultsState);
      }
      
      protected function visibilityChangedHandler() : void
      {
         if(!model.control.isHUDVisible)
         {
            pushState(HUDHiddenState);
         }
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
