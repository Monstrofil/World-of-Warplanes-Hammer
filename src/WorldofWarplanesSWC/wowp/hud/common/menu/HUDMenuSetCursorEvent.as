package wowp.hud.common.menu
{
   import flash.events.Event;
   
   public class HUDMenuSetCursorEvent extends Event
   {
      
      public static const SET_CURSOR:String = "wowp.hud.common.menu.HUDMenuSetCursorEvent.SET_CURSOR";
       
      public var x:Number;
      
      public var y:Number;
      
      public function HUDMenuSetCursorEvent(param1:String, param2:Number, param3:Number)
      {
         this.x = param2;
         this.y = param3;
         super(param1,true);
      }
      
      override public function clone() : Event
      {
         return new HUDMenuSetCursorEvent(type,this.x,this.y);
      }
      
      override public function toString() : String
      {
         return formatToString("HUDMenuSetCursorEvent","type","bubbles","cancelable","eventPhase","x","y");
      }
   }
}
