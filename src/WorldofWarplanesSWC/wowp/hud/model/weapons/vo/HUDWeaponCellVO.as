package wowp.hud.model.weapons.vo
{
   public class HUDWeaponCellVO
   {
      
      public static const WEAPON_TYPE_GUN:int = 0;
      
      public static const WEAPON_TYPE_ROCKET:int = 1;
      
      public static const WEAPON_TYPE_BOMB:int = 2;
      
      public static const WEAPON_TYPE_CANNON:int = 3;
       
      public var id:String;
      
      public var warningQuantity:int;
      
      public var quantity:int;
      
      public var key:String;
      
      public var iconPath:String;
      
      public var iconEmptyPath:String;
      
      public var caliber:String;
      
      public var type:String = "empty";
      
      public var weaponType:int;
      
      public var maxQuantity:int;
      
      public var restartTime:int;
      
      public function HUDWeaponCellVO()
      {
         super();
      }
      
      public function setData(param1:Object) : void
      {
         this.id = param1.id;
         this.warningQuantity = param1.warningQuantity;
         this.quantity = param1.quantity;
         this.key = param1.key;
         this.iconPath = param1.iconPath;
         this.caliber = param1.caliber;
         this.iconEmptyPath = param1.iconEmptyPath;
         if(param1.hasOwnProperty("ammoBeltType"))
         {
            this.type = param1.ammoBeltType;
         }
         this.maxQuantity = this.quantity;
         if(this.maxQuantity == 0)
         {
            this.maxQuantity = 1;
         }
         this.weaponType = param1.weaponType;
         trace("HUDWeaponCellVO:: id:",this.id,"warningQuantity:",this.warningQuantity,"quantity:",this.quantity,"maxQuantity:",this.maxQuantity,"key:",this.key,"iconPath:",this.iconPath,"iconEmptyPath:",this.iconEmptyPath,"caliber:",this.caliber,"type:",this.type,"weaponType:",this.weaponType);
      }
   }
}
