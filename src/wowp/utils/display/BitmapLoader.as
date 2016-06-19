package wowp.utils.display
{
   import flash.display.Sprite;
   import wowp.utils.display.cache.ICacheClient;
   import flash.display.Bitmap;
   import wowp.utils.display.cache.Cache;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class BitmapLoader extends Sprite implements ICacheClient
   {
       
      protected var _isCentered:Boolean = false;
      
      public var lockSize:Boolean = false;
      
      private var _opacity:Number = 1;
      
      protected var _bitmap:Bitmap;
      
      protected var _originalWidth:Number = 1;
      
      protected var _originalHeight:Number = 1;
      
      protected var _smoothing:Boolean;
      
      protected var _path:String;
      
      public function BitmapLoader()
      {
         super();
         this._originalHeight = height;
         this._originalWidth = width;
         scaleX = 1;
         scaleY = 1;
         this._bitmap = new Bitmap();
         addChild(this._bitmap);
      }
      
      public function get isCentered() : Boolean
      {
         return this._isCentered;
      }
      
      public function set isCentered(param1:Boolean) : void
      {
         this._isCentered = param1;
      }
      
      public function get opacity() : Number
      {
         return this._opacity;
      }
      
      public function set opacity(param1:Number) : void
      {
         this._opacity = param1;
         if(this._bitmap)
         {
            this._bitmap.alpha = this._opacity;
         }
      }
      
      public function load(param1:String, param2:Boolean = true) : void
      {
         this._smoothing = param2;
         this.clear();
         this._path = param1;
         Cache.getResource(this._path,this);
      }
      
      public function onResourceLoaded(param1:Object) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.lockSize)
         {
            this._bitmap.scaleX = 1;
            this._bitmap.scaleY = 1;
         }
         this._bitmap.alpha = this._opacity;
         this._bitmap.bitmapData = param1 as BitmapData;
         this._bitmap.smoothing = this._smoothing;
         if(this.lockSize)
         {
            _loc2_ = this._originalWidth / this._bitmap.width;
            _loc3_ = this._originalHeight / this._bitmap.height;
            if(_loc2_ > _loc3_)
            {
               this._bitmap.scaleX = this._bitmap.scaleY = _loc3_;
               this._bitmap.x = (this._originalWidth - this._bitmap.width) / 2;
               this._bitmap.y = 0;
            }
            else
            {
               this._bitmap.scaleX = this._bitmap.scaleY = _loc2_;
               this._bitmap.x = 0;
               this._bitmap.y = (this._originalHeight - this._bitmap.height) / 2;
            }
         }
         if(this._isCentered)
         {
            this._bitmap.x = -this._bitmap.width / 2;
            this._bitmap.y = -this._bitmap.height / 2;
         }
         dispatchEvent(new Event("resourceLoaded",true));
      }
      
      public function clear() : void
      {
         Cache.releaseClient(this._path,this);
         this._path = null;
         removeChild(this._bitmap);
         this._bitmap = new Bitmap();
         addChild(this._bitmap);
      }
   }
}
