package wowp.hud.model.skills
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import flash.geom.Rectangle;
   
   public class HUDSkillsModel extends HUDModelComponent
   {
       
      private var _onActiveSkill:Signal;
      
      private var _onSituationalPilot:Signal;
      
      private var _onUpdateViewSize:Signal;
      
      private var _situationalSkills:Array;
      
      private var _viewSize:Rectangle;
      
      public function HUDSkillsModel()
      {
         super();
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.uniqueSkillStateChanged",this.onActiveSkillHandler);
         backend.addCallback("hud.situationalPilotSkills",this.onSituationalPilotHandler);
         backend.call("hud.getSituationalPilotSkills");
      }
      
      private function onActiveSkillHandler(param1:int, param2:Boolean) : void
      {
         if(this._onActiveSkill)
         {
            this._onActiveSkill.fire(param1,param2);
         }
      }
      
      private function onSituationalPilotHandler(param1:Array) : void
      {
         this._situationalSkills = param1;
         if(this._onSituationalPilot)
         {
            this._onSituationalPilot.fire(param1);
         }
      }
      
      public function get onActiveSkill() : Signal
      {
         if(!this._onActiveSkill)
         {
            this._onActiveSkill = new Signal();
         }
         return this._onActiveSkill;
      }
      
      override protected function onDispose() : void
      {
         if(this._onActiveSkill)
         {
            this._onActiveSkill.dispose();
            this._onActiveSkill = null;
         }
         if(this._onSituationalPilot)
         {
            this._onSituationalPilot.dispose();
            this._onSituationalPilot = null;
         }
         backend.addCallback("hud.uniqueSkillStateChanged",null);
         backend.addCallback("hud.situationalPilotSkills",null);
      }
      
      public function get onSituationalPilot() : Signal
      {
         if(!this._onSituationalPilot)
         {
            this._onSituationalPilot = new Signal();
         }
         return this._onSituationalPilot;
      }
      
      public function get situationalSkills() : Array
      {
         return this._situationalSkills;
      }
      
      public function get viewSize() : Rectangle
      {
         if(!this._viewSize)
         {
            return new Rectangle();
         }
         return this._viewSize;
      }
      
      public function set viewSize(param1:Rectangle) : void
      {
         this._viewSize = param1;
         if(this._onUpdateViewSize)
         {
            this._onUpdateViewSize.fire();
         }
      }
      
      public function get onUpdateViewSize() : Signal
      {
         if(!this._onUpdateViewSize)
         {
            this._onUpdateViewSize = new Signal();
         }
         return this._onUpdateViewSize;
      }
   }
}
