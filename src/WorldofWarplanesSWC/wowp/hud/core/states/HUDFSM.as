package wowp.hud.core.states
{
   import flash.events.EventDispatcher;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class HUDFSM extends EventDispatcher
   {
       
      private var _state:wowp.hud.core.states.HUDState;
      
      private var _defaultState:Class;
      
      private var _stack:Vector.<Class>;
      
      private var _delayedEnterStateTimeoutID:uint;
      
      public function HUDFSM()
      {
         this._stack = new Vector.<Class>();
         super();
      }
      
      public function dispose() : void
      {
         if(this._state)
         {
            this._state.removeEventListener(HUDStateEvent.CHANGE_STATE,this.changeStateHandler);
            this._state.removeEventListener(HUDStateEvent.DEFAULT_STATE,this.changeDefaultStateHandler);
            this._state.removeEventListener(HUDStateEvent.POP_STATE,this.popStateHandler);
            this._state.removeEventListener(HUDStateEvent.PUSH_STATE,this.pushStateHandler);
            this._state.removeEventListener(HUDStateEvent.SET_DEFAULT,this.setDefaultStateHandler);
            this._state.exit();
            this._state = null;
         }
         this._stack.length = 0;
      }
      
      public function start(param1:Class) : void
      {
         this.setState(param1);
      }
      
      private function changeStateHandler(param1:HUDStateEvent) : void
      {
         trace("HUDFSM::changeStateHandler",param1.stateClass);
         this.setState(param1.stateClass);
      }
      
      private function changeDefaultStateHandler(param1:HUDStateEvent) : void
      {
         trace("HUDFSM::changeDefaultStateHandler",param1.stateClass);
         this._defaultState = param1.stateClass;
         if(this._stack.length > 0)
         {
            this._stack[0] = param1.stateClass;
         }
      }
      
      private function pushStateHandler(param1:HUDStateEvent) : void
      {
         trace("HUDFSM::pushStateHandler",param1.stateClass);
         this._stack[this._stack.length] = this._state.getStateClass();
         this.setState(param1.stateClass);
      }
      
      private function popStateHandler(param1:HUDStateEvent) : void
      {
         trace("HUDFSM::popStateHandler");
         this.setState(this._stack.length > 0?this._stack.pop():this._defaultState);
      }
      
      private function setDefaultStateHandler(param1:HUDStateEvent) : void
      {
         this._stack.length = 0;
         this.setState(this._defaultState);
      }
      
      private function setState(param1:Class) : void
      {
         var _loc2_:wowp.hud.core.states.HUDState = null;
         if(param1)
         {
            _loc2_ = new param1() as wowp.hud.core.states.HUDState;
            if(_loc2_)
            {
               if(this._state)
               {
                  this._state.removeEventListener(HUDStateEvent.CHANGE_STATE,this.changeStateHandler);
                  this._state.removeEventListener(HUDStateEvent.DEFAULT_STATE,this.changeDefaultStateHandler);
                  this._state.removeEventListener(HUDStateEvent.POP_STATE,this.popStateHandler);
                  this._state.removeEventListener(HUDStateEvent.PUSH_STATE,this.pushStateHandler);
                  this._state.removeEventListener(HUDStateEvent.SET_DEFAULT,this.setDefaultStateHandler);
                  trace("HUDFSM: exiting state:",this._state);
                  this._state.exit();
                  dispatchEvent(new HUDFSMEvent(HUDFSMEvent.STATE_DEACTIVATED,this._state,_loc2_));
               }
               this._state = _loc2_;
               _loc2_.addEventListener(HUDStateEvent.CHANGE_STATE,this.changeStateHandler);
               _loc2_.addEventListener(HUDStateEvent.DEFAULT_STATE,this.changeDefaultStateHandler);
               _loc2_.addEventListener(HUDStateEvent.POP_STATE,this.popStateHandler);
               _loc2_.addEventListener(HUDStateEvent.PUSH_STATE,this.pushStateHandler);
               _loc2_.addEventListener(HUDStateEvent.SET_DEFAULT,this.setDefaultStateHandler);
               dispatchEvent(new HUDFSMEvent(HUDFSMEvent.STATE_ACTIVATED,this._state));
               clearTimeout(this._delayedEnterStateTimeoutID);
               if(this._state.isEnterWithoutDelay)
               {
                  this.delayedEnter(_loc2_);
               }
               else
               {
                  this._delayedEnterStateTimeoutID = setTimeout(this.delayedEnter,1,_loc2_);
               }
               return;
            }
            throw new Error("HUDFSM:Given class is not a HUDState!");
         }
         throw new Error("HUDFSM:State class can\'t be null!");
      }
      
      private function delayedEnter(param1:wowp.hud.core.states.HUDState) : void
      {
         trace("HUDFSM: entering new state:",param1);
         param1.enter();
      }
      
      public function get currentState() : wowp.hud.core.states.HUDState
      {
         return this._state;
      }
   }
}
