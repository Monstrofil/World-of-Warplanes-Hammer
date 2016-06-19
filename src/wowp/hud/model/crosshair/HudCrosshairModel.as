package wowp.hud.model.crosshair
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import wowp.hud.model.crosshair.vo.HUDCrosshairSettingsVO;
   import wowp.hud.core.vo.PositionVO;
   
   public class HudCrosshairModel extends HUDModelComponent
   {
       
      public var onVisibilityChanged:Signal;
      
      public var onCrosshairSettingsChanged:Signal;
      
      public var onChangeAimActivate:Signal;
      
      public var settings:HUDCrosshairSettingsVO;
      
      public var crosshair:PositionVO;
      
      public var targetSize:Number = 0;
      
      public var isCenterPointVisible:Boolean = true;
      
      public var centerPoint:PositionVO;
      
      public function HudCrosshairModel()
      {
         this.onVisibilityChanged = new Signal();
         this.onCrosshairSettingsChanged = new Signal();
         this.onChangeAimActivate = new Signal();
         this.settings = new HUDCrosshairSettingsVO();
         this.crosshair = new PositionVO();
         this.centerPoint = new PositionVO();
         super();
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.crosshairUpdate",this.crosshairUpdate);
         backend.addCallback("hud.crosshairTargetSize",this.crosshairTargetSize);
         backend.addCallback("hud.visibleCenterPoint",this.visibleCenterPoint);
         backend.addCallback("hud.centerPointUpdate",this.centerPointUpdate);
         backend.addCallback("hud.updateAim",this.updateCrosshairSettings);
         backend.addCallback("hud.setAimActive",this.updateAimActivate);
      }
      
      private function updateAimActivate(param1:Boolean) : void
      {
         this.settings.setAimActive(param1);
         this.onChangeAimActivate.fire();
      }
      
      private function crosshairUpdate(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         this.crosshair.x = param1;
         this.crosshair.y = param2;
         this.crosshair.z = param3;
         this.crosshair.pitch = param5;
         this.crosshair.roll = param6;
         this.crosshair.yaw = param4;
      }
      
      private function crosshairTargetSize(param1:Number) : void
      {
         this.targetSize = param1;
      }
      
      private function visibleCenterPoint(param1:Boolean) : void
      {
         this.isCenterPointVisible = param1;
         this.onVisibilityChanged.fire();
      }
      
      private function centerPointUpdate(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         this.centerPoint.x = param1;
         this.centerPoint.y = param2;
         this.centerPoint.z = param3;
         this.centerPoint.yaw = param4;
         this.centerPoint.pitch = param5;
         this.centerPoint.roll = param6;
      }
      
      private function updateCrosshairSettings(param1:Object) : void
      {
         this.settings.updateData(param1);
         this.onCrosshairSettingsChanged.fire();
      }
   }
}
