package wowp.core.updater
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class Updater
   {
       
      private var _isPaused:Boolean;
      
      private var _newCallbacks:Vector.<wowp.core.updater.IUpdatabale>;
      
      private var _callbacks:Vector.<wowp.core.updater.IUpdatabale>;
      
      private var _anchor:Sprite;
      
      public function Updater()
      {
         super();
         this._callbacks = new Vector.<wowp.core.updater.IUpdatabale>();
         this._newCallbacks = new Vector.<wowp.core.updater.IUpdatabale>();
         this._anchor = new Sprite();
      }
      
      public function init() : void
      {
         this._anchor.addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         this._isPaused = false;
      }
      
      public function dispose() : void
      {
         this.clear();
         this._anchor.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      
      public function set paused(param1:Boolean) : void
      {
         if(this._isPaused != param1)
         {
            this._isPaused = param1;
            if(param1)
            {
               this._anchor.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
            }
            else
            {
               this._anchor.addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
            }
         }
      }
      
      public function get paused() : Boolean
      {
         return this._isPaused;
      }
      
      public function add(param1:wowp.core.updater.IUpdatabale) : void
      {
         if(this._callbacks.indexOf(param1) == -1 && this._newCallbacks.indexOf(param1) == -1)
         {
            this._newCallbacks[this._newCallbacks.length] = param1;
         }
      }
      
      public function remove(param1:wowp.core.updater.IUpdatabale) : void
      {
         var _loc2_:int = this._callbacks.indexOf(param1);
         if(_loc2_ != -1)
         {
            this._callbacks[_loc2_] = null;
         }
         else
         {
            _loc2_ = this._newCallbacks.indexOf(param1);
            if(_loc2_ != -1)
            {
               this._newCallbacks.splice(_loc2_,1);
            }
         }
      }
      
      public function clear() : void
      {
         this._newCallbacks.length = 0;
         this._callbacks.length = 0;
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         var _loc4_:wowp.core.updater.IUpdatabale = null;
         var _loc2_:int = this._newCallbacks.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._callbacks[this._callbacks.length] = this._newCallbacks[_loc3_];
            _loc3_++;
         }
         this._newCallbacks.length = 0;
         _loc2_ = this._callbacks.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._callbacks[_loc3_];
            if(_loc4_ == null)
            {
               if(_loc3_ == _loc2_ - 1)
               {
                  this._callbacks.pop();
               }
               else
               {
                  this._callbacks[_loc3_] = this._callbacks.pop();
               }
               _loc2_--;
            }
            else
            {
               _loc4_.update();
               _loc3_++;
            }
         }
      }
   }
}
