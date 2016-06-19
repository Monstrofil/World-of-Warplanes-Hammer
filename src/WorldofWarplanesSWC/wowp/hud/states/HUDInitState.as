package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import wowp.utils.display.cache.ICacheClient;
   import flash.events.Event;
   import flash.utils.setTimeout;
   import wowp.utils.display.cache.Cache;
   
   public class HUDInitState extends HUDState implements ICacheClient
   {
       
      private var _rslCount:int = 0;
      
      private var HUD_TUTORIAL:int = 3;
      
      private var HUD_WAITING:int = 4;
      
      public function HUDInitState()
      {
         super();
      }
      
      override protected function onEnter() : void
      {
         trace("HUDInitState::OnEnter");
         model.control.onShowHelp.add(this.showHelp);
         layout.addEventListener(Event.ENTER_FRAME,this.nextFrameHandler);
      }
      
      private function nextFrameHandler(param1:Event) : void
      {
         layout.removeEventListener(Event.ENTER_FRAME,this.nextFrameHandler);
         this.loadRSL("hudWOTIcons.swf");
         this.loadRSL("hudLayoutBase.swf");
         this.loadRSL("hudLayoutWOT.swf");
         this.loadRSL("hudLayoutLoading.swf");
         this.loadRSL("hudLayoutTutorialWOT.swf");
         this.loadRSL("hudInfoEntities.swf");
      }
      
      override protected function onExit() : void
      {
         model.control.onShowHelp.remove(this.showHelp);
         setTimeout(model.chat.getHistoryMessages,1);
      }
      
      private function loadRSL(param1:String) : void
      {
         this._rslCount++;
         Cache.getResource(param1,this);
      }
      
      public function onResourceLoaded(param1:Object) : void
      {
         this._rslCount--;
         if(this._rslCount == 0)
         {
            setTimeout(this.complete,1);
         }
      }
      
      private function complete() : void
      {
         trace("HUDInitState.complete");
         defaultState(HUDNormalState);
         model.init();
         model.layout.currentLayout = this.HUD_WAITING;
         changeState(HUDLoadingState);
      }
      
      private function showHelp() : void
      {
         if(Boolean(model) && Boolean(model.control.isHelpVisible))
         {
            changeState(HUDHelpState);
         }
      }
   }
}
