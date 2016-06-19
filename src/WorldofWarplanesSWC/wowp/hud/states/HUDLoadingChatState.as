package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   
   public class HUDLoadingChatState extends HUDState
   {
       
      public function HUDLoadingChatState()
      {
         super();
      }
      
      override protected function onEnter() : void
      {
         model.control.startDispatchKeys();
         model.loading.onLoadingFinished.add(this.close);
         model.loading.onRequestLoadingClose.add(this.requestLoadingClose);
         model.chat.onChangedVisible.add(this.setChatVisible);
      }
      
      override protected function onExit() : void
      {
         model.control.stopDispatchKeys();
         model.loading.onLoadingFinished.remove(this.close);
         model.loading.onRequestLoadingClose.remove(this.requestLoadingClose);
         model.chat.onChangedVisible.remove(this.setChatVisible);
      }
      
      protected function close() : void
      {
         popState();
      }
      
      protected function setChatVisible() : void
      {
         if(!model.chat.isChatVisibled)
         {
            popState();
         }
      }
      
      public function requestLoadingClose() : void
      {
         model.loading.saveChatSettings();
         pushState(HUDStartingState);
      }
   }
}
