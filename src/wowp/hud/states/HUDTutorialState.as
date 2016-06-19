package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import flash.display.Loader;
   import flash.events.MouseEvent;
   import wowp.hud.model.control.HUDControlModel;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.system.ApplicationDomain;
   import scaleform.clik.utils.Constraints;
   
   public class HUDTutorialState extends HUDState
   {
       
      private const TUTORIAL_RESULT_WINDOW_PATH:String = "hangarTutorial.swf";
      
      private const TUTORIAL_NECESSARY_COMMAND_WINDOW_PATH:String = "settings.swf";
      
      private var _content:Loader;
      
      private var _neceassaryContent:Loader;
      
      public function HUDTutorialState()
      {
         this._content = new Loader();
         this._neceassaryContent = new Loader();
         super();
      }
      
      override protected function onEnter() : void
      {
         trace("HUDTutorialState::onEnter");
         model.control.onShowCursor.add(this.showCursor);
         model.control.onHideCursor.add(this.hideCursor);
         model.tutorial.onHideTutorial.add(this.hideTutorial);
         model.control.onVisibilityChanged.add(this.visibilityChangedHandler);
         model.tutorial.onShowTutorialResultWindow.add(this.showResultWindow);
         model.tutorial.onShowNecessaryCommandWindow.add(this.showNecessaryCommandWindow);
         model.tutorial.onLayoutTutorialInit.add(this.onEnterState);
         model.control.onShowPlayerList.add(this.showPlayerList);
         model.control.onEscPressed.add(this.escPressed);
         layout.stage.addEventListener(MouseEvent.CLICK,this.onMouseClick);
         if(model.tutorial.isLayoutTutorialInit)
         {
            this.onEnterState();
         }
      }
      
      private function onEnterState() : void
      {
         trace("HUDTutorialState::onEnterState");
         model.tutorial.sendTutorialInitialized();
         model.control.isBackendGraphicsVisible = false;
         model.control.showBackendGraphics();
         model.tutorial.sendEnterState();
         if(model.tutorial.isShowCursor)
         {
            this.showCursor();
         }
         else
         {
            this.hideCursor();
         }
         if(model.control.isCursorVisible)
         {
            this.showCursor();
         }
         if(model.tutorial.isShowModalWindow)
         {
            model.tutorial.isPause = true;
         }
         else
         {
            model.tutorial.isPause = false;
         }
         if(model.tutorial.showNecessarySettings)
         {
            this.showNecessaryCommandWindow();
         }
         if(Boolean(model.tutorial.isShowTutorialResultWindow) && model.tutorial.isShowModalWindow == false)
         {
            model.tutorial.isShowTutorialResultWindow = false;
            this.showResultWindow();
         }
         this.restoreAmmoLockState();
         this.restoreTutorialHintControl();
         this.restoreVisibilityControl();
         this.restoreVisibilityMimimap();
         this.restoreProgressbar();
      }
      
      override protected function onExit() : void
      {
         trace("HUDTutorialState::onExit");
         layout.stage.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         model.control.onShowCursor.remove(this.showCursor);
         model.control.onHideCursor.remove(this.hideCursor);
         model.tutorial.onHideTutorial.remove(this.hideTutorial);
         model.control.onVisibilityChanged.remove(this.visibilityChangedHandler);
         model.tutorial.onShowTutorialResultWindow.remove(this.showResultWindow);
         model.tutorial.onLayoutTutorialInit.remove(this.onEnterState);
         model.control.onShowPlayerList.remove(this.showPlayerList);
         model.control.onEscPressed.remove(this.escPressed);
         model.control.hideBackendGraphics(false,HUDControlModel.STATE_TUTORIAL);
         model.tutorial.isPause = true;
      }
      
      protected function escPressed() : void
      {
         if(!model.tutorial.isShowModalWindow)
         {
            model.tutorial.isFromMenuState = true;
            pushState(HUDMenuState);
         }
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         model.tutorial.onMouseClick(param1.target);
      }
      
      protected function visibilityChangedHandler() : void
      {
         if(!model.control.isHUDVisible)
         {
            model.tutorial.isFromMenuState = true;
            pushState(HUDHiddenState);
         }
      }
      
      protected function showCursor() : void
      {
         model.control.mouseShow();
         model.tutorial.isShowCursor = true;
      }
      
      protected function hideCursor() : void
      {
         model.control.mouseHide();
         model.tutorial.isShowCursor = false;
      }
      
      private function hideTutorial() : void
      {
         model.tutorial.isGoToHangar = false;
         model.control.gotoHangar();
      }
      
      private function showResultWindow() : void
      {
         this.saveDeviceState();
         model.control.hideBackendGraphics(false,HUDControlModel.STATE_TUTORIAL);
         this.showCursor();
         this.removeContent();
         this.load(this.TUTORIAL_RESULT_WINDOW_PATH);
      }
      
      private function removeContent() : void
      {
         if(this._content.content != null)
         {
            this._content.removeEventListener(Event.CLOSE,this.closeResultWindow);
            this._content.removeEventListener("GO_TO_HANGAR",this.goToHangar);
            this._content.removeEventListener("RESTART_LESSON",this.restartLesson);
            hideWindow(this._content);
            model.tutorial.isShowModalWindow = false;
         }
      }
      
      private function closeResultWindow() : void
      {
         this.removeContent();
         model.tutorial.isPause = false;
         model.tutorial.onClearTutorial.fire();
         model.control.showBackendGraphics();
         this.hideCursor();
         model.tutorial.isShowTutorialResultWindow = false;
         if(model.tutorial.isGoToHangar)
         {
            this.hideTutorial();
         }
      }
      
      private function load(param1:String) : void
      {
         this._content.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCompleted,false);
         this._content.load(new URLRequest(param1),new LoaderContext(false,ApplicationDomain.currentDomain));
         this._content.addEventListener(Event.CLOSE,this.closeResultWindow,false,0,true);
         this._content.addEventListener("GO_TO_HANGAR",this.goToHangar,false,0,true);
         this._content.addEventListener("RESTART_LESSON",this.restartLesson,false,0,true);
      }
      
      private function loadCompleted(param1:Event) : void
      {
         this._content.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadCompleted);
         showWindow(this._content,Constraints.CENTER_H | Constraints.CENTER_V,true);
         this.hideAllDevice();
         this.showCursor();
         model.tutorial.isShowModalWindow = true;
      }
      
      private function goToHangar() : void
      {
         model.tutorial.isGoToHangar = true;
      }
      
      private function showNecessaryCommandWindow() : void
      {
         model.tutorial.showNecessarySettings = false;
         model.control.hideBackendGraphics(false,HUDControlModel.STATE_TUTORIAL);
         this._neceassaryContent.contentLoaderInfo.addEventListener(Event.COMPLETE,this.necessaryWindowLoadCompleted,false);
         this._neceassaryContent.load(new URLRequest(this.TUTORIAL_NECESSARY_COMMAND_WINDOW_PATH),new LoaderContext(false,ApplicationDomain.currentDomain));
      }
      
      private function necessaryWindowLoadCompleted(param1:Event) : void
      {
         this._neceassaryContent.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.necessaryWindowLoadCompleted);
         (this._neceassaryContent.content as Object).isNecessary = true;
         (this._neceassaryContent.content as Object).addEventListener("APPLY",this.applyNecessaryCommand,false,0,true);
         (this._neceassaryContent.content as Object).addEventListener(Event.CLOSE,this.closeNecessaryWindow,false,0,true);
         model.tutorial.isShowModalWindow = true;
         model.tutorial.isPause = true;
         model.control.hideBackendGraphics(false,HUDControlModel.STATE_TUTORIAL);
         this.saveDeviceState();
         this.hideAllDevice();
         this.showCursor();
         showWindow(this._neceassaryContent,Constraints.CENTER_H | Constraints.CENTER_V,true);
      }
      
      private function closeNecessaryWindow(param1:Event) : void
      {
         if(this._neceassaryContent.content != null)
         {
            model.control.showBackendGraphics();
            (this._neceassaryContent.content as Object).removeEventListener(Event.CLOSE,this.closeNecessaryWindow);
            (this._neceassaryContent.content as Object).removeEventListener("APPLY",this.applyNecessaryCommand);
            hideWindow(this._neceassaryContent);
         }
         model.control.stopDispatchKeys();
         model.tutorial.isPause = false;
         model.tutorial.isFromMenuState = false;
         model.tutorial.isShowModalWindow = false;
         this.restoreDeviceState();
         this.hideCursor();
      }
      
      private function applyNecessaryCommand() : void
      {
      }
      
      private function restartLesson() : void
      {
         this.closeResultWindow();
         this.restoreDeviceState();
      }
      
      private function restoreDeviceState() : void
      {
         model.layout.damagePanelMode = model.tutorial.dataDeviceState.damagePanelMode;
         model.layout.speedometerMode = model.tutorial.dataDeviceState.speedometerMode;
         model.layout.variometerMode = model.tutorial.dataDeviceState.variometerMode;
         model.layout.weaponPanelMode = model.tutorial.dataDeviceState.weaponPanelMode;
         model.layout.healthmeterMode = model.tutorial.dataDeviceState.healthmeterMode;
         model.layout.aviaHorizonMode = model.tutorial.dataDeviceState.aviaHorizonMode;
         model.layout.crosshairMode = model.tutorial.dataDeviceState.crosshairMode;
         model.layout.targetWindowMode = model.tutorial.dataDeviceState.targetWindowMode;
         model.layout.minimapMode = model.tutorial.dataDeviceState.minimapMode;
         model.layout.forsageMode = model.tutorial.dataDeviceState.forsageMode;
         model.layout.equipmentPanelMode = model.tutorial.dataDeviceState.equipmentPanelMode;
         model.layout.playerListMode = model.tutorial.dataDeviceState.playerListMode;
         model.layout.battleMessagesMode = model.tutorial.dataDeviceState.battleMessagesMode;
         model.layout.onStateChanged.fire();
      }
      
      private function hideAllDevice() : void
      {
         model.layout.damagePanelMode = 0;
         model.layout.speedometerMode = 0;
         model.layout.variometerMode = 0;
         model.layout.weaponPanelMode = 0;
         model.layout.healthmeterMode = 0;
         model.layout.aviaHorizonMode = 0;
         model.layout.crosshairMode = 0;
         model.layout.targetWindowMode = 0;
         model.layout.minimapMode = 0;
         model.layout.forsageMode = 0;
         model.layout.equipmentPanelMode = 0;
         model.layout.playerListMode = 0;
         model.layout.battleMessagesMode = 0;
      }
      
      private function saveDeviceState() : void
      {
         model.tutorial.dataDeviceState.damagePanelMode = model.layout.damagePanelMode;
         model.tutorial.dataDeviceState.speedometerMode = model.layout.speedometerMode;
         model.tutorial.dataDeviceState.variometerMode = model.layout.variometerMode;
         model.tutorial.dataDeviceState.weaponPanelMode = model.layout.weaponPanelMode;
         model.tutorial.dataDeviceState.healthmeterMode = model.layout.healthmeterMode;
         model.tutorial.dataDeviceState.aviaHorizonMode = model.layout.aviaHorizonMode;
         model.tutorial.dataDeviceState.crosshairMode = model.layout.crosshairMode;
         model.tutorial.dataDeviceState.targetWindowMode = model.layout.targetWindowMode;
         model.tutorial.dataDeviceState.minimapMode = model.layout.minimapMode;
         model.tutorial.dataDeviceState.forsageMode = model.layout.forsageMode;
         model.tutorial.dataDeviceState.equipmentPanelMode = model.layout.equipmentPanelMode;
         model.tutorial.dataDeviceState.playerListMode = model.layout.playerListMode;
         model.tutorial.dataDeviceState.battleMessagesMode = model.layout.battleMessagesMode;
      }
      
      private function restoreAmmoLockState() : void
      {
         if(Boolean(model.tutorial.dataAmmoLock.hasOwnProperty("rocket")) && Boolean(model.tutorial.dataAmmoLock.hasOwnProperty("bomb")) && Boolean(model.tutorial.dataAmmoLock.hasOwnProperty("cannon")))
         {
            model.tutorial.onLockAmmo.fire();
         }
      }
      
      private function restoreTutorialHintControl() : void
      {
         model.tutorial.onShowHintControlTutorial.fire();
      }
      
      private function restoreVisibilityControl() : void
      {
         model.tutorial.dataElementsVisible.markerPointer = model.tutorial.isMarkerPointerVisible;
         model.tutorial.dataElementsVisible.hintControl = model.tutorial.isHintControlVisible;
         model.tutorial.onSetElementsVisibleTutorial.fire();
      }
      
      private function restoreVisibilityMimimap() : void
      {
         model.map.onMapHeightChanged.fire();
      }
      
      private function restoreProgressbar() : void
      {
         model.tutorial.onUpdateProgressBarTutorial.fire();
      }
      
      protected function showPlayerList() : void
      {
         if(!model.tutorial.isShowModalWindow)
         {
            pushState(HUDTabState);
         }
      }
   }
}
