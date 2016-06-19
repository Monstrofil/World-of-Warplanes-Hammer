package wowp.utils.display
{
   import scaleform.clik.utils.Constraints;
   import flash.display.DisplayObject;
   import scaleform.clik.utils.ConstrainedElement;
   import flash.display.Sprite;
   
   public class ConstraintsInteger extends Constraints
   {
       
      public function ConstraintsInteger(param1:Sprite, param2:String = "counterScale")
      {
         super(param1,param2);
      }
      
      override public function update(param1:Number, param2:Number) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:* = null;
         super.update(param1,param2);
         for(_loc4_ in elements)
         {
            _loc3_ = (elements[_loc4_] as ConstrainedElement).clip;
            _loc3_.x = Math.round(_loc3_.x);
            _loc3_.y = Math.round(_loc3_.y);
         }
      }
   }
}
