package wowp.utils.display.cache
{
   import flash.net.URLLoader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.System;
   
   public class URLResourceLoader extends ResourceLoader
   {
       
      private var _loader:URLLoader;
      
      public function URLResourceLoader(param1:String)
      {
         super(param1);
      }
      
      override protected function load() : void
      {
         this._loader = new URLLoader();
         this._loader.addEventListener(Event.COMPLETE,this.loadCompletedHandler);
         this._loader.load(new URLRequest(_path));
      }
      
      override protected function removeListeners() : void
      {
         this._loader.removeEventListener(Event.COMPLETE,this.loadCompletedHandler);
      }
      
      private function loadCompletedHandler(param1:Event) : void
      {
         setLoadedContent(this._loader.data);
      }
      
      override public function dispose() : void
      {
         if(_content is XML)
         {
            System.disposeXML(_content as XML);
         }
         if(this._loader)
         {
            this._loader.close();
         }
         super.dispose();
      }
   }
}
