package wowp.utils.string.time
{
   public function concatNickname(param1:String, param2:String, param3:String = "[", param4:String = "]") : String
   {
      if(param2 != null && param2.length > 0)
      {
         return param1 + param3 + param2 + param4;
      }
      return param1;
   }
}
