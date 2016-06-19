package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import wowp.core.SWFLoader;
   import flash.display.DisplayObject;
   import wowp.controls.dialog.Dialog;
   import flash.events.Event;
   import wowp.hud.model.control.HUDControlModel;
   import flash.utils.clearTimeout;
   import wowp.hud.common.menu.HUDMenuEvents;
   import wowp.hud.common.menu.HUDMenuSetCursorEvent;
   import scaleform.clik.utils.Constraints;
   import flash.display.Sprite;
   import wowp.controls.ButtonEx;
   import scaleform.clik.events.ButtonEvent;
   import wowp.core.LocalizationManager;
   import wowp.controls.UIFactory;
   
   public class HUDMenuState extends HUDState
   {
      
      private static const PATH:String = "hudMenu.swf";
      
      private static const PATH_REPLAYS:String = "hudMenuReplays.swf";
       
      private var _swfLoader:SWFLoader;
      
      private var _currentWindow:DisplayObject;
      
      private var _dialog:Dialog = null;
      
      private var _showCursorTimeout:uint;
      
      public function HUDMenuState()
      {
         super();
      }
      
      override protected function onEnter() : void
      {
         this._swfLoader = new SWFLoader();
         this._swfLoader.addEventListener(Event.COMPLETE,this.loadCompleted);
         if(!model.replays.isEnableReplays)
         {
            this._swfLoader.load(PATH);
         }
         else
         {
            this._swfLoader.load(PATH_REPLAYS);
         }
         model.control.hideBackendGraphics(false,HUDControlModel.STATE_MENU);
         model.control.startDispatchKeys();
         model.control.togglePauseMenu(true);
         model.control.onBattleResult.add(this.setBattleResults);
         model.control.onEscPressed.add(this.escPressed);
         model.spectator.onSpectatorMode.add(this.setSpectatorMode);
      }
      
      override protected function onExit() : void
      {
         clearTimeout(this._showCursorTimeout);
         if(this._currentWindow)
         {
            this._currentWindow.removeEventListener(HUDMenuEvents.CLOSE,this.closeHandler,false);
            this._currentWindow.removeEventListener(HUDMenuEvents.EXIT,this.exitRequest,false);
            this._currentWindow.removeEventListener(HUDMenuEvents.SETTINGS,this.showSettings,false);
            this._currentWindow.removeEventListener(HUDMenuEvents.HELP,this.showHelp,false);
            this._currentWindow.removeEventListener(HUDMenuEvents.ENTER,this.showEnter,false);
            this._currentWindow.removeEventListener(HUDMenuSetCursorEvent.SET_CURSOR,this.setCursorHandler,false);
            hideWindow(this._currentWindow);
            this._currentWindow = null;
         }
         model.control.stopDispatchKeys();
         model.control.togglePauseMenu(false);
         model.control.onBattleResult.remove(this.setBattleResults);
         model.control.onEscPressed.remove(this.escPressed);
         model.spectator.onSpectatorMode.remove(this.setSpectatorMode);
      }
      
      protected function escPressed() : void
      {
         if(this._dialog)
         {
            this.closeDialogHandler(null);
         }
         popState();
      }
      
      protected function loadCompleted(param1:Event) : void
      {
         if(this._swfLoader.lastLoadedContent)
         {
            this._swfLoader.removeEventListener(Event.COMPLETE,this.loadCompleted);
            this._currentWindow = this._swfLoader.lastLoadedContent;
            this._currentWindow.visible = true;
            this._currentWindow.addEventListener(HUDMenuEvents.CLOSE,this.closeHandler,false,0,true);
            this._currentWindow.addEventListener(HUDMenuEvents.EXIT,this.exitRequest,false,0,true);
            this._currentWindow.addEventListener(HUDMenuEvents.SETTINGS,this.showSettings,false,0,true);
            this._currentWindow.addEventListener(HUDMenuEvents.HELP,this.showHelp,false,0,true);
            this._currentWindow.addEventListener(HUDMenuEvents.ENTER,this.showEnter,false);
            this._currentWindow.addEventListener(HUDMenuSetCursorEvent.SET_CURSOR,this.setCursorHandler,false,0,true);
            showWindow(this._currentWindow,Constraints.CENTER_H | Constraints.CENTER_V,true);
         }
      }
      
      protected function setBattleResults() : void
      {
         defaultState(HUDBattleResultsState);
      }
      
      protected function closeHandler(param1:Event = null) : void
      {
         popState();
      }
      
      protected function showEnter(param1:Event = null) : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:ButtonEx = null;
         if(!this._currentWindow.visible && Boolean(this._dialog))
         {
            _loc2_ = this._dialog["buttons"] as Sprite;
            _loc3_ = _loc2_.getChildByName("YES") as ButtonEx;
            if(_loc3_)
            {
               _loc3_.dispatchEvent(new Event(ButtonEvent.CLICK,true));
            }
            else
            {
               this.onDialogConfirm();
            }
         }
         else
         {
            this.closeHandler();
         }
      }
      
      protected function setCursorHandler(param1:HUDMenuSetCursorEvent) : void
      {
         if(Boolean(model) && Boolean(model.control))
         {
            model.control.setCursor(param1.x,param1.y);
            model.control.mouseShow();
         }
      }
      
      private function showSettings(param1:Event) : void
      {
         switch(model.spectator.spectatorMode)
         {
            case 0:
               changeState(HUDSettingsSpectatorInitState);
               break;
            case 1:
               changeState(HUDSettingsSpectatorDefaultState);
               break;
            case 2:
               changeState(HUDSettingsSpectatorDinamicState);
               break;
            case 3:
               changeState(HUDSettingsSpectatorCinemaState);
               break;
            default:
               changeState(HUDSettingsState);
         }
      }
      
      private function showHelp(param1:Event) : void
      {
         model.control.isHelpVisible = true;
         switch(model.spectator.spectatorMode)
         {
            case 0:
               changeState(HUDHelpSpectatorInitState);
               break;
            case 1:
               changeState(HUDHelpSpectatorDefaultState);
               break;
            case 2:
               changeState(HUDHelpSpectatorDinamicState);
               break;
            case 3:
               changeState(HUDHelpSpectatorCinemaState);
               break;
            default:
               changeState(HUDHelpState);
         }
      }
      
      protected function exitRequest(param1:Event = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         this._currentWindow.visible = false;
         if(!model.replays.isEnableReplays)
         {
            _loc2_ = LocalizationManager.getInstance().textByLocalizationID("dialog_leave_battle_header");
            _loc3_ = LocalizationManager.getInstance().textByLocalizationID("dialog_leave_battle_message");
         }
         else
         {
            _loc2_ = LocalizationManager.getInstance().textByLocalizationID("REPLAY_MESSAGE_HEADER_REPLAY_ENDED");
            _loc3_ = LocalizationManager.getInstance().textByLocalizationID("REPLAY_MESSAGE_LEAVE_REPLAY");
         }
         this._dialog = UIFactory.createConfirmationDialog(this._currentWindow.stage,_loc2_,_loc3_,this.onDialogConfirm,this.closeHandler);
         this._dialog.addEventListener(Event.CLOSE,this.closeDialogHandler);
         showWindow(this._dialog,Constraints.CENTER_H | Constraints.CENTER_V,true);
      }
      
      private function closeDialogHandler(param1:Event = null) : void
      {
         if(param1)
         {
            param1.stopImmediatePropagation();
         }
         this._dialog.removeEventListener(Event.CLOSE,this.closeDialogHandler);
         hideWindow(this._dialog);
         this._dialog = null;
      }
      
      private function onDialogConfirm() : void
      {
         if(!model.replays.isEnableReplays)
         {
            model.control.gotoHangar();
         }
         else
         {
            model.control.gotoWindows();
         }
      }
      
      protected function setSpectatorMode() : void
      {
         model.loading.saveChatSettings();
         model.messages.saveBattleMessageSettings();
         if(this._dialog)
         {
            this.closeDialogHandler();
         }
         switch(model.spectator.spectatorMode)
         {
            case 0:
               pushState(HUDSpectatorInitState);
               break;
            case 1:
               pushState(HUDSpectatorDefaultState);
               break;
            case 2:
               pushState(HUDSpectatorDinamicState);
               break;
            case 3:
               pushState(HUDSpectatorCinemaState);
               break;
            case 4:
               pushState(HUDSpectatorFinalState);
         }
      }
   }
}
