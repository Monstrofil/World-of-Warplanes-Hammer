package wowp.controls
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import wowp.utils.domain.getDefinition;
   
   public class CostConfirmation extends MovieClip
   {
      
      private static const ITEM_RENDERER:String = "comCostConfirmationItemRenderer";
      
      private static const ICON_EXP:String = "experience";
      
      private static const ICON_FREE_EXP:String = "free_experience";
      
      private static const ICON_CREDITS:String = "credits";
      
      private static const ICON_GOLD:String = "gold";
      
      private static var _order:Array = [ICON_EXP,ICON_FREE_EXP,ICON_CREDITS,ICON_GOLD];
       
      public var mcRightHolder:MovieClip;
      
      public var mcHolder:MovieClip;
      
      public var textField:TextField;
      
      public var isEnoughXP:Boolean = true;
      
      public var isEnoughCredits:Boolean = true;
      
      public var isEnoughGold:Boolean = true;
      
      public function CostConfirmation()
      {
         super();
      }
      
      public function setMessage(param1:String) : void
      {
         this.textField.text = param1;
      }
      
      public function setInfo(param1:String, param2:int, param3:int, param4:int, param5:int, param6:Boolean, param7:int, param8:int, param9:int) : void
      {
         var _loc13_:int = 0;
         var _loc14_:CostConfirmationItemRenderer = null;
         var _loc18_:String = null;
         this.setMessage(param1);
         this.isEnoughXP = param9 < 0 || param9 >= param4 + param5;
         this.isEnoughCredits = param8 < 0 || param8 >= param2;
         this.isEnoughGold = param7 < 0 || param7 >= param3;
         var _loc10_:Object = {};
         _loc10_[ICON_EXP] = [param4,"MESSAGE_EXPLORATION",this.isEnoughXP];
         _loc10_[ICON_FREE_EXP] = [param5,"MESSAGE_EXPLORATION",this.isEnoughXP];
         _loc10_[ICON_CREDITS] = [param2,"MESSAGE_PURCHASE",this.isEnoughCredits];
         _loc10_[ICON_GOLD] = [param3,"MESSAGE_PURCHASE",this.isEnoughGold];
         var _loc11_:Number = this.textField.width;
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         _loc11_ = Math.round(this.textField.width - _loc11_);
         if(_loc11_ > 0)
         {
            this.textField.width = this.textField.width + _loc11_;
            this.mcRightHolder.x = this.mcRightHolder.x + _loc11_;
         }
         var _loc12_:int = _order.length;
         var _loc15_:Class = getDefinition(ITEM_RENDERER,loaderInfo);
         var _loc16_:Number = 0;
         var _loc17_:Array = [];
         var _loc19_:MovieClip = this.mcHolder;
         if(param6)
         {
            _loc19_ = this.mcRightHolder;
         }
         _loc13_ = 0;
         while(_loc13_ < _loc12_)
         {
            if(_loc10_[_order[_loc13_]][0] > 0 || _loc13_ == 2 && _loc16_ == 0 && _loc10_[ICON_GOLD][0] == 0)
            {
               _loc14_ = new _loc15_();
               _loc14_.name = "cost" + _loc13_;
               _loc18_ = _loc10_[_order[_loc13_]][1];
               if(_loc17_.indexOf(_loc18_) >= 0 || Boolean(param6))
               {
                  _loc18_ = "";
               }
               else
               {
                  _loc17_.push(_loc18_);
               }
               _loc14_.setData(_order[_loc13_],String(_loc10_[_order[_loc13_]][0]),_loc18_,_loc10_[_order[_loc13_]][2]);
               _loc19_.addChild(_loc14_);
               _loc14_.y = _loc16_;
               _loc16_ = _loc16_ + _loc14_.height;
            }
            _loc13_++;
         }
      }
   }
}
