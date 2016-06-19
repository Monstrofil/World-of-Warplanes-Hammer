package wowp.core.base
{
   import wowp.utils.data.ioc.UnitInjector;
   
   public class BaseVO
   {
       
      public function BaseVO(param1:Object = null)
      {
         super();
         if(param1)
         {
            this.updateProps(param1);
         }
      }
      
      protected function updateProps(param1:Object) : void
      {
         new UnitInjector(this["constructor"],param1).inject(this);
      }
   }
}
