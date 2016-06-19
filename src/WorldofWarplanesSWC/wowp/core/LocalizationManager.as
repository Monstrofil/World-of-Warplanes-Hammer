package wowp.core
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.display.DisplayObjectContainer;
   import flash.display.DisplayObject;
   import flash.external.ExternalInterface;
   import flash.events.Event;
   
   public class LocalizationManager extends EventDispatcher
   {
      
      protected static var instance:wowp.core.LocalizationManager;
      
      public static const LANGUAGE_CHANGED:String = "languageChanged";
       
      private const IN_PROPERTIES:Array = ["text","label"];
      
      private const SET_PROPERTIES:Array = ["label","htmlText","text"];
      
      protected var _controlsHash:Dictionary;
      
      protected const SINGLETON_MSG:String = "LocalizationManager Singleton already constructed!";
      
      protected var _localizationTable:Object;
      
      public function LocalizationManager()
      {
         this._localizationTable = new Object();
         super();
         if(instance != null)
         {
            throw Error(this.SINGLETON_MSG);
         }
         instance = this;
         this._controlsHash = new Dictionary(true);
         ExternalInterface.addCallback("receiveLocalization",this.receiveLocalization);
      }
      
      public static function getInstance() : wowp.core.LocalizationManager
      {
         if(instance == null)
         {
            instance = new wowp.core.LocalizationManager();
         }
         return instance;
      }
      
      public function applyLocalization(param1:Object, param2:Boolean = false) : void
      {
         var _loc5_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:String = "";
         var _loc4_:int = this.IN_PROPERTIES.length;
         if(param1 in this._controlsHash)
         {
            _loc3_ = this._controlsHash[param1] || "";
         }
         else
         {
            _loc4_ = this.IN_PROPERTIES.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(param1.hasOwnProperty(this.IN_PROPERTIES[_loc5_]))
               {
                  _loc3_ = param1[this.IN_PROPERTIES[_loc5_]] || "";
                  break;
               }
               _loc5_++;
            }
         }
         if(_loc3_.length < 1)
         {
            return;
         }
         var _loc6_:int = _loc3_.lastIndexOf("\r");
         if(_loc6_ == _loc3_.length - 1)
         {
            _loc3_ = _loc3_.substr(0,_loc6_);
         }
         if(_loc3_ == null)
         {
            _loc3_ = "NULL";
         }
         else
         {
            _loc3_ = _loc3_.toUpperCase();
         }
         var _loc7_:String = this._localizationTable[_loc3_] as String || "";
         if(_loc7_.length)
         {
            _loc4_ = this.SET_PROPERTIES.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(param1.hasOwnProperty(this.SET_PROPERTIES[_loc5_]))
               {
                  param1[this.SET_PROPERTIES[_loc5_]] = _loc7_;
                  break;
               }
               _loc5_++;
            }
         }
         if(_loc3_ != _loc7_ && Boolean(param2))
         {
            this._controlsHash[param1] = _loc3_;
         }
      }
      
      public function localizeDisplayObjectContainer(param1:DisplayObjectContainer, param2:Array = null, param3:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         if(param1 == null)
         {
            return;
         }
         if(param2 != null && param2.indexOf(param1.name) >= 0)
         {
            return;
         }
         var _loc4_:int = param1.numChildren;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1.getChildAt(_loc5_);
            if(_loc6_ is DisplayObjectContainer)
            {
               this.localizeDisplayObjectContainer(_loc6_ as DisplayObjectContainer,param2,param3);
            }
            else if(_loc6_ is DisplayObject && param2 == null || param2.indexOf(_loc6_.name) < 0)
            {
               this.applyLocalization(_loc6_,param3);
            }
            _loc5_++;
         }
         this.applyLocalization(param1 as Object,param3);
      }
      
      public function textByLocalizationID(param1:String) : String
      {
         if(param1 == null)
         {
            param1 = "NULL";
         }
         else
         {
            param1 = param1.toUpperCase();
         }
         return this._localizationTable[param1] || param1;
      }
      
      public function reloadLocalization() : void
      {
         ExternalInterface.call("Loader.GetLocalizationTable");
      }
      
      public function localizeArray(param1:Array) : void
      {
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            param1[_loc3_] = this.textByLocalizationID(param1[_loc3_]);
            _loc3_++;
         }
      }
      
      private function receiveLocalization(param1:Array) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this._localizationTable[param1[_loc2_]] = param1[_loc2_ + 1];
            _loc2_ = _loc2_ + 2;
         }
         dispatchEvent(new Event(LANGUAGE_CHANGED));
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         trace("LocalizationManager::dispose");
         ExternalInterface.addCallback("receiveLocalization",null);
         for(_loc1_ in this._controlsHash)
         {
            delete this._controlsHash[_loc1_];
         }
         this._controlsHash = null;
         wowp.core.LocalizationManager.instance = null;
      }
   }
}
