package wowp.utils.string
{
   import flash.text.TextField;
   
   public function cutTextfieldName(param1:TextField, param2:String, param3:String = "..") : Boolean
   {
      var _loc8_:Number = NaN;
      if(param2 == null || param1 == null)
      {
         return false;
      }
      var _loc4_:Array = cutNickname(param2);
      var _loc5_:String = _loc4_[0];
      var _loc6_:String = _loc4_[1];
      var _loc7_:Boolean = false;
      if(param1 != null)
      {
         param1.text = _loc5_ + _loc6_;
         _loc8_ = param2.length;
         while(param1.textWidth >= param1.width)
         {
            param1.text = _loc5_.substr(0,--_loc8_) + param3 + _loc6_;
            _loc7_ = true;
         }
      }
      return _loc7_;
   }
}
