package wowp.core.layers.tip
{
   import flash.display.Stage;
   import scaleform.clik.motion.Tween;
   import flash.display.DisplayObject;
   import flash.utils.clearTimeout;
   import flash.events.Event;
   import wowp.core.layers.tip.events.ShowTipEvent;
   import wowp.core.layers.tip.events.HideTipEvent;
   import wowp.core.layers.context.events.AddContextMenuEvent;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import flash.display.InteractiveObject;
   import flash.display.DisplayObjectContainer;
   import wowp.core.api.IDisposable;
   import flash.utils.getTimer;
   
   public class TipsManager
   {
      
      public static var fadeInDuration:int = 100;
       
      private var _stage:Stage;
      
      private var _tween:Tween;
      
      private var _tip:DisplayObject;
      
      private var _delay:int;
      
      private var _mouseXoffset:Number;
      
      private var _mouseYoffset:Number;
      
      private var _follow:Boolean;
      
      private var _showTipDelay:uint;
      
      private var _validateStageDepth:uint;
      
      private var _maxHideSpeed:Number;
      
      private var _prevMouseX:Number;
      
      private var _prevMouseY:Number;
      
      private var _prevTime:int;
      
      private var _isWaitingForDelay:Boolean;
      
      public function TipsManager(param1:Stage)
      {
         super();
         this._stage = param1;
         param1.addEventListener(ShowTipEvent.TYPE,this.showTipHandler);
         param1.addEventListener(HideTipEvent.TYPE,this.hideTipHandler);
         param1.addEventListener(AddContextMenuEvent.TYPE,this.hideTipHandler);
         param1.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
         param1.addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      
      public function dispose() : void
      {
         clearTimeout(this._showTipDelay);
         clearTimeout(this._validateStageDepth);
         this.removeTip();
         if(this._stage)
         {
            this._stage.removeEventListener(Event.ADDED,this.addedHandler);
            this._stage.removeEventListener(ShowTipEvent.TYPE,this.showTipHandler);
            this._stage.removeEventListener(HideTipEvent.TYPE,this.hideTipHandler);
            this._stage.removeEventListener(AddContextMenuEvent.TYPE,this.hideTipHandler);
            this._stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
            this._stage.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
            this._stage = null;
         }
      }
      
      private function showTipHandler(param1:ShowTipEvent) : void
      {
         this.removeTip();
         this._maxHideSpeed = param1.maxSpeed;
         this._delay = param1.delay;
         this._tip = param1.tip;
         this._mouseXoffset = param1.mouseXoffset;
         this._mouseYoffset = param1.mouseYoffset;
         this._follow = param1.follow;
         clearTimeout(this._showTipDelay);
         this._isWaitingForDelay = true;
         this._showTipDelay = setTimeout(this.show,this._delay);
      }
      
      private function show() : void
      {
         this._isWaitingForDelay = false;
         this._stage.addChild(this._tip);
         this._stage.setChildIndex(this._tip,this._stage.numChildren - 1);
         this._tip.name = "tip";
         this._stage.addEventListener(Event.ADDED,this.addedHandler,false,int.MAX_VALUE);
         this._tip.visible = true;
         this._tip.alpha = 0;
         if(this._tween)
         {
            this._tween.paused = true;
         }
         this._tween = new Tween(fadeInDuration,this._tip,{"alpha":1});
         if(this._tip is InteractiveObject)
         {
            (this._tip as InteractiveObject).mouseEnabled = false;
         }
         if(this._tip is DisplayObjectContainer)
         {
            (this._tip as DisplayObjectContainer).mouseChildren = false;
         }
         this.position(true);
      }
      
      private function addedHandler(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         if(this._validateStageDepth == 0)
         {
            this._validateStageDepth = setTimeout(this.validateStageDepth,1);
         }
      }
      
      private function validateStageDepth() : void
      {
         if(Boolean(this._tip) && Boolean(this._stage))
         {
            this._stage.setChildIndex(this._tip,this._stage.numChildren - 1);
         }
         this._validateStageDepth = 0;
      }
      
      private function hideTipHandler(param1:Event) : void
      {
         this._isWaitingForDelay = false;
         clearTimeout(this._showTipDelay);
         this.removeTip();
      }
      
      private function removeTip() : void
      {
         if(this._tween)
         {
            this._tween.paused = true;
         }
         if(this._tip)
         {
            if(this._tip.parent)
            {
               this._tip.parent.removeChild(this._tip);
            }
            if(this._tip is IDisposable)
            {
               (this._tip as IDisposable).dispose();
            }
            this._tip = null;
         }
         if(this._stage)
         {
            this._stage.removeEventListener(Event.ADDED,this.addedHandler);
         }
      }
      
      private function mouseMoveHandler(param1:Event) : void
      {
         if(this._follow)
         {
            this.position(false);
         }
      }
      
      private function position(param1:Boolean) : void
      {
         if(this._tip)
         {
            if(!isNaN(this._mouseXoffset))
            {
               this._tip.x = this._stage.mouseX + this._mouseXoffset;
            }
            if(!isNaN(this._mouseYoffset))
            {
               this._tip.y = this._stage.mouseY + this._mouseYoffset;
            }
            if(this._tip.x < 0)
            {
               this._tip.x = 0;
            }
            if(this._tip.y < 0)
            {
               this._tip.y = 0;
            }
            if(this._tip.x + this._tip.width > this._stage.stageWidth)
            {
               this._tip.x = this._stage.stageWidth - this._tip.width;
            }
            if(this._tip.y + this._tip.height > this._stage.stageHeight)
            {
               this._tip.y = this._stage.stageHeight - this._tip.height;
            }
            if(param1)
            {
               this._tip.x = int(this._tip.x);
               this._tip.y = int(this._tip.y);
            }
         }
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - this._prevTime;
         this._prevTime = _loc2_;
         var _loc4_:Number = this._stage.mouseX - this._prevMouseX;
         var _loc5_:Number = this._stage.mouseY - this._prevMouseY;
         this._prevMouseX = this._stage.mouseX;
         this._prevMouseY = this._stage.mouseY;
         if(_loc3_ == 0)
         {
            return;
         }
         if(this._tip)
         {
            if(!isNaN(this._maxHideSpeed))
            {
               if(this._maxHideSpeed <= (_loc4_ < 0?-_loc4_:_loc4_) / _loc3_ || this._maxHideSpeed <= (_loc5_ < 0?-_loc5_:_loc5_) / _loc3_)
               {
                  if(Boolean(this._tip.visible) && this._tip.parent != null)
                  {
                     this._isWaitingForDelay = false;
                     clearTimeout(this._showTipDelay);
                     this._tip.visible = false;
                     if(this._tween)
                     {
                        this._tween.paused = true;
                     }
                  }
               }
               else if(!this._tip.visible || this._tip.parent == null)
               {
                  if(!this._isWaitingForDelay)
                  {
                     clearTimeout(this._showTipDelay);
                     this._isWaitingForDelay = true;
                     this._showTipDelay = setTimeout(this.show,this._delay);
                  }
               }
            }
         }
      }
   }
}
