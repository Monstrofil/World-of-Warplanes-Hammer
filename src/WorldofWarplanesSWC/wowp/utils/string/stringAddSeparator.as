package wowp.utils.string
{
   public function stringAddSeparator(param1:*, param2:String = " ", param3:int = 3) : String
   {
      var _loc5_:String = null;
      var _loc7_:String = null;
      var _loc8_:int = 0;
      var _loc9_:int = 0;
      var _loc10_:int = 0;
      var _loc4_:String = String(param1);
      var _loc6_:String = "";
      _loc5_ = String(param1);
      if(_loc5_.charAt(0) == "-" || _loc5_.charAt(0) == "+")
      {
         _loc7_ = _loc5_.charAt(0);
         _loc5_ = param1.substring(1);
      }
      _loc8_ = _loc5_.length;
      while(_loc8_ >= 0)
      {
         _loc9_ = _loc8_;
         _loc10_ = _loc9_ - param3;
         if(_loc10_ < 0)
         {
            _loc10_ = 0;
         }
         _loc6_ = _loc5_.slice(_loc10_,_loc9_) + _loc6_;
         if(_loc10_ != 0)
         {
            _loc6_ = param2 + _loc6_;
         }
         _loc8_ = _loc8_ - param3;
      }
      if(_loc7_)
      {
         _loc6_ = _loc7_ + _loc6_;
      }
      return _loc6_;
   }
}
