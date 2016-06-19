package wowp.core.layers.context
{
   import scaleform.clik.utils.Padding;
   import wowp.controls.contextMenu.ContextMenu;
   
   public interface IContextMenuManager
   {
       
      function get itemRenderer() : Class;
      
      function set itemRenderer(param1:Class) : void;
      
      function get background() : Class;
      
      function set background(param1:Class) : void;
      
      function get padding() : Padding;
      
      function set padding(param1:Padding) : void;
      
      function get offset() : Number;
      
      function set offset(param1:Number) : void;
      
      function get openSubmenuRolloverDelay() : int;
      
      function set openSubmenuRolloverDelay(param1:int) : void;
      
      function clear() : void;
      
      function getCurrentContextMenu() : ContextMenu;
   }
}
