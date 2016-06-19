package wowp.hud.model.loading
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import wowp.hud.model.loading.vo.TeamsVO;
   import wowp.hud.model.loading.vo.VehicleCompareVO;
   import wowp.hud.model.loading.vo.PlayerInfoVO;
   import wowp.newsTicker.vo.NewsTickerVO;
   import flash.external.ExternalInterface;
   import wowp.utils.string.time.concatNickname;
   import wowp.hud.model.loading.vo.HintVO;
   import wowp.hud.model.loading.vo.CharacteristicsVO;
   
   public class HUDLoadingModel extends HUDModelComponent
   {
      
      public static const ARENA_TYPE_TUTORIAL:int = 5;
       
      public var onInitTeams:Signal;
      
      public var onSetBattleType:Signal;
      
      public var onSetBattleMap:Signal;
      
      public var onUpdateProgressBar:Signal;
      
      public var onUpdateTeamA:Signal;
      
      public var onUpdateTeamB:Signal;
      
      public var onUpdateHelpText:Signal;
      
      public var onLoadingScreenHide:Signal;
      
      public var onComparingVehicle:Signal;
      
      public var onHintData:Signal;
      
      public var onPlayerInfoData:Signal;
      
      public var onArenaLoaded:Signal;
      
      public var onShowPlayersList:Signal;
      
      public var onBattleLoadingTabIndex:Signal;
      
      public var onLoadingFinished:Signal;
      
      public var onSetListNews:Signal;
      
      public var onChinaFlag:Signal;
      
      public var onRequestLoadingClose:Signal;
      
      public var onSaveChatSettings:Signal;
      
      private var _isLoadingHidden:Boolean = false;
      
      private var _loadedTabIndex:int = 1;
      
      private var _loadingFinished:Boolean = false;
      
      private var _isRequestLoadingClose:Boolean = false;
      
      public var teamsVO:TeamsVO;
      
      public var tutorialIndex:int = -1;
      
      public var curProfileName:String = "";
      
      public var battleType:int = 0;
      
      public var battleLoadingTitle:String = "";
      
      public var titleProfile:String;
      
      public var battleName:String;
      
      public var curNation:String;
      
      public var battleLoadingDescription:String = "";
      
      public var arenaName:String;
      
      public var arenaIcoPath:String;
      
      public var helpTextMessage:String;
      
      public var updatedTeamA:Array;
      
      public var updatedTeamB:Array;
      
      public var progressBarValue:Number;
      
      public var pvpUnlocked:Boolean;
      
      public var compareVO:VehicleCompareVO;
      
      public var hintData:Array;
      
      public var playerInfo:PlayerInfoVO;
      
      public var isArenaLoaded:Boolean = false;
      
      public var isShowCursor:Boolean = false;
      
      public var newsSpeed:int = 0;
      
      public var isChina:Boolean = false;
      
      public var isIntroEnabled:Boolean = false;
      
      public var isResponseComparingVehicle:Boolean = false;
      
      public var isResponsePlayerInfo:Boolean = false;
      
      private var _newsTicker:NewsTickerVO;
      
      private var _dataNewsList:Array;
      
      private var _isBattleLoadingClose:Boolean = false;
      
      public function HUDLoadingModel()
      {
         this.onInitTeams = new Signal();
         this.onSetBattleType = new Signal();
         this.onSetBattleMap = new Signal();
         this.onUpdateProgressBar = new Signal();
         this.onUpdateTeamA = new Signal();
         this.onUpdateTeamB = new Signal();
         this.onUpdateHelpText = new Signal();
         this.onLoadingScreenHide = new Signal();
         this.onComparingVehicle = new Signal();
         this.onHintData = new Signal();
         this.onPlayerInfoData = new Signal();
         this.onArenaLoaded = new Signal();
         this.onShowPlayersList = new Signal();
         this.onBattleLoadingTabIndex = new Signal();
         this.onLoadingFinished = new Signal();
         this.onSetListNews = new Signal();
         this.onChinaFlag = new Signal();
         this.onRequestLoadingClose = new Signal();
         this.onSaveChatSettings = new Signal();
         this.hintData = [];
         this.playerInfo = new PlayerInfoVO();
         this._dataNewsList = [];
         super();
      }
      
      public function get isLoadingHidden() : Boolean
      {
         return this._isLoadingHidden;
      }
      
      public function get loadedTabIndex() : int
      {
         return this._loadedTabIndex;
      }
      
      public function get loadingFinished() : Boolean
      {
         return this._loadingFinished;
      }
      
      public function set loadingFinished(param1:Boolean) : void
      {
         this._loadingFinished = param1;
         this.onLoadingFinished.fire();
      }
      
      public function get isRequestLoadingClose() : Boolean
      {
         return this._isRequestLoadingClose;
      }
      
      public function get dataNewsList() : Array
      {
         return this._dataNewsList;
      }
      
      override protected function onInit() : void
      {
         this.teamsVO = new TeamsVO();
         ExternalInterface.addCallback("initTeams",this.initTeams);
         ExternalInterface.addCallback("setBattleType",this.setBattleType);
         ExternalInterface.addCallback("setBattleMap",this.setBattleMap);
         ExternalInterface.addCallback("updateProgressBar",this.updateProgressBar);
         ExternalInterface.addCallback("updateTeamA",this.updateTeamA);
         ExternalInterface.addCallback("updateTeamB",this.updateTeamB);
         ExternalInterface.addCallback("updateHelpText",this.updateHelpText);
         ExternalInterface.addCallback("hud.hideLoadingScreen",this.hideLoadingScreen);
         ExternalInterface.addCallback("responseComparingVehicle",this.responseComparingVehicle);
         ExternalInterface.addCallback("responseBattleHints",this.responseBattleHints);
         ExternalInterface.addCallback("responsePlayerInfo",this.responsePlayerInfo);
         ExternalInterface.addCallback("arenaLoaded",this.arenaLoaded);
         ExternalInterface.addCallback("battleLoadingTabIndex",this.battleLoadingTabIndexResponse);
         ExternalInterface.addCallback("newsTicker.setListNews",this.setListNews);
         ExternalInterface.addCallback("newsTicker.setSpeed",this.setSpeed);
         ExternalInterface.addCallback("setChinaFlag",this.setChinaFlag);
         ExternalInterface.addCallback("hud.preIntroEnabled",this.setPreIntroEnabled);
      }
      
      private function battleLoadingTabIndexResponse(param1:int) : void
      {
         this._loadedTabIndex = param1;
         this.onBattleLoadingTabIndex.fire();
      }
      
      public function saveBattleLoadingTabIndex(param1:int) : void
      {
         ExternalInterface.call("setBattleLoadingTabIndex",param1);
      }
      
      private function arenaLoaded() : void
      {
         trace("HUDLoadingModel.arenaLoaded");
         this.isArenaLoaded = true;
         this.onArenaLoaded.fire();
      }
      
      public function initTeams(param1:Object) : void
      {
         trace("HUDLoadingModel::initTeams::teamsVO::" + param1);
         trace("HUDLoadingModel::teamsVO.teamA.length::" + param1.teamA.length);
         trace("HUDLoadingModel::teamsVO.teamB.length::" + param1.teamB.length);
         this.updatePlayersName(param1.teamA);
         this.updatePlayersName(param1.teamB);
         this.teamsVO.teamA = param1.teamA;
         this.teamsVO.teamB = param1.teamB;
         this.sortTeams(param1.teamA);
         this.sortTeams(param1.teamB);
         var _loc2_:int = 0;
         while(_loc2_ < param1.teamA.length)
         {
            if(param1.teamA[_loc2_].isOwner)
            {
               this.playerInfo.planeName = param1.teamA[_loc2_].planeName;
               this.playerInfo.planeIcoPath = param1.teamA[_loc2_].battleLoadingIconPath;
               this.playerInfo.typeIcoPath = param1.teamA[_loc2_].typeIconPath;
               break;
            }
            _loc2_++;
         }
         this.onInitTeams.fire();
         this.onPlayerInfoData.fire();
      }
      
      private function updatePlayersName(param1:Array) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in param1)
         {
            _loc2_.playerName = concatNickname(_loc2_.playerName,_loc2_.clanAbbrev);
         }
      }
      
      private function sortTeams(param1:Array) : void
      {
         if(param1)
         {
            param1.sortOn("planeNumber",Array.NUMERIC);
         }
      }
      
      public function setBattleType(param1:Object) : void
      {
         trace("HUDLoadingModel.setBattleType > data.battleType : " + param1.battleType);
         this.battleType = int(param1.battleType);
         this.pvpUnlocked = Boolean(param1.pvpUnlocked);
         if(this.battleType == ARENA_TYPE_TUTORIAL)
         {
            this.battleLoadingTitle = param1.battleLoadingTitle;
            this.battleName = "";
            this.titleProfile = param1.titleProfile;
            this.tutorialIndex = param1.tutorialIndex;
            this.curProfileName = param1.curProfileName;
            if(param1.hasOwnProperty("curNation"))
            {
               this.curNation = param1.curNation;
            }
         }
         else
         {
            this.battleName = param1.battleName;
            this.battleLoadingTitle = param1.battleLoadingTitle;
            this.battleLoadingDescription = param1.battleLoadingDescription;
         }
         this.onSetBattleType.fire();
      }
      
      public function setBattleMap(param1:String, param2:String) : void
      {
         trace("HUDLoadingModel.setBattleMap > arenaName : " + param1 + ", arenaIcoPath : " + param2);
         this.arenaName = param1;
         this.arenaIcoPath = param2;
         this.onSetBattleMap.fire();
      }
      
      public function updateTeam(param1:Array, param2:Array) : Array
      {
         var _loc3_:int = 0;
         if(param1.length == param2.length)
         {
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               param2[_loc3_].isLoaded = Boolean(param1[_loc3_]);
               _loc3_++;
            }
         }
         return param2;
      }
      
      public function updateTeamA(param1:Array) : void
      {
         trace("HUDLoadingModel.updateTeamA::loadedPlayers::" + param1 + ", loadedPlayers.length::" + param1.length);
         this.updatedTeamA = [];
         this.updatedTeamA = this.updateTeam(param1,this.teamsVO.teamA);
         this.sortTeams(this.updatedTeamA);
         this.teamsVO.teamA = this.updatedTeamA;
         this.onUpdateTeamA.fire();
      }
      
      public function updateTeamB(param1:Array) : void
      {
         trace("HUDLoadingModel.updateTeamB::loadedPlayers::" + param1 + ", loadedPlayers.length::" + param1.length);
         this.updatedTeamB = [];
         this.updatedTeamB = this.updateTeam(param1,this.teamsVO.teamB);
         this.sortTeams(this.updatedTeamB);
         this.teamsVO.teamB = this.updatedTeamB;
         this.onUpdateTeamB.fire();
      }
      
      public function updateHelpText(param1:String) : void
      {
         this.helpTextMessage = param1;
         this.onUpdateHelpText.fire();
      }
      
      public function updateProgressBar(param1:Number) : void
      {
         this.progressBarValue = param1;
         this.onUpdateProgressBar.fire();
      }
      
      public function hideLoadingScreen() : void
      {
         trace("HUDLoadingModel.hideLoadingScreen");
         this._isLoadingHidden = true;
         this.onLoadingScreenHide.fire();
      }
      
      public function saveChatSettings() : void
      {
         this.onSaveChatSettings.fire();
      }
      
      public function requestLoadingClose() : void
      {
         trace("HUDLoadingModel.requestLoadingClose");
         this._isRequestLoadingClose = true;
         this.onRequestLoadingClose.fire();
      }
      
      public function battleLoadingClose() : void
      {
         trace("HUDLoadingModel.battleLoadingClose_isBattleLoadingClose = " + this._isBattleLoadingClose);
         if(!this._isBattleLoadingClose)
         {
            this._isBattleLoadingClose = true;
            ExternalInterface.call("battleLoadingClose");
         }
      }
      
      public function requestComparingVehicle(param1:int) : void
      {
         trace("HUDLoadingModel.requestComparingVehicle > id : " + param1);
         ExternalInterface.call("requestComparingVehicle",param1);
      }
      
      private function responseComparingVehicle(param1:Object) : void
      {
         trace("HUDLoadingModel.responseComparingVehicle > vo : " + param1);
         this.compareVO = new VehicleCompareVO(param1);
         this.onComparingVehicle.fire();
         this.isResponseComparingVehicle = true;
      }
      
      private function responseBattleHints(param1:Array) : void
      {
         var _loc2_:HintVO = null;
         trace("HUDLoadingModel.responseBattleHints > hintData.length : " + param1.length);
         this.hintData = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new HintVO();
            _loc2_.id = param1[_loc3_].id;
            _loc2_.imgPath = param1[_loc3_].imgPath;
            _loc2_.locText = param1[_loc3_].locText;
            this.hintData.push(_loc2_);
            trace(_loc2_.toString());
            _loc3_++;
         }
         this.onHintData.fire();
      }
      
      private function responsePlayerInfo(param1:Object) : void
      {
         var _loc2_:CharacteristicsVO = null;
         trace("HUDLoadingModel.responsePlayerInfo > vo : " + param1);
         this.playerInfo.description = param1.description;
         trace("playerInfo.description : " + this.playerInfo.description);
         this.playerInfo.characteristics = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.characteristics.length)
         {
            _loc2_ = new CharacteristicsVO();
            _loc2_.stars = param1.characteristics[_loc3_].stars;
            _loc2_.text = param1.characteristics[_loc3_].text;
            _loc2_.value = param1.characteristics[_loc3_].value;
            this.playerInfo.characteristics.push(_loc2_);
            trace("charact : " + _loc2_);
            _loc3_++;
         }
         this.onPlayerInfoData.fire();
         if(Boolean(this.isResponseComparingVehicle) && Boolean(this.isResponsePlayerInfo))
         {
            this.onComparingVehicle.fire();
         }
         this.isResponsePlayerInfo = true;
      }
      
      public function requestPlayersList() : void
      {
         this.onShowPlayersList.fire();
      }
      
      private function setListNews(param1:Array) : void
      {
         trace("HUDLoadingModel::setListNews::news::" + param1);
         this._dataNewsList = [];
         if(param1.length == 0)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this._newsTicker = new NewsTickerVO(param1[_loc2_]);
            this._dataNewsList.push(this._newsTicker);
            _loc2_++;
         }
         this.onSetListNews.fire();
      }
      
      private function setSpeed(param1:int) : void
      {
         trace("HUDLoadingModel::setSpeed::speed::" + param1);
         this.newsSpeed = param1;
      }
      
      private function setChinaFlag(param1:Boolean) : void
      {
         trace("HUDLoadingModel::setChinaFlag::flag::" + param1);
         this.isChina = param1;
         this.onChinaFlag.fire();
      }
      
      private function setPreIntroEnabled(param1:Boolean) : void
      {
         this.isIntroEnabled = param1;
      }
      
      public function mouseShowPoint() : void
      {
         ExternalInterface.call("system.setCursor","point");
      }
      
      public function mouseShowArrow() : void
      {
         ExternalInterface.call("system.setCursor","arrow");
      }
      
      public function onNewsClicked(param1:String) : void
      {
         ExternalInterface.call("newsTicker.openNews",param1);
      }
      
      public function loadingClosed() : void
      {
         ExternalInterface.call("system.loadingClosed");
      }
      
      override protected function onDispose() : void
      {
         this.teamsVO = null;
         ExternalInterface.addCallback("initTeams",null);
         ExternalInterface.addCallback("setBattleType",null);
         ExternalInterface.addCallback("setBattleMap",null);
         ExternalInterface.addCallback("updateProgressBar",null);
         ExternalInterface.addCallback("updateTeamA",null);
         ExternalInterface.addCallback("updateTeamB",null);
         ExternalInterface.addCallback("updateHelpText",null);
         ExternalInterface.addCallback("hud.hideLoadingScreen",null);
         ExternalInterface.addCallback("responseComparingVehicle",null);
         ExternalInterface.addCallback("responseBattleHints",null);
         ExternalInterface.addCallback("responsePlayerInfo",null);
         ExternalInterface.addCallback("arenaLoaded",null);
         ExternalInterface.addCallback("newsTicker.setListNews",null);
         ExternalInterface.addCallback("newsTicker.setSpeed",null);
         ExternalInterface.addCallback("setChinaFlag",null);
      }
   }
}
