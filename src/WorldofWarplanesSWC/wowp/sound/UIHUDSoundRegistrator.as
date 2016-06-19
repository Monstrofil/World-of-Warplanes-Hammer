package wowp.sound
{
   import flash.events.MouseEvent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.controls.DropdownMenu;
   import wowp.controls.ButtonEx;
   
   public class UIHUDSoundRegistrator
   {
       
      public function UIHUDSoundRegistrator()
      {
         super();
      }
      
      public static function register() : void
      {
         var _loc1_:Array = [MouseEvent.ROLL_OVER,UISoundConstants.UI_SOUND_HOVER];
         var _loc2_:Array = [ButtonEvent.CLICK,UISoundConstants.UI_SOUND_LIST_CLICK];
         var _loc3_:Array = [ButtonEvent.CLICK,UISoundConstants.UI_SOUND_CLICK];
         var _loc4_:Array = [MouseEvent.CLICK,UISoundConstants.UI_SOUND_CLICK];
         var _loc5_:Array = [MouseEvent.MOUSE_DOWN,UISoundConstants.UI_SOUND_CLICK];
         var _loc6_:Array = [ButtonEvent.PRESS,UISoundConstants.UI_SOUND_LIST_CLICK];
         reg([_loc1_,_loc3_],null,"comBtnGlassCarousel");
         reg([_loc1_,_loc3_],null,"comBtnScr");
         reg([_loc1_,_loc3_],null,"comBtn");
         reg([_loc1_,_loc3_],null,"comBtnRefresh");
         reg([_loc1_,_loc3_],null,"comBtnSmall");
         reg([_loc1_,_loc4_],null,"comListItemRenderer");
         reg([_loc1_,_loc3_],null,"comWindowBtnClose");
         reg([_loc1_,_loc3_],"nextBtn");
         reg([_loc1_,_loc3_],"prevBtn");
         reg([_loc1_,_loc4_],null,"comBtnRadio");
         reg([_loc1_,_loc4_],null,"comCheckBox");
         reg([_loc1_],null,"comDropdown");
         reg([_loc2_],null,null,DropdownMenu);
         reg([_loc1_,_loc4_],null,"comListItemRendererDropdown");
         reg([_loc1_,_loc4_],null,"comSettingsCheckBoxGrey");
         reg([_loc1_,_loc3_],null,"comBtnOptionLeft");
         reg([_loc1_,_loc3_],null,"comBtnOptionRight");
         reg([_loc1_,_loc3_],null,"comBtnLeftRight");
         reg([_loc1_,_loc4_],null,"comBtnSettingsKey");
         reg([_loc1_,_loc3_],null,"comBtnClose");
         reg([_loc1_,_loc4_],null,"comSettingsBtnRadio");
         reg([_loc1_,_loc3_],null,"settingsTabLong");
         reg([_loc1_,_loc3_],null,"comTab");
         reg([_loc1_,_loc3_],null,"comMenuBarBigButton");
         reg([_loc1_,_loc3_],null,"comMenuBarSmallButton");
         reg([_loc1_,_loc3_],null,"comMenuBarAlphaButton");
         reg([_loc1_,_loc3_],null,"comBtnGlassRefresh");
         reg([_loc1_],null,"Circle");
         reg([_loc1_,_loc3_],null,null,ButtonEx);
         reg([_loc1_,_loc3_],null,"comListItemRendererMenu");
         reg([_loc1_,_loc3_],null,"WOTTeamLeftListItemInstance");
         reg([_loc1_,_loc3_],null,"WOTTeamRightListItemInstance");
         reg([_loc1_,_loc3_],null,"comTabStats");
         reg([_loc1_,_loc3_],null,"comBtnLeft");
         reg([_loc1_,_loc3_],null,"comBtnRight");
         reg([_loc1_,_loc3_],null,"listItemRendererLeft");
         reg([_loc1_,_loc3_],null,"listItemRendererRight");
         reg([_loc1_,_loc3_],null,"comBtnBig");
         reg([_loc1_,_loc3_],null,"comBtnSelect");
         reg([_loc1_,_loc3_],null,"btnHome");
         reg([_loc1_,_loc3_],null,"btnForward");
         reg([_loc1_,_loc3_],null,"btnEnd");
         reg([_loc1_,_loc3_],null,"btnIncrease");
         reg([_loc1_,_loc3_],null,"btnPlay");
         reg([_loc1_,_loc3_],null,"btnDecrease");
         reg([_loc1_,_loc3_],null,"btnBack");
         reg([_loc1_,_loc3_],null,"btnPause");
      }
      
      private static function reg(param1:Array, param2:String = null, param3:String = null, param4:Class = null) : void
      {
         var _loc5_:Array = null;
         for each(_loc5_ in param1)
         {
            UISound.instanse.register(_loc5_[0],_loc5_[1],param2,param3,param4);
         }
      }
   }
}
