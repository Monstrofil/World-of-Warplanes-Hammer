package wowp.utils.domain
{
   import flash.display.LoaderInfo;
   import flash.system.ApplicationDomain;
   
   public function getDefinition(param1:String, param2:LoaderInfo = null) : Class
   {
      var _loc3_:ApplicationDomain = ApplicationDomain.currentDomain;
      if(param2 != null && param2.applicationDomain != null)
      {
         _loc3_ = param2.applicationDomain;
      }
      return _loc3_.getDefinition(param1) as Class;
   }
}
