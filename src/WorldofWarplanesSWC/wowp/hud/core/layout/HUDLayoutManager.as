package wowp.hud.core.layout
{
   import wowp.utils.data.binding.Signal;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class HUDLayoutManager
   {
       
      public var onFactoryChanged:Signal;
      
      private var _currentFactoryID:String;
      
      private var _factories:Dictionary;
      
      private var _layoutFactory:wowp.hud.core.layout.IHUDLayoutFactory;
      
      private var _factoryChangedTimeoutID:uint;
      
      public function HUDLayoutManager()
      {
         this.onFactoryChanged = new Signal();
         this._factories = new Dictionary();
         this._layoutFactory = new HUDDefaultLayoutFactory();
         super();
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         for(_loc1_ in this._factories)
         {
            delete this._factories[_loc1_];
         }
         this._currentFactoryID = null;
         clearTimeout(this._factoryChangedTimeoutID);
      }
      
      public function getLayout(param1:Class) : HUDLayout
      {
         if(this._layoutFactory)
         {
            trace("HUDLayoutManager::getLayout:",this._layoutFactory,param1);
            return this._layoutFactory.getLayout(param1);
         }
         throw new Error("HUDLayoutManager: layout factory is not set!");
      }
      
      public function registerFactory(param1:wowp.hud.core.layout.IHUDLayoutFactory) : void
      {
         this._factories[param1.id] = param1;
      }
      
      public function setConcreteFactory(param1:String) : void
      {
         if(this._currentFactoryID != param1)
         {
            trace("HUDLayoutManager::setConcreteFactory:",param1);
            this._currentFactoryID = param1;
            this._layoutFactory = this._factories[param1] as wowp.hud.core.layout.IHUDLayoutFactory;
            if(this._layoutFactory == null)
            {
               throw new Error("HUDLayoutManager: can\'t find factory! ID:",param1);
            }
            clearTimeout(this._factoryChangedTimeoutID);
            this._factoryChangedTimeoutID = setTimeout(this.onFactoryChanged.fire,1);
         }
      }
      
      public function get currentFactoryID() : String
      {
         return this._currentFactoryID;
      }
   }
}
