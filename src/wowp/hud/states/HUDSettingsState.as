package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.system.ApplicationDomain;
   import wowp.hud.model.control.HUDControlModel;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import scaleform.clik.utils.Constraints;
   
   public class HUDSettingsState extends HUDState
   {
      
      private static const PATH:String = "settings.swf";
       
      private var _loader:Loader;
      
      public function HUDSettingsState()
      {
         this._loader = new Loader();
         super();
      }
      
      override protected function onEnter() : void
      {
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCompleted,false,0,true);
         this._loader.addEventListener(Event.CLOSE,this.close);
         this._loader.load(new URLRequest(PATH),new LoaderContext(false,ApplicationDomain.currentDomain));
         layout.visible = false;
         model.control.hideBackendGraphics(false,HUDControlModel.STATE_SETTINGS);
         model.control.mouseShow();
         model.control.startDispatchKeys();
         model.control.onBattleResult.add(this.setBattleResults);
      }
      
      override protected function onExit() : void
      {
         model.control.stopDispatchKeys();
         this._loader.removeEventListener(Event.CLOSE,this.close);
         layout.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler,false);
         model.control.onBattleResult.remove(this.setBattleResults);
         hideWindow(this._loader);
         this._loader.unloadAndStop();
         layout.visible = true;
      }
      
      private function keyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ESCAPE)
         {
            popState();
         }
      }
      
      protected function loadCompleted(param1:Event) : void
      {
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadCompleted);
         layout.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler,false,0,true);
         showWindow(this._loader,Constraints.CENTER_H | Constraints.CENTER_V,false);
      }
      
      protected function close(param1:Event) : void
      {
         popState();
      }
      
      protected function setBattleResults() : void
      {
         defaultState(HUDBattleResultsState);
      }
   }
}
