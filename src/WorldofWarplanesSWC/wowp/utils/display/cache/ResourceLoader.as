package wowp.utils.display.cache
{
   class ResourceLoader
   {
       
      private var _clients:Vector.<wowp.utils.display.cache.ICacheClient>;
      
      protected var _path:String;
      
      protected var _content:Object;
      
      private var _loaded:Boolean;
      
      function ResourceLoader(param1:String)
      {
         this._clients = new Vector.<wowp.utils.display.cache.ICacheClient>();
         super();
         this._path = param1;
         this.load();
      }
      
      protected function load() : void
      {
      }
      
      protected function removeListeners() : void
      {
      }
      
      protected function setLoadedContent(param1:Object) : void
      {
         var _loc2_:wowp.utils.display.cache.ICacheClient = null;
         this.removeListeners();
         this._content = param1;
         this._loaded = true;
         if(param1 != null)
         {
            for each(_loc2_ in this._clients)
            {
               _loc2_.onResourceLoaded(this._content);
            }
         }
         this._clients.length = 0;
      }
      
      public function addClient(param1:wowp.utils.display.cache.ICacheClient) : void
      {
         if(this._loaded)
         {
            param1.onResourceLoaded(this._content);
         }
         else
         {
            this._clients[this._clients.length] = param1;
         }
      }
      
      public function removeClient(param1:wowp.utils.display.cache.ICacheClient) : void
      {
         var _loc2_:int = this._clients.indexOf(param1);
         if(_loc2_ > -1)
         {
            this._clients.splice(_loc2_,1);
         }
      }
      
      public function dispose() : void
      {
         this.removeListeners();
         this._clients.length = 0;
         this._content = null;
      }
   }
}
