package wowp.hud.common.infoEntities
{
   import flash.display.MovieClip;
   import wowp.hud.model.targetCapture.vo.CapturedTargetVO;
   import flash.display.DisplayObject;
   
   public class AnimMarkerCrit extends MovieClip
   {
       
      public var mcModule:MovieClip;
      
      public var _isBigIcon:Boolean = true;
      
      public function AnimMarkerCrit()
      {
         super();
         stop();
         this.visible = false;
      }
      
      public function showPart(param1:int) : void
      {
         var _loc2_:int = CapturedTargetVO.getPositionBySlot(param1);
         gotoAndStop(CapturedTargetVO.getStrPositionByPosition(_loc2_));
         this.mcModule = getChildAt(0) as MovieClip;
         this.mcModule.stop();
         this.visible = true;
      }
      
      public function setIsTarget(param1:Boolean, param2:Boolean) : void
      {
         this._isBigIcon = param1;
         if(this._isBigIcon)
         {
            this.mcModule.gotoAndStop(!!param2?"l_big_alternative_color":"l_big");
         }
         else
         {
            this.mcModule.gotoAndStop(!!param2?"l_small_alternative_color":"l_small");
         }
      }
      
      public function setAlternativeColor(param1:Boolean) : void
      {
         if(param1)
         {
            if(this.mcModule.currentLabel == "l_big")
            {
               this.mcModule.gotoAndStop("l_big_alternative_color");
            }
            else if(this.mcModule.currentLabel == "l_small")
            {
               this.mcModule.gotoAndStop("l_small_alternative_color");
            }
         }
         else if(this.mcModule.currentLabel == "l_big_alternative_color")
         {
            this.mcModule.gotoAndStop("l_big");
         }
         else if(this.mcModule.currentLabel == "l_small_alternative_color")
         {
            this.mcModule.gotoAndStop("l_small");
         }
      }
      
      public function destroy() : void
      {
         stop();
         this.visible = false;
      }
      
      public function getWidth() : int
      {
         var _loc1_:DisplayObject = this.mcModule.getChildAt(0);
         if(!this._isBigIcon)
         {
            return _loc1_.width + 3;
         }
         return _loc1_.width;
      }
      
      public function getHeight() : int
      {
         var _loc1_:DisplayObject = this.mcModule.getChildAt(0);
         return _loc1_.height;
      }
   }
}
