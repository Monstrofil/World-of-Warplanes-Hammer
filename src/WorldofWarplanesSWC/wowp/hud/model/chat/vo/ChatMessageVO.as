package wowp.hud.model.chat.vo
{
   import wowp.utils.string.time.concatNickname;
   
   public class ChatMessageVO
   {
       
      public var authorName:String;
      
      public var message:String;
      
      public var isOwner:Boolean;
      
      public var msgType:int;
      
      public var authorType:int;
      
      public var senderID:int;
      
      public var isHistory:Boolean;
      
      public var leaderType:int;
      
      public function ChatMessageVO(param1:Object)
      {
         super();
         this.authorName = concatNickname(param1.authorName,param1.authorClanAbbrev);
         this.message = param1.message;
         this.isOwner = param1.isOwner;
         this.msgType = param1.msgType;
         this.authorType = param1.authorType;
         this.senderID = param1.senderID;
         this.isHistory = param1.isHistory;
         this.leaderType = param1.leaderType;
      }
   }
}
