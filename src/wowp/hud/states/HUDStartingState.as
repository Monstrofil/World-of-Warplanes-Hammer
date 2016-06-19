package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import flash.events.KeyboardEvent;
   import wowp.hud.model.loading.HUDLoadingModel;
   import flash.ui.Keyboard;
   import wowp.hud.model.layout.HUDLayoutModel;
   
   public class HUDStartingState extends HUDState
   {
       
      public function HUDStartingState()
      {
         super();
      }
      
      override protected function onEnter() : void
      {
         trace("HUDStartingState.onEnter");
         if(model.loading.isLoadingHidden)
         {
            this.close();
         }
         else
         {
            model.control.hideHud();
            model.control.mouseHide();
            model.loading.isShowCursor = false;
            model.loading.onLoadingFinished.add(this.close);
            model.control.onShowHelp.add(this.showHelp);
            model.control.onShowPlayerList.add(this.showPlayerList);
            model.control.onEscPressed.add(this.escPressed);
            model.chat.onChangedVisible.add(this.setChatVisible);
            if(model.replays.isEnableReplays)
            {
               model.control.onShowCursor.add(this.enterCtrlState);
            }
            layout.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         }
      }
      
      override protected function onExit() : void
      {
         model.loading.onLoadingFinished.remove(this.close);
         model.control.onShowHelp.remove(this.showHelp);
         model.control.onShowPlayerList.remove(this.showPlayerList);
         model.control.onEscPressed.remove(this.escPressed);
         model.chat.onChangedVisible.remove(this.setChatVisible);
         if(model.replays.isEnableReplays)
         {
            model.control.onShowCursor.remove(this.enterCtrlState);
         }
         layout.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
      }
      
      protected function setChatVisible() : void
      {
         if(Boolean(model.chat.isChatVisibled) && Boolean(model.chat.isEnabled) && model.loading.battleType != HUDLoadingModel.ARENA_TYPE_TUTORIAL)
         {
            pushState(HUDStartingChatState);
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
               break;
            case Keyboard.SPACE:
               model.loading.battleLoadingClose();
         }
      }
      
      protected function escPressed() : void
      {
         pushState(HUDStartingMenuState);
      }
      
      protected function showPlayerList() : void
      {
         pushState(HUDStartingTabState);
      }
      
      protected function enterCtrlState() : void
      {
         pushState(HUDStartingCursorState);
      }
      
      public function close() : void
      {
         if(model.tutorial.isTutorialStarted)
         {
            defaultState(HUDTutorialState);
            model.layout.currentLayout = HUDLayoutModel.HUD_TUTORIAL;
         }
         else
         {
            model.layout.currentLayout = HUDLayoutModel.HUD_WOT;
         }
         setDefault();
      }
      
      protected function showHelp() : void
      {
         if(Boolean(model) && Boolean(model.control.isHelpVisible))
         {
            pushState(HUDHelpState);
         }
      }
   }
}
