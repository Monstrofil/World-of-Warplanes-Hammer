package wowp.core.shared
{
   import flash.events.IEventDispatcher;
   
   public interface ISharedObject extends IEventDispatcher
   {
       
      function read(param1:String) : Object;
      
      function write(param1:String, param2:Object) : void;
   }
}
