package wowp.hud.common.infoEntities
{
   import flash.display.MovieClip;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   
   public class AnticipationPoint extends MovieClip
   {
       
      public var mcState:MovieClip;
      
      private var _state:int = 1;
      
      private var _color:int = 1;
      
      private var _isAlternativeColor:Boolean = false;
      
      private var dirBlink:int;
      
      private var valueBlink:Number;
      
      private var _updateTimeBlink:Timer;
      
      public function AnticipationPoint()
      {
         super();
         x = -1000;
         y = -1000;
         this.reset();
         this._updateTimeBlink = new Timer(40,5);
         this._updateTimeBlink.addEventListener(TimerEvent.TIMER,this.updateTimeBlink);
         this.setPoint();
      }
      
      private function setPoint() : void
      {
         gotoAndStop(this._state);
         this.mcState.gotoAndStop(this._color);
         if(Boolean(this._isAlternativeColor) && this.mcState.currentFrame == 1)
         {
            this.mcState.gotoAndStop(this.mcState.totalFrames);
         }
         else if(!this._isAlternativeColor && this.mcState.currentFrame == this.mcState.totalFrames)
         {
            this.mcState.gotoAndStop(1);
         }
      }
      
      public function setFPState(param1:int) : void
      {
         this._state = param1;
         this.setPoint();
         if(this._state == 3)
         {
            this.mcState.scaleX = this.mcState.scaleY = 0;
         }
      }
      
      public function setFPColor(param1:int) : void
      {
         this._color = param1;
         this.setPoint();
      }
      
      public function setAlternativeColor(param1:Boolean) : void
      {
         this._isAlternativeColor = param1;
         this.setPoint();
      }
      
      public function showBlink() : void
      {
         this.dirBlink = 1;
         this.valueBlink = 0;
         this.clearBlink();
         this._updateTimeBlink.reset();
         this._updateTimeBlink.start();
      }
      
      public function reset() : void
      {
         this.dirBlink = 0;
         this.valueBlink = 0;
         this.clearBlink();
      }
      
      private function updateTimeBlink(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         if(Boolean(this.dirBlink) && this.dirBlink != 0)
         {
            this.valueBlink = this.valueBlink + this.dirBlink * Marker.DELTA_ICON_BLINK;
            if(this.valueBlink >= Marker.MAX_ICON_BLINK)
            {
               this.valueBlink = Marker.MAX_ICON_BLINK;
               this.dirBlink = -this.dirBlink;
            }
            _loc2_ = this.valueBlink * 255;
            if(_loc2_ > 0)
            {
               this.blink(_loc2_);
            }
            else
            {
               this.dirBlink = 0;
               this.clearBlink();
            }
         }
      }
      
      private function blink(param1:int) : void
      {
         this.transform.colorTransform = new ColorTransform(1,1,1,1,param1,param1,param1,0);
      }
      
      private function clearBlink() : void
      {
         this.transform.colorTransform = new ColorTransform();
      }
      
      public function dispose() : void
      {
         this._updateTimeBlink.stop();
         this._updateTimeBlink.removeEventListener(TimerEvent.TIMER,this.updateTimeBlink);
         this._updateTimeBlink = null;
      }
   }
}
