package wowp.hud.core.states
{
   import flash.events.Event;
   
   public class HUDStateEvent extends Event
   {
      
      static const CHANGE_STATE:String = "wowp.hud.core.states.HUDStateEvent.CHANGE_STATE";
      
      static const POP_STATE:String = "wowp.hud.core.states.HUDStateEvent.POP_STATE";
      
      static const PUSH_STATE:String = "wowp.hud.core.states.HUDStateEvent.PUSH_STATE";
      
      static const DEFAULT_STATE:String = "wowp.hud.core.states.HUDStateEvent.DEFAULT_STATE";
      
      static const SET_DEFAULT:String = "wowp.hud.core.states.HUDStateEvent.SET_DEFAULT";
       
      public var stateClass:Class;
      
      public function HUDStateEvent(param1:String, param2:Class = null)
      {
         this.stateClass = param2;
         super(param1);
      }
   }
}
