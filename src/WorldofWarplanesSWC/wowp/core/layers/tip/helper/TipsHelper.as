package wowp.core.layers.tip.helper
{
   import flash.utils.Dictionary;
   import flash.display.Stage;
   import wowp.core.layers.tip.events.HideTipEvent;
   import flash.display.DisplayObject;
   import wowp.core.layers.tip.events.ShowTipEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TipsHelper
   {
       
      private var _tips:Dictionary;
      
      private var _stage:Stage;
      
      public var tipDelay:int = 700;
      
      public var follow:Boolean = false;
      
      public var dx:Number = 0;
      
      public var dy:Number = 0;
      
      public var maxSpeed:Number = NaN;
      
      public function TipsHelper(param1:Stage)
      {
         this._tips = new Dictionary(true);
         super();
         this._stage = param1;
      }
      
      public function dispose() : void
      {
         if(this._stage)
         {
            this._stage.dispatchEvent(new HideTipEvent());
            this._stage = null;
         }
         this._tips = null;
      }
      
      public function removeTip() : void
      {
         if(this._stage)
         {
            this._stage.dispatchEvent(new HideTipEvent());
         }
      }
      
      public function showTip(param1:DisplayObject, param2:int = 0, param3:Number = NaN, param4:Number = NaN, param5:Boolean = true, param6:Number = NaN) : void
      {
         var _loc7_:ShowTipEvent = new ShowTipEvent(param1);
         _loc7_.delay = param2;
         _loc7_.mouseXoffset = param3;
         _loc7_.mouseYoffset = param4;
         _loc7_.follow = param5;
         _loc7_.maxSpeed = param6;
         this._stage.dispatchEvent(_loc7_);
      }
      
      private function mouseOverHandler(param1:Event) : void
      {
         var _loc2_:TipElement = this._tips[param1.currentTarget] as TipElement;
         if(_loc2_)
         {
            this.showTip(_loc2_.displayObject,_loc2_.delay,_loc2_.dx,_loc2_.dy,_loc2_.follow,_loc2_.maxSpeed);
         }
      }
      
      private function mouseOutHandler(param1:Event) : void
      {
         this.removeTip();
      }
      
      public function registerStaticTip(param1:DisplayObject, param2:DisplayObject) : void
      {
         var _loc3_:TipElement = null;
         if(param1 != null)
         {
            param1.addEventListener(MouseEvent.ROLL_OVER,this.mouseOverHandler,false,0,true);
            param1.addEventListener(MouseEvent.ROLL_OUT,this.mouseOutHandler,false,0,true);
            _loc3_ = new TipElement();
            _loc3_.delay = this.tipDelay;
            _loc3_.displayObject = param2;
            _loc3_.dx = this.dx;
            _loc3_.dy = this.dy;
            _loc3_.maxSpeed = this.maxSpeed;
            this._tips[param1] = _loc3_;
         }
      }
      
      public function removeStaticTip(param1:DisplayObject) : void
      {
         if(param1 != null)
         {
            param1.removeEventListener(MouseEvent.ROLL_OVER,this.mouseOverHandler);
            param1.removeEventListener(MouseEvent.ROLL_OUT,this.mouseOutHandler);
            if(this._tips[param1])
            {
               delete this._tips[param1];
            }
         }
      }
   }
}

import flash.display.DisplayObject;

class TipElement
{
    
   public var dx:Number;
   
   public var dy:Number;
   
   public var delay:int;
   
   public var displayObject:DisplayObject;
   
   public var follow:Boolean;
   
   public var maxSpeed:Number;
   
   function TipElement()
   {
      super();
   }
}
