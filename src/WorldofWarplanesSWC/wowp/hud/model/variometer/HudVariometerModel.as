package wowp.hud.model.variometer
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import wowp.hud.model.vo.HUDDeviceRatioVO;
   
   public class HudVariometerModel extends HUDModelComponent
   {
      
      public static const MINIMAL:String = "minimal";
      
      public static const EXTENDED:String = "extended";
       
      public var onStateChanged:Signal;
      
      public var onMessageChanged:Signal;
      
      public var onMetricChanged:Signal;
      
      public var onValueChanged:Signal;
      
      public var onMaxAltitudeChaned:Signal;
      
      public var onRatiosChanged:Signal;
      
      public var onHeightModeChanged:Signal;
      
      private var _state:String = "extended";
      
      private var _message:String = "";
      
      private var _metric:String = "";
      
      private var _heightMode:int = 1;
      
      public var altitude1:Number = 0;
      
      public var altitude2:Number = 0;
      
      public var altitudeMax:Number = 2000;
      
      public var delta:Number = 0;
      
      public var ratiosVO:HUDDeviceRatioVO;
      
      private var _oldAltitude:Number = 0;
      
      public function HudVariometerModel()
      {
         this.onStateChanged = new Signal();
         this.onMessageChanged = new Signal();
         this.onMetricChanged = new Signal();
         this.onValueChanged = new Signal();
         this.onMaxAltitudeChaned = new Signal();
         this.onRatiosChanged = new Signal();
         this.onHeightModeChanged = new Signal();
         this.ratiosVO = new HUDDeviceRatioVO();
         super();
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      public function get message() : String
      {
         return this._message;
      }
      
      public function get metric() : String
      {
         return this._metric;
      }
      
      public function get heightMode() : int
      {
         return this._heightMode;
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.variometerInit",this.initAll);
         backend.addCallback("hud.variometerState",this.setState);
         backend.addCallback("hud.variometerMessage",this.setMessage);
         backend.addCallback("hud.variometerMetric",this.setMetric);
         backend.addCallback("hud.variometerAltitude",this.setAltitude);
         backend.addCallback("hud.variometerHeightMode",this.setHeightMode);
      }
      
      private function initAll(param1:Object) : void
      {
         if(param1.hasOwnProperty("altitude"))
         {
            this.setAltitude(param1.altitude,param1.altitude);
         }
         if(param1.hasOwnProperty("message"))
         {
            this.setMessage(param1.message);
         }
         if(param1.hasOwnProperty("state"))
         {
            this.setState(param1.state);
         }
         if(param1.hasOwnProperty("metric"))
         {
            this.setMetric(param1.metric);
         }
         if(param1.hasOwnProperty("altitudeNorm"))
         {
            this.setMaxAltitude(param1.altitudeNorm);
         }
         this.setRatios(param1);
      }
      
      public function setRatios(param1:Object) : void
      {
         this.ratiosVO.parse(param1);
         this.onRatiosChanged.fire();
      }
      
      public function setMaxAltitude(param1:Number) : void
      {
         this.altitudeMax = param1;
         this.onMaxAltitudeChaned.fire();
      }
      
      public function setState(param1:String) : void
      {
         this._state = param1;
         this.onStateChanged.fire();
      }
      
      protected function setMessage(param1:String) : void
      {
         this._message = param1;
         this.onMessageChanged.fire();
      }
      
      protected function setMetric(param1:String) : void
      {
         this._metric = param1;
         this.onMetricChanged.fire();
      }
      
      private function setAltitude(param1:Number, param2:Number) : void
      {
         this.altitude1 = param1;
         this.altitude2 = param2;
         this.delta = param2 - this._oldAltitude;
         this._oldAltitude = param2;
      }
      
      private function setHeightMode(param1:int) : void
      {
         this._heightMode = param1;
         this.onHeightModeChanged.fire();
      }
   }
}
