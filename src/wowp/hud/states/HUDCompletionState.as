package wowp.hud.states
{
   import wowp.hud.core.states.HUDState;
   import flash.text.TextField;
   import wowp.controls.dialog.Dialog;
   import flash.events.Event;
   import wowp.core.layers.windows.events.HideWindowEvent;
   import wowp.core.LocalizationManager;
   import wowp.controls.UIFactory;
   import wowp.core.layers.windows.events.ShowWindowEvent;
   import scaleform.clik.utils.Constraints;
   
   public class HUDCompletionState extends HUDState
   {
       
      public function HUDCompletionState()
      {
         super();
         isEnterWithoutDelay = true;
      }
      
      override protected function onEnter() : void
      {
         model.control.mouseShow();
         this.showCompletionMessage();
      }
      
      override protected function onExit() : void
      {
      }
      
      private function showCompletionMessage() : void
      {
         var dlg:Dialog = null;
         var cancelHandler:Function = null;
         var removedFromStageHandler:Function = null;
         cancelHandler = function(param1:Event):void
         {
            param1.stopPropagation();
            layout.stage.dispatchEvent(new HideWindowEvent(dlg));
            model.control.gotoWindows();
         };
         removedFromStageHandler = function(param1:Event):void
         {
            dlg.removeEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
            dlg.removeEventListener(Event.CLOSE,cancelHandler);
            dlg.removeEventListener("NO",cancelHandler);
         };
         var header:String = LocalizationManager.getInstance().textByLocalizationID("REPLAY_MESSAGE_REPLAY_ENDED");
         var message:String = LocalizationManager.getInstance().textByLocalizationID("REPLAY_MESSAGE_REPLAY_ENDED_OK_TO_EXIT");
         var textfield:TextField = UIFactory.createTextField();
         textfield.htmlText = message;
         dlg = UIFactory.createDialog(header,[{
            "label":LocalizationManager.getInstance().textByLocalizationID("WING_BUTTON_OK"),
            "event":"NO"
         }],textfield);
         dlg.addEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
         dlg.addEventListener(Event.CLOSE,cancelHandler);
         dlg.addEventListener("NO",cancelHandler);
         layout.stage.dispatchEvent(new ShowWindowEvent(dlg,Constraints.CENTER_H | Constraints.CENTER_V,true));
      }
   }
}
