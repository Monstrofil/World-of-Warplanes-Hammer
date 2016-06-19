package wowp.hud.core.layout
{
   import flash.display.MovieClip;
   import wowp.hud.model.HUDModel;
   import wowp.core.updater.Updater;
   import wowp.hud.core.HUDViewComponent;
   import wowp.core.updater.IUpdatabale;
   
   public class HUDLayout extends MovieClip
   {
       
      protected var _model:HUDModel;
      
      private var _updater:Updater;
      
      protected var _components:Vector.<HUDViewComponent>;
      
      private var _oldWidth:Number;
      
      private var _oldHeight:Number;
      
      protected var WIDTH:int = 1024;
      
      protected var HEIGHT:int = 768;
      
      public function HUDLayout()
      {
         var _loc3_:HUDViewComponent = null;
         this._updater = new Updater();
         this._components = new Vector.<HUDViewComponent>();
         super();
         var _loc1_:int = 0;
         var _loc2_:int = numChildren;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = getChildAt(_loc1_) as HUDViewComponent;
            if(_loc3_)
            {
               this._components[this._components.length] = _loc3_;
            }
            _loc1_++;
         }
      }
      
      public final function init(param1:HUDModel) : void
      {
         this._oldWidth = this.WIDTH;
         this._oldHeight = this.HEIGHT;
         this._model = param1;
         var _loc2_:int = this._components.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._components[_loc3_].init(param1);
            if(this._components[_loc3_] is IUpdatabale)
            {
               this._updater.add(this._components[_loc3_] as IUpdatabale);
            }
            _loc3_++;
         }
         this.onInit();
         this._updater.init();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
         var _loc1_:int = this._components.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(this._components[_loc2_] is IUpdatabale)
            {
               this._updater.remove(this._components[_loc2_] as IUpdatabale);
            }
            this._components[_loc2_].dispose();
            _loc2_++;
         }
         this._updater.dispose();
      }
      
      public final function resize(param1:Number, param2:Number) : void
      {
         var _loc3_:int = this._components.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._components[_loc4_].resize(this._oldWidth,this._oldHeight,param1,param2);
            _loc4_++;
         }
         this.onResize(this._oldWidth,this._oldHeight,param1,param2);
         this._oldWidth = param1;
         this._oldHeight = param2;
      }
      
      protected function onInit() : void
      {
      }
      
      protected function onDispose() : void
      {
      }
      
      protected function onResize(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
      }
      
      public function hideAll() : void
      {
         var _loc3_:HUDViewComponent = null;
         var _loc1_:int = 0;
         var _loc2_:int = numChildren;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = getChildAt(_loc1_) as HUDViewComponent;
            if(_loc3_)
            {
               _loc3_.hide();
            }
            _loc1_++;
         }
      }
      
      public function showAll() : void
      {
         var _loc3_:HUDViewComponent = null;
         var _loc1_:int = 0;
         var _loc2_:int = numChildren;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = getChildAt(_loc1_) as HUDViewComponent;
            if(_loc3_)
            {
               _loc3_.show();
            }
            _loc1_++;
         }
      }
   }
}
