package wowp.hud.model.time
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   
   public class HUDTimeModel extends HUDModelComponent
   {
       
      public var onBigTimerHide:Signal;
      
      public var onBigTimerShow:Signal;
      
      public var onBigTimerUpdate:Signal;
      
      public var onTimerUpdate:Signal;
      
      public var isBigTimerShown:Boolean = false;
      
      public var bigTime:int;
      
      public var time:int;
      
      public function HUDTimeModel()
      {
         this.onBigTimerHide = new Signal();
         this.onBigTimerShow = new Signal();
         this.onBigTimerUpdate = new Signal();
         this.onTimerUpdate = new Signal();
         super();
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.updateTime",this.updateTime);
         backend.addCallback("hud.bigTimerUpdateTime",this.updateBigTimer);
         backend.addCallback("hud.bigTimerHide",this.hideBigTimer);
      }
      
      private function hideBigTimer() : void
      {
         if(this.isBigTimerShown)
         {
            this.isBigTimerShown = false;
            this.onBigTimerHide.fire();
         }
      }
      
      private function updateBigTimer(param1:int) : void
      {
         this.bigTime = param1;
         if(!this.isBigTimerShown)
         {
            this.isBigTimerShown = true;
            this.onBigTimerShow.fire();
         }
         this.onBigTimerUpdate.fire();
      }
      
      private function updateTime(param1:int) : void
      {
         this.time = param1;
         this.onTimerUpdate.fire();
      }
   }
}
