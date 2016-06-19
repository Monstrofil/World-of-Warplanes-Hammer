package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import wowp.core.SWFLoader;
   import wowp.hud.model.control.HUDControlModel;
   import flash.events.Event;
   import wowp.hud.core.IHUDModelClient;
   import scaleform.clik.utils.Constraints;
   
   public class HUDTabState extends HUDState
   {
      
      private static const PATH:String = "hudBigPlayerList.swf";
       
      private var _loader:SWFLoader;
      
      public function HUDTabState()
      {
         this._loader = new SWFLoader();
         super();
      }
      
      override protected function onEnter() : void
      {
         model.control.mouseShow();
         layout.mouseEnabled = true;
         layout.mouseChildren = true;
         model.control.hideBackendGraphics(false,HUDControlModel.STATE_TAB);
         model.control.onHidePlayerList.add(this.close);
         model.control.onBattleResult.add(this.showBattleResults);
         if(model.control.isPlayerListShown)
         {
            this._loader.addEventListener(Event.COMPLETE,this.loadCompleted,false,0,true);
            this._loader.load(PATH);
            layout.visible = false;
         }
         else
         {
            this.close();
         }
         if(model.control.isBattleResult)
         {
            this.showBattleResults();
         }
      }
      
      override protected function onExit() : void
      {
         model.control.onHidePlayerList.remove(this.close);
         model.control.onBattleResult.remove(this.showBattleResults);
         hideWindow(this._loader.lastLoadedContent);
         layout.visible = true;
         model.control.showBackendGraphics();
      }
      
      private function close() : void
      {
         popState();
      }
      
      protected function showBattleResults() : void
      {
         changeState(HUDBattleResultsState);
      }
      
      protected function loadCompleted(param1:Event) : void
      {
         this._loader.removeEventListener(Event.COMPLETE,this.loadCompleted);
         if(this._loader.lastLoadedContent is IHUDModelClient)
         {
            (this._loader.lastLoadedContent as IHUDModelClient).setModel(model);
         }
         showWindow(this._loader.lastLoadedContent,Constraints.CENTER_H | Constraints.CENTER_V,false);
      }
   }
}
