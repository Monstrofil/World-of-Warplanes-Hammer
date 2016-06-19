package wowp.controls
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import scaleform.clik.utils.Padding;
   import scaleform.clik.controls.Label;
   import flash.text.TextFieldAutoSize;
   import wowp.core.LocalizationManager;
   import scaleform.gfx.TextFieldEx;
   import wowp.utils.domain.getDefinition;
   
   public class UIFactoryToolTip extends Sprite
   {
       
      private var _textField:TextField;
      
      private var _bg:Sprite;
      
      private var _padding:Padding;
      
      public function UIFactoryToolTip(param1:String = "", param2:Boolean = true, param3:Number = 25, param4:Array = null, param5:int = 0)
      {
         super();
         mouseEnabled = mouseChildren = false;
         this._padding = new Padding(param3,param3,param3,param3);
         this.updateText(param1,param2,param4,param5);
      }
      
      public function updateText(param1:String = "", param2:Boolean = true, param3:Array = null, param4:int = 0) : void
      {
         var _loc5_:Label = null;
         var _loc6_:Object = null;
         if(param1 != "" && param1 != null)
         {
            this.updateBg();
            if(!this._textField)
            {
               this._textField = UIFactory.createLabel("").textField;
               this._textField.multiline = true;
               this._textField.autoSize = TextFieldAutoSize.LEFT;
               if(param4 > 0)
               {
                  this._textField.wordWrap = true;
                  this._textField.width = param4;
               }
               addChild(this._textField);
            }
            if(param2)
            {
               this._textField.htmlText = LocalizationManager.getInstance().textByLocalizationID(param1);
            }
            else
            {
               this._textField.htmlText = param1;
            }
            if(param3 != null)
            {
               for each(_loc6_ in param3)
               {
                  TextFieldEx.setImageSubstitutions(this._textField,_loc6_);
               }
            }
            this._bg.width = this._padding.horizontal + this._textField.width;
            this._bg.height = this._padding.vertical + this._textField.height;
            this._textField.x = this._padding.left;
            this._textField.y = this._padding.top;
         }
      }
      
      private function updateBg() : void
      {
         if(!this._bg)
         {
            this._bg = new (getDefinition("comBgModulesExtended") as Class)();
            addChild(this._bg);
         }
      }
   }
}
