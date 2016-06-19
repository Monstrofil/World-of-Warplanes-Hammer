package wowp.utils.display.cache
{
   
   public class Cache
   {
      
      private static var _loaders:Object = {};
       
      public function Cache()
      {
         super();
      }
      
      public static function getResource(param1:String, param2:ICacheClient) : void
      {
         if(param1 == null)
         {
            trace("[ERROR]Cache::getResource: path can\'t be null!");
            return;
         }
         var _loc3_:ResourceLoader = _loaders[param1] as ResourceLoader;
         if(_loc3_ == null)
         {
            _loc3_ = createLoader(param1);
            _loaders[param1] = _loc3_;
         }
         _loc3_.addClient(param2);
      }
      
      public static function releaseClient(param1:String, param2:ICacheClient) : void
      {
         var _loc3_:ResourceLoader = _loaders[param1] as ResourceLoader;
         if(_loc3_)
         {
            _loc3_.removeClient(param2);
         }
      }
      
      public static function disposeResource(param1:String) : void
      {
         var _loc2_:ResourceLoader = _loaders[param1] as ResourceLoader;
         if(_loc2_)
         {
            _loc2_.dispose();
            delete _loaders[param1];
         }
      }
      
      public static function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:ResourceLoader = null;
         trace("Cache::dispose...");
         for(_loc1_ in _loaders)
         {
            _loc2_ = _loaders[_loc1_] as ResourceLoader;
            _loc2_.dispose();
         }
         _loaders = {};
         trace("...Cache::disposed");
      }
      
      private static function createLoader(param1:String) : ResourceLoader
      {
         var _loc2_:String = null;
         var _loc3_:Array = param1.split(".");
         if(_loc3_.length > 1)
         {
            _loc2_ = _loc3_[_loc3_.length - 1];
         }
         if(_loc2_ == "xml")
         {
            return new URLResourceLoader(param1);
         }
         return new DefaultResourceLoader(param1);
      }
   }
}
