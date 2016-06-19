package wowp.hud.model.speedometer
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import wowp.hud.model.vo.HUDDeviceRatioVO;
   
   public class HudSpeedometerModel extends HUDModelComponent
   {
      
      public static const MINIMAL:String = "minimal";
      
      public static const EXTENDED:String = "extended";
       
      public var onStateChanged:Signal;
      
      public var onMessageChanged:Signal;
      
      public var onMetricChanged:Signal;
      
      public var onMaxTemperatureChanged:Signal;
      
      public var onForceChanged:Signal;
      
      public var onKeyForceChanged:Signal;
      
      public var onForsageTimeChaged:Signal;
      
      public var onIsNitroChaged:Signal;
      
      public var onMaxSpeedChanged:Signal;
      
      public var onRatiosChanged:Signal;
      
      public var onUpdateKeys:Signal;
      
      private var _state:String = "extended";
      
      private var _message:String = "";
      
      private var _metric:String = "";
      
      public var speed:Number = 0;
      
      public var speedMax:Number = 1000;
      
      public var power:Number;
      
      public var temperature:Number;
      
      public var maxTemperature:Number = 0.8;
      
      public var isNitro:Boolean;
      
      public var isForce:Boolean;
      
      public var keyForce:String;
      
      public var keyShowMap:String = "M";
      
      public var keyShowTeams:String = "TAB";
      
      public var ratiosVO:HUDDeviceRatioVO;
      
      public var forsageTime:int;
      
      public function HudSpeedometerModel()
      {
         this.onStateChanged = new Signal();
         this.onMessageChanged = new Signal();
         this.onMetricChanged = new Signal();
         this.onMaxTemperatureChanged = new Signal();
         this.onForceChanged = new Signal();
         this.onKeyForceChanged = new Signal();
         this.onForsageTimeChaged = new Signal();
         this.onIsNitroChaged = new Signal();
         this.onMaxSpeedChanged = new Signal();
         this.onRatiosChanged = new Signal();
         this.onUpdateKeys = new Signal();
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
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.speedometerInit",this.initAll);
         backend.addCallback("hud.speedometerState",this.setState);
         backend.addCallback("hud.speedometerMessage",this.setMessage);
         backend.addCallback("hud.speedometerMetric",this.setMetric);
         backend.addCallback("hud.speedometerSpeed",this.setSpeed);
         backend.addCallback("hud.speedometerForce",this.setPower);
         backend.addCallback("hud.speedometerTemperature",this.setTemperature);
         backend.addCallback("hud.isForce",this.setForce);
         backend.addCallback("hud.keyForce",this.setKeyForce);
         backend.addCallback("hud.updateAfterBurningTime",this.updateAfterBurningTime);
         backend.addCallback("hud.updateKeys",this.updateKeys);
      }
      
      private function updateKeys(param1:Object) : void
      {
         this.keyForce = param1.force;
         this.keyShowMap = param1.showMap;
         this.keyShowTeams = param1.showTeams;
         this.onUpdateKeys.fire();
         this.onKeyForceChanged.fire();
      }
      
      private function initAll(param1:Object) : void
      {
         if(param1.hasOwnProperty("force"))
         {
            this.setPower(param1.force);
         }
         if(param1.hasOwnProperty("speed"))
         {
            this.setSpeed(param1.speed);
         }
         if(param1.hasOwnProperty("maxTemperature"))
         {
            this.setMaxTemperature(param1.maxTemperature);
         }
         if(param1.hasOwnProperty("temperature"))
         {
            this.setTemperature(param1.temperature,false);
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
         if(param1.hasOwnProperty("speedNorm"))
         {
            this.setMaxSpeed(param1.speedNorm);
         }
         this.setRatios(param1);
      }
      
      public function setRatios(param1:Object) : void
      {
         this.ratiosVO.parse(param1);
         this.onRatiosChanged.fire();
      }
      
      public function setMaxSpeed(param1:Number) : void
      {
         this.speedMax = param1;
         this.onMaxSpeedChanged.fire();
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
      
      private function setSpeed(param1:Number) : void
      {
         this.speed = param1;
      }
      
      private function setPower(param1:Number) : void
      {
         this.power = param1;
      }
      
      private function setTemperature(param1:Number, param2:Boolean) : void
      {
         this.temperature = param1;
         if(this.isNitro != param2)
         {
            this.isNitro = param2;
            this.onIsNitroChaged.fire();
         }
      }
      
      private function setMaxTemperature(param1:Number) : void
      {
         this.maxTemperature = param1;
         this.onMaxTemperatureChanged.fire();
      }
      
      private function setForce(param1:Boolean) : void
      {
         if(this.isForce != param1)
         {
            this.isForce = param1;
            this.onForceChanged.fire();
         }
      }
      
      private function setKeyForce(param1:String) : void
      {
         this.keyForce = param1;
         this.onKeyForceChanged.fire();
      }
      
      private function updateAfterBurningTime(param1:int) : void
      {
         this.forsageTime = param1;
         this.onForsageTimeChaged.fire();
      }
   }
}
