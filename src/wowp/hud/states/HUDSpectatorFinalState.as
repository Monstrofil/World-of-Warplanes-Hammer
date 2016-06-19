package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import flash.events.KeyboardEvent;
   import wowp.hud.model.control.HUDControlModel;
   import flash.ui.Keyboard;
   
   public class HUDSpectatorFinalState extends HUDState
   {
       
      public function HUDSpectatorFinalState()
      {
         super();
      }
      
      override protected function onEnter() : void
      {
         trace("HUDSpectatorFinalState");
         model.spectator.onSpectatorMode.add(this.setSpectatorMode);
         model.control.onShowCursor.add(this.enterCtrlState);
         model.control.onEscPressed.add(this.escPressed);
         model.chat.onChangedVisible.add(this.setChatVisible);
         layout.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         model.control.hideBackendGraphics(false,HUDControlModel.STATE_SPECTATORFINAL);
         model.control.mouseHide();
         this.setSpectatorMode();
      }
      
      override protected function onExit() : void
      {
         layout.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         model.spectator.onSpectatorMode.remove(this.setSpectatorMode);
         model.control.onShowCursor.remove(this.enterCtrlState);
         model.control.onEscPressed.remove(this.escPressed);
         model.chat.onChangedVisible.remove(this.setChatVisible);
      }
      
      protected function setChatVisible() : void
      {
         if(Boolean(model.chat.isChatVisibled) && !model.replays.isEnableReplays && Boolean(model.chat.isEnabled))
         {
            pushState(HUDChatSpectatorFinalState);
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
               if(!model.replays.isEnableReplays)
               {
                  model.spectator.needOutroFadein();
               }
         }
      }
      
      protected function escPressed() : void
      {
         pushState(HUDMenuSpectatorFinalState);
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
      }
      
      protected function enterCtrlState() : void
      {
         if(model.replays.isEnableReplays)
         {
            pushState(HUDCursorSpectatorFinalState);
         }
      }
   }
}
