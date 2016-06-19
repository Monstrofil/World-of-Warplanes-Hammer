package wowp.core.layers.windows.events
{
   import flash.events.Event;
   import flash.display.DisplayObject;
   
   public class HideWindowEvent extends Event
   {
      
      public static const TYPE:String = "wowp.core.layers.windows.events";
       
      public var window:DisplayObject;
      
      public function HideWindowEvent(param1:DisplayObject)
      {
         this.window = param1;
         super(TYPE,true);
      }
   }
}
