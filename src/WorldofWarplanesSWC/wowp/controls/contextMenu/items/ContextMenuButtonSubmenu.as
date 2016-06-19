package wowp.controls.contextMenu.items
{
   public class ContextMenuButtonSubmenu extends ContextMenuButton
   {
       
      public var subElements:Array;
      
      public function ContextMenuButtonSubmenu(param1:String, param2:Array, param3:String = "submenu", param4:Object = null, param5:Class = null)
      {
         super(param1,param3,param4,param5);
         this.subElements = param2;
      }
   }
}
