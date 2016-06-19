package wowp.account.constants
{
   import wowp.controls.picker.HangarColor;
   import wowp.utils.domain.getDefinition;
   
   public class ColorConstants
   {
      
      private static var _colors:HangarColor;
       
      public function ColorConstants()
      {
         super();
      }
      
      public static function get GOLD() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtGold.textColor;
      }
      
      public static function get GOLD_DISABLED() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtGoldDisabled.textColor;
      }
      
      public static function get CREDITS() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtCredits.textColor;
      }
      
      public static function get CREDITS_DISABLED() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtCreditsDisabled.textColor;
      }
      
      public static function get PREMIUM() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtPremium.textColor;
      }
      
      public static function get PREMIUM_DISABLED() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtPremiumDisabled.textColor;
      }
      
      public static function get FREE_EXP() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtFreeExp.textColor;
      }
      
      public static function get FREE_EXP_DISABLED() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtFreeExpDisabled.textColor;
      }
      
      public static function get EXP() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtExp.textColor;
      }
      
      public static function get EXP_DISABLED() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtExpDisabled.textColor;
      }
      
      public static function get ELITE_EXP() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtEliteExp.textColor;
      }
      
      public static function get ELITE_DISABLED() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtEliteExpDisabled.textColor;
      }
      
      public static function get RED() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtRed.textColor;
      }
      
      public static function get YELLOW() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtYellow.textColor;
      }
      
      public static function get GREEN() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtGreen.textColor;
      }
      
      public static function get BLUE() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtBlue.textColor;
      }
      
      public static function get TICKET() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtTicket.textColor;
      }
      
      public static function get TICKET_DISABLED() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtTicketDisabled.textColor;
      }
      
      public static function get CREW_WHITE() : uint
      {
         return 15921906;
      }
      
      public static function get CREW_WHITE_DISABLED() : uint
      {
         return 9146777;
      }
      
      public static function get CREW_TXT_DISABLED() : uint
      {
         return 5067350;
      }
      
      public static function get CREW_GOLD() : uint
      {
         return 16766334;
      }
      
      public static function get XP_FACTOR() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtXPFactor.textColor;
      }
      
      public static function get XP_FACTOR_DISABLED() : uint
      {
         if(_colors == null)
         {
            init();
         }
         return _colors.txtXPFactorDisabled.textColor;
      }
      
      private static function init() : void
      {
         _colors = new getDefinition("HangarColorClass")() as HangarColor;
      }
   }
}
