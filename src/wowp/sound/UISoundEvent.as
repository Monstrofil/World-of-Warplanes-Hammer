package wowp.sound
{
   import flash.events.Event;
   
   public class UISoundEvent extends Event
   {
      
      public static const PLAY_UI_SOUND:String = "wowp.sound.UISoundEvent.PLAY_UI_SOUND";
       
      public var soundID:String;
      
      public function UISoundEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         this.soundID = param2;
         super(param1,param3,param4);
      }
      
      override public function clone() : Event
      {
         return new UISoundEvent(type,this.soundID,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("UISoundEvent","soundID","type","bubbles","cancelable","eventPhase");
      }
   }
}
