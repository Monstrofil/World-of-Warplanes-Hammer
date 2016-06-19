package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import wowp.hud.model.control.HUDControlModel;
   
   public class HUDNormalState extends HUDState
   {
       
      private var HUD_TUTORIAL:int = 3;
      
      public function HUDNormalState()
      {
         super();
      }
      
      override protected function onEnter() : void
      {
         model.control.showBackendGraphics();
         if(Boolean(model.chat.isChatVisibled) && !model.replays.isEnableReplays)
         {
            pushState(HUDChatState);
            return;
         }
         model.control.onBattleResult.add(this.showBattleResults);
         model.control.onShowCursor.add(this.enterCtrlState);
         model.control.onHideCursor.add(this.hideCursor);
         model.control.onVisibilityChanged.add(this.visibilityChangedHandler);
         model.control.onShowHelp.add(this.showHelp);
         model.control.onShowPlayerList.add(this.showPlayerList);
         model.control.onEscPressed.add(this.escPressed);
         model.replays.onCompletionMessageReplaysShow.add(this.showCompletionMessageReplays);
         model.spectator.onSpectatorMode.add(this.setSpectatorMode);
         model.spectator.onNeedFadein.add(this.setFadein);
         model.chat.onChangedVisible.add(this.setChatVisible);
         if(model.control.isCursorVisible)
         {
            this.enterCtrlState();
         }
         model.control.mouseHide();
         layout.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         if(model.control.isBattleResult)
         {
            this.showBattleResults();
         }
         this.setSpectatorMode();
         this.showHelp();
         this.visibilityChangedHandler();
      }
      
      override protected function onExit() : void
      {
         layout.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         model.control.onBattleResult.remove(this.showBattleResults);
         model.control.onShowCursor.remove(this.enterCtrlState);
         model.control.onHideCursor.remove(this.hideCursor);
         model.control.onVisibilityChanged.remove(this.visibilityChangedHandler);
         model.control.onShowHelp.remove(this.showHelp);
         model.control.onShowPlayerList.remove(this.showPlayerList);
         model.control.onEscPressed.remove(this.escPressed);
         model.replays.onCompletionMessageReplaysShow.remove(this.showCompletionMessageReplays);
         model.spectator.onSpectatorMode.remove(this.setSpectatorMode);
         model.spectator.onNeedFadein.remove(this.setFadein);
         model.chat.onChangedVisible.remove(this.setChatVisible);
      }
      
      protected function setChatVisible() : void
      {
         if(Boolean(model.chat.isChatVisibled) && !model.replays.isEnableReplays && Boolean(model.chat.isEnabled))
         {
            pushState(HUDChatState);
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
      
      protected function enterCtrlState() : void
      {
         pushState(HUDCursorState);
      }
      
      protected function hideCursor() : void
      {
         model.control.mouseHide();
      }
      
      protected function visibilityChangedHandler() : void
      {
         if(!model.control.isHUDVisible)
         {
            model.loading.saveChatSettings();
            model.messages.saveBattleMessageSettings();
            pushState(HUDHiddenState);
         }
      }
      
      protected function showBattleResults() : void
      {
         changeState(HUDBattleResultsState);
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
      
      protected function setFadein() : void
      {
         model.control.hideBackendGraphics(false,HUDControlModel.STATE_NORMAL);
      }
   }
}
