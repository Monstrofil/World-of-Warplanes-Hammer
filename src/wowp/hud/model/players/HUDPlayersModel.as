package wowp.hud.model.players
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import wowp.hud.model.players.vo.HUDPlayerVO;
   
   public class HUDPlayersModel extends HUDModelComponent
   {
       
      public var onPlayersChanged:Signal;
      
      public var onStateChanged:Signal;
      
      public var onPlayersUpdated:Signal;
      
      public var onSwitchedVehicle:Signal;
      
      private var _players:Object;
      
      private var _playersUpdatedArr:Array;
      
      private var _state:int = 1;
      
      private var _countDenunciations:int = 0;
      
      private var _switchedPlayerID:int = 0;
      
      private var _playerIDLeaderPlane:int = -1;
      
      private var _playerIDLeaderGround:int = -1;
      
      public function HUDPlayersModel()
      {
         this.onPlayersChanged = new Signal();
         this.onStateChanged = new Signal();
         this.onPlayersUpdated = new Signal();
         this.onSwitchedVehicle = new Signal();
         this._players = {};
         this._playersUpdatedArr = [];
         super();
      }
      
      public function get players() : Object
      {
         return this._players;
      }
      
      public function get playersUpdatedArr() : Array
      {
         return this._playersUpdatedArr;
      }
      
      public function get switchedPlayerID() : int
      {
         return this._switchedPlayerID;
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.playerListUpdateStats",this.updatePlayer);
         backend.addCallback("hud.playerListUpdate",this.updateList);
         backend.addCallback("hud.playerListUpdateSpeaker",this.updateSpeaker);
         backend.addCallback("hud.playerListSetMuted",this.setMuted);
         backend.addCallback("hud.playerListUpdateStatsBatch",this.updateBatch);
         backend.addCallback("hud.playerListChangeState",this.changeState);
         backend.addCallback("hud.denunciations",this.setCountDenunciations);
         backend.addCallback("hud.playerListSetChatList",this.setChatList);
         backend.addCallback("hud.onSwitchedVehicle",this.switchedVehicle);
         backend.addCallback("hud.updateAvatarHealth",this.updateAvatarHealth);
         backend.addCallback("hud.playerListUpdateLeader",this.updateLeader);
      }
      
      public function updatePlayer(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:HUDPlayerVO = this._players[param1.ID] as HUDPlayerVO;
         if(_loc2_ != null)
         {
            _loc3_ = 0;
            if(_loc2_.isDead == param1.isDead)
            {
               if((_loc2_.frags != param1.frags || _loc2_.fragsTeamObject != param1.fragsTeamObject || _loc2_.superiorityPoints != param1.superiorityPoints) && _loc2_.state == param1.state && _loc2_.isTeamKiller == param1.isTeamKiller)
               {
                  _loc3_ = 1;
               }
               else
               {
                  _loc3_ = 2;
               }
            }
            _loc2_.lives = param1.lives;
            _loc2_.frags = param1.frags;
            _loc2_.fragsTeamObject = param1.fragsTeamObject;
            _loc2_.superiorityPoints = param1.superiorityPoints;
            _loc2_.isDead = param1.isDead;
            _loc2_.state = param1.state;
            _loc2_.assistsNumber = param1.assists;
            _loc2_.assistsGroundNumber = param1.assistsGround;
            _loc2_.isTeamKiller = param1.isTeamKiller;
            switch(_loc3_)
            {
               case 0:
                  this.onPlayersChanged.fire();
                  break;
               case 1:
                  _loc2_.setFragsChanged();
                  break;
               case 2:
                  _loc2_.setPlayerChanged();
            }
            this._playersUpdatedArr = [];
            this._playersUpdatedArr.push(_loc2_.ID);
            this.onPlayersUpdated.fire();
         }
      }
      
      protected function updateList(param1:Array) : void
      {
         var _loc2_:HUDPlayerVO = null;
         this._players = {};
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = HUDPlayerVO.create(param1[_loc4_]);
            if(_loc2_)
            {
               this._players[_loc2_.ID] = _loc2_;
            }
            _loc4_++;
         }
         this._playersUpdatedArr = [];
         this.onPlayersChanged.fire();
      }
      
      public function updateSpeaker(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:HUDPlayerVO = this._players[param1];
         if(_loc4_ != null)
         {
            _loc4_.speaker = param2;
            _loc4_.isSpeaking = param3;
            _loc4_.setSpeakerChanged();
         }
      }
      
      public function setMuted(param1:int, param2:Boolean) : void
      {
         var _loc3_:HUDPlayerVO = this._players[param1];
         if(_loc3_ != null)
         {
            _loc3_.isMuted = param2;
         }
      }
      
      public function set state(param1:int) : void
      {
         backend.callAsync("onSavePlayerListChangeState",param1);
         this._state = param1;
         this.onStateChanged.fire();
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function changeState(param1:int) : void
      {
         this._state = param1;
         this.onStateChanged.fire();
      }
      
      public function get countDenunciations() : int
      {
         return this._countDenunciations;
      }
      
      public function setCountDenunciations(param1:int) : void
      {
         this._countDenunciations = param1;
      }
      
      public function setChatList(param1:Array) : void
      {
         var _loc4_:HUDPlayerVO = null;
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._players[param1[_loc3_].id];
            if(_loc4_ != null)
            {
               _loc4_.chatList = param1[_loc3_].status;
            }
            _loc3_++;
         }
         this.onPlayersChanged.fire();
      }
      
      public function switchedVehicle(param1:int) : void
      {
         this._switchedPlayerID = param1;
         this.onSwitchedVehicle.fire();
      }
      
      public function updateAvatarHealth(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:HUDPlayerVO = this._players[param1];
         if(_loc4_ != null)
         {
            _loc4_.maxHealth = param2;
            _loc4_.health = param3;
            _loc4_.setHealthChanged();
         }
      }
      
      public function resetLeader(param1:int, param2:int) : void
      {
         var _loc3_:HUDPlayerVO = this._players[param1];
         if(_loc3_ != null)
         {
            switch(param2)
            {
               case 1:
                  _loc3_.isLeaderPlane = false;
                  break;
               case 2:
                  _loc3_.isLeaderGround = false;
            }
            _loc3_.setLeaderChanged();
         }
      }
      
      public function updateLeader(param1:int, param2:int) : void
      {
         var _loc3_:HUDPlayerVO = this._players[param1];
         if(_loc3_ != null)
         {
            switch(param2)
            {
               case 1:
                  if(this._playerIDLeaderPlane != -1)
                  {
                     this.resetLeader(this._playerIDLeaderPlane,param2);
                  }
                  _loc3_.isLeaderPlane = true;
                  this._playerIDLeaderPlane = param1;
                  break;
               case 2:
                  if(this._playerIDLeaderGround != -1)
                  {
                     this.resetLeader(this._playerIDLeaderGround,param2);
                  }
                  _loc3_.isLeaderGround = true;
                  this._playerIDLeaderGround = param1;
            }
            _loc3_.setLeaderChanged();
         }
      }
      
      public function updateBatch(param1:Array) : void
      {
         var _loc2_:Object = null;
         var _loc3_:HUDPlayerVO = null;
         var _loc4_:String = null;
         var _loc5_:Boolean = false;
         var _loc6_:int = param1.length;
         this._playersUpdatedArr = [];
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc2_ = param1[_loc7_];
            _loc4_ = _loc2_[HUDPlayerVO.PLAYER_ID];
            if(_loc4_)
            {
               _loc3_ = this._players[_loc4_] as HUDPlayerVO;
               if(Boolean(_loc3_) && Boolean(_loc3_.setFields(_loc2_)))
               {
                  _loc5_ = true;
                  this._playersUpdatedArr.push(_loc3_.ID);
               }
            }
            _loc7_++;
         }
         if(_loc5_)
         {
            this.onPlayersUpdated.fire();
            this.onPlayersChanged.fire();
         }
      }
      
      public function applySortStrategy(param1:Array) : void
      {
         var _loc5_:Object = null;
         param1.sortOn(HUDPlayerVO.PLANE_NUMBER,Array.NUMERIC);
         var _loc2_:int = 0;
         var _loc3_:int = param1.length;
         var _loc4_:Array = [];
         while(_loc2_ < _loc3_)
         {
            _loc5_ = param1[_loc2_];
            if(_loc5_.isDead)
            {
               _loc4_[_loc4_.length] = _loc5_;
               param1.splice(_loc2_,1);
               _loc3_--;
            }
            else
            {
               _loc2_++;
            }
         }
         _loc2_ = 0;
         _loc3_ = _loc4_.length;
         while(_loc2_ < _loc3_)
         {
            param1[param1.length] = _loc4_[_loc2_];
            _loc2_++;
         }
      }
      
      public function setSortChanged() : void
      {
         this.onSwitchedVehicle.fire();
      }
      
      public function getPlayer(param1:int) : HUDPlayerVO
      {
         return this._players[param1] as HUDPlayerVO;
      }
      
      public function requestFriendPlayer(param1:int, param2:Boolean) : void
      {
         backend.callAsync("hud.editFriendStatus",param1,param2);
      }
      
      public function requestIgnorePlayer(param1:int, param2:Boolean) : void
      {
         backend.callAsync("hud.editIgnoreStatus",param1,param2);
      }
      
      public function requestMutePlayer(param1:int, param2:Boolean) : void
      {
         backend.callAsync("hud.requestMutePlayer",param1,param2);
      }
      
      public function requestDenunciationPlayer(param1:int, param2:int, param3:int) : void
      {
         backend.callAsync("hud.onDenunciation",param1,param2,param3);
      }
      
      public function switchToVehicle(param1:int) : void
      {
         trace("HUDPlayersModel::switchToVehicle = " + param1);
         backend.callAsync("hud.switchToVehicle",param1);
      }
   }
}
