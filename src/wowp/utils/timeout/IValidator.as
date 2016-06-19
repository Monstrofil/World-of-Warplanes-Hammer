package wowp.utils.timeout
{
   public interface IValidator
   {
       
      function invalidate(... rest) : void;
      
      function dispose() : void;
      
      function validateNow() : void;
   }
}
