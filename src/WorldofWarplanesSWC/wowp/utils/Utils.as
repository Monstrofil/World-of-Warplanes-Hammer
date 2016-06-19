package wowp.utils
{
   import scaleform.clik.controls.Label;
   import flash.display.Stage;
   import flash.display.StageAlign;
   import flash.display.DisplayObjectContainer;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.geom.Rectangle;
   
   public class Utils
   {
      
      public static var TIME_SEPARATOR:String = " : ";
      
      private static const SECONDS:int = 60;
      
      private static var LOGICAL_W:Number = 1024;
      
      private static var LOGICAL_H:Number = 768;
       
      public function Utils()
      {
         super();
      }
      
      public static function refillArray(param1:Array, param2:Array) : void
      {
         var _loc3_:int = 0;
         param1.splice(0);
         var _loc4_:int = param2.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            param1[_loc3_] = param2[_loc3_];
            _loc3_++;
         }
      }
      
      public static function getLabelFormatter(param1:Label, param2:Number = 1, param3:int = 0) : Function
      {
         var label:Label = param1;
         var multiplier:Number = param2;
         var numDigits:int = param3;
         return function(param1:Number):void
         {
            label.text = Number(param1 * multiplier).toFixed(numDigits);
         };
      }
      
      public static function getSceneTop(param1:Stage) : Number
      {
         if(param1.align == StageAlign.TOP || param1.align == StageAlign.TOP_LEFT || param1.align == StageAlign.TOP_RIGHT)
         {
            return 0;
         }
         return -(param1.stageHeight - LOGICAL_H) / 2;
      }
      
      public static function getSceneBottom(param1:Stage) : Number
      {
         if(param1.align == StageAlign.TOP || param1.align == StageAlign.TOP_LEFT || param1.align == StageAlign.TOP_RIGHT)
         {
            return param1.stageHeight;
         }
         return LOGICAL_H + (param1.stageHeight - LOGICAL_H) / 2;
      }
      
      public static function getSceneLeft(param1:Stage) : Number
      {
         if(param1.align == StageAlign.BOTTOM_LEFT || param1.align == StageAlign.TOP_LEFT || param1.align == StageAlign.LEFT)
         {
            return 0;
         }
         return -(param1.stageWidth - LOGICAL_W) / 2;
      }
      
      public static function getSceneRight(param1:Stage) : Number
      {
         if(param1.align == StageAlign.BOTTOM_LEFT || param1.align == StageAlign.TOP_LEFT || param1.align == StageAlign.LEFT)
         {
            return param1.stageWidth;
         }
         return LOGICAL_W + (param1.stageWidth - LOGICAL_W) / 2;
      }
      
      public static function forEachChild(param1:DisplayObjectContainer, param2:Function, param3:Function, ... rest) : void
      {
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:Boolean = false;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:int = param1.numChildren;
         if(rest == null)
         {
            rest = [];
         }
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = param1.getChildAt(_loc6_);
            if(_loc7_ is DisplayObjectContainer)
            {
               _loc8_ = true;
               if(param3 != null)
               {
                  rest.unshift(_loc7_);
                  _loc8_ = param3.apply(null,rest);
                  rest.shift();
               }
               if(_loc8_)
               {
                  forEachChild.apply(null,([_loc7_,param2,param3] as Array).concat(rest));
               }
            }
            else if(param2 != null)
            {
               rest.unshift(_loc7_);
               param2.apply(null,rest);
               rest.shift();
            }
            _loc6_++;
         }
         if(param2 != null)
         {
            rest.unshift(param1 as DisplayObject);
            param2.apply(null,rest);
         }
      }
      
      public static function arabic2Roman(param1:int) : String
      {
         switch(param1)
         {
            case 1:
               return "I";
            case 2:
               return "II";
            case 3:
               return "III";
            case 4:
               return "IV";
            case 5:
               return "V";
            case 6:
               return "VI";
            case 7:
               return "VII";
            case 8:
               return "VIII";
            case 9:
               return "IX";
            case 10:
               return "X";
            default:
               return "n/a";
         }
      }
      
      public static function setShortString(param1:TextField, param2:String, param3:String = null) : String
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Rectangle = null;
         if(param1 == null || param2 == "" || param2 == null)
         {
            return "";
         }
         param3 = !param3?param1.autoSize:param3;
         param1.visible = false;
         param1.htmlText = param2;
         param2 = param1.text;
         while(true)
         {
            _loc7_ = param1.getCharBoundaries(param1.text.length - 1);
            _loc5_ = _loc7_.y + _loc7_.height;
            _loc4_ = _loc7_.x + _loc7_.width;
            if(_loc5_ > param1.height || _loc4_ > param1.width)
            {
               param2 = param2.slice(0,param2.length - 1);
               param1.text = param2;
               _loc6_ = true;
               continue;
            }
            break;
         }
         if(_loc6_)
         {
            param2 = param2.slice(0,param2.length - 3) + "...";
         }
         param1.text = "";
         param1.autoSize = param3;
         param1.visible = true;
         return param2;
      }
      
      public static function formatTime(param1:int) : String
      {
         var _loc2_:int = param1 / SECONDS;
         var _loc3_:int = param1 - SECONDS * _loc2_;
         var _loc4_:String = _loc3_.toString();
         var _loc5_:String = _loc2_.toString();
         if(_loc3_ < 10)
         {
            _loc4_ = "0" + _loc4_;
         }
         if(_loc2_ < 10)
         {
            _loc5_ = "0" + _loc5_;
         }
         return _loc5_ + TIME_SEPARATOR + _loc4_;
      }
      
      public static function trimWhitespace(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return param1.replace(/^\s+|\s+$/g,"");
      }
   }
}
