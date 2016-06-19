package wowp.hud.core
{
   import wowp.hud.model.HUDModel;
   import wowp.utils.backend.IBackend;
   import flash.events.Event;
   
   public class HUDModelComponent
   {
       
      private var _model:HUDModel;
      
      private var _backend:IBackend;
      
      public function HUDModelComponent()
      {
         super();
      }
      
      protected function get model() : HUDModel
      {
         return this._model;
      }
      
      protected final function get backend() : IBackend
      {
         return this._backend;
      }
      
      public final function init(param1:HUDModel, param2:IBackend) : void
      {
         this._model = param1;
         this._backend = param2;
         this.onInit();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
         this._model = null;
      }
      
      protected final function dispatchEvent(param1:Event) : void
      {
         if(this._model.hasEventListener(param1.type))
         {
            this._model.dispatchEvent(param1);
         }
      }
      
      protected function onInit() : void
      {
      }
      
      protected function onDispose() : void
      {
      }
   }
}
