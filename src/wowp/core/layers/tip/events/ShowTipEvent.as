package wowp.core.layers.tip.events
{
   import flash.events.Event;
   import flash.display.DisplayObject;
   
   public class ShowTipEvent extends Event
   {
      
      public static const TYPE:String = "wowp.core.layers.tip.events.ShowTipEvent";
       
      public var tip:DisplayObject;
      
      public var mouseXoffset:Number = NaN;
      
      public var mouseYoffset:Number = NaN;
      
      public var delay:int = 0;
      
      public var follow:Boolean = true;
      
      public var maxSpeed:Number;
      
      public function ShowTipEvent(param1:DisplayObject)
      {
         this.tip = param1;
         super(TYPE,true,true);
      }
   }
}
