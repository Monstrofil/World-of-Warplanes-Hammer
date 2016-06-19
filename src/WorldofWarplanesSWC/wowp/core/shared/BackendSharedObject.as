package wowp.core.shared
{
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   
   public class BackendSharedObject extends EventDispatcher implements ISharedObject
   {
       
      public function BackendSharedObject()
      {
         super();
      }
      
      public function read(param1:String) : Object
      {
         return ExternalInterface.call("UI.readObject",param1);
      }
      
      public function write(param1:String, param2:Object) : void
      {
         ExternalInterface.call("UI.saveObject",param1,param2);
      }
   }
}
