package wowp.hud.model.weapons
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import wowp.hud.model.weapons.vo.HUDWeaponCellVO;
   
   public class HudWeaponsModel extends HUDModelComponent
   {
       
      public var onRefill:Signal;
      
      public var onRekey:Signal;
      
      public var onBombingAvailable:Signal;
      
      public var onGunRestartTimeUpdate:Signal;
      
      public var isBombingAvailable:Boolean = true;
      
      public var gunTemperatureState:Number = 1;
      
      public var cells:Object;
      
      public function HudWeaponsModel()
      {
         this.onRefill = new Signal();
         this.onRekey = new Signal();
         this.onBombingAvailable = new Signal();
         this.onGunRestartTimeUpdate = new Signal();
         this.cells = {};
         super();
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.weaponUpdate",this.update);
         backend.addCallback("hud.weaponInit",this.parse);
         backend.addCallback("hud.weaponReInit",this.setKey);
         backend.addCallback("hud.isCorrectBombingAngle",this.isCorrectBombingAngleUpdated);
         backend.addCallback("hud.gunRestartTimeUpdate",this.gunRestartTimeUpdate);
      }
      
      public function parse(param1:Array) : void
      {
         var _loc4_:HUDWeaponCellVO = null;
         this.cells = {};
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new HUDWeaponCellVO();
            _loc4_.setData(param1[_loc3_]);
            this.cells[_loc4_.id] = _loc4_;
            _loc3_++;
         }
         this.onRefill.fire();
      }
      
      public function setKey(param1:Array) : void
      {
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.cells[param1[_loc3_].id].key = param1[_loc3_].key;
            _loc3_++;
         }
         this.onRekey.fire();
      }
      
      private function update(param1:String, param2:int) : void
      {
         var _loc3_:HUDWeaponCellVO = this.cells[param1] as HUDWeaponCellVO;
         if(_loc3_ != null)
         {
            _loc3_.quantity = param2;
         }
      }
      
      private function isCorrectBombingAngleUpdated(param1:Boolean) : void
      {
         trace("HudWeaponsModel::isCorrectBombingAngleUpdated:",param1);
         if(this.isBombingAvailable != param1)
         {
            this.isBombingAvailable = param1;
            this.onBombingAvailable.fire();
         }
      }
      
      private function gunRestartTimeUpdate(param1:String, param2:int) : void
      {
         trace("HudWeaponsModel::gunRestartTimeUpdate: id",param1,"restartTime",param2);
         var _loc3_:HUDWeaponCellVO = this.cells[param1] as HUDWeaponCellVO;
         if(_loc3_ != null)
         {
            _loc3_.restartTime = param2;
            this.onGunRestartTimeUpdate.fire(param1);
         }
      }
   }
}
