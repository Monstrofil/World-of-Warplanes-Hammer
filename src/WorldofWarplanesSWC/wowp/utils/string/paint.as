package wowp.utils.string
{
   public function paint(param1:String, param2:uint) : String
   {
      return "<font color=\'#" + param2.toString(16) + "\'>" + param1 + "</font>";
   }
}
