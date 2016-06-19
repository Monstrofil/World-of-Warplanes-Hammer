package wowp.core.layers.context.events
{
   import flash.events.Event;
   
   public class RemoveContextMenuEvent extends Event
   {
      
      public static const TYPE:String = "wowp.core.layers.context.events.RemoveContextMenuEvent";
       
      public function RemoveContextMenuEvent()
      {
         super(TYPE,true,true);
      }
   }
}
