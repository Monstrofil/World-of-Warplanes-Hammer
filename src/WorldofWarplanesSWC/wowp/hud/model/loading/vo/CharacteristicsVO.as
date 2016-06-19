package wowp.hud.model.loading.vo
{
   public class CharacteristicsVO
   {
       
      public var stars:Number;
      
      public var text:String;
      
      public var value:int;
      
      public function CharacteristicsVO()
      {
         super();
      }
      
      public function toString() : String
      {
         return "[CharacteristicsVO stars=" + this.stars + " text=" + this.text + " value=" + this.value + "]";
      }
   }
}
