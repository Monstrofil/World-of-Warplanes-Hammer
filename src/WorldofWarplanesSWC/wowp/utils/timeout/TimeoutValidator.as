package wowp.utils.timeout
{
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TimeoutValidator implements IValidator
   {
      
      private static var _ids:Array = [];
       
      private var _timeoutID:uint;
      
      private var _validateCallback:Function;
      
      private var _validateArgs:Array;
      
      public function TimeoutValidator(param1:Function)
      {
         super();
         _ids[_ids.length] = this;
         this._validateCallback = param1;
      }
      
      public static function destroy() : void
      {
         var _loc1_:TimeoutValidator = null;
         trace("TimeoutValidator::destroy");
         for each(_loc1_ in _ids)
         {
            _loc1_.dispose();
         }
      }
      
      public function dispose() : void
      {
         clearTimeout(this._timeoutID);
         this._validateCallback = null;
         this._validateArgs = null;
      }
      
      public function invalidate(... rest) : void
      {
         this._validateArgs = rest;
         clearTimeout(this._timeoutID);
         this._timeoutID = setTimeout(this.validate,1);
      }
      
      private function validate() : void
      {
         clearTimeout(this._timeoutID);
         if(this._validateCallback != null)
         {
            if(this._validateCallback.length == 0)
            {
               this._validateCallback();
            }
            else
            {
               this._validateCallback.apply(null,this._validateArgs);
            }
         }
      }
      
      public function validateNow() : void
      {
         this.validate();
      }
   }
}
