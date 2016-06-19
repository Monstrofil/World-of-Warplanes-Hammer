package wowp.core
{
   import flash.events.EventDispatcher;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.system.ApplicationDomain;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class SWFLoader extends EventDispatcher
   {
      
      private static var _arr:Vector.<wowp.core.SWFLoader> = new Vector.<wowp.core.SWFLoader>();
      
      private static var _cache:Object;
       
      private var _path:String;
      
      private var _lastLoadedContent:DisplayObject;
      
      private var _loaders:Object;
      
      private var _isLoading:Boolean = false;
      
      public function SWFLoader()
      {
         this._loaders = {};
         super();
         _arr.push(this);
         if(!_cache)
         {
            _cache = {};
         }
      }
      
      public static function destroy() : void
      {
         trace("SWFLoader::destroy:",_arr.length,"instances");
         while(_arr.length > 0)
         {
            _arr.pop().dispose();
         }
         _cache = null;
      }
      
      public function get isLoading() : Boolean
      {
         return this._isLoading;
      }
      
      public function load(param1:String) : void
      {
         var _loc2_:Loader = null;
         var _loc3_:URLRequest = null;
         this._path = param1;
         if(!this.checkCache())
         {
            this._isLoading = true;
            _loc2_ = new Loader();
            this._loaders[param1] = _loc2_;
            _loc3_ = new URLRequest(param1);
            _loc2_.load(_loc3_,new LoaderContext(false,ApplicationDomain.currentDomain));
            _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadingCompleteHandler);
         }
      }
      
      public function cancelLoad() : void
      {
         var _loc1_:Loader = null;
         if(this._isLoading)
         {
            this._isLoading = false;
            _loc1_ = this._loaders[this._path] as Loader;
            _loc1_.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadingCompleteHandler);
            _loc1_.close();
            delete this._loaders[this._path];
            this._path = null;
         }
      }
      
      public function get lastLoadedContent() : DisplayObject
      {
         return this._lastLoadedContent;
      }
      
      public function set lastLoadedContent(param1:DisplayObject) : void
      {
         if(param1)
         {
            this._lastLoadedContent = param1;
         }
      }
      
      private function loadingCompleteHandler(param1:Event) : void
      {
         this._isLoading = false;
         (param1.target as IEventDispatcher).removeEventListener(Event.COMPLETE,this.loadingCompleteHandler);
         this._lastLoadedContent = param1.target.content as DisplayObject;
         _cache[this._path] = this._lastLoadedContent;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function checkCache() : Boolean
      {
         this._lastLoadedContent = _cache[this._path];
         if(this._lastLoadedContent == null)
         {
            return false;
         }
         dispatchEvent(new Event(Event.COMPLETE));
         return true;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:Loader = null;
         this._lastLoadedContent = null;
         for(_loc1_ in this._loaders)
         {
            trace("SWFLoader::dispose:",_loc1_);
            _loc2_ = this._loaders[_loc1_] as Loader;
            _loc2_.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadingCompleteHandler);
            _loc2_.close();
            _loc2_.unloadAndStop();
            _loc2_.unload();
         }
         this._loaders = null;
      }
   }
}
