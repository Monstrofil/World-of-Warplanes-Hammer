package wowp.hud
{
   import flash.display.Sprite;
   import wowp.hud.model.HUDModel;
   import wowp.hud.core.layout.HUDLayoutManager;
   import wowp.hud.core.states.HUDFSM;
   import flash.display.DisplayObjectContainer;
   import wowp.core.layers.LayerManager;
   import wowp.hud.core.layout.HUDLayout;
   import wowp.hud.common.infoEntities.InfoEntities;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import wowp.sound.UISound;
   import wowp.sound.UIHUDSoundRegistrator;
   import wowp.hud.core.states.HUDFSMEvent;
   import wowp.utils.display.cache.Cache;
   import wowp.hud.core.states.HUDState;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import wowp.utils.string.cutTextfieldName;
   import wowp.core.LocalizationManager;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import wowp.hud.states.HUDInitState;
   import flash.display.Loader;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.system.ApplicationDomain;
   
   public class HUD extends Sprite
   {
       
      private var _model:HUDModel;
      
      private var _layoutManager:HUDLayoutManager;
      
      private var _mapping:wowp.hud.HUDMapping;
      
      private var _fsm:HUDFSM;
      
      private var _uiLayers:DisplayObjectContainer;
      
      private var _layerManager:LayerManager;
      
      private var _layoutsContainer:DisplayObjectContainer;
      
      private var _currentLayout:HUDLayout;
      
      public var mcInfoEntities:InfoEntities;
      
      public function HUD()
      {
         super();
         cutTextfieldName(null,null);
         mouseEnabled = false;
         LocalizationManager.getInstance();
         stage.align = StageAlign.TOP_LEFT;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.addEventListener(Event.RESIZE,this.resizeHandler);
         this._model = new HUDModel();
         this._model.addEventListener(HUDModel.MODEL_INITIALIZED,this.modelInitHandler);
         this._model.addEventListener(HUDModel.DISPOSE,this.disposeHandler);
         this._model.control.onEscPressed.add(this.escPressed);
         this._fsm = new HUDFSM();
         this._fsm.addEventListener(HUDFSMEvent.STATE_ACTIVATED,this.stateActivatedHandler);
         this._fsm.addEventListener(HUDFSMEvent.STATE_DEACTIVATED,this.stateDeactivatedEvent);
         this._layoutManager = new HUDLayoutManager();
         this._layoutManager.onFactoryChanged.add(this.factoryChangeHandler);
         this._layoutsContainer = new Sprite();
         addChild(this._layoutsContainer);
         this._layoutsContainer.name = "layoutContainer";
         this._uiLayers = new Sprite();
         addChild(this._uiLayers);
         this._uiLayers.name = "uiLayers";
         this._layerManager = new LayerManager(this._uiLayers);
         this._mapping = new wowp.hud.HUDMapping(this._layoutManager,this._model);
         this._fsm.start(HUDInitState);
         var _loc1_:Loader = new Loader();
         stage.addChild(_loc1_);
         _loc1_.load(new URLRequest("debug/common/debugWindow.swf"),new LoaderContext(false,ApplicationDomain.currentDomain));
         if(stage)
         {
            this.addedToStageHandler(null);
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         }
      }
      
      private function clickTest(param1:MouseEvent) : void
      {
         trace("-------clickTest---------");
         this._model.messages.testElements();
      }
      
      private function addedToStageHandler(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         this.updateSize();
         UISound.instanse.init(stage);
         UIHUDSoundRegistrator.register();
      }
      
      public function disposeHandler(param1:Event) : void
      {
         this._layerManager.dispose();
         this._layoutManager.onFactoryChanged.remove(this.factoryChangeHandler);
         this._layoutManager.dispose();
         this._fsm.dispose();
         this._fsm.removeEventListener(HUDFSMEvent.STATE_ACTIVATED,this.stateActivatedHandler);
         this._fsm.removeEventListener(HUDFSMEvent.STATE_DEACTIVATED,this.stateDeactivatedEvent);
         this._model.removeEventListener(HUDModel.DISPOSE,this.disposeHandler);
         this._model.control.onEscPressed.remove(this.escPressed);
         this._model.dispose();
         this._mapping.dispose();
         stage.removeEventListener(Event.RESIZE,this.resizeHandler);
         this.mcInfoEntities.dispose();
         Cache.dispose();
      }
      
      private function modelInitHandler(param1:Event) : void
      {
         this._model.removeEventListener(HUDModel.MODEL_INITIALIZED,this.modelInitHandler);
         this.mcInfoEntities = new InfoEntities();
         addChildAt(this.mcInfoEntities,0);
         this.mcInfoEntities.setModel(this._model);
      }
      
      private function stateActivatedHandler(param1:HUDFSMEvent) : void
      {
         var _loc2_:HUDState = param1.state;
         if(this._currentLayout == null)
         {
            this.initLayout(this._layoutManager.getLayout(_loc2_.getStateClass()));
         }
         _loc2_.layout = this._currentLayout;
         _loc2_.setModel(this._model);
      }
      
      private function stateDeactivatedEvent(param1:HUDFSMEvent) : void
      {
         var _loc2_:HUDState = param1.state;
         if(this._layoutManager.getLayout(param1.newState.getStateClass()) != this._currentLayout)
         {
            this.disposeLayout(_loc2_.layout);
         }
         _loc2_.layout = null;
         _loc2_.setModel(null);
      }
      
      private function factoryChangeHandler() : void
      {
         var _loc1_:HUDState = this._fsm.currentState;
         this.disposeLayout(_loc1_.layout);
         this.initLayout(this._layoutManager.getLayout(_loc1_.getStateClass()));
         _loc1_.layout = this._currentLayout;
      }
      
      private function initLayout(param1:HUDLayout) : void
      {
         param1.init(this._model);
         this._layoutsContainer.addChild(param1);
         param1.name = "layout";
         param1.resize(stage.stageWidth,stage.stageHeight);
         this._currentLayout = param1;
      }
      
      private function disposeLayout(param1:HUDLayout) : void
      {
         param1.dispose();
         this._layoutsContainer.removeChild(param1);
         this._currentLayout = null;
      }
      
      private function resizeHandler(param1:Event) : void
      {
         this.updateSize();
         if(this._currentLayout)
         {
            this._currentLayout.resize(stage.stageWidth,stage.stageHeight);
         }
         this._mapping.resize(stage.stageWidth,stage.stageHeight);
      }
      
      private function escPressed() : void
      {
         var _loc1_:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN,true,true,0,Keyboard.ESCAPE);
         if(stage.focus != null)
         {
            stage.focus.dispatchEvent(_loc1_);
         }
         else
         {
            stage.dispatchEvent(_loc1_);
         }
      }
      
      private function updateSize() : void
      {
         if(stage)
         {
            this._model.control.stageHeight = stage.stageHeight;
            this._model.control.stageWidth = stage.stageWidth;
         }
      }
   }
}
