package wowp.hud.core
{
   import flash.display.MovieClip;
   import wowp.hud.model.HUDModel;
   
   public class HUDViewComponent extends MovieClip
   {
       
      protected var _model:HUDModel;
      
      public var verticalAlign:String = "none";
      
      public var horizontalAlign:String = "none";
      
      private var _initialX:Number;
      
      private var _initialY:Number;
      
      public function HUDViewComponent()
      {
         super();
         this._initialX = x;
         this._initialY = y;
         stop();
      }
      
      public final function init(param1:HUDModel) : void
      {
         x = this._initialX;
         y = this._initialY;
         this._model = param1;
         trace("HUD: init view component:",this);
         this.onInit();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
         this._model = null;
      }
      
      public final function resize(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         switch(this.verticalAlign)
         {
            case "center":
               _loc6_ = (param4 - param2) / 2;
               break;
            case "bottom":
               _loc6_ = param4 - param2;
         }
         switch(this.horizontalAlign)
         {
            case "center":
               _loc5_ = (param3 - param1) / 2;
               break;
            case "right":
               _loc5_ = param3 - param1;
         }
         x = x + _loc5_;
         y = y + _loc6_;
         this.onResize(param1,param2,param3,param4);
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
      
      public function show() : void
      {
         visible = true;
      }
      
      public function hide() : void
      {
         visible = false;
      }
   }
}
