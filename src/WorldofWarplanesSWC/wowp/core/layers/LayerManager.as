package wowp.core.layers
{
   import flash.display.DisplayObjectContainer;
   import wowp.core.layers.tip.TipsManager;
   import wowp.core.layers.context.ContextMenuManager;
   import wowp.core.layers.windows.WindowsManager;
   import wowp.core.layers.context.IContextMenuManager;
   import wowp.core.layers.windows.IWindowsManager;
   
   public class LayerManager
   {
       
      private var _container:DisplayObjectContainer;
      
      private var _tips:TipsManager;
      
      private var _context:ContextMenuManager;
      
      private var _windowsManager:WindowsManager;
      
      public function LayerManager(param1:DisplayObjectContainer)
      {
         super();
         this._container = param1;
         this._container.mouseEnabled = false;
         this._windowsManager = new WindowsManager();
         this._windowsManager.name = "windowsManager";
         param1.addChild(this._windowsManager);
         this._context = new ContextMenuManager();
         this._context.name = "contextMenuManager";
         param1.addChild(this._context);
         this._tips = new TipsManager(param1.stage);
      }
      
      public function dispose() : void
      {
         this._container.removeChild(this._windowsManager);
         this._context.dispose();
         this._container.removeChild(this._context);
         this._tips.dispose();
         this._container = null;
      }
      
      public function get contextMenuManager() : IContextMenuManager
      {
         return this._context;
      }
      
      public function get windowsManager() : IWindowsManager
      {
         return this._windowsManager;
      }
   }
}
