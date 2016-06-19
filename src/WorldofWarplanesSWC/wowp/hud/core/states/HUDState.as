package wowp.hud.core.states
{
   import flash.events.EventDispatcher;
   import wowp.hud.core.layout.HUDLayout;
   import wowp.hud.model.HUDModel;
   import flash.display.DisplayObject;
   import wowp.core.layers.windows.events.ShowWindowEvent;
   import wowp.core.layers.windows.events.HideWindowEvent;
   
   public class HUDState extends EventDispatcher
   {
       
      private var _layout:HUDLayout;
      
      private var _model:HUDModel;
      
      private var _isEnterWithoutDelay:Boolean = false;
      
      public function HUDState()
      {
         super();
      }
      
      protected function get model() : HUDModel
      {
         return this._model;
      }
      
      public function get layout() : HUDLayout
      {
         return this._layout;
      }
      
      public function set layout(param1:HUDLayout) : void
      {
         this._layout = param1;
      }
      
      public function get isEnterWithoutDelay() : Boolean
      {
         return this._isEnterWithoutDelay;
      }
      
      public function set isEnterWithoutDelay(param1:Boolean) : void
      {
         this._isEnterWithoutDelay = param1;
      }
      
      public function setModel(param1:HUDModel) : void
      {
         this._model = param1;
      }
      
      final function enter() : void
      {
         this.onEnter();
      }
      
      public function getStateClass() : Class
      {
         return this["constructor"] as Class;
      }
      
      final function exit() : void
      {
         this.onExit();
      }
      
      protected function onEnter() : void
      {
      }
      
      protected function onExit() : void
      {
      }
      
      protected function showWindow(param1:DisplayObject, param2:uint, param3:Boolean = false) : void
      {
         this._layout.dispatchEvent(new ShowWindowEvent(param1,param2,param3));
      }
      
      protected function hideWindow(param1:DisplayObject) : void
      {
         this._layout.dispatchEvent(new HideWindowEvent(param1));
      }
      
      protected function changeState(param1:Class) : void
      {
         dispatchEvent(new HUDStateEvent(HUDStateEvent.CHANGE_STATE,param1));
      }
      
      protected function pushState(param1:Class) : void
      {
         dispatchEvent(new HUDStateEvent(HUDStateEvent.PUSH_STATE,param1));
      }
      
      protected function popState() : void
      {
         dispatchEvent(new HUDStateEvent(HUDStateEvent.POP_STATE));
      }
      
      protected function setDefault() : void
      {
         dispatchEvent(new HUDStateEvent(HUDStateEvent.SET_DEFAULT));
      }
      
      protected function defaultState(param1:Class) : void
      {
         dispatchEvent(new HUDStateEvent(HUDStateEvent.DEFAULT_STATE,param1));
      }
   }
}
