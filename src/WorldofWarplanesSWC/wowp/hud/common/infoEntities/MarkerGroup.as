package wowp.hud.common.infoEntities
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class MarkerGroup extends MovieClip
   {
       
      private const SCALE_NORMAL:Number = 1.0;
      
      private const SCALE_MEDIUM:Number = 0.75;
      
      private const SCALE_SMALL:Number = 0.6;
      
      private const ALPHA_NORMAL:Number = 1.0;
      
      private const ALPHA_MEDIUM:Number = 1.0;
      
      private const ALPHA_SMALL:Number = 0.5;
      
      private const STATE_RANGE_UNDEF:int = -1;
      
      private const STATE_RANGE_NEAR:int = 0;
      
      private const STATE_RANGE_MIDDLE:int = 1;
      
      private const STATE_RANGE_FAR:int = 2;
      
      public var txtName:TextField;
      
      public var mcSmall:MovieClip;
      
      public var mcMedium:MovieClip;
      
      public var mcNormal:MovieClip;
      
      private var _currentEntityState:int;
      
      public function MarkerGroup()
      {
         super();
      }
      
      public function Marker() : *
      {
         this._currentEntityState = this.STATE_RANGE_UNDEF;
      }
      
      public function resetEntity(param1:Boolean) : void
      {
         visible = false;
      }
      
      public function setDistanceState(param1:int = -1) : void
      {
         if(param1 != this.STATE_RANGE_UNDEF)
         {
            this._currentEntityState = param1;
         }
         switch(this._currentEntityState)
         {
            case this.STATE_RANGE_NEAR:
               this.changeSizeIcon("normal");
               alpha = this.ALPHA_NORMAL;
               break;
            case this.STATE_RANGE_MIDDLE:
               this.changeSizeIcon("medium");
               alpha = this.ALPHA_MEDIUM;
               break;
            case this.STATE_RANGE_FAR:
               this.changeSizeIcon("small");
               alpha = this.ALPHA_SMALL;
         }
      }
      
      public function changeSizeIcon(param1:String) : void
      {
         this.mcSmall.visible = false;
         this.mcMedium.visible = false;
         this.mcNormal.visible = false;
         switch(param1)
         {
            case "small":
               this.mcSmall.visible = true;
               break;
            case "medium":
               this.mcMedium.visible = true;
               break;
            case "normal":
               this.mcNormal.visible = true;
         }
      }
      
      public function initEntity(param1:Object) : void
      {
         if(param1.iconIndex)
         {
            gotoAndStop(param1.iconIndex);
            this.mcSmall.gotoAndStop(param1.iconIndex);
            this.mcMedium.gotoAndStop(param1.iconIndex);
            this.mcNormal.gotoAndStop(param1.iconIndex);
            this.changeSizeIcon("normal");
         }
         if(param1.text)
         {
            this.txtName.text = param1.text;
         }
         this.setDistanceState();
      }
      
      public function updateEntity(param1:Object) : void
      {
         this.initEntity(param1);
      }
   }
}
