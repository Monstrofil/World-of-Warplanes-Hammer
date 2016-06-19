package wowp.hud.model.domination
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import wowp.hud.model.messages.vo.MessageVO;
   
   public class HudDominationModel extends HUDModelComponent
   {
       
      public var onScoreUpdated:Signal;
      
      public var onDominationUpdated:Signal;
      
      public var onGotAllyMessage:Signal;
      
      public var onGotEnemyMessage:Signal;
      
      public var onSetSuperiority:Signal;
      
      public var ownScore:Number;
      
      public var enemyScore:Number;
      
      public var ownDomination:Number;
      
      public var enemyDomination:Number;
      
      public var isSuperiority2:Boolean = false;
      
      private var _lastAllyMessage:MessageVO;
      
      private var _lastEnemyMessage:MessageVO;
      
      public function HudDominationModel()
      {
         this.onScoreUpdated = new Signal();
         this.onDominationUpdated = new Signal();
         this.onGotAllyMessage = new Signal();
         this.onGotEnemyMessage = new Signal();
         this.onSetSuperiority = new Signal();
         this._lastAllyMessage = new MessageVO();
         this._lastEnemyMessage = new MessageVO();
         super();
      }
      
      public function get lastAllyMessage() : MessageVO
      {
         return this._lastAllyMessage;
      }
      
      public function get lastEnemyMessage() : MessageVO
      {
         return this._lastEnemyMessage;
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.captureBaseDomination",this.updateDominations);
         backend.addCallback("hud.captureBaseScore",this.updateScore);
         backend.addCallback("hud.messageAlly",this.showAllyMessage);
         backend.addCallback("hud.messageEnemy",this.showEnemyMessage);
         backend.addCallback("hud.isSuperiority2",this.setSuperiority);
      }
      
      private function updateDominations(param1:Number, param2:Number) : void
      {
         this.ownDomination = param1;
         this.enemyDomination = param2;
         this.onDominationUpdated.fire();
      }
      
      private function updateScore(param1:Number, param2:Number) : void
      {
         this.ownScore = param1;
         this.enemyScore = param2;
         this.onScoreUpdated.fire();
      }
      
      public function showAllyMessage(param1:String, param2:int = 0) : void
      {
         this._lastAllyMessage.message = param1;
         this._lastAllyMessage.type = param2;
         this.onGotAllyMessage.fire();
      }
      
      public function showEnemyMessage(param1:String, param2:int = 0) : void
      {
         this._lastEnemyMessage.message = param1;
         this._lastEnemyMessage.type = param2;
         this.onGotEnemyMessage.fire();
      }
      
      public function setSuperiority(param1:Boolean) : void
      {
         this.isSuperiority2 = param1;
         this.onSetSuperiority.fire();
      }
   }
}
