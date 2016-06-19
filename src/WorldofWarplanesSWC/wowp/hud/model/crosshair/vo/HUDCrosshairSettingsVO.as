package wowp.hud.model.crosshair.vo
{
   public class HUDCrosshairSettingsVO
   {
       
      public var crosshairShape:int = 1;
      
      public var crosshairColor:int = 1;
      
      public var crosshairTransparency:Number = 1;
      
      public var targetAreaShape:int = 1;
      
      public var targetAreaColor:int = 1;
      
      public var targetAreaTransparency:Number = 1;
      
      public var externalAimShape:int = 1;
      
      public var externalAimTransparency:Number = 1;
      
      public var crosshairMode:int = 0;
      
      public var isAimActive:Boolean = false;
      
      public function HUDCrosshairSettingsVO()
      {
         super();
      }
      
      public function updateData(param1:Object) : void
      {
         var _loc2_:* = null;
         trace("HUDCrosshairSettingsVO:");
         for(_loc2_ in param1)
         {
            trace("    ",_loc2_,":",param1[_loc2_]);
         }
         if(param1.hasOwnProperty("crosshairShape"))
         {
            this.crosshairShape = param1.crosshairShape + 1;
         }
         if(param1.hasOwnProperty("crosshairColor"))
         {
            this.crosshairColor = param1.crosshairColor + 1;
         }
         if(param1.hasOwnProperty("crosshairTransparency"))
         {
            this.crosshairTransparency = param1.crosshairTransparency;
         }
         if(param1.hasOwnProperty("targetAreaShape"))
         {
            this.targetAreaShape = param1.targetAreaShape + 1;
         }
         if(param1.hasOwnProperty("targetAreaColor"))
         {
            this.targetAreaColor = param1.targetAreaColor + 1;
         }
         if(param1.hasOwnProperty("targetAreaTransparency"))
         {
            this.targetAreaTransparency = param1.targetAreaTransparency;
         }
         if(param1.hasOwnProperty("externalAimShape"))
         {
            this.externalAimShape = param1.externalAimShape + 1;
         }
         if(param1.hasOwnProperty("externalAimTransparency"))
         {
            this.externalAimTransparency = param1.externalAimTransparency;
         }
         if(param1.hasOwnProperty("crosshairMode"))
         {
            this.crosshairMode = param1.crosshairMode;
         }
      }
      
      public function setAimActive(param1:Boolean) : void
      {
         this.isAimActive = param1;
      }
   }
}
