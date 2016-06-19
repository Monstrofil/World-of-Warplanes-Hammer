package wowp.utils.data.ioc
{
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   public class UnitInjector implements IUnitInjector
   {
       
      private var _interfaceClass:Class;
      
      private var _sourceRoot:Object;
      
      private var _target:Object;
      
      public function UnitInjector(param1:Class = null, param2:Object = null)
      {
         super();
         this.fill(param1,param2);
      }
      
      public function fill(param1:Class, param2:Object) : void
      {
         this._interfaceClass = param1;
         this._sourceRoot = param2;
      }
      
      public function inject(param1:Object) : void
      {
         var target:Object = param1;
         this._target = target;
         if(!target)
         {
            throw Error("::Injection is not possible, there is no target object !\'");
         }
         if(!this._sourceRoot)
         {
            throw Error("::Data injection is missing !\'");
         }
         if(!this._interfaceClass)
         {
            throw Error("::Injector interface missing !");
         }
         try
         {
            this._interfaceClass(target);
         }
         catch(e:Error)
         {
            throw Error("::Interface \'" + _interfaceClass + "\'is not implemented !");
         }
         this.injectRecurrent(target,this._sourceRoot);
      }
      
      protected function injectRecurrent(param1:Object, param2:Object = null) : void
      {
         var _loc3_:* = null;
         var _loc7_:Object = null;
         var _loc8_:XML = null;
         var _loc9_:XML = null;
         var _loc10_:Function = null;
         var _loc11_:Array = null;
         var _loc12_:Object = null;
         var _loc4_:XML = describeType(param2);
         var _loc5_:XMLList = _loc4_.variable;
         var _loc6_:XMLList = _loc4_.accessor;
         if(_loc5_.length() + _loc6_.length() > 0)
         {
            _loc7_ = {};
            for(_loc3_ in param2)
            {
               _loc7_[_loc3_] = param2[_loc3_];
            }
            for each(_loc8_ in _loc5_)
            {
               _loc7_[_loc8_.@name] = param2[_loc8_.@name];
            }
            for each(_loc9_ in _loc6_)
            {
               if(Boolean(_loc9_ && _loc9_.@type && _loc9_.@name && _loc9_.@access && _loc9_.parameter) && Boolean(_loc9_.parameter.length() <= 0) && (_loc9_.@access == "readwrite" || _loc9_.@access == "readonly"))
               {
                  _loc7_[_loc9_.@name] = param2[_loc9_.@name];
               }
            }
            param2 = _loc7_;
         }
         for(_loc3_ in param2)
         {
            if(param1.hasOwnProperty(_loc3_))
            {
               if(typeof param1[_loc3_] == "object")
               {
                  if(param1[_loc3_] == null || getQualifiedClassName(param1[_loc3_]) == getQualifiedClassName(param2[_loc3_]))
                  {
                     try
                     {
                        param1[_loc3_] = param2[_loc3_];
                     }
                     catch(e:Error)
                     {
                     }
                  }
                  else
                  {
                     this.injectRecurrent(param1[_loc3_],param2[_loc3_] as Object);
                  }
               }
               else if(param1[_loc3_] is Function)
               {
                  _loc10_ = param1[_loc3_] as Function;
                  if(_loc10_.length == 0)
                  {
                     _loc10_.call();
                  }
                  else if(_loc10_.length == 1)
                  {
                     _loc10_(param2[_loc3_]);
                  }
                  else if(_loc10_.length > 1)
                  {
                     _loc11_ = [];
                     for each(_loc12_ in param2[_loc3_])
                     {
                        _loc11_.push(getQualifiedClassName(_loc12_) + "(" + (_loc12_ is String?"\"" + _loc12_ + "\"":_loc12_) + ")");
                     }
                     _loc10_.apply(null,param2[_loc3_]);
                  }
               }
               else
               {
                  param1[_loc3_] = param2[_loc3_];
               }
            }
         }
      }
      
      public function get targetClass() : Class
      {
         return this._interfaceClass;
      }
      
      public function get target() : Object
      {
         return this._target;
      }
   }
}
