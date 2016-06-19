package wowp.hud.common.infoEntities
{
   import flash.display.MovieClip;
   
   public class MarkerPart extends MovieClip
   {
       
      public var mcType1:MovieClip;
      
      public var mcType2:MovieClip;
      
      public var mcType3:MovieClip;
      
      public var mcType4:MovieClip;
      
      private var _type:int;
      
      private var _parts:Array;
      
      private var _partsLength:int;
      
      private var _isAlternativeColor:Boolean = false;
      
      public function MarkerPart()
      {
         super();
         this._parts = [this.mcType1,this.mcType2,this.mcType3,this.mcType4];
         this._partsLength = this._parts.length;
         this.setType(1);
      }
      
      public function resetEntity(param1:Boolean) : void
      {
         visible = false;
      }
      
      public function setType(param1:int) : void
      {
         this._type = param1 - 1;
         var _loc2_:int = 0;
         while(_loc2_ < this._partsLength)
         {
            if(_loc2_ == this._type)
            {
               this._parts[_loc2_].visible = true;
            }
            else
            {
               this._parts[_loc2_].visible = false;
            }
            _loc2_++;
         }
      }
      
      public function setPartDamaged(param1:Boolean) : void
      {
         this._parts[this._type].play();
      }
      
      public function setAlternativeColor(param1:Boolean) : void
      {
         this._isAlternativeColor = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this._partsLength)
         {
            this._parts[_loc2_].color.gotoAndStop(!!this._isAlternativeColor?2:1);
            _loc2_++;
         }
      }
   }
}
