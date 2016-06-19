package wowp.hud.model.map
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   
   public class HUDMapModel extends HUDModelComponent
   {
       
      public var onMapInfoChanged:Signal;
      
      public var onMapHeightChanged:Signal;
      
      public var battleType:int;
      
      public var battleName:String;
      
      public var mapName:String;
      
      public var teamTask:String = "";
      
      public var playerTask:String = "";
      
      public var height:int = 0;
      
      public var isBeginner:Boolean = false;
      
      public function HUDMapModel()
      {
         this.onMapInfoChanged = new Signal();
         this.onMapHeightChanged = new Signal();
         super();
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.setMapInfo",this.setMapInfo);
         backend.addCallback("hud.setMapHeight",this.setMapHeight);
      }
      
      private function setMapInfo(param1:int, param2:String, param3:String, param4:String, param5:String, param6:Boolean = false) : void
      {
         trace("HUDMapModel::setMapInfo::battleType::" + param1 + ", battleName::" + param2 + ", mapName::" + param3 + ", teamTask::" + param4 + ", playerTask::" + param5 + ", isBeginner::" + param6);
         this.battleName = param2;
         this.battleType = param1;
         this.mapName = param3;
         this.teamTask = param4;
         this.playerTask = param5;
         this.isBeginner = param6;
         this.onMapInfoChanged.fire();
      }
      
      private function setMapHeight(param1:int) : void
      {
         this.height = param1;
         this.onMapHeightChanged.fire();
      }
   }
}
