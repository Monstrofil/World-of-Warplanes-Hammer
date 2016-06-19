package wowp.hud.common.infoEntities
{
   import flash.display.MovieClip;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import flash.events.Event;
   
   public class AnimMarkerDamage extends MovieClip
   {
       
      public var mcHp:MovieClip;
      
      private var _timer:Timer;
      
      private var _id:Number;
      
      public function AnimMarkerDamage(param1:int)
      {
         super();
         this._id = Math.random();
         stop();
         this.visible = false;
         this.mcHp.tfHp.text = param1 + "";
      }
      
      public function start() : void
      {
         this._timer = new Timer(1000,1);
         this._timer.addEventListener(TimerEvent.TIMER,this.timerTick);
         this._timer.start();
         gotoAndPlay(1);
         this.visible = true;
      }
      
      private function timerTick(param1:TimerEvent) : void
      {
         dispatchEvent(new Event(Event.DEACTIVATE));
      }
      
      public function destroy() : void
      {
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.timerTick);
            this._timer = null;
         }
         stop();
         this.visible = false;
      }
   }
}
