package wowp.core.eventPipe
{
   import flash.events.IEventDispatcher;
   import wowp.utils.data.binding.Signal;
   import flash.events.Event;
   
   public class EventPipe implements IEventDispatcher
   {
      
      public static const INITIALIZED:String = "wowp.core.eventPipe.EventPipe.INITIALIZED";
      
      private static var __pipe:IEventDispatcher;
      
      public static const onInitialized:Signal = new Signal();
       
      public function EventPipe()
      {
         super();
      }
      
      protected static function get _pipe() : IEventDispatcher
      {
         return __pipe;
      }
      
      protected static function set _pipe(param1:IEventDispatcher) : void
      {
         if(__pipe == null && param1 != null)
         {
            __pipe = param1;
            onInitialized.fire();
         }
      }
      
      public static function get isInitialized() : Boolean
      {
         return _pipe != null;
      }
      
      public static function get dispatcher() : IEventDispatcher
      {
         return __pipe;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(_pipe)
         {
            _pipe.addEventListener(param1,param2,param3,param4,param5);
         }
         else
         {
            this.traceError();
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         if(_pipe)
         {
            return _pipe.dispatchEvent(param1);
         }
         this.traceError();
         return false;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         if(_pipe)
         {
            return _pipe.hasEventListener(param1);
         }
         this.traceError();
         return false;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(_pipe)
         {
            _pipe.removeEventListener(param1,param2,param3);
         }
         else
         {
            this.traceError();
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         if(_pipe)
         {
            return _pipe.willTrigger(param1);
         }
         this.traceError();
         return false;
      }
      
      private function traceError() : void
      {
         trace("EventPipe is not initialized!");
      }
   }
}
