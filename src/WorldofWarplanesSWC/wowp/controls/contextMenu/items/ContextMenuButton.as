package wowp.controls.contextMenu.items
{
   public class ContextMenuButton extends ContextMenuElement
   {
       
      public var label:String;
      
      public var id:String;
      
      public var data:Object;
      
      public function ContextMenuButton(param1:String, param2:String, param3:Object = null, param4:Class = null)
      {
         this.label = param1;
         this.id = param2;
         this.data = param3;
         super(param4,param3);
      }
   }
}
