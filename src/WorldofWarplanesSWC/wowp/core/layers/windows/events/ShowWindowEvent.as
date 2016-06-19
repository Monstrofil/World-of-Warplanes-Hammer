package wowp.core.layers.windows.events
{
   import flash.events.Event;
   import flash.display.DisplayObject;
   
   public class ShowWindowEvent extends Event
   {
      
      public static const TYPE:String = "wowp.core.layers.windows.events.TYPE";
       
      public var window:DisplayObject;
      
      public var isModal:Boolean;
      
      public var edges:uint;
      
      public var sortOnMouseDown:Boolean;
      
      public var openOnBottom:Boolean;
      
      public var putUnder:String = "state";
      
      public function ShowWindowEvent(param1:DisplayObject, param2:uint = 0, param3:Boolean = false, param4:Boolean = true, param5:Boolean = false)
      {
         this.window = param1;
         this.isModal = param3;
         this.edges = param2;
         this.sortOnMouseDown = param4;
         this.openOnBottom = param5;
         super(TYPE,true,true);
      }
   }
}
