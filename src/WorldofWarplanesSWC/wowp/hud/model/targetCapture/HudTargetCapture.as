package wowp.hud.model.targetCapture
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import wowp.hud.model.targetCapture.vo.CapturedTargetVO;
   import wowp.hud.model.targetCapture.vo.ModuleCapturedTarget;
   
   public class HudTargetCapture extends HUDModelComponent
   {
       
      public var onMessageUpdated:Signal;
      
      public var onCaptureUpdated:Signal;
      
      public var onVisibilityChanged:Signal;
      
      public var updateDamageTarget:Signal;
      
      public var onInitDamageSchemeTarget:Signal;
      
      public var onCritDamageUpdate:Signal;
      
      public var onVictimInformAboutCrit:Signal;
      
      public var capturedMessage:String = "";
      
      public var capturedTarget:CapturedTargetVO;
      
      public var isVisible:Boolean = false;
      
      public var currentDamageList:Array;
      
      public var partID:String = "";
      
      public var planeID:int = -1;
      
      public function HudTargetCapture()
      {
         this.onMessageUpdated = new Signal();
         this.onCaptureUpdated = new Signal();
         this.onVisibilityChanged = new Signal();
         this.updateDamageTarget = new Signal();
         this.onInitDamageSchemeTarget = new Signal();
         this.onCritDamageUpdate = new Signal();
         this.onVictimInformAboutCrit = new Signal();
         this.capturedTarget = new CapturedTargetVO();
         super();
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.updateInfoCapturedTargetMessage",this.updateInfoCapturedTargetMessage);
         backend.addCallback("hud.updateInfoCapturedTarget",this.updateInfoCapturedTarget);
         backend.addCallback("hud.visibleInfoCapturedTarget",this.visibleInfoCapturedTarget);
         backend.addCallback("hud.initInfoCapturedTarget",this.initInfoCapturedTarget);
         backend.addCallback("hud.damagePanelUpdateTarget",this.updateDamagePanelTarget);
         backend.addCallback("hud.initDamageSchemeTarget",this.initDamageSchemeTarget);
         backend.addCallback("hud.onVictimInformAboutCrit",this.onVictivInformHandler);
      }
      
      private function onVictivInformHandler(param1:String, param2:int) : void
      {
         this.partID = param1;
         this.planeID = param2;
         this.onVictimInformAboutCrit.fire();
      }
      
      private function initDamageSchemeTarget(param1:*) : void
      {
         this.capturedTarget.clear();
         this.onInitDamageSchemeTarget.fire();
      }
      
      private function updateDamagePanelTarget(param1:Array) : void
      {
         this.addModules(param1);
         this.currentDamageList = param1;
         this.onCritDamageUpdate.fire();
         this.updateDamageTarget.fire();
      }
      
      public function addModules(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc4_:ModuleCapturedTarget = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = param1[_loc3_][0];
            _loc4_ = this.capturedTarget.getNewModule(_loc2_,param1[_loc3_][2]);
            if(_loc4_ == null)
            {
               _loc4_ = new ModuleCapturedTarget();
               this.capturedTarget.newModules.push(_loc4_);
            }
            _loc5_ = CapturedTargetVO.getPositionBySlot(_loc2_);
            if(_loc5_ != -1)
            {
               param1[_loc3_].push(CapturedTargetVO.getStrPositionByPosition(_loc5_));
               param1[_loc3_].push(_loc5_);
               _loc4_.setData(param1[_loc3_]);
            }
            _loc3_++;
         }
      }
      
      private function updateInfoCapturedTargetMessage(param1:Boolean, param2:String) : void
      {
         this.capturedMessage = param2;
         this.onMessageUpdated.fire();
      }
      
      private function updateInfoCapturedTarget(param1:Object) : void
      {
         this.capturedTarget.distance = param1.distance;
         this.capturedTarget.health = param1.health;
         if(param1.icon)
         {
            this.capturedTarget.icon = param1.icon;
         }
         this.onCaptureUpdated.fire();
      }
      
      private function visibleInfoCapturedTarget(param1:Boolean) : void
      {
         this.isVisible = param1;
         if(!this.isVisible)
         {
            this.capturedTarget.clear();
            this.updateDamageTarget.fire();
         }
         this.onVisibilityChanged.fire();
      }
      
      private function initInfoCapturedTarget(param1:Object) : void
      {
         this.capturedTarget.setData(param1);
         this.capturedTarget.clear();
         this.updateDamageTarget.fire();
         this.onCaptureUpdated.fire();
      }
   }
}
