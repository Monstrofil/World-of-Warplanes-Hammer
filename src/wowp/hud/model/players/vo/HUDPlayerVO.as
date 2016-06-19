package wowp.hud.model.players.vo
{
   import wowp.utils.string.time.concatNickname;
   import wowp.utils.data.binding.Signal;
   
   public class HUDPlayerVO
   {
      
      public static const PLAYER_IS_NOT_LOADED:int = 0;
      
      public static const PLAYER_IS_LOADED:int = 1;
      
      public static const PLAYER_IS_CLIENT:int = 2;
      
      public static const PLAYER_ID:String = "ID";
      
      public static const TEAM_ID:String = "teamID";
      
      public static const PLAYER_NAME:String = "playerName";
      
      public static const LIVES:String = "lives";
      
      public static const FRAGS:String = "frags";
      
      public static const FRAGS_TEAM_OBJECT:String = "fragsTeamObject";
      
      public static const SPEAKER:String = "speaker";
      
      public static const PLANE_ICON_PATH:String = "planeIconPath";
      
      public static const PLANE_TYPE_ICON_PATH:String = "planeTypeIconPath";
      
      public static const IS_DEAD:String = "isDead";
      
      public static const STATE:String = "state";
      
      public static const PLANE_NAME:String = "planeName";
      
      public static const PLANE_TYPE:String = "planeType";
      
      public static const PLANE_LEVEL:String = "planeLevel";
      
      public static const SQUAD_NUMBER:String = "squadNumber";
      
      public static const SQUAD_TYPE:String = "squadType";
      
      public static const PLANE_NUMBER:String = "planeNumber";
      
      public static const ASSISTS_NUMBER:String = "assists";
      
      public static const ASSISTS_GROUND_NUMBER:String = "assistsGround";
      
      public static const IS_TEAM_KILLER:String = "isTeamKiller";
      
      public static const IS_MUTED:String = "isMuted";
      
      public static const CHAT_LIST:String = "chatList";
      
      public static const IS_BOT:String = "isBot";
      
      public static const IS_LEADER_PLANE:String = "isLeaderPlane";
      
      public static const IS_LEADER_GROUND:String = "isLeaderGround";
      
      public static const IS_IGR:String = "isIgr";
      
      public static const SUPERIORITY_POINTS:String = "superiorityPoints";
       
      public const onPlayerChanged:Signal = new Signal();
      
      public const onSpeakerChanged:Signal = new Signal();
      
      public const onFragsChanged:Signal = new Signal();
      
      public const onHealthChanged:Signal = new Signal();
      
      public const onLeaderChanged:Signal = new Signal();
      
      public var ID:int;
      
      public var teamID:int;
      
      public var playerName:String;
      
      public var lives:int;
      
      public var frags:int;
      
      public var fragsTeamObject:int;
      
      public var speaker:int;
      
      public var isSpeaking:Boolean;
      
      public var isMuted:Boolean;
      
      public var planeIconPath:String;
      
      public var planeTypeIconPath:String;
      
      public var isDead:Boolean;
      
      public var state:int;
      
      public var planeName:String;
      
      public var planeType:int;
      
      public var planeLevel:int;
      
      public var squadNumber:int;
      
      public var squadType:int;
      
      public var planeNumber:int;
      
      public var assistsNumber:int;
      
      public var assistsGroundNumber:int;
      
      public var isTeamKiller:Boolean = false;
      
      public var chatList:int = 0;
      
      public var isBot:Boolean;
      
      public var isLeaderPlane:Boolean;
      
      public var isLeaderGround:Boolean;
      
      public var maxHealth:int = 100;
      
      public var health:int = 100;
      
      public var isIgr:Boolean = false;
      
      public var superiorityPoints:int = 0;
      
      public function HUDPlayerVO()
      {
         super();
      }
      
      public static function create(param1:Object) : HUDPlayerVO
      {
         var _loc2_:HUDPlayerVO = null;
         if(param1.hasOwnProperty(PLAYER_ID))
         {
            _loc2_ = new HUDPlayerVO();
            param1.playerName = concatNickname(param1.playerName,param1.playerClanAbbrev);
            _loc2_.setFields(param1);
            return _loc2_;
         }
         return null;
      }
      
      public function toString() : String
      {
         return PLAYER_ID + ": " + this[PLAYER_ID] + ", " + TEAM_ID + ": " + this[TEAM_ID] + ", " + PLAYER_NAME + ": " + this[PLAYER_NAME] + ", " + LIVES + ": " + this[LIVES] + ", " + FRAGS + ": " + this[FRAGS] + ", " + FRAGS_TEAM_OBJECT + ": " + this[FRAGS_TEAM_OBJECT] + ", " + SPEAKER + ": " + this[SPEAKER] + ", " + PLANE_ICON_PATH + ": " + this[PLANE_ICON_PATH] + ", " + IS_DEAD + ": " + this[IS_DEAD] + ", " + STATE + ": " + this[STATE] + ", " + PLANE_NAME + ": " + this[PLANE_NAME] + ", " + PLANE_TYPE + ": " + this[PLANE_TYPE] + ", " + PLANE_LEVEL + ": " + this[PLANE_LEVEL] + ", " + SQUAD_NUMBER + ": " + this[SQUAD_NUMBER] + ", " + SQUAD_TYPE + ": " + this[SQUAD_TYPE] + ", " + ASSISTS_NUMBER + ": " + this[ASSISTS_NUMBER] + ", " + ASSISTS_GROUND_NUMBER + ": " + this[ASSISTS_GROUND_NUMBER] + ", " + IS_TEAM_KILLER + ": " + this[IS_TEAM_KILLER] + ", " + IS_MUTED + ": " + this[IS_MUTED] + ", " + CHAT_LIST + ": " + this[CHAT_LIST] + ", " + IS_BOT + ": " + this[IS_BOT] + ", " + IS_LEADER_PLANE + ": " + this[IS_LEADER_PLANE] + ", " + IS_LEADER_GROUND + ": " + this[IS_LEADER_GROUND] + ", " + IS_IGR + ": " + this[IS_IGR] + ", " + PLANE_NUMBER + ": " + this[PLANE_NUMBER];
      }
      
      public function setFields(param1:Object) : Boolean
      {
         return (this.updateField(param1,PLAYER_ID) | this.updateField(param1,TEAM_ID) | this.updateField(param1,PLAYER_NAME) | this.updateField(param1,LIVES) | this.updateField(param1,FRAGS) | this.updateField(param1,FRAGS_TEAM_OBJECT) | this.updateField(param1,SPEAKER) | this.updateField(param1,PLANE_ICON_PATH) | this.updateField(param1,PLANE_TYPE_ICON_PATH) | this.updateField(param1,IS_DEAD) | this.updateField(param1,STATE) | this.updateField(param1,PLANE_NAME) | this.updateField(param1,PLANE_TYPE) | this.updateField(param1,PLANE_LEVEL) | this.updateField(param1,SQUAD_NUMBER) | this.updateField(param1,SQUAD_TYPE) | this.updateField(param1,ASSISTS_NUMBER) | this.updateField(param1,ASSISTS_GROUND_NUMBER) | this.updateField(param1,IS_TEAM_KILLER) | this.updateField(param1,IS_MUTED) | this.updateField(param1,CHAT_LIST) | this.updateField(param1,IS_BOT) | this.updateField(param1,IS_LEADER_PLANE) | this.updateField(param1,IS_LEADER_GROUND) | this.updateField(param1,IS_IGR) | this.updateField(param1,SUPERIORITY_POINTS) | this.updateField(param1,PLANE_NUMBER)) == 1;
      }
      
      private function updateField(param1:Object, param2:String) : int
      {
         if(Boolean(hasOwnProperty(param2)) && Boolean(param1.hasOwnProperty(param2)))
         {
            this[param2] = param1[param2];
            return 1;
         }
         return 0;
      }
      
      public function setPlayerChanged() : void
      {
         this.onPlayerChanged.fire();
      }
      
      public function setSpeakerChanged() : void
      {
         this.onSpeakerChanged.fire();
      }
      
      public function setFragsChanged() : void
      {
         this.onFragsChanged.fire();
      }
      
      public function setHealthChanged() : void
      {
         this.onHealthChanged.fire();
      }
      
      public function setLeaderChanged() : void
      {
         this.onLeaderChanged.fire();
      }
   }
}
