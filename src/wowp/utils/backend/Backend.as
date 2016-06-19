package wowp.utils.backend
{
   import flash.utils.Dictionary;
   import flash.external.ExternalInterface;
   import flash.utils.setTimeout;
   
   public class Backend implements IBackend
   {
       
      private var _functions:Dictionary;
      
      public function Backend()
      {
         super();
         this._functions = new Dictionary(true);
      }
      
      public function addCallback(param1:String, param2:Function) : void
      {
         this._functions[param1] = param2;
         ExternalInterface.addCallback(param1,param2);
      }
      
      public function call(param1:String, ... rest) : *
      {
         if(rest == null)
         {
            rest = [];
         }
         rest.unshift(param1);
         return ExternalInterface.call.apply(null,rest);
      }
      
      public function callAsync(param1:String, ... rest) : void
      {
         if(rest == null)
         {
            rest = [];
         }
         rest.unshift(param1);
         setTimeout(this.makeAsyncCall,1,rest);
      }
      
      private function makeAsyncCall(param1:Array) : void
      {
         ExternalInterface.call.apply(null,param1);
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         for(_loc1_ in this._functions)
         {
            ExternalInterface.addCallback(_loc1_,null);
         }
         this._functions = new Dictionary(true);
      }
   }
}
