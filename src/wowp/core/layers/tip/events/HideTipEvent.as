package wowp.core.layers.tip.events
{
   import flash.events.Event;
   
   public class HideTipEvent extends Event
   {
      
      public static const TYPE:String = "wowp.core.layers.tip.events.HideTipEvent";
       
      public function HideTipEvent()
      {
         super(TYPE,true,true);
      }
   }
}
