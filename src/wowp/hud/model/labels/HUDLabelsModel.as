package wowp.hud.model.labels
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.hud.model.labels.events.HUDLabelEvent;
   
   public class HUDLabelsModel extends HUDModelComponent
   {
      
      public static const LABEL_EVENT_TYPE_PREFIX:String = "wowp.hud.model.labels.HUDLabeslModel.LABEL_EVENT_TYPE_PREFIX_";
       
      private var _labelsHash:Object;
      
      public function HUDLabelsModel()
      {
         this._labelsHash = {};
         super();
      }
      
      public function setText(param1:String, param2:String = "") : void
      {
         this._labelsHash[param1] = param2;
      }
      
      public function getText(param1:String) : String
      {
         var _loc2_:String = this._labelsHash[param1];
         return !!_loc2_?_loc2_:"";
      }
      
      public function clearText(param1:String) : void
      {
         this._labelsHash[param1] = "";
      }
      
      override protected function onInit() : void
      {
         backend.addCallback("hud.labelSetText",this.setLabelText);
         backend.addCallback("hud.labelClearText",this.clearLabelText);
      }
      
      private function setLabelText(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = param1.text;
         var _loc3_:String = param1.id;
         this.setText(_loc3_,_loc2_);
         dispatchEvent(new HUDLabelEvent(LABEL_EVENT_TYPE_PREFIX + _loc3_,_loc2_));
      }
      
      private function clearLabelText(param1:String) : void
      {
         this.setText(param1,"");
         dispatchEvent(new HUDLabelEvent(LABEL_EVENT_TYPE_PREFIX + param1));
      }
   }
}
