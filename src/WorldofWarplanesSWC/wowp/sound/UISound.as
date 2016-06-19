package wowp.sound
{
   import wowp.utils.timeout.IValidator;
   import flash.events.IEventDispatcher;
   import wowp.core.eventPipe.EventPipe;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import wowp.utils.timeout.TimeoutValidator;
   
   public class UISound
   {
      
      private static var _instance:wowp.sound.UISound;
       
      private var _validator:IValidator;
      
      private var _recentSoundsValidator:IValidator;
      
      private const _holdersByEventType:Object = {};
      
      private const _eventsToSubscribe:Array = [];
      
      private const _subscribedEvents:Array = [];
      
      private const _recentSounds:Array = [];
      
      private var _eventDispatcher:IEventDispatcher;
      
      public function UISound(param1:SingletonEnforser)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Singleton instatiation error, use UISound.instanse instead!");
         }
         this._validator = new TimeoutValidator(this.validate);
         this._recentSoundsValidator = new TimeoutValidator(this.clearRecentSounds);
         if(EventPipe.isInitialized)
         {
            this.init();
         }
         else
         {
            EventPipe.onInitialized.add(this.init);
         }
      }
      
      public static function get instanse() : wowp.sound.UISound
      {
         if(_instance == null)
         {
            _instance = new wowp.sound.UISound(new SingletonEnforser());
         }
         return _instance;
      }
      
      public function init(param1:IEventDispatcher = null) : void
      {
         trace("UISound::init",param1);
         this._eventDispatcher = param1 != null?param1:new EventPipe();
         this.invalidate();
         this._eventDispatcher.addEventListener(UISoundEvent.PLAY_UI_SOUND,this.soundEventHandler);
      }
      
      public function dispose() : void
      {
         var _loc1_:String = null;
         trace("UISound::dispose");
         this._eventDispatcher.removeEventListener(UISoundEvent.PLAY_UI_SOUND,this.soundEventHandler);
         while(this._subscribedEvents.length > 0)
         {
            _loc1_ = this._subscribedEvents.pop();
            this._eventDispatcher.removeEventListener(_loc1_,this.handler,true);
            delete this._holdersByEventType[_loc1_];
         }
         this._validator.dispose();
         this._eventsToSubscribe.length = 0;
      }
      
      private function soundEventHandler(param1:UISoundEvent) : void
      {
         this.playSound(param1.soundID);
      }
      
      public function register(param1:String, param2:String, param3:String = null, param4:String = null, param5:Class = null) : void
      {
         var _loc6_:SoundHolderCollection = this._holdersByEventType[param1] as SoundHolderCollection;
         if(_loc6_ == null)
         {
            _loc6_ = this._holdersByEventType[param1] = new SoundHolderCollection();
         }
         var _loc7_:SoundHolder = new SoundHolder();
         _loc7_.soundID = param2;
         _loc7_.targetClassName = param4;
         _loc7_.targetName = param3;
         _loc7_.targetClass = param5;
         _loc6_.add(_loc7_);
         this._eventsToSubscribe.push(param1);
         this.invalidate();
      }
      
      private function invalidate() : void
      {
         this._validator.invalidate();
      }
      
      public function validateNow() : void
      {
         this._validator.validateNow();
      }
      
      private function validate() : void
      {
         var _loc1_:String = null;
         if(this._eventDispatcher is EventPipe && Boolean(EventPipe.isInitialized) || !(this._eventDispatcher is EventPipe))
         {
            while(this._eventsToSubscribe.length > 0)
            {
               _loc1_ = this._eventsToSubscribe.pop();
               if(this._subscribedEvents.indexOf(_loc1_) == -1)
               {
                  this._subscribedEvents.push(_loc1_);
                  this._eventDispatcher.addEventListener(_loc1_,this.handler,true,0,false);
                  this._eventDispatcher.addEventListener(_loc1_,this.handler,false,0,false);
               }
            }
         }
      }
      
      private function handler(param1:Event) : void
      {
         this.process(param1.type,param1.target);
      }
      
      private function process(param1:String, param2:Object) : void
      {
         var _loc4_:SoundHolder = null;
         var _loc3_:SoundHolderCollection = this._holdersByEventType[param1] as SoundHolderCollection;
         if(_loc3_)
         {
            _loc4_ = _loc3_.getSoundHolder(param2);
            if(_loc4_)
            {
               this.playSound(_loc4_.soundID);
            }
            else if(_loc3_.soundID != null)
            {
               this.playSound(_loc3_.soundID);
            }
         }
      }
      
      private function clearRecentSounds() : void
      {
         this._recentSounds.length = 0;
      }
      
      public function playSound(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(this._recentSounds.indexOf(param1) == -1)
         {
            this._recentSounds[this._recentSounds.length] = param1;
            trace("UISound::playSound:",param1);
            ExternalInterface.call("UI.playSFX",param1);
            this._recentSoundsValidator.invalidate();
         }
      }
   }
}

class SingletonEnforser
{
    
   function SingletonEnforser()
   {
      super();
   }
}

class SoundHolder
{
    
   public var soundID:String;
   
   public var targetName:String;
   
   public var targetClass:Class;
   
   public var targetClassName:String;
   
   function SoundHolder()
   {
      super();
   }
}

import flash.utils.Dictionary;
import flash.utils.describeType;

class SoundHolderCollection
{
    
   private var _soundID:String;
   
   private var _byName:Object;
   
   private var _byClassName:Object;
   
   private var _byClass:Dictionary;
   
   function SoundHolderCollection()
   {
      this._byName = {};
      this._byClassName = {};
      this._byClass = new Dictionary();
      super();
   }
   
   public function get soundID() : String
   {
      return this._soundID;
   }
   
   public function add(param1:SoundHolder) : void
   {
      if(param1.targetName == null && param1.targetClassName == null && param1.targetClass == null)
      {
         this._soundID = param1.soundID;
      }
      else
      {
         if(param1.targetName)
         {
            this._byName[param1.targetName] = param1;
         }
         if(param1.targetClassName)
         {
            this._byClassName[param1.targetClassName] = param1;
         }
         if(param1.targetClass)
         {
            this._byClass[param1.targetClass] = param1;
         }
      }
   }
   
   public function getSoundHolder(param1:Object) : SoundHolder
   {
      var _loc2_:String = param1.name;
      var _loc3_:String = describeType(param1).@name.toString();
      var _loc4_:Class = param1["constructor"] as Class;
      return this._byName[_loc2_] as SoundHolder || this._byClassName[_loc3_] as SoundHolder || this.getByClass(param1);
   }
   
   private function getByClass(param1:Object) : SoundHolder
   {
      var _loc2_:* = undefined;
      var _loc3_:Class = null;
      for(_loc2_ in this._byClass)
      {
         _loc3_ = _loc2_ as Class;
         if(Boolean(_loc3_) && param1 is _loc3_)
         {
            return this._byClass[_loc2_] as SoundHolder;
         }
      }
      return null;
   }
}
