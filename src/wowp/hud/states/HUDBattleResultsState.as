package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.system.ApplicationDomain;
   import wowp.hud.model.control.HUDControlModel;
   import scaleform.clik.utils.Constraints;
   
   public class HUDBattleResultsState extends HUDState
   {
      
      private static const PATH:String = "stats.swf";
       
      private var _loader:Loader;
      
      public function HUDBattleResultsState()
      {
         this._loader = new Loader();
         super();
      }
      
      override protected function onEnter() : void
      {
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCompleted,false,0,true);
         this._loader.load(new URLRequest(PATH),new LoaderContext(false,ApplicationDomain.currentDomain));
         model.control.hideBackendGraphics(false,HUDControlModel.STATE_BATTLERESULTS);
         model.control.mouseShow();
         model.control.startDispatchKeys();
         model.control.onEscPressed.add(this.escPressed);
      }
      
      override protected function onExit() : void
      {
         this._loader.removeEventListener(Event.CLOSE,this.closeHandler,false);
         model.control.mouseHide();
         model.control.onEscPressed.remove(this.escPressed);
      }
      
      protected function loadCompleted(param1:Event) : void
      {
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadCompleted);
         this._loader.addEventListener(Event.CLOSE,this.closeHandler,false,0,true);
         showWindow(this._loader,Constraints.CENTER_H | Constraints.CENTER_V,false);
      }
      
      protected function close() : void
      {
         model.control.gotoHangar();
      }
      
      private function closeHandler(param1:Event) : void
      {
         this.close();
      }
      
      protected function escPressed() : void
      {
         model.control.gotoHangar();
      }
   }
}
