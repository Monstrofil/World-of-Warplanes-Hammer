package wowp.hud.model.aviahorizon
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import wowp.hud.core.vo.PositionVO;
   
   public class AviaHorizonModel extends HUDModelComponent
   {
       
      public var onModeChanged:Signal;
      
      private var _mode:int;
      
      private var _cameraType:int;
      
      public var position:PositionVO;
      
      public function AviaHorizonModel()
      {
         this.onModeChanged = new Signal();
         this.position = new PositionVO();
         super();
      }
      
      public function get mode() : int
      {
         return this._mode;
      }
      
      public function get cameraType() : int
      {
         return this._cameraType;
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.aviahorizonSetMode",this.setMode);
         backend.addCallback("hud.aviahorizonUpdate",this.update);
         backend.addCallback("hud.updateCameraType",this.setCameraType);
      }
      
      private function setMode(param1:int) : void
      {
         this._mode = param1;
         this.onModeChanged.fire();
      }
      
      private function setCameraType(param1:int) : void
      {
         this._cameraType = param1;
         this.onModeChanged.fire();
      }
      
      private function update(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         this.position.x = param1;
         this.position.y = param2;
         this.position.z = param3;
         this.position.pitch = param5;
         this.position.roll = param6;
         this.position.yaw = param4;
      }
   }
}
