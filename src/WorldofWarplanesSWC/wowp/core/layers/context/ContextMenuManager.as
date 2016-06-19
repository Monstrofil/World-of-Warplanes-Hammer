package wowp.core.layers.context
{
   import flash.display.Sprite;
   import wowp.controls.contextMenu.ContextMenu;
   import scaleform.clik.utils.Padding;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.Event;
   import wowp.core.layers.context.events.AddContextMenuEvent;
   import wowp.core.layers.context.events.RemoveContextMenuEvent;
   import wowp.controls.contextMenu.ContextMenuEvents;
   import flash.events.MouseEvent;
   import flash.events.KeyboardEvent;
   import wowp.controls.contextMenu.items.ContextMenuButtonSubmenu;
   import flash.ui.Keyboard;
   
   public class ContextMenuManager extends Sprite implements IContextMenuManager
   {
       
      private var _contextMenu:ContextMenu;
      
      private var _itemRenderer:Class;
      
      private var _background:Class;
      
      private var _padding:Padding;
      
      private var _offset:Number;
      
      private var _openSubmenuRolloverDelay:int = -1;
      
      private var _prevFocus:InteractiveObject;
      
      private var _stage:Stage;
      
      public function ContextMenuManager()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function addedToStageHandler(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         stage.addEventListener(AddContextMenuEvent.TYPE,this.addContextMenuHandler);
         stage.addEventListener(RemoveContextMenuEvent.TYPE,this.removeContextMenuHandler);
         stage.addEventListener(ContextMenuEvents.ITEM_PRESSED,this.contextMenuItemPressedHandler);
         stage.addEventListener(Event.RESIZE,this.resizeHandler);
         this._stage = stage;
      }
      
      public function dispose() : void
      {
         this.clear();
         if(this._contextMenu)
         {
            this._contextMenu.dispose();
         }
         this._stage.removeEventListener(ContextMenuEvents.ITEM_PRESSED,this.contextMenuItemPressedHandler);
         this._stage.removeEventListener(AddContextMenuEvent.TYPE,this.addContextMenuHandler);
         this._stage.removeEventListener(RemoveContextMenuEvent.TYPE,this.removeContextMenuHandler);
         this._stage.removeEventListener(Event.RESIZE,this.resizeHandler);
         this._stage = null;
      }
      
      private function resizeHandler(param1:Event) : void
      {
         this.clear();
      }
      
      public function get itemRenderer() : Class
      {
         return this._itemRenderer;
      }
      
      public function set itemRenderer(param1:Class) : void
      {
         this._itemRenderer = param1;
      }
      
      public function get background() : Class
      {
         return this._background;
      }
      
      public function set background(param1:Class) : void
      {
         this._background = param1;
      }
      
      public function get padding() : Padding
      {
         return this._padding;
      }
      
      public function set padding(param1:Padding) : void
      {
         this._padding = param1;
      }
      
      public function get offset() : Number
      {
         return this._offset;
      }
      
      public function set offset(param1:Number) : void
      {
         this._offset = param1;
      }
      
      public function get openSubmenuRolloverDelay() : int
      {
         return this._openSubmenuRolloverDelay;
      }
      
      public function set openSubmenuRolloverDelay(param1:int) : void
      {
         this._openSubmenuRolloverDelay = param1;
      }
      
      public function clear() : void
      {
         this._stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         this._stage.focus = this._prevFocus;
         this._prevFocus = null;
         if(this._contextMenu)
         {
            if(this._contextMenu.parent)
            {
               this._contextMenu.parent.removeChild(this._contextMenu);
            }
            this._contextMenu.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyPressedHandler);
            this._contextMenu.dispose();
            this._contextMenu = null;
         }
      }
      
      private function addContextMenuHandler(param1:AddContextMenuEvent) : void
      {
         this.clear();
         this._contextMenu = new ContextMenu();
         this._contextMenu.owner = param1.owner;
         this._contextMenu.name = "menuContext";
         if(param1.background != null)
         {
            this._contextMenu.background = param1.background;
         }
         else
         {
            this._contextMenu.background = this._background;
         }
         this._contextMenu.submenuGap = param1.submenuGap;
         this._contextMenu.itemRenderer = this._itemRenderer;
         if(param1.padding != null)
         {
            this._contextMenu.menuOffset = param1.padding;
         }
         else if(this._padding)
         {
            this._contextMenu.menuOffset = this._padding;
         }
         if(!isNaN(param1.offset))
         {
            this._contextMenu.offset = param1.offset;
         }
         else if(!isNaN(this._offset))
         {
            this._contextMenu.offset = this._offset;
         }
         if(this._openSubmenuRolloverDelay > -1)
         {
            this._contextMenu.openSubmenuRolloverDelay = this._openSubmenuRolloverDelay;
         }
         addChild(this._contextMenu);
         this._prevFocus = this._stage.focus;
         this._stage.focus = this._contextMenu;
         this._stage.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler,false,-100);
         this._contextMenu.addEventListener(KeyboardEvent.KEY_DOWN,this.keyPressedHandler);
         if(!isNaN(param1.x))
         {
            this._contextMenu.x = param1.x;
         }
         else
         {
            this._contextMenu.x = this._stage.mouseX;
            if(!isNaN(param1.dx))
            {
               this._contextMenu.x = this._contextMenu.x + param1.dx;
            }
         }
         if(!isNaN(param1.y))
         {
            this._contextMenu.y = param1.y;
         }
         else
         {
            this._contextMenu.y = this._stage.mouseY;
            if(!isNaN(param1.dy))
            {
               this._contextMenu.y = this._contextMenu.y + param1.dy;
            }
         }
         this._contextMenu.dataProvider = param1.data;
         this._contextMenu.validateNow();
         if(this._contextMenu.height + this._contextMenu.y > this._stage.stageHeight)
         {
            this._contextMenu.y = this._stage.stageHeight - this._contextMenu.height;
         }
      }
      
      public function removeContextMenuHandler(param1:Event) : void
      {
         this.clear();
      }
      
      private function contextMenuItemPressedHandler(param1:ContextMenuEvents) : void
      {
         if(!(param1.item is ContextMenuButtonSubmenu))
         {
            this.clear();
         }
      }
      
      public function getCurrentContextMenu() : ContextMenu
      {
         return this._contextMenu;
      }
      
      private function mouseDownHandler(param1:Event) : void
      {
         if(Boolean(this._contextMenu) && !this._contextMenu.hitTestPoint(this._stage.mouseX,this._stage.mouseY,true))
         {
            if(!this._contextMenu.owner || Boolean(this._contextMenu.owner) && Boolean(!this._contextMenu.owner.hitTestPoint(stage.mouseX,stage.mouseY,true)))
            {
               this.clear();
               stage.dispatchEvent(new Event("removedContextMenu"));
            }
         }
      }
      
      private function keyPressedHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ESCAPE)
         {
            this.clear();
            param1.stopImmediatePropagation();
            param1.preventDefault();
         }
      }
   }
}
