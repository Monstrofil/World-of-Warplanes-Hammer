package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import flash.display.Loader;
   import wowp.hud.model.control.HUDControlModel;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.system.ApplicationDomain;
   import scaleform.clik.utils.Constraints;
   import flash.utils.setTimeout;
   
   public class HUDHelpState extends HUDState
   {
      
      private static const PATH:String = "help.swf";
      
      private static const PATH_REPLAYS:String = "helpReplays.swf";
       
      private var _loader:Loader;
      
      public function HUDHelpState()
      {
         this._loader = new Loader();
         super();
      }
      
      override protected function onEnter() : void
      {
         if(model.loading.loadingFinished)
         {
            model.control.hideBackendGraphics(true,HUDControlModel.STATE_HELP);
         }
         else
         {
            model.control.hideHud();
         }
         model.control.mouseShow();
         layout.visible = false;
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCompleted,false,0,true);
         this._loader.addEventListener(Event.CLOSE,this.closeHandler);
         this._loader.addEventListener("settings button pressed",this.showSettings);
         this._loader.addEventListener("exit button pressed",this.closeHandler);
         if(!model.replays.isEnableReplays)
         {
            this._loader.load(new URLRequest(PATH),new LoaderContext(false,ApplicationDomain.currentDomain));
         }
         else
         {
            this._loader.load(new URLRequest(PATH_REPLAYS),new LoaderContext(false,ApplicationDomain.currentDomain));
         }
         model.control.onShowHelp.add(this.close);
         model.control.onBattleResult.add(this.showBattleResults);
         model.control.onEscPressed.add(this.escPressed);
         model.layout.onAlternativeColorChange.add(this.setAlternativeColor);
         model.layout.onLayoutResize.add(this.layoutResize);
         if(!model.control.isHelpVisible)
         {
            model.control.helpDeInitialized();
            popState();
         }
      }
      
      override protected function onExit() : void
      {
         this._loader.removeEventListener(Event.CLOSE,this.closeHandler);
         this._loader.removeEventListener("settings button pressed",this.showSettings);
         this._loader.removeEventListener("exit button pressed",this.closeHandler);
         this._loader.unloadAndStop();
         model.control.onShowHelp.remove(this.close);
         model.control.onBattleResult.remove(this.showBattleResults);
         model.control.onEscPressed.remove(this.escPressed);
         model.layout.onAlternativeColorChange.remove(this.setAlternativeColor);
         model.layout.onLayoutResize.remove(this.layoutResize);
         hideWindow(this._loader);
         layout.visible = true;
      }
      
      protected function escPressed() : void
      {
         this.close();
      }
      
      protected function loadCompleted(param1:Event) : void
      {
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadCompleted);
         showWindow(this._loader,Constraints.CENTER_H | Constraints.CENTER_V,false);
         setTimeout(this.setAlternativeColor,1);
      }
      
      private function setHelpDeInitialized() : void
      {
         if(Boolean(model) && Boolean(model.control.isHelpVisible))
         {
            model.control.isHelpVisible = false;
            model.control.helpDeInitialized();
         }
      }
      
      private function showSettings(param1:Event) : void
      {
         this.setHelpDeInitialized();
         changeState(HUDSettingsState);
      }
      
      protected function showBattleResults() : void
      {
         this.setHelpDeInitialized();
         defaultState(HUDBattleResultsState);
      }
      
      protected function close() : void
      {
         this.setHelpDeInitialized();
         popState();
      }
      
      protected function closeHandler(param1:Event = null) : void
      {
         this.close();
      }
      
      private function setAlternativeColor() : void
      {
         if(this._loader.content)
         {
            if(model.layout.isAlternativeColor)
            {
               this._loader.content.dispatchEvent(new Event("setAlternativeColor",true));
            }
            else
            {
               this._loader.content.dispatchEvent(new Event("setNormalColor",true));
            }
         }
      }
      
      private function layoutResize() : void
      {
         if(this._loader.content)
         {
            if(model.replays.isEnableReplays)
            {
               this._loader.content.dispatchEvent(new Event("layoutResize",true));
            }
         }
      }
   }
}
