package wowp.utils.data.ioc
{
   public interface IUnitInjector
   {
       
      function inject(param1:Object) : void;
      
      function get targetClass() : Class;
      
      function get target() : Object;
   }
}
