package wowp.core.layers.windows
{
   import scaleform.clik.utils.Padding;
   import flash.display.DisplayObject;
   import wowp.chat.IChatWindow;
   import flash.display.DisplayObjectContainer;
   
   public interface IWindowsManager
   {
       
      function get stagePadding() : Padding;
      
      function set stagePadding(param1:Padding) : void;
      
      function addWindow(param1:DisplayObject, param2:uint = 0, param3:Boolean = true, param4:Boolean = false) : void;
      
      function addChatWindow(param1:IChatWindow) : void;
      
      function removeWindow(param1:DisplayObject) : void;
      
      function bringToTop(param1:DisplayObject) : void;
      
      function bringToBottom(param1:DisplayObject) : void;
      
      function get middleContainer() : DisplayObjectContainer;
      
      function closeAllModal() : void;
      
      function addModalWindow(param1:DisplayObject, param2:uint = 0, param3:String = null) : void;
      
      function removeModalWindow(param1:DisplayObject) : void;
   }
}
