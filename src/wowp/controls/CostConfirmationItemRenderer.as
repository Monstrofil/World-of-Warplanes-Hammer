package wowp.controls
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import wowp.utils.string.stringAddSeparator;
   import wowp.utils.string.paint;
   import wowp.account.constants.ColorConstants;
   import flash.text.TextFieldAutoSize;
   
   public class CostConfirmationItemRenderer extends UIComponent
   {
      
      private static const STATE_AVAIL:String = "available";
      
      private static const STATE_UNAVAIL:String = "unavailable";
      
      private static const ICON_EXP:String = "experience";
      
      private static const ICON_FREE_EXP:String = "free_experience";
      
      private static const ICON_CREDITS:String = "credits";
      
      private static const ICON_GOLD:String = "gold";
       
      public var textField:TextField;
      
      public var prompt:TextField;
      
      public var mcIcon:MovieClip;
      
      public function CostConfirmationItemRenderer()
      {
         super();
      }
      
      public function setData(param1:String, param2:String, param3:String, param4:Boolean) : void
      {
         trace("CostConfirmationItemRenderer::setData:",param1,param2,param3,param4);
         if(!param4)
         {
            gotoAndStop(STATE_UNAVAIL);
         }
         else
         {
            gotoAndStop(STATE_AVAIL);
         }
         this.prompt.text = param3;
         this.mcIcon.gotoAndStop(param1);
         var _loc5_:String = stringAddSeparator(param2," ");
         if(param4)
         {
            switch(param1)
            {
               case ICON_EXP:
                  _loc5_ = paint(stringAddSeparator(param2," "),ColorConstants.EXP);
                  break;
               case ICON_FREE_EXP:
                  _loc5_ = paint(stringAddSeparator(param2," "),ColorConstants.FREE_EXP);
                  break;
               case ICON_CREDITS:
                  _loc5_ = paint(stringAddSeparator(param2," "),ColorConstants.CREDITS);
                  break;
               case ICON_GOLD:
                  _loc5_ = paint(stringAddSeparator(param2," "),ColorConstants.GOLD);
            }
         }
         this.textField.htmlText = _loc5_;
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.mcIcon.x = this.textField.textWidth + 3;
      }
   }
}
