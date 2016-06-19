package wowp.hud.model.chat
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import wowp.hud.model.chat.vo.ChatMessageVO;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   
   public class ChatModel extends HUDModelComponent
   {
      
      private static var CHAT_PAGE_HEIGHT:int = 5;
       
      public var onBanned:Signal;
      
      public var onEnabled:Signal;
      
      public var onGotMessage:Signal;
      
      public var onPageChangedMessages:Signal;
      
      public var onChangedVisible:Signal;
      
      private var _isSquad:Boolean;
      
      private var _isBanned:Boolean = false;
      
      private var _isEnabled:Boolean = true;
      
      private var _isScrollEnable:Boolean = false;
      
      private var _lastChatMessage:ChatMessageVO;
      
      private var _restoreSettings:Object;
      
      private var _historyChatMessages:Array;
      
      private var _historyChatMessagesPos:int = 0;
      
      private var _updateScrollEnable:Timer;
      
      private var _isChatVisibled:Boolean = false;
      
      private var _isNeedSend:Boolean = false;
      
      public function ChatModel()
      {
         this.onBanned = new Signal();
         this.onEnabled = new Signal();
         this.onGotMessage = new Signal();
         this.onPageChangedMessages = new Signal();
         this.onChangedVisible = new Signal();
         this._historyChatMessages = [];
         super();
      }
      
      public function get isSquad() : Boolean
      {
         return this._isSquad;
      }
      
      public function get isBanned() : Boolean
      {
         return this._isBanned;
      }
      
      public function get isEnabled() : Boolean
      {
         return this._isEnabled;
      }
      
      public function get lastChatMessageVo() : ChatMessageVO
      {
         return this._lastChatMessage;
      }
      
      public function getHistoryChatMessageVo(param1:int) : ChatMessageVO
      {
         var _loc2_:* = this._historyChatMessagesPos - CHAT_PAGE_HEIGHT + param1;
         if(_loc2_ >= 0)
         {
            return this._historyChatMessages[_loc2_];
         }
         return null;
      }
      
      public function get isChatVisibled() : Boolean
      {
         return this._isChatVisibled;
      }
      
      public function get isNeedSend() : Boolean
      {
         return this._isNeedSend;
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
         var _loc2_:Object = null;
         backend.addCallback("hud.chatIsSquad",this.chatIsSquad);
         backend.addCallback("hud.chatUpdateStatus",this.updateStatus);
         backend.addCallback("hud.chatMessage",this.showChatMessage);
         backend.addCallback("hud.onVisibilityChat",this.setVisibilityChat);
         var _loc1_:* = 0;
         while(_loc1_ < CHAT_PAGE_HEIGHT)
         {
            _loc2_ = {};
            _loc2_.msgType = -1;
            this._lastChatMessage = new ChatMessageVO(_loc2_);
            this._historyChatMessages.push(this._lastChatMessage);
            this._historyChatMessagesPos = this._historyChatMessages.length;
            _loc1_++;
         }
         this._updateScrollEnable = new Timer(12000,1);
         this._updateScrollEnable.addEventListener(TimerEvent.TIMER,this.onUpdateScrollEnable);
      }
      
      public function onUpdateScrollEnable(param1:TimerEvent) : *
      {
         this._isScrollEnable = false;
      }
      
      public function chatIsSquad(param1:Boolean) : void
      {
         this._isSquad = param1;
      }
      
      private function updateStatus(param1:Object) : void
      {
         if(this._isBanned != param1.isBanned)
         {
            this._isBanned = param1.isBanned;
            this.onBanned.fire();
         }
         if(this._isEnabled != param1.isEnabled)
         {
            this._isEnabled = param1.isEnabled;
            this.onEnabled.fire();
         }
      }
      
      public function showChatMessage(param1:Object) : void
      {
         this._lastChatMessage = new ChatMessageVO(param1);
         var _loc2_:Boolean = false;
         if(this._historyChatMessagesPos != this._historyChatMessages.length)
         {
            _loc2_ = true;
         }
         if(this._historyChatMessages[0].msgType == -1)
         {
            this._historyChatMessages.shift();
         }
         this._historyChatMessages.push(this._lastChatMessage);
         this._historyChatMessagesPos = this._historyChatMessages.length;
         if(_loc2_)
         {
            this.onPageChangedMessages.fire();
         }
         else
         {
            this.onGotMessage.fire();
         }
         this._isScrollEnable = true;
         this._updateScrollEnable.reset();
         this._updateScrollEnable.start();
      }
      
      public function setVisibilityChat(param1:Boolean, param2:Boolean) : void
      {
         this._isChatVisibled = param1;
         this._isNeedSend = param2;
         this.onChangedVisible.fire();
      }
      
      public function setOpenChat() : void
      {
         backend.callAsync("hud.onOpenChat");
      }
      
      public function send(param1:String, param2:int) : void
      {
         if(this._isBanned)
         {
            this.onBanned.fire();
         }
         else if(param1 != "")
         {
            backend.callAsync("hud.requestChatSend",param1,param2);
         }
      }
      
      public function pageUp() : void
      {
         if(Boolean(this._isScrollEnable) && this._historyChatMessagesPos > CHAT_PAGE_HEIGHT)
         {
            this._historyChatMessagesPos--;
         }
         this.onPageChangedMessages.fire();
         this._isScrollEnable = true;
         this._updateScrollEnable.reset();
         this._updateScrollEnable.start();
      }
      
      public function pageDown() : void
      {
         if(Boolean(this._isScrollEnable) && this._historyChatMessagesPos < this._historyChatMessages.length)
         {
            this._historyChatMessagesPos++;
         }
         this.onPageChangedMessages.fire();
         this._isScrollEnable = true;
         this._updateScrollEnable.reset();
         this._updateScrollEnable.start();
      }
      
      public function getHistoryMessages() : void
      {
      }
   }
}
