package wowp.utils.string
{
   public function cutNickname(param1:String, param2:String = "[", param3:String = "]") : Array
   {
      var _loc7_:Array = null;
      var _loc4_:Array = [];
      var _loc5_:Array = param1.split(param2);
      _loc4_[0] = _loc5_[0];
      var _loc6_:String = _loc5_[1];
      if(_loc6_ == null)
      {
         _loc4_[1] = "";
      }
      else
      {
         _loc7_ = _loc6_.split(param3);
         _loc4_[1] = param2 + _loc7_[0] + param3;
      }
      return _loc4_;
   }
}
