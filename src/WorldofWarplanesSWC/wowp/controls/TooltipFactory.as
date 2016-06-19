package wowp.controls
{
   import wowp.controls.tooltips.ITooltipIconDescriptionDetails;
   import wowp.utils.domain.getDefinition;
   import wowp.controls.tooltips.ITooltipIconTitleDescription;
   import wowp.controls.tooltips.ITooltipNoTitleIconDescription;
   import wowp.controls.tooltips.ITooltipSimpleText;
   import flash.utils.getQualifiedClassName;
   import flash.display.DisplayObject;
   import wowp.utils.data.ioc.IUnitInjector;
   import scaleform.clik.utils.Padding;
   
   public class TooltipFactory
   {
      
      private static var _map:Object;
       
      public function TooltipFactory()
      {
         super();
      }
      
      private static function init() : void
      {
         _map = {};
         register(ITooltipIconDescriptionDetails,getDefinition("SimpleIconTooltipClass") as Class);
         register(ITooltipIconTitleDescription,getDefinition("SimpleIconTitleDescriptionClass") as Class);
         register(ITooltipNoTitleIconDescription,getDefinition("SimpleIconTootipNoTitleClass") as Class);
         register(ITooltipSimpleText,getDefinition("SimpleTextTooltipClass") as Class);
      }
      
      public static function register(param1:Class, param2:Class) : void
      {
         if(_map == null)
         {
            init();
         }
         _map[getQualifiedClassName(param1)] = param2;
      }
      
      public static function createContent(param1:Class, param2:IUnitInjector = null) : DisplayObject
      {
         var _loc4_:DisplayObject = null;
         if(_map == null)
         {
            init();
         }
         var _loc3_:Class = _map[getQualifiedClassName(param1)] as Class;
         if(_loc3_)
         {
            _loc4_ = new _loc3_() as DisplayObject;
            if(param2 != null)
            {
               param2.inject(_loc4_);
            }
            return _loc4_;
         }
         return null;
      }
      
      public static function createTooltip(param1:Class, param2:IUnitInjector = null, param3:Padding = null) : DisplayObject
      {
         return UIFactory.createInfoTip(createContent(param1,param2),param3);
      }
   }
}
