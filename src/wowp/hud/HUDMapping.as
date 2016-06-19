package wowp.hud
{
   import wowp.hud.core.layout.HUDLayoutManager;
   import wowp.hud.model.HUDModel;
   import flash.utils.clearTimeout;
   import flash.events.Event;
   import flash.utils.setTimeout;
   import wowp.hud.model.layout.HUDLayoutModel;
   import wowp.hud.view.HUDLayoutFactory;
   import wowp.utils.domain.getDefinition;
   import wowp.hud.states.HUDNormalState;
   import wowp.hud.states.HUDCursorState;
   import wowp.hud.states.HUDChatState;
   import wowp.hud.states.HUDMenuState;
   import wowp.hud.states.HUDCompletionState;
   import wowp.hud.states.HUDTabState;
   import wowp.hud.states.HUDHelpState;
   import wowp.hud.states.HUDSettingsState;
   import wowp.hud.states.HUDHiddenState;
   import wowp.hud.states.HUDHiddenSpectatorDefaultState;
   import wowp.hud.states.HUDHiddenSpectatorDinamicState;
   import wowp.hud.states.HUDSpectatorInitState;
   import wowp.hud.states.HUDCursorSpectatorInitState;
   import wowp.hud.states.HUDMenuSpectatorInitState;
   import wowp.hud.states.HUDHelpSpectatorInitState;
   import wowp.hud.states.HUDSettingsSpectatorInitState;
   import wowp.hud.states.HUDSpectatorDefaultState;
   import wowp.hud.states.HUDCursorSpectatorDefaultState;
   import wowp.hud.states.HUDTabSpectatorDefaultState;
   import wowp.hud.states.HUDChatSpectatorDefaultState;
   import wowp.hud.states.HUDMenuSpectatorDefaultState;
   import wowp.hud.states.HUDHelpSpectatorDefaultState;
   import wowp.hud.states.HUDSettingsSpectatorDefaultState;
   import wowp.hud.states.HUDSpectatorDinamicState;
   import wowp.hud.states.HUDCursorSpectatorDinamicState;
   import wowp.hud.states.HUDTabSpectatorDinamicState;
   import wowp.hud.states.HUDChatSpectatorDinamicState;
   import wowp.hud.states.HUDMenuSpectatorDinamicState;
   import wowp.hud.states.HUDHelpSpectatorDinamicState;
   import wowp.hud.states.HUDSettingsSpectatorDinamicState;
   import wowp.hud.states.HUDSpectatorCinemaState;
   import wowp.hud.states.HUDCursorSpectatorCinemaState;
   import wowp.hud.states.HUDTabSpectatorCinemaState;
   import wowp.hud.states.HUDChatSpectatorCinemaState;
   import wowp.hud.states.HUDMenuSpectatorCinemaState;
   import wowp.hud.states.HUDHelpSpectatorCinemaState;
   import wowp.hud.states.HUDSettingsSpectatorCinemaState;
   import wowp.hud.states.HUDSpectatorFinalState;
   import wowp.hud.states.HUDCursorSpectatorFinalState;
   import wowp.hud.states.HUDChatSpectatorFinalState;
   import wowp.hud.states.HUDMenuSpectatorFinalState;
   import wowp.hud.states.HUDTutorialState;
   import wowp.hud.states.HUDLoadingState;
   import wowp.hud.states.HUDLoadingChatState;
   import wowp.hud.states.HUDStartingState;
   import wowp.hud.states.HUDStartingChatState;
   import wowp.hud.states.HUDStartingMenuState;
   import wowp.hud.states.HUDStartingCursorState;
   import wowp.hud.states.HUDStartingTabState;
   
   public class HUDMapping
   {
       
      private var _layoutManager:HUDLayoutManager;
      
      private var _model:HUDModel;
      
      private var _layoutValidationTimeoutID:uint;
      
      public function HUDMapping(param1:HUDLayoutManager, param2:HUDModel)
      {
         super();
         this._model = param2;
         this._layoutManager = param1;
         this._model.addEventListener(HUDModel.MODEL_INITIALIZED,this.modelInitHandler);
      }
      
      public function dispose() : void
      {
         clearTimeout(this._layoutValidationTimeoutID);
         this._model.layout.onStateChanged.remove(this.invalidateLayout);
         this._model.layout.onLayoutChange.remove(this.invalidateLayout);
         this._model = null;
         this._layoutManager = null;
      }
      
      public function modelInitHandler(param1:Event) : void
      {
         this._model.removeEventListener(HUDModel.MODEL_INITIALIZED,this.modelInitHandler);
         this.createMapping();
         this._model.layout.onStateChanged.add(this.invalidateLayout);
         this._model.layout.onLayoutChange.add(this.invalidateLayout);
      }
      
      private function invalidateLayout() : void
      {
         clearTimeout(this._layoutValidationTimeoutID);
         this._layoutValidationTimeoutID = setTimeout(this.validateLayout,1);
      }
      
      private function validateLayout() : void
      {
         trace("HUDMapping::validateLayout");
         if(this._model.layout.currentLayout == HUDLayoutModel.HUD_WOT)
         {
            this._layoutManager.setConcreteFactory(HUDConstants.WOT_STYLE_LAYOUT_1);
         }
         if(this._model.layout.currentLayout == HUDLayoutModel.HUD_TUTORIAL)
         {
            this._layoutManager.setConcreteFactory(HUDConstants.TUTORIAL_STYLE_LAYOUT_1);
         }
         if(this._model.layout.currentLayout == HUDLayoutModel.HUD_WAITING)
         {
            this._layoutManager.setConcreteFactory(HUDConstants.WAITING_STYLE_LAYOUT_1);
         }
      }
      
      public function resize(param1:Number, param2:int) : void
      {
      }
      
      private function createMapping() : void
      {
         var _loc1_:HUDLayoutFactory = new HUDLayoutFactory(HUDConstants.WOT_STYLE_LAYOUT_1);
         _loc1_.mapLayout(getDefinition("WOTLayout") as Class,HUDNormalState);
         _loc1_.mapLayout(getDefinition("WOTLayout") as Class,HUDCursorState);
         _loc1_.mapLayout(getDefinition("WOTLayout") as Class,HUDChatState);
         _loc1_.mapLayout(getDefinition("WOTLayout") as Class,HUDMenuState);
         _loc1_.mapLayout(getDefinition("WOTLayout") as Class,HUDCompletionState);
         _loc1_.mapLayout(getDefinition("WOTLayout") as Class,HUDTabState);
         _loc1_.mapLayout(getDefinition("WOTLayout") as Class,HUDHelpState);
         _loc1_.mapLayout(getDefinition("WOTLayout") as Class,HUDSettingsState);
         _loc1_.mapLayout(getDefinition("WOTLayoutReplays") as Class,HUDHiddenState);
         _loc1_.mapLayout(getDefinition("WOTLayoutReplays") as Class,HUDHiddenSpectatorDefaultState);
         _loc1_.mapLayout(getDefinition("WOTLayoutReplays") as Class,HUDHiddenSpectatorDinamicState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorInit") as Class,HUDSpectatorInitState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorInit") as Class,HUDCursorSpectatorInitState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorInit") as Class,HUDMenuSpectatorInitState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorInit") as Class,HUDHelpSpectatorInitState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorInit") as Class,HUDSettingsSpectatorInitState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorDefault") as Class,HUDSpectatorDefaultState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorDefault") as Class,HUDCursorSpectatorDefaultState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorDefault") as Class,HUDTabSpectatorDefaultState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorDefault") as Class,HUDChatSpectatorDefaultState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorDefault") as Class,HUDMenuSpectatorDefaultState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorDefault") as Class,HUDHelpSpectatorDefaultState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorDefault") as Class,HUDSettingsSpectatorDefaultState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorDinamic") as Class,HUDSpectatorDinamicState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorDinamic") as Class,HUDCursorSpectatorDinamicState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorDinamic") as Class,HUDTabSpectatorDinamicState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorDinamic") as Class,HUDChatSpectatorDinamicState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorDinamic") as Class,HUDMenuSpectatorDinamicState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorDinamic") as Class,HUDHelpSpectatorDinamicState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorDinamic") as Class,HUDSettingsSpectatorDinamicState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorCinema") as Class,HUDSpectatorCinemaState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorCinema") as Class,HUDCursorSpectatorCinemaState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorCinema") as Class,HUDTabSpectatorCinemaState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorCinema") as Class,HUDChatSpectatorCinemaState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorCinema") as Class,HUDMenuSpectatorCinemaState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorCinema") as Class,HUDHelpSpectatorCinemaState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorCinema") as Class,HUDSettingsSpectatorCinemaState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorFinal") as Class,HUDSpectatorFinalState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorFinal") as Class,HUDCursorSpectatorFinalState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorFinal") as Class,HUDChatSpectatorFinalState);
         _loc1_.mapLayout(getDefinition("WOTLayoutSpectatorFinal") as Class,HUDMenuSpectatorFinalState);
         this._layoutManager.registerFactory(_loc1_);
         var _loc2_:HUDLayoutFactory = new HUDLayoutFactory(HUDConstants.TUTORIAL_STYLE_LAYOUT_1);
         _loc2_.mapLayout(getDefinition("WOTTutorialLayout") as Class,HUDTutorialState);
         _loc2_.mapLayout(getDefinition("WOTTutorialLayout") as Class,HUDCursorState);
         _loc2_.mapLayout(getDefinition("WOTTutorialLayout") as Class,HUDMenuState);
         this._layoutManager.registerFactory(_loc2_);
         var _loc3_:HUDLayoutFactory = new HUDLayoutFactory(HUDConstants.WAITING_STYLE_LAYOUT_1);
         _loc3_.mapLayout(getDefinition("LoadingLayout") as Class,HUDLoadingState);
         _loc3_.mapLayout(getDefinition("LoadingLayout") as Class,HUDLoadingChatState);
         _loc3_.mapLayout(getDefinition("StartingLayout") as Class,HUDStartingState);
         _loc3_.mapLayout(getDefinition("StartingLayout") as Class,HUDStartingChatState);
         _loc3_.mapLayout(getDefinition("StartingLayout") as Class,HUDStartingMenuState);
         _loc3_.mapLayout(getDefinition("StartingLayout") as Class,HUDStartingCursorState);
         _loc3_.mapLayout(getDefinition("StartingLayout") as Class,HUDStartingTabState);
         this._layoutManager.registerFactory(_loc3_);
      }
   }
}
