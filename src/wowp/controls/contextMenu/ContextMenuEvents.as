package wowp.controls.contextMenu
{
   import flash.events.Event;
   import wowp.controls.contextMenu.items.ContextMenuButton;
   
   public class ContextMenuEvents extends Event
   {
      
      public static const ITEM_PRESSED:String = "ITEM_PRESSED";
      
      public static const ITEM_OVER:String = "ITEM_OVER";
      
      public static const ITEM_OUT:String = "ITEM_OUT";
       
      public var item:ContextMenuButton;
      
      public function ContextMenuEvents(param1:String)
      {
         super(param1,true,true);
      }
   }
}
