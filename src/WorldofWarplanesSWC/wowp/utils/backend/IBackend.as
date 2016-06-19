package wowp.utils.backend
{
   public interface IBackend
   {
       
      function addCallback(param1:String, param2:Function) : void;
      
      function call(param1:String, ... rest) : *;
      
      function callAsync(param1:String, ... rest) : void;
      
      function dispose() : void;
   }
}
