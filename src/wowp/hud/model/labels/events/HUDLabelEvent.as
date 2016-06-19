package wowp.hud.model.labels.events
{
   import flash.events.Event;
   
   public class HUDLabelEvent extends Event
   {
       
      public var text:String;
      
      public function HUDLabelEvent(param1:String, param2:String = "")
      {
         this.text = param2;
         super(param1);
      }
   }
}
