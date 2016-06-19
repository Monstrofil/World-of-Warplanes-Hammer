package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import wowp.hud.model.control.HUDControlModel;
   
   public class HUDChatState extends HUDState
   {
       
      public function HUDChatState()
      {
         super();
      }
      
      override protected function onEnter() : void
      {
         model.control.startDispatchKeys();
         model.control.onBattleResult.add(this.showBattleResults);
         model.spectator.onSpectatorMode.add(this.setSpectatorMode);
         model.spectator.onNeedFadein.add(this.setFadein);
         model.control.onShowCursor.add(this.showCursor);
         model.control.onHideCursor.add(this.hideCursor);
         model.chat.onChangedVisible.add(this.setChatVisible);
      }
      
      override protected function onExit() : void
      {
         model.control.stopDispatchKeys();
         model.control.onBattleResult.remove(this.showBattleResults);
         model.spectator.onSpectatorMode.remove(this.setSpectatorMode);
         model.spectator.onNeedFadein.remove(this.setFadein);
         model.control.onShowCursor.remove(this.showCursor);
         model.control.onHideCursor.remove(this.hideCursor);
         model.chat.onChangedVisible.remove(this.setChatVisible);
      }
      
      protected function showBattleResults() : void
      {
         changeState(HUDBattleResultsState);
      }
      
      protected function showCursor() : void
      {
         model.control.mouseShow();
      }
      
      protected function hideCursor() : void
      {
         model.control.mouseHide();
      }
      
      protected function setChatVisible() : void
      {
         if(!model.chat.isChatVisibled)
         {
            popState();
         }
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
      
      protected function setFadein() : void
      {
         model.control.hideBackendGraphics(false,HUDControlModel.STATE_CHAT);
      }
   }
}
