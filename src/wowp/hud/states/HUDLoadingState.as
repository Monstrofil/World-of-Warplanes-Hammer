package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import flash.events.KeyboardEvent;
   import wowp.hud.model.loading.HUDLoadingModel;
   import wowp.utils.Utils;
   import flash.ui.Keyboard;
   import wowp.hud.model.layout.HUDLayoutModel;
   
   public class HUDLoadingState extends HUDState
   {
       
      public function HUDLoadingState()
      {
         super();
      }
      
      override protected function onEnter() : void
      {
         trace("HUDLoadingState.onEnter");
         if(model.loading.isLoadingHidden)
         {
            this.close();
         }
         else
         {
            model.control.showHud();
            model.control.mouseShow();
            model.loading.isShowCursor = true;
            model.loading.onLoadingFinished.add(this.close);
            model.loading.onRequestLoadingClose.add(this.requestLoadingClose);
            model.chat.onChangedVisible.add(this.setChatVisible);
            layout.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         }
      }
      
      override protected function onExit() : void
      {
         trace("HUDLoadingState.onExit");
         model.loading.onLoadingFinished.remove(this.close);
         model.loading.onRequestLoadingClose.remove(this.requestLoadingClose);
         model.chat.onChangedVisible.remove(this.setChatVisible);
         layout.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
      }
      
      protected function setChatVisible() : void
      {
         if(Boolean(model.chat.isChatVisibled) && Boolean(model.chat.isEnabled) && model.loading.battleType != HUDLoadingModel.ARENA_TYPE_TUTORIAL)
         {
            pushState(HUDLoadingChatState);
         }
      }
      
      private function keyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:Array = null;
         switch(param1.keyCode)
         {
            case Keyboard.PAGE_UP:
               model.chat.pageUp();
               break;
            case Keyboard.PAGE_DOWN:
               model.chat.pageDown();
               break;
            case Keyboard.SPACE:
               if(model.loading.isArenaLoaded)
               {
                  _loc2_ = Utils.formatTime(model.time.bigTime).split(Utils.TIME_SEPARATOR);
                  if(_loc2_[1] > 0)
                  {
                     if(!model.loading.isIntroEnabled)
                     {
                        model.loading.saveChatSettings();
                        model.loading.battleLoadingClose();
                     }
                     else
                     {
                        this.requestLoadingClose();
                     }
                  }
               }
         }
      }
      
      public function close() : void
      {
         trace("HUDLoadingState.close");
         model.control.mouseHide();
         model.loading.isShowCursor = false;
         if(model.tutorial.isTutorialStarted)
         {
            defaultState(HUDTutorialState);
            model.layout.currentLayout = HUDLayoutModel.HUD_TUTORIAL;
         }
         else
         {
            model.layout.currentLayout = HUDLayoutModel.HUD_WOT;
         }
         if(Boolean(model) && Boolean(model.control.isHelpVisible))
         {
            changeState(HUDHelpState);
         }
         else
         {
            setDefault();
         }
      }
      
      public function requestLoadingClose() : void
      {
         model.loading.saveChatSettings();
         pushState(HUDStartingState);
      }
   }
}
