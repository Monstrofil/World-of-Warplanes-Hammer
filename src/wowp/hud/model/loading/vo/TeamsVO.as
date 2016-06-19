package wowp.hud.model.loading.vo
{
   public class TeamsVO
   {
       
      public var teamA:Array;
      
      public var teamB:Array;
      
      public var playerObj:Object;
      
      public var playerName:String = "";
      
      public var isLoaded:Boolean = false;
      
      public var planeName:String = "";
      
      public var planeLevel:Number = 0;
      
      public var planeIcoPath:String = "";
      
      public var isOwner:Boolean = false;
      
      public var squadNumber:Number = 0;
      
      public var squadType:String = "";
      
      public var battleLoadingIconPath:String = "";
      
      public var typeIconPath:String = "";
      
      public var id:int;
      
      public var isIgr:Boolean = false;
      
      public function TeamsVO()
      {
         this.teamA = [];
         this.teamB = [];
         super();
      }
      
      public function teamsVO() : *
      {
      }
   }
}
