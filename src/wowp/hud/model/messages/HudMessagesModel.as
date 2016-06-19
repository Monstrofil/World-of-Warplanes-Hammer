package wowp.hud.model.messages
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import wowp.hud.model.messages.vo.MessageVO;
   import wowp.hud.model.messages.vo.BattleMessageVO;
   import flash.utils.setTimeout;
   
   public class HudMessagesModel extends HUDModelComponent
   {
       
      public var onHeaderChanged:Signal;
      
      public var onGotMessage:Signal;
      
      public var onGotBattleMessage:Signal;
      
      public var onGotBattleMessageClear:Signal;
      
      public var onShowDamageMessage:Signal;
      
      public var onShowUselessShootMessage:Signal;
      
      public var onShowSuperiorityMessage:Signal;
      
      public var onUpdateLeaderInfo:Signal;
      
      public var onUpdateHintInfo:Signal;
      
      public var onShowAward:Signal;
      
      public var onVisibilitySkipIntroHintChanged:Signal;
      
      public var onSaveBattleMessageSettings:Signal;
      
      private var _lastMessageVO:MessageVO;
      
      private var _lastBattleMessage:BattleMessageVO;
      
      private var _teamKillers:Array;
      
      public var headerTitle:String = "";
      
      public var headerMessage:String = "";
      
      private var _damageMessage:String;
      
      private var _damageMessageValue:String;
      
      private var _superiorityMessage:String;
      
      private var _superiorityMessageValue:String;
      
      private var _leaderInfo:Object;
      
      private var _hintInfo:Object;
      
      private var _award:Object;
      
      private var _isVisibleSkipIntroHint:Boolean;
      
      private var _restoreSettings:Object;
      
      public function HudMessagesModel()
      {
         this.onHeaderChanged = new Signal();
         this.onGotMessage = new Signal();
         this.onGotBattleMessage = new Signal();
         this.onGotBattleMessageClear = new Signal();
         this.onShowDamageMessage = new Signal();
         this.onShowUselessShootMessage = new Signal();
         this.onShowSuperiorityMessage = new Signal();
         this.onUpdateLeaderInfo = new Signal();
         this.onUpdateHintInfo = new Signal();
         this.onShowAward = new Signal();
         this.onVisibilitySkipIntroHintChanged = new Signal();
         this.onSaveBattleMessageSettings = new Signal();
         this._lastMessageVO = new MessageVO();
         this._teamKillers = [];
         this._leaderInfo = {};
         this._hintInfo = {};
         this._award = {};
         super();
      }
      
      public function get lastMessageVO() : MessageVO
      {
         return this._lastMessageVO;
      }
      
      public function get lastBattleMessageVO() : BattleMessageVO
      {
         return this._lastBattleMessage;
      }
      
      public function set lastBattleMessageVO(param1:BattleMessageVO) : void
      {
         this._lastBattleMessage = param1;
      }
      
      public function get damageMessage() : String
      {
         return this._damageMessage;
      }
      
      public function get damageMessageValue() : String
      {
         return this._damageMessageValue;
      }
      
      public function get superiorityMessage() : String
      {
         return this._superiorityMessage;
      }
      
      public function get superiorityMessageValue() : String
      {
         return this._superiorityMessageValue;
      }
      
      public function get leaderInfo() : Object
      {
         return this._leaderInfo;
      }
      
      public function get hintInfo() : Object
      {
         return this._hintInfo;
      }
      
      public function get award() : Object
      {
         return this._award;
      }
      
      public function get isVisibleSkipIntroHint() : Boolean
      {
         return this._isVisibleSkipIntroHint;
      }
      
      public function isTeamKiller(param1:int) : Boolean
      {
         return this._teamKillers.indexOf(param1) != -1 || Boolean(model.players.getPlayer(param1)) && Boolean(model.players.getPlayer(param1).isTeamKiller);
      }
      
      public function get restoreSettings() : Object
      {
         return this._restoreSettings;
      }
      
      public function set restoreSettings(param1:Object) : void
      {
         this._restoreSettings = param1;
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.setHeaderMessages",this.setHeaderMessages);
         backend.addCallback("hud.message",this.showMessage);
         backend.addCallback("hud.battleMessage",this.gotBattleMessage);
         backend.addCallback("hud.battleMessageClear",this.gotBattleMessageClear);
         backend.addCallback("hud.showDamageMessage",this.showDamageMessage);
         backend.addCallback("hud.showUselessShootMessage",this.showUselessShootMessage);
         backend.addCallback("hud.showSuperiorityMessage",this.showSuperiorityMessage);
         backend.addCallback("hud.updateLeaderInfo",this.updateLeaderInfo);
         backend.addCallback("hud.hint",this.updateHintInfo);
         backend.addCallback("hud.showAward",this.showAward);
         backend.addCallback("hud.setVisibilitySkipIntroHint",this.setVisibilitySkipIntroHint);
      }
      
      private function setHeaderMessages(param1:String, param2:String) : void
      {
         this.headerTitle = param1;
         this.headerMessage = param2;
         this.onHeaderChanged.fire();
      }
      
      private function showDamageMessage(param1:String, param2:String) : void
      {
         trace("HudMessagesModel::showDamageMessage");
         this._damageMessage = param1;
         this._damageMessageValue = param2;
         this.onShowDamageMessage.fire();
      }
      
      private function showUselessShootMessage(param1:String) : void
      {
         trace("HudMessagesModel::showUselessShootMessage");
      }
      
      private function showSuperiorityMessage(param1:String, param2:String) : void
      {
         trace("HudMessagesModel::showSuperiorityMessage");
         this._superiorityMessage = param1;
         this._superiorityMessageValue = param2;
         this.onShowSuperiorityMessage.fire();
      }
      
      public function showMessage(param1:String, param2:int, param3:Boolean) : void
      {
         this._lastMessageVO.isSquad = param3;
         this._lastMessageVO.message = param1;
         this._lastMessageVO.type = param2;
         this.onGotMessage.fire();
      }
      
      private function gotBattleMessage(param1:Object) : void
      {
         this._lastBattleMessage = new BattleMessageVO(param1);
         if(this._lastBattleMessage.killerTeamIndex == this._lastBattleMessage.victimTeamIndex && this._lastBattleMessage.killerID != this._lastBattleMessage.victimID)
         {
            if(!this.isTeamKiller(this._lastBattleMessage.killerID))
            {
               this._teamKillers[this._teamKillers.length] = this._lastBattleMessage.killerID;
            }
         }
         this.onGotBattleMessage.fire();
      }
      
      private function gotBattleMessageClear() : void
      {
         trace("HudMessagesModel::hud.battleMessageClear");
         this.onGotBattleMessageClear.fire();
      }
      
      private function updateLeaderInfo(param1:int, param2:String) : void
      {
         trace("HudMessagesModel::updateLeaderInfo");
         this._leaderInfo.type = param1;
         this._leaderInfo.text = param2;
         this.onUpdateLeaderInfo.fire();
      }
      
      private function updateHintInfo(param1:Object) : void
      {
         trace("HudMessagesModel::updateHintInfo");
         this._hintInfo.timeForShow = param1.timeForShow;
         this._hintInfo.text = param1.text;
         this._hintInfo.color = param1.color;
         this.onUpdateHintInfo.fire();
      }
      
      public function testElements() : void
      {
         setTimeout(function():void
         {
            trace("-------testEleemnts-------");
            var _loc1_:Object = new Object();
            _loc1_.icoPath = "icons/awards/achievements/signsGotcha.png";
            _loc1_.type = int(Math.random() * 5);
            _loc1_.text = "«Попал!»";
            showAward(_loc1_);
         },1000);
      }
      
      private function showAward(param1:Object) : void
      {
         this._award.icoPath = param1.icoPath;
         this._award.text = param1.text;
         if(!param1.hasOwnProperty("type"))
         {
            param1.type = 0;
         }
         this._award.type = param1.type;
         this._award.isNew = true;
         this.onShowAward.fire();
         this._award.isNew = false;
      }
      
      private function setVisibilitySkipIntroHint(param1:Boolean) : void
      {
         trace("HudMessagesModel::setVisibilitySkipIntroHint = " + param1);
         this._isVisibleSkipIntroHint = param1;
         this.onVisibilitySkipIntroHintChanged.fire();
      }
      
      public function saveBattleMessageSettings() : void
      {
         this.onSaveBattleMessageSettings.fire();
      }
   }
}
