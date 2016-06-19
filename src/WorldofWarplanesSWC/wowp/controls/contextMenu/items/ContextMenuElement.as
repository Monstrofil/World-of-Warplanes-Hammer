package wowp.controls.contextMenu.items
{
   public class ContextMenuElement
   {
       
      public var customItemRenderer:Class;
      
      public var customItemData:Object;
      
      public function ContextMenuElement(param1:Class = null, param2:Object = null)
      {
         super();
         this.customItemRenderer = param1;
         this.customItemData = param2;
      }
   }
}
