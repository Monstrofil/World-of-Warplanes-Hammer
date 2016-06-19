package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.system.ApplicationDomain;
   import scaleform.clik.utils.Constraints;
   import wowp.hud.core.IHUDModelClient;
   
   public class HUDStartingTabState extends HUDState
   {
      
      private static const PATH:String = "hudBigPlayerList.swf";
       
      private var _loader:Loader;
      
      public function HUDStartingTabState()
      {
         this._loader = new Loader();
         super();
      }
      
      override protected function onEnter() : void
      {
         trace("HUDStartingTabState::onEnter");
         model.control.mouseShow();
         layout.mouseEnabled = true;
         layout.mouseChildren = true;
         model.control.onHidePlayerList.add(this.close);
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCompleted,false,0,true);
         this._loader.load(new URLRequest(PATH),new LoaderContext(false,ApplicationDomain.currentDomain));
         model.layout.setVisibleBlackout(true);
      }
      
      override protected function onExit() : void
      {
         model.control.onHidePlayerList.remove(this.close);
         hideWindow(this._loader);
         this._loader.unloadAndStop();
         model.layout.setVisibleBlackout(false);
      }
      
      private function close() : void
      {
         popState();
      }
      
      protected function loadCompleted(param1:Event) : void
      {
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadCompleted);
         showWindow(this._loader,Constraints.CENTER_H | Constraints.CENTER_V,false);
         if(this._loader.content is IHUDModelClient)
         {
            (this._loader.content as IHUDModelClient).setModel(model);
         }
      }
   }
}
