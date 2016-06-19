package wowp.hud.model.spectator
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   
   public class HUDSpectatorModel extends HUDModelComponent
   {
      
      private static const SPECTATOR_FINAL_STATE:int = 4;
       
      public var onSpectatorMode:Signal;
      
      public var onSpectatorDynamicCameraState:Signal;
      
      public var onSpectatorResultFinal:Signal;
      
      public var onNeedOutroFadein:Signal;
      
      public var onNeedFadein:Signal;
      
      private var _spectatorMode:int = -1;
      
      private var _spectatorDynamicCameraState:int = 0;
      
      private var _spectatorResultFinal:Object;
      
      public function HUDSpectatorModel()
      {
         this.onSpectatorMode = new Signal();
         this.onSpectatorDynamicCameraState = new Signal();
         this.onSpectatorResultFinal = new Signal();
         this.onNeedOutroFadein = new Signal();
         this.onNeedFadein = new Signal();
         this._spectatorResultFinal = {};
         super();
      }
      
      public function get spectatorMode() : int
      {
         return this._spectatorMode;
      }
      
      public function get spectatorDynamicCameraState() : int
      {
         return this._spectatorDynamicCameraState;
      }
      
      public function get spectatorResultFinal() : Object
      {
         return this._spectatorResultFinal;
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.spectatorMode",this.setSpectatorMode);
         backend.addCallback("hud.spectatorDynamicCameraState",this.setSpectatorDynamicCameraState);
         backend.addCallback("hud.initOutro",this.setResultFinal);
      }
      
      public function changeSpectatorMode() : void
      {
         this.onSpectatorMode.fire();
      }
      
      private function setSpectatorMode(param1:int) : void
      {
         trace("HUDSpectatorModel::setSpectatorMode",param1);
         this._spectatorMode = param1;
         if(this._spectatorMode != SPECTATOR_FINAL_STATE)
         {
            this.changeSpectatorMode();
         }
         else
         {
            this.onNeedFadein.fire();
         }
      }
      
      private function setSpectatorDynamicCameraState(param1:int) : void
      {
         trace("HUDControlModel::setSpectatorDynamicCameraState",param1);
         this._spectatorDynamicCameraState = param1;
         this.onSpectatorDynamicCameraState.fire();
      }
      
      private function setResultFinal(param1:Object) : void
      {
         this._spectatorResultFinal.winIndex = param1.winIndex;
         this._spectatorResultFinal.winState = param1.winState;
         this._spectatorResultFinal.winResult = param1.winResult;
         this.onSpectatorResultFinal.fire();
      }
      
      public function needOutroFadein() : void
      {
         this.onNeedOutroFadein.fire();
      }
      
      public function setOutroFadein() : void
      {
         backend.call("hud.outroFadein");
      }
      
      public function cameraSwitch(param1:int) : void
      {
         backend.call("hud.spectatorModeDynamicCameraSwitch",param1);
      }
   }
}
