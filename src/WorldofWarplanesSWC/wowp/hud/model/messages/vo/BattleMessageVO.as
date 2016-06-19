package wowp.hud.model.messages.vo
{
   import wowp.utils.string.time.concatNickname;
   
   public class BattleMessageVO
   {
      
      public static const SQUAD_TYPE_WO:int = 0;
      
      public static const SQUAD_TYPE_OTHER:int = 1;
      
      public static const SQUAD_TYPE_ALLY:int = 2;
      
      public static const PLANE_TYPE_FIGHTER:int = 1;
      
      public static const PLANE_TYPE_HFIGHTER:int = 2;
      
      public static const PLANE_TYPE_ASSAULT:int = 3;
      
      public static const PLANE_TYPE_NAVY:int = 4;
      
      public static const TURRET:int = 3;
      
      public static const DAMAGE_TYPE_OTHER:int = 1;
      
      public static const DAMAGE_TYPE_MIKHALICH:int = 2;
       
      public var playerID:int;
      
      public var killerID:int;
      
      public var victimID:int;
      
      public var playerTeamIndex:int;
      
      public var killerTeamIndex:int;
      
      public var victimTeamIndex:int;
      
      public var killerSquadType:int;
      
      public var victimSquadType:int;
      
      public var killerType:int;
      
      public var victimType:int;
      
      public var playerType:int;
      
      public var killerName:String;
      
      public var victimName:String;
      
      public var playerName:String;
      
      public var killerPlaneName:String;
      
      public var victimPlaneName:String;
      
      public var playerPlaneName:String;
      
      public var killerIsAvatar:Boolean;
      
      public var assists:Array;
      
      public var lastDamageType:int;
      
      public function BattleMessageVO(param1:Object)
      {
         super();
         this.playerID = param1.playerID;
         this.killerID = param1.killerID;
         this.victimID = param1.victimID;
         this.playerTeamIndex = param1.playerTeamIndex;
         this.killerTeamIndex = param1.killerTeamIndex;
         this.victimTeamIndex = param1.victimTeamIndex;
         this.killerSquadType = param1.killerSquadType;
         this.victimSquadType = param1.victimSquadType;
         this.killerType = param1.killerType;
         this.victimType = param1.victimType;
         this.playerType = param1.playerType;
         this.killerName = concatNickname(param1.killerName,param1.killerClanAbbrev);
         this.victimName = concatNickname(param1.victimName,param1.victimClanAbbrev);
         this.playerName = concatNickname(param1.playerName,param1.playerClanAbbrev);
         this.killerPlaneName = param1.killerPlaneName;
         this.victimPlaneName = param1.victimPlaneName;
         this.playerPlaneName = param1.playerPlaneName;
         this.killerIsAvatar = param1.killerIsAvatar;
         this.assists = param1.assists;
         this.lastDamageType = param1.lastDamageType;
         trace("playerID:",this.playerID,", killerID:",this.killerID,", victimID:",this.victimID,", playerTeamIndex:",this.playerTeamIndex,", killerTeamIndex:",this.killerTeamIndex,", victimTeamIndex:",this.victimTeamIndex,", killerType:",this.killerType,", victimType:",this.victimType,", killerName:",this.killerName,", victimName:",this.victimName,", playerType:",this.playerType,", playerName:",this.playerName,", killerIsAvatar:",this.killerIsAvatar,", lastDamageType:",this.lastDamageType,", killerPlaneName:",this.killerPlaneName,", victimPlaneName:",this.victimPlaneName,", playerPlaneName:",this.playerPlaneName,", assists:",this.assists);
      }
   }
}
