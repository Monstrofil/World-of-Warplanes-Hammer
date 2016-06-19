package wowp.controls.contextMenu
{
   import scaleform.clik.core.UIComponent;
   import flash.display.Sprite;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.utils.Padding;
   import wowp.controls.contextMenu.items.ContextMenuElement;
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   import flash.events.Event;
   import flash.utils.clearTimeout;
   import scaleform.clik.constants.InvalidationType;
   import wowp.controls.contextMenu.items.ContextMenuButtonSubmenu;
   import flash.geom.Point;
   import wowp.controls.contextMenu.items.ContextMenuButton;
   import scaleform.clik.controls.Button;
   import wowp.controls.contextMenu.items.ContextMenuSeparator;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.MouseEvent;
   import flash.display.InteractiveObject;
   import flash.display.DisplayObjectContainer;
   import flash.utils.setTimeout;
   import wowp.core.eventPipe.EventPipe;
   
   public class ContextMenu extends UIComponent
   {
      
      private static const INVALIDATION_TREE:String = "INVALIDATION_TREE";
      
      private static const DEFAULT_OFFSET:Number = 0;
       
      public var owner:Sprite;
      
      protected var _dataProvider:IDataProvider;
      
      protected var _itemRenderer:Class;
      
      protected var _background:Class;
      
      public var menuOffset:Padding;
      
      public var offset:Number;
      
      private var _tree:Vector.<Array>;
      
      private var _chain:Vector.<ContextMenuElement>;
      
      private var _root:DisplayObject;
      
      private var _subMenus:Dictionary;
      
      private var _renderers:Dictionary;
      
      public var openSubmenuRolloverDelay:int = 500;
      
      private var _openSubmenuRolloverDelayTimeout:uint;
      
      public var submenuGap:int = 4;
      
      public var bottomMargin:int = 10;
      
      private var _map:Dictionary;
      
      public function ContextMenu()
      {
         this._map = new Dictionary(true);
         super();
         this.menuOffset = new Padding(DEFAULT_OFFSET);
         this.offset = DEFAULT_OFFSET;
      }
      
      public function get dataProvider() : IDataProvider
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         if(this._dataProvider == param1)
         {
            return;
         }
         if(this._dataProvider != null)
         {
            this._dataProvider.removeEventListener(Event.CHANGE,this.handleDataChange,false);
         }
         this._dataProvider = param1;
         if(this._dataProvider == null)
         {
            return;
         }
         this._dataProvider.addEventListener(Event.CHANGE,this.handleDataChange,false,0,true);
         invalidateData();
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
      
      public function dispose() : void
      {
         if(this._dataProvider != null)
         {
            this._dataProvider.removeEventListener(Event.CHANGE,this.handleDataChange,false);
         }
         clearTimeout(this._openSubmenuRolloverDelayTimeout);
      }
      
      override protected function configUI() : void
      {
         this._tree = new Vector.<Array>();
         this._chain = new Vector.<ContextMenuElement>();
         this._subMenus = new Dictionary(true);
         this._renderers = new Dictionary(true);
         invalidate(INVALIDATION_TREE);
      }
      
      protected function handleDataChange(param1:Event) : void
      {
         invalidate(InvalidationType.DATA);
      }
      
      override protected function draw() : void
      {
         if(stage == null)
         {
            return;
         }
         if(isInvalid(INVALIDATION_TREE))
         {
            this.validateTree();
            this.drawMenu();
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.drawMenu();
         }
      }
      
      protected function validateTree() : void
      {
         var _loc3_:ContextMenuElement = null;
         this._tree.length = 0;
         this._tree[this._tree.length] = this._dataProvider as Array;
         var _loc1_:int = 0;
         var _loc2_:int = this._chain.length;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this._chain[_loc1_];
            if(_loc3_ is ContextMenuButtonSubmenu)
            {
               this._tree[this._tree.length] = (_loc3_ as ContextMenuButtonSubmenu).subElements;
               _loc1_++;
            }
         }
      }
      
      protected function drawMenu() : void
      {
         var _loc5_:DisplayObject = null;
         var _loc6_:Point = null;
         var _loc7_:Number = NaN;
         var _loc8_:DisplayObject = null;
         var _loc9_:Number = NaN;
         var _loc1_:int = 1;
         var _loc2_:int = 0;
         var _loc3_:int = this._tree.length;
         var _loc4_:Number = 0;
         while(_loc2_ < _loc3_)
         {
            if(_loc2_ == 0)
            {
               _loc5_ = this._root;
            }
            else
            {
               _loc5_ = this._subMenus[this._chain[_loc2_ - 1]] as DisplayObject;
            }
            if(_loc5_ == null)
            {
               _loc5_ = this.createMenu(this._tree[_loc2_]);
               addChild(_loc5_);
            }
            if(_loc2_ > 0)
            {
               _loc4_ = _loc4_ + this.getWidth(_loc5_) * _loc1_;
            }
            _loc5_.x = _loc4_;
            _loc6_ = new Point(_loc5_.x + this.getWidth(_loc5_));
            if(_loc1_ == 1 && localToGlobal(_loc6_).x > stage.stageWidth)
            {
               if(_loc2_ == 0)
               {
                  _loc5_.x = globalToLocal(new Point(stage.stageWidth)).x - _loc5_.width;
                  _loc4_ = _loc5_.x;
               }
               else
               {
                  _loc4_ = _loc4_ - this.getWidth(_loc5_) * _loc1_;
                  _loc4_ = _loc4_ - this.getWidth(this.getParent(_loc2_)) * _loc1_;
                  _loc5_.x = _loc4_;
                  _loc1_ = _loc1_ * -1;
               }
            }
            _loc6_.x = _loc5_.x;
            if(_loc1_ == -1 && localToGlobal(_loc6_).x < 0)
            {
               if(_loc2_ == 0)
               {
                  _loc5_.x = globalToLocal(new Point()).x;
                  _loc4_ = _loc5_.x;
               }
               else
               {
                  _loc4_ = _loc4_ - this.getWidth(this.getParent(_loc2_)) * _loc1_;
                  _loc4_ = _loc4_ - this.getWidth(_loc5_) * _loc1_;
                  _loc5_.x = _loc4_;
                  _loc1_ = _loc1_ * -1;
               }
            }
            if(_loc2_ == 0)
            {
               this._root = _loc5_;
            }
            else
            {
               _loc8_ = this._renderers[this._chain[_loc2_ - 1]] as DisplayObject;
               _loc9_ = _loc8_.y + _loc8_.parent.y;
               _loc5_.y = _loc9_ - this.menuOffset.top;
               this._subMenus[this._chain[_loc2_ - 1]] = _loc5_;
            }
            _loc6_.y = _loc5_.y + _loc5_.height;
            _loc7_ = localToGlobal(_loc6_).y;
            if(_loc7_ > stage.stageHeight - this.bottomMargin)
            {
               _loc5_.y = _loc5_.y - (_loc7_ - stage.stageHeight + this.bottomMargin);
            }
            _loc5_.x = int(_loc5_.x);
            _loc5_.y = int(_loc5_.y);
            _loc2_++;
         }
      }
      
      private function getParent(param1:int) : DisplayObject
      {
         var _loc2_:DisplayObject = this._subMenus[this._chain[param1 - 1]] as DisplayObject;
         if(_loc2_ == null)
         {
            return this._root;
         }
         return _loc2_;
      }
      
      private function getWidth(param1:DisplayObject) : Number
      {
         return param1.width - this.menuOffset.horizontal + this.submenuGap;
      }
      
      protected function createMenu(param1:Array) : DisplayObject
      {
         var _loc7_:ContextMenuElement = null;
         var _loc8_:DisplayObject = null;
         var _loc9_:ContextMenuButton = null;
         var _loc10_:Button = null;
         var _loc11_:Button = null;
         var _loc12_:DisplayObject = null;
         var _loc2_:Sprite = new Sprite();
         _loc2_.name = "menuList";
         var _loc3_:Number = this.menuOffset.top;
         var _loc4_:Number = 0;
         var _loc5_:int = 0;
         var _loc6_:int = param1.length;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = param1[_loc5_] as ContextMenuElement;
            if(_loc7_)
            {
               if(_loc7_ is ContextMenuSeparator && _loc7_.customItemRenderer == null)
               {
                  _loc3_ = _loc3_ + (_loc7_ as ContextMenuSeparator).offset;
               }
               else
               {
                  if(_loc7_.customItemRenderer)
                  {
                     _loc8_ = new _loc7_.customItemRenderer();
                  }
                  else
                  {
                     _loc8_ = new this._itemRenderer() as DisplayObject;
                  }
                  if(_loc8_ is IListItemRenderer)
                  {
                     (_loc8_ as IListItemRenderer).setListData(new ListData(_loc5_,_loc7_.customItemData != null?_loc7_.customItemData.label:null));
                     (_loc8_ as IListItemRenderer).setData(_loc7_.customItemData);
                  }
                  if(_loc8_ is Button && Boolean(_loc7_.customItemData))
                  {
                     (_loc8_ as Button).data = _loc7_.customItemData;
                     (_loc8_ as Button).preventAutosizing = true;
                  }
                  if(_loc7_ is ContextMenuButton)
                  {
                     _loc9_ = _loc7_ as ContextMenuButton;
                     _loc10_ = _loc8_ as Button;
                     if(_loc10_)
                     {
                        _loc10_.label = _loc9_.label;
                        _loc10_.name = _loc9_.id;
                     }
                  }
                  if(_loc8_ is UIComponent)
                  {
                     (_loc8_ as UIComponent).validateNow();
                  }
                  _loc2_.addChild(_loc8_);
                  _loc8_.x = this.menuOffset.left;
                  if(_loc4_ < _loc8_.width)
                  {
                     _loc4_ = _loc8_.width;
                  }
                  if(_loc8_ is Button)
                  {
                     _loc11_ = _loc8_ as Button;
                     this._map[_loc11_] = _loc7_;
                     _loc11_.addEventListener(ButtonEvent.CLICK,this.buttonClickHandler);
                     _loc11_.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
                     _loc11_.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
                  }
                  if(_loc8_ is InteractiveObject)
                  {
                     (_loc8_ as InteractiveObject).focusRect = null;
                  }
                  if(_loc3_ != this.menuOffset.top)
                  {
                     _loc3_ = _loc3_ + this.offset;
                  }
                  _loc8_.y = _loc3_;
                  _loc3_ = _loc3_ + _loc8_.height;
               }
               this._renderers[_loc7_] = _loc8_;
            }
            _loc5_++;
         }
         if(this._background)
         {
            _loc12_ = new this._background() as DisplayObject;
            _loc12_.width = _loc2_.width + this.menuOffset.horizontal;
            _loc12_.height = _loc2_.height + this.menuOffset.vertical;
            _loc2_.addChildAt(_loc12_,0);
         }
         return _loc2_;
      }
      
      public function chainPush(param1:ContextMenuElement) : void
      {
         var _loc2_:Boolean = false;
         if(this._chain.length > 0 && param1 == this._chain[this._chain.length - 1])
         {
            return;
         }
         var _loc3_:int = this._tree.length;
         while(--_loc3_ >= 0)
         {
            if(this._tree[_loc3_].indexOf(param1) != -1)
            {
               while(this._chain.length > _loc3_)
               {
                  _loc2_ = true;
                  this.removeSubmenu(this._chain.pop());
               }
               if(param1 is ContextMenuButtonSubmenu)
               {
                  _loc2_ = true;
                  this._chain[this._chain.length] = param1;
               }
               break;
            }
         }
         if(_loc2_)
         {
            invalidate(INVALIDATION_TREE);
         }
      }
      
      private function removeSubmenu(param1:ContextMenuElement) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc2_:DisplayObject = this._subMenus[param1];
         this._subMenus[param1] = null;
         delete this._subMenus[param1];
         if(_loc2_)
         {
            _loc3_ = _loc2_ as DisplayObjectContainer;
            if(_loc3_)
            {
               this.destroySubmenu(_loc3_);
            }
            removeChild(_loc2_);
         }
      }
      
      private function destroySubmenu(param1:DisplayObjectContainer) : void
      {
         var _loc2_:DisplayObject = null;
         while(param1.numChildren > 0)
         {
            _loc2_ = param1.removeChildAt(0);
            _loc2_.removeEventListener(ButtonEvent.CLICK,this.buttonClickHandler);
            _loc2_.removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
            _loc2_.removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
         }
      }
      
      private function mouseOverHandler(param1:MouseEvent) : void
      {
         var _loc3_:ContextMenuButton = null;
         var _loc4_:ContextMenuEvents = null;
         var _loc2_:Button = param1.target as Button;
         if(_loc2_)
         {
            _loc3_ = this._map[_loc2_] as ContextMenuButton;
            if(_loc3_)
            {
               if(_loc3_ is ContextMenuButtonSubmenu && this._chain.indexOf(_loc3_) == -1)
               {
                  clearTimeout(this._openSubmenuRolloverDelayTimeout);
                  if(this.openSubmenuRolloverDelay != 0)
                  {
                     this._openSubmenuRolloverDelayTimeout = setTimeout(this.chainPush,this.openSubmenuRolloverDelay,_loc3_);
                  }
               }
               else
               {
                  this.chainPush(_loc3_);
               }
               _loc4_ = new ContextMenuEvents(ContextMenuEvents.ITEM_OVER);
               _loc4_.item = _loc3_;
               dispatchEvent(_loc4_);
            }
         }
      }
      
      private function mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc3_:ContextMenuButton = null;
         var _loc4_:ContextMenuEvents = null;
         var _loc2_:Button = param1.target as Button;
         if(_loc2_)
         {
            _loc3_ = this._map[_loc2_] as ContextMenuButton;
            if(_loc3_)
            {
               clearTimeout(this._openSubmenuRolloverDelayTimeout);
               this.chainPush(_loc3_);
               _loc4_ = new ContextMenuEvents(ContextMenuEvents.ITEM_OUT);
               _loc4_.item = _loc3_;
               dispatchEvent(_loc4_);
            }
         }
      }
      
      private function buttonClickHandler(param1:ButtonEvent) : void
      {
         var _loc3_:ContextMenuButton = null;
         var _loc4_:ContextMenuEvents = null;
         var _loc2_:Button = param1.target as Button;
         if(_loc2_)
         {
            _loc3_ = this._map[_loc2_] as ContextMenuButton;
            if(_loc3_)
            {
               _loc4_ = new ContextMenuEvents(ContextMenuEvents.ITEM_PRESSED);
               _loc4_.item = _loc3_;
               new EventPipe().dispatchEvent(_loc4_);
               clearTimeout(this._openSubmenuRolloverDelayTimeout);
               this.chainPush(_loc3_);
            }
         }
      }
   }
}
