package wowp.hud.model.radar
{
   import wowp.hud.core.HUDModelComponent;
   
   public class HUDRadarModel extends HUDModelComponent
   {
       
      protected const RADAR_TOP_PADDING:int = 22;
      
      protected const RADAR_RIGHT_PADDINGS:Array = [0,40,150,150,205,330];
      
      protected var _radarWidth:int;
      
      protected var _radarHeight:int;
      
      protected var _radarX:int;
      
      protected var _radarY:int;
      
      public function HUDRadarModel()
      {
         super();
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.radarSize",this.responseRadarSize);
      }
      
      public function setRadarPosition(param1:int, param2:int, param3:int) : void
      {
         if(param1 < 0)
         {
            this._radarX = 0;
         }
         if(param2 < 0)
         {
            this._radarY = 0;
         }
         if(param3 == 5)
         {
            this._radarX = param1 - this._radarWidth - 20;
         }
         else
         {
            this._radarX = param1 - this._radarWidth + this.RADAR_RIGHT_PADDINGS[param3];
         }
         this._radarY = param2 + this.RADAR_TOP_PADDING;
         this.invalidateRadarPosition();
      }
      
      protected function requestRadarSize() : void
      {
      }
      
      protected function responseRadarSize(param1:int, param2:int) : void
      {
         this._radarWidth = param1;
         this._radarHeight = param2;
      }
      
      protected function invalidateRadarPosition() : void
      {
         backend.callAsync("ui.ChangeRadarPosition",this._radarX,this._radarY);
      }
      
      override protected function onDispose() : void
      {
         backend.addCallback("hud.radarSize",null);
      }
   }
}
