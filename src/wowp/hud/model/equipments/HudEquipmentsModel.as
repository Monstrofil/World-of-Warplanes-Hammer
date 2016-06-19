package wowp.hud.model.equipments
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   
   public class HudEquipmentsModel extends HUDModelComponent
   {
       
      public var onRefill:Signal;
      
      public var onStateChanged:Signal;
      
      public var onKeyNameChanged:Signal;
      
      public var onChargesCountChanged:Signal;
      
      public var onCoolDownTillChanged:Signal;
      
      public var onActiveTillChanged:Signal;
      
      public var onUseSlot:Signal;
      
      public var cells:Array;
      
      public var useSlotID:int;
      
      public function HudEquipmentsModel()
      {
         this.onRefill = new Signal();
         this.onStateChanged = new Signal();
         this.onKeyNameChanged = new Signal();
         this.onChargesCountChanged = new Signal();
         this.onCoolDownTillChanged = new Signal();
         this.onActiveTillChanged = new Signal();
         this.onUseSlot = new Signal();
         this.cells = [];
         super();
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.initEquipment",this.parse);
         backend.addCallback("hud.updateEquipment",this.change);
         backend.addCallback("hud.useEquipment",this.useEquipment);
      }
      
      private function parse(param1:Array) : void
      {
         this.cells = [];
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.cells[_loc3_] = param1[_loc3_];
            _loc3_++;
         }
         this.onRefill.fire();
      }
      
      private function change(param1:Array) : void
      {
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1[_loc3_].isEmpty != undefined)
            {
               this.cells[_loc3_].isEmpty = param1[_loc3_].isEmpty;
               this.onStateChanged.fire();
            }
            if(param1[_loc3_].keyName != undefined)
            {
               this.cells[_loc3_].keyName = param1[_loc3_].keyName;
               this.onKeyNameChanged.fire();
            }
            if(param1[_loc3_].chargesCount != undefined)
            {
               this.cells[_loc3_].chargesCount = param1[_loc3_].chargesCount;
               this.onChargesCountChanged.fire();
            }
            if(param1[_loc3_].coolDownTill != undefined)
            {
               this.cells[_loc3_].coolDownTill = param1[_loc3_].coolDownTill;
               this.onCoolDownTillChanged.fire();
            }
            if(param1[_loc3_].activeTill != undefined)
            {
               this.cells[_loc3_].activeTill = param1[_loc3_].activeTill;
               this.onActiveTillChanged.fire();
            }
            _loc3_++;
         }
      }
      
      private function useEquipment(param1:int) : void
      {
         this.useSlotID = param1;
         this.onUseSlot.fire();
      }
      
      public function onUseEquipment(param1:int) : void
      {
         backend.call("hud.onUseEquipment",param1);
      }
   }
}
