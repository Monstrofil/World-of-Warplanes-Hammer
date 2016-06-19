package wowp.utils.display.cache
{
   import flash.display.Loader;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.system.ApplicationDomain;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class DefaultResourceLoader extends ResourceLoader
   {
       
      private var _loader:Loader;
      
      public function DefaultResourceLoader(param1:String)
      {
         super(param1);
      }
      
      override protected function load() : void
      {
         var _loc1_:URLRequest = new URLRequest(_path);
         this._loader = new Loader();
         this._loader.load(_loc1_,new LoaderContext(false,ApplicationDomain.currentDomain));
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCompletedHandler);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
      }
      
      override protected function removeListeners() : void
      {
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadCompletedHandler);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
      }
      
      private function loadCompletedHandler(param1:Event) : void
      {
         var _loc2_:Object = this._loader.content;
         if(_loc2_ is Bitmap)
         {
            _loc2_ = (_loc2_ as Bitmap).bitmapData;
         }
         setLoadedContent(_loc2_);
      }
      
      private function loadErrorHandler(param1:IOErrorEvent) : void
      {
         trace("ResourceLoader::loadErrorHandler:",param1.text);
         setLoadedContent(null);
      }
      
      override public function dispose() : void
      {
         if(_content is BitmapData)
         {
            (_content as BitmapData).dispose();
         }
         if(this._loader)
         {
            this._loader.close();
            this._loader.unload();
            this._loader.unloadAndStop();
         }
         super.dispose();
      }
   }
}
