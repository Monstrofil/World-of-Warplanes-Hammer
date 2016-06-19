package wowp.hud.model.loading.vo
{
   public class HintVO
   {
       
      public var locText:Array;
      
      public var imgPath:Array;
      
      public var id:int;
      
      public function HintVO()
      {
         super();
      }
      
      public function toString() : String
      {
         var _loc1_:* = "[HintVO id = " + this.id + ", locText = ";
         var _loc2_:int = 0;
         while(_loc2_ < this.locText.length)
         {
            _loc1_ = _loc1_ + (this.locText[_loc2_] + ", ");
            _loc2_++;
         }
         _loc1_ = _loc1_ + "imgPath = ";
         _loc2_ = 0;
         while(_loc2_ < this.imgPath.length)
         {
            _loc1_ = _loc1_ + (this.imgPath[_loc2_] + ", ");
            _loc2_++;
         }
         _loc1_ = _loc1_ + "]";
         return _loc1_;
      }
   }
}
