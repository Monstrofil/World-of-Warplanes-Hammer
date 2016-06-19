package wowp.hud.core.states
{
   import flash.events.Event;
   
   public class HUDFSMEvent extends Event
   {
      
      public static const STATE_ACTIVATED:String = "wowp.hud.core.states.HUDStateEvent.STATE_ACTIVATED";
      
      public static const STATE_DEACTIVATED:String = "wowp.hud.core.states.HUDStateEvent.STATE_DEACTIVATED";
       
      public var state:wowp.hud.core.states.HUDState;
      
      public var newState:wowp.hud.core.states.HUDState;
      
      public function HUDFSMEvent(param1:String, param2:wowp.hud.core.states.HUDState, param3:wowp.hud.core.states.HUDState = null)
      {
         this.state = param2;
         this.newState = param3;
         super(param1);
      }
   }
}
