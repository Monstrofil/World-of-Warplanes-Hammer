package wowp.hud.common.infoEntities
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import wowp.utils.display.BitmapLoader;
   import flash.utils.Timer;
   import flash.geom.Point;
   import flash.events.TimerEvent;
   import wowp.utils.string.cutTextfieldName;
   import flash.filters.ColorMatrixFilter;
   import flash.events.Event;
   import wowp.hud.model.players.vo.HUDPlayerVO;
   import wowp.utils.Utils;
   
   public class Marker extends MovieClip
   {
      
      private static const DELTA_HP_ALPHA:Number = 0.02;
      
      private static const DELTA_CMD_ALPHA:Number = 0.005;
      
      public static const DELTA_ICON_BLINK:Number = 0.5;
      
      public static const MAX_ICON_BLINK:Number = 1;
      
      private static const PROGRESS_ALPHA_MAX:Number = 1;
      
      private static const PROGRESS_ALPHA_MIN:Number = 0.5;
      
      private static const ICON_ALPHA_MAX:Number = 1;
      
      private static const ICON_ALPHA_MIN:Number = 0.7;
      
      private static const ICON_HEIGHT:int = 16;
      
      private static const COUNT_TYPES_PLANES:int = 4;
      
      private static const COLOR_OFFSET_HFIGHTER:Array = [-56,-51,-20];
      
      private static const COLOR_OFFSET_ASSAULT:Array = [-43,-64,-85];
      
      private static const MULTIPLIER_OFFSET:Number = 0.85;
      
      private static const POS_OFFSET_HEALTH:int = -3;
      
      private static const POS_OFFSET_DISTANCE:int = -4;
      
      private static const POS_OFFSET_PLAYER_NAME:int = -4;
      
      private static const POS_OFFSET_ENTITY_NAME:int = -4;
      
      private static const POS_OFFSET_PLANE:int = -1;
      
      private static const POS_OFFSET_NUMBER:int = -4;
       
      public var txtPlaneLevel:TextField;
      
      public var txtNumber:TextField;
      
      public var mcEntityName:MovieClip;
      
      public var mcPlayerName:MovieClip;
      
      public var mcCommand:MovieClip;
      
      public var iconLoader:BitmapLoader;
      
      public var mcIcon:MovieClip;
      
      public var mcDistance:MovieClip;
      
      public var mcHealthBar:MovieClip;
      
      public var mcMarkerPlane:MovieClip;
      
      public var distance:int = 0;
      
      private var dirBlink:int;
      
      private var valueBlink:Number;
      
      private var entityId:int;
      
      private var sideType:int;
      
      private var planeLevel:String;
      
      private var entityName:String;
      
      private var playerName:String;
      
      private var entityType:int;
      
      private var targetType:int;
      
      private var health:Number;
      
      private var maxHealth:Number;
      
      private var planeNumber:String;
      
      private var planeIconPath:String;
      
      private var isVisibleHealthBarAlt:Boolean;
      
      private var isVisibleHealthBarBasic:Boolean;
      
      private var isVisibleHealthBarValueAlt:Boolean;
      
      private var isVisibleHealthBarValueBasic:Boolean;
      
      private var isVisibleHealthBarTxtHealthAlt:Boolean;
      
      private var isVisibleHealthBarTxtHealthBasic:Boolean;
      
      private var isVisibleDistanceAlt:Boolean;
      
      private var isVisibleDistanceBasic:Boolean;
      
      private var isVisibleNumberAlt:Boolean;
      
      private var isVisibleNumberBasic:Boolean;
      
      private var isVisibleEntityNameAlt:Boolean;
      
      private var isVisibleEntityNameBasic:Boolean;
      
      private var isVisiblePlayerNameAlt:Boolean;
      
      private var isVisiblePlayerNameBasic:Boolean;
      
      private var isVisibleIconLoaderAlt:Boolean;
      
      private var isVisibleIconLoaderBasic:Boolean;
      
      private var isVisiblePlaneLevelAlt:Boolean;
      
      private var isVisiblePlaneLevelBasic:Boolean;
      
      private var isVisibleIconAlt:Boolean;
      
      private var isVisibleIconBasic:Boolean;
      
      private var altStrengthIndicatorType:Boolean;
      
      private var basicStrengthIndicatorType:Boolean;
      
      private var basicScaleIconType:int = 0;
      
      private var altScaleIconType:int = 0;
      
      private var _posY:int = -10;
      
      private var _posAltY:int;
      
      private var _posBasicY:int;
      
      private var _isAltEnable:Boolean = false;
      
      private var _isAlternativeColor:Boolean = false;
      
      private var _isTargetMarker:Boolean = false;
      
      private var yDistanceAlt:int;
      
      private var yDistanceBasic:int;
      
      private var yIconAlt:int;
      
      private var yIconBasic:int;
      
      private var yNumberAlt:int;
      
      private var yNumberBasic:int;
      
      private var yEntityNameAlt:int;
      
      private var yEntityNameBasic:int;
      
      private var yPlayerNameAlt:int;
      
      private var yPlayerNameBasic:int;
      
      private var yIconLoaderAlt:int;
      
      private var yIconLoaderBasic:int;
      
      private var yPlaneLevelAlt:int;
      
      private var yPlaneLevelBasic:int;
      
      private var yCommandAlt:int;
      
      private var yCommandBasic:int;
      
      private var yHealthBarAlt:int;
      
      private var yHealthBarBasic:int;
      
      private var _updateTimeHp:Timer;
      
      private var _updateTimeBlink:Timer;
      
      private var _updateTimeCommand:Timer;
      
      public var markerWidth:int = 0;
      
      public var markerHeight:int = 0;
      
      private var _xyMcAnimHP:Point;
      
      public var _myID:Number;
      
      private var _previewModules:Array;
      
      private var _critModules:Array;
      
      private var _timeBlink:Number = 0;
      
      private var _elementsMarkerDamage:Array;
      
      private var _basePosBig:Point;
      
      private var _basePosSmall:Point;
      
      private var _baseTextPosBig:Point;
      
      private var _baseTextPosSmall:Point;
      
      private var _needPosition:Point;
      
      private var _isTarget:Boolean = false;
      
      public function Marker(param1:int)
      {
         this._xyMcAnimHP = new Point(-50,0);
         this._critModules = [];
         this._elementsMarkerDamage = [];
         this._basePosBig = new Point(-22,-6);
         this._basePosSmall = new Point(-6,1);
         this._baseTextPosBig = new Point(-6,-7);
         this._baseTextPosSmall = new Point(1,5);
         this._needPosition = this._basePosSmall;
         super();
         this._posY = -param1;
         this._myID = Math.random();
         this._updateTimeHp = new Timer(40,51);
         this._updateTimeHp.addEventListener(TimerEvent.TIMER,this.updateTimeHp);
         this._updateTimeBlink = new Timer(40,5);
         this._updateTimeBlink.addEventListener(TimerEvent.TIMER,this.updateTimeBlink);
         this._updateTimeCommand = new Timer(40,201);
         this._updateTimeCommand.addEventListener(TimerEvent.TIMER,this.updateTimeCommand);
      }
      
      public function dispose() : void
      {
         this._updateTimeHp.stop();
         this._updateTimeHp.removeEventListener(TimerEvent.TIMER,this.updateTimeHp);
         this._updateTimeBlink.stop();
         this._updateTimeBlink.removeEventListener(TimerEvent.TIMER,this.updateTimeBlink);
         this._updateTimeCommand.stop();
         this._updateTimeCommand.removeEventListener(TimerEvent.TIMER,this.updateTimeCommand);
         this._previewModules = null;
         this.clearCritMarkers();
      }
      
      public function set isAltEnable(param1:Boolean) : void
      {
         this._isAltEnable = param1;
      }
      
      public function set isTargetMarker(param1:Boolean) : void
      {
         this._isTargetMarker = param1;
      }
      
      public function resetEntity() : void
      {
         visible = false;
         this.mcHealthBar.txtHp.alpha = 0;
         this.dirBlink = 0;
         this.valueBlink = 0;
         this.clearBlink();
         this.mcCommand.alpha = 0;
         this.clearMarkersDamage();
      }
      
      public function altPressed() : void
      {
         if(this.mcHealthBar)
         {
            this.mcHealthBar.txtHealth.visible = !!this._isAltEnable?this.isVisibleHealthBarTxtHealthAlt:this.isVisibleHealthBarTxtHealthBasic;
            this.mcHealthBar.visible = !!this._isAltEnable?Boolean(this.isVisibleHealthBarAlt):Boolean(this.isVisibleHealthBarBasic);
            this.mcHealthBar.y = !!this._isAltEnable?Number(this.yHealthBarAlt):Number(this.yHealthBarBasic);
            this.setProgressVisible(!!this._isAltEnable?Boolean(this.isVisibleHealthBarValueAlt):Boolean(this.isVisibleHealthBarValueBasic));
            this.setHealth(this.health);
         }
         if(this.mcDistance)
         {
            this.mcDistance.visible = !!this._isAltEnable?Boolean(this.isVisibleDistanceAlt):Boolean(this.isVisibleDistanceBasic);
            this.mcDistance.y = !!this._isAltEnable?Number(this.yDistanceAlt):Number(this.yDistanceBasic);
         }
         if(this.mcIcon)
         {
            this.mcIcon.visible = !!this._isAltEnable?Boolean(this.isVisibleIconAlt):Boolean(this.isVisibleIconBasic);
            this.mcIcon.y = !!this._isAltEnable?Number(this.yIconAlt):Number(this.yIconBasic);
         }
         if(this.txtNumber)
         {
            this.txtNumber.visible = !!this._isAltEnable?Boolean(this.isVisibleNumberAlt):Boolean(this.isVisibleNumberBasic);
            this.txtNumber.y = !!this._isAltEnable?Number(this.yNumberAlt):Number(this.yNumberBasic);
         }
         if(this.mcEntityName)
         {
            this.mcEntityName.visible = !!this._isAltEnable?Boolean(this.isVisibleEntityNameAlt):Boolean(this.isVisibleEntityNameBasic);
            this.mcEntityName.y = !!this._isAltEnable?Number(this.yEntityNameAlt):Number(this.yEntityNameBasic);
         }
         if(this.mcPlayerName)
         {
            this.mcPlayerName.visible = !!this._isAltEnable?Boolean(this.isVisiblePlayerNameAlt):Boolean(this.isVisiblePlayerNameBasic);
            this.mcPlayerName.y = !!this._isAltEnable?Number(this.yPlayerNameAlt):Number(this.yPlayerNameBasic);
         }
         if(Boolean(this.iconLoader) && Boolean(this.txtPlaneLevel))
         {
            this.iconLoader.visible = !!this._isAltEnable?Boolean(this.isVisibleIconLoaderAlt):Boolean(this.isVisibleIconLoaderBasic);
            this.iconLoader.y = !!this._isAltEnable?Number(this.yIconLoaderAlt):Number(this.yIconLoaderBasic);
            this.txtPlaneLevel.visible = !!this._isAltEnable?Boolean(this.isVisiblePlaneLevelAlt):Boolean(this.isVisiblePlaneLevelBasic);
            this.txtPlaneLevel.y = !!this._isAltEnable?Number(this.yPlaneLevelAlt):Number(this.yPlaneLevelBasic);
         }
         if(this.mcCommand)
         {
            this.mcCommand.y = !!this._isAltEnable?Number(this.yCommandAlt):Number(this.yCommandBasic);
         }
         if(Boolean(this._isAltEnable) || Boolean(this._isTargetMarker))
         {
            this.mcHealthBar.progress.alpha = !!this._isTargetMarker?PROGRESS_ALPHA_MAX:PROGRESS_ALPHA_MIN;
            this.mcHealthBar.progressSmall.alpha = !!this._isTargetMarker?PROGRESS_ALPHA_MAX:PROGRESS_ALPHA_MIN;
            this.mcIcon.alpha = ICON_ALPHA_MAX;
         }
         else
         {
            this.mcHealthBar.progress.alpha = PROGRESS_ALPHA_MIN;
            this.mcHealthBar.progressSmall.alpha = PROGRESS_ALPHA_MIN;
            this.mcIcon.alpha = this.sideType == 2?Number(ICON_ALPHA_MIN):Number(ICON_ALPHA_MAX);
         }
         this.setScaleIcon(!!this._isAltEnable?int(this.altScaleIconType):int(this.basicScaleIconType));
         this.repositionCritDamage();
      }
      
      public function changeHealthBarColor() : void
      {
         if(this._isAlternativeColor)
         {
            if(this.mcHealthBar.progress.currentFrame == 1)
            {
               this.mcHealthBar.progress.gotoAndStop(4);
            }
            else if(this.mcHealthBar.progress.currentFrame == 3)
            {
               this.mcHealthBar.progress.gotoAndStop(5);
            }
            if(this.mcHealthBar.progressSmall.currentFrame == 1)
            {
               this.mcHealthBar.progressSmall.gotoAndStop(4);
            }
            else if(this.mcHealthBar.progressSmall.currentFrame == 3)
            {
               this.mcHealthBar.progressSmall.gotoAndStop(5);
            }
         }
         else
         {
            if(this.mcHealthBar.progress.currentFrame == 4)
            {
               this.mcHealthBar.progress.gotoAndStop(1);
            }
            else if(this.mcHealthBar.progress.currentFrame == 5)
            {
               this.mcHealthBar.progress.gotoAndStop(3);
            }
            if(this.mcHealthBar.progressSmall.currentFrame == 4)
            {
               this.mcHealthBar.progressSmall.gotoAndStop(1);
            }
            else if(this.mcHealthBar.progressSmall.currentFrame == 5)
            {
               this.mcHealthBar.progressSmall.gotoAndStop(3);
            }
         }
      }
      
      public function changeEntityNameColor() : void
      {
         if(this._isAlternativeColor)
         {
            if(this.mcEntityName.currentFrame == 1)
            {
               this.mcEntityName.gotoAndStop(4);
               this.mcEntityName.txtName.text = this.entityName;
            }
            else if(this.mcEntityName.currentFrame == 3)
            {
               this.mcEntityName.gotoAndStop(5);
               this.mcEntityName.txtName.text = this.entityName;
            }
         }
         else if(this.mcEntityName.currentFrame == 4)
         {
            this.mcEntityName.gotoAndStop(1);
            this.mcEntityName.txtName.text = this.entityName;
         }
         else if(this.mcEntityName.currentFrame == 5)
         {
            this.mcEntityName.gotoAndStop(3);
            this.mcEntityName.txtName.text = this.entityName;
         }
      }
      
      public function changePlayerNameColor() : void
      {
         if(this._isAlternativeColor)
         {
            if(this.mcPlayerName.currentFrame == 1)
            {
               this.mcPlayerName.gotoAndStop(4);
               cutTextfieldName(this.mcPlayerName.txtName,this.playerName);
            }
            else if(this.mcPlayerName.currentFrame == 3)
            {
               this.mcPlayerName.gotoAndStop(5);
               cutTextfieldName(this.mcPlayerName.txtName,this.playerName);
            }
         }
         else if(this.mcPlayerName.currentFrame == 4)
         {
            this.mcPlayerName.gotoAndStop(1);
            cutTextfieldName(this.mcPlayerName.txtName,this.playerName);
         }
         else if(this.mcPlayerName.currentFrame == 5)
         {
            this.mcPlayerName.gotoAndStop(3);
            cutTextfieldName(this.mcPlayerName.txtName,this.playerName);
         }
      }
      
      public function changeIconFrame(param1:MovieClip) : void
      {
         if(this._isAlternativeColor)
         {
            if(param1.currentFrame == 1)
            {
               param1.gotoAndStop(4);
            }
            else if(param1.currentFrame == 3)
            {
               param1.gotoAndStop(5);
            }
         }
         else if(param1.currentFrame == 4)
         {
            param1.gotoAndStop(1);
         }
         else if(param1.currentFrame == 5)
         {
            param1.gotoAndStop(3);
         }
      }
      
      public function changeIconColor() : void
      {
         this.changeIconFrame(this.mcIcon.big);
         this.changeIconFrame(this.mcIcon.normal);
         this.changeIconFrame(this.mcIcon.small);
      }
      
      public function setAlternativeColor(param1:Boolean) : void
      {
         var _loc2_:AnimMarkerCrit = null;
         this._isAlternativeColor = param1;
         this.changeHealthBarColor();
         this.changeEntityNameColor();
         this.changePlayerNameColor();
         this.changeIconColor();
         if(this._critModules == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._critModules.length)
         {
            _loc2_ = this._critModules[_loc3_];
            _loc2_.setAlternativeColor(this._isAlternativeColor);
            _loc3_++;
         }
      }
      
      public function updateTimeHp(param1:TimerEvent) : void
      {
         if(this.mcHealthBar.txtHp)
         {
            if(Boolean(this.mcHealthBar.txtHp.alpha) && this.mcHealthBar.txtHp.alpha > 0)
            {
               this.mcHealthBar.txtHp.alpha = this.mcHealthBar.txtHp.alpha - DELTA_HP_ALPHA;
               if(this.mcHealthBar.txtHp.alpha < 0)
               {
                  this.mcHealthBar.txtHp.alpha = 0;
                  this.mcHealthBar.txtHp.text = "";
               }
            }
         }
      }
      
      public function updateTimeBlink(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         if(this.mcIcon)
         {
            if(Boolean(this.dirBlink) && this.dirBlink != 0)
            {
               this.valueBlink = this.valueBlink + this.dirBlink * DELTA_ICON_BLINK;
               if(this.valueBlink >= MAX_ICON_BLINK)
               {
                  this.valueBlink = MAX_ICON_BLINK;
                  this.dirBlink = -this.dirBlink;
               }
               _loc2_ = this.valueBlink * 255;
               if(_loc2_ > 0)
               {
                  this.blink(_loc2_);
               }
               else
               {
                  this.dirBlink = 0;
                  this.clearBlink();
               }
            }
         }
      }
      
      private function blink(param1:int) : void
      {
         var _loc2_:Date = new Date();
         if(this._timeBlink + 150 > _loc2_.time)
         {
            return;
         }
         this._timeBlink = _loc2_.time;
         var _loc3_:ColorMatrixFilter = this.setBrightness(70);
         var _loc4_:ColorMatrixFilter = this.setBrightness(70);
         if(this.mcIcon)
         {
            this.mcIcon.filters = [_loc4_];
         }
         var _loc5_:MovieClip = null;
         if(Boolean(this.mcHealthBar) && Boolean(this.mcHealthBar.progress) && Boolean(this.mcHealthBar.progress.visible))
         {
            _loc5_ = this.mcHealthBar.progress;
         }
         if(Boolean(this.mcHealthBar) && Boolean(this.mcHealthBar.progressSmall) && Boolean(this.mcHealthBar.progressSmall.visible))
         {
            _loc5_ = this.mcHealthBar.progressSmall;
         }
         if(_loc5_)
         {
            if(this.sideType != 2)
            {
               _loc5_.filters = [_loc3_];
            }
         }
      }
      
      private function setBrightness(param1:Number) : ColorMatrixFilter
      {
         param1 = param1 * (255 / 250);
         var _loc2_:Array = new Array();
         _loc2_ = _loc2_.concat([1,0,0,0,param1]);
         _loc2_ = _loc2_.concat([0,1,0,0,param1]);
         _loc2_ = _loc2_.concat([0,0,1,0,param1]);
         _loc2_ = _loc2_.concat([0,0,0,1,0]);
         return new ColorMatrixFilter(_loc2_);
      }
      
      private function clearBlink() : void
      {
         if(this.mcIcon)
         {
            this.mcIcon.filters = [];
         }
         if(Boolean(this.mcHealthBar) && Boolean(this.mcHealthBar.progress))
         {
            this.mcHealthBar.progress.filters = [];
         }
         if(Boolean(this.mcHealthBar) && Boolean(this.mcHealthBar.progressSmall))
         {
            this.mcHealthBar.progressSmall.filters = [];
         }
      }
      
      public function updateTimeCommand(param1:TimerEvent) : void
      {
         if(this.mcCommand)
         {
            if(Boolean(this.mcCommand.alpha) && this.mcCommand.alpha > 0)
            {
               this.mcCommand.alpha = this.mcCommand.alpha - DELTA_CMD_ALPHA;
               if(this.mcCommand.alpha < 0)
               {
                  this.mcCommand.alpha = 0;
                  this.mcCommand.visible = false;
               }
            }
         }
         this.updateMcCommand();
      }
      
      public function calculateSize() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         this.markerWidth = 0;
         this.markerHeight = 0;
         var _loc1_:* = 0;
         while(_loc1_ < numChildren)
         {
            _loc2_ = getChildAt(_loc1_);
            if(_loc2_.visible)
            {
               if(_loc2_ == this.mcEntityName)
               {
                  _loc3_ = this.mcEntityName.txtName.textWidth;
               }
               else if(_loc2_ == this.mcPlayerName)
               {
                  _loc3_ = this.mcPlayerName.txtName.textWidth;
               }
               else
               {
                  _loc3_ = _loc2_.width;
               }
               if(this.markerWidth < _loc3_)
               {
                  this.markerWidth = _loc3_;
               }
               if(this.markerHeight < -_loc2_.y)
               {
                  this.markerHeight = -_loc2_.y;
               }
            }
            _loc1_++;
         }
      }
      
      public function setDistanceState(param1:int = 0) : void
      {
         this.altPressed();
         if(Boolean(this._isTargetMarker) && Boolean(this.entityType))
         {
            this.calculateSize();
         }
      }
      
      public function setProgressVisible(param1:Boolean) : void
      {
         if(param1)
         {
            if(this.mcHealthBar.txtHealth.visible)
            {
               this.mcHealthBar.progress.visible = true;
               this.mcHealthBar.progressSmall.visible = false;
               this.mcHealthBar.txtHp.x = this.mcHealthBar.progress.x + this.mcHealthBar.progress.width / 2;
            }
            else
            {
               this.mcHealthBar.progressSmall.visible = true;
               this.mcHealthBar.progress.visible = false;
               this.mcHealthBar.txtHp.x = this.mcHealthBar.progressSmall.x + this.mcHealthBar.progressSmall.width / 2;
            }
         }
         else
         {
            this.mcHealthBar.progress.visible = false;
            this.mcHealthBar.progressSmall.visible = false;
         }
      }
      
      public function addHealthBar(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         if(this.mcHealthBar)
         {
            this.mcHealthBar.progress.gotoAndStop(this.sideType);
            this.mcHealthBar.progressSmall.gotoAndStop(this.sideType);
            if(this._isAlternativeColor)
            {
               if(this.sideType == 1)
               {
                  this.mcHealthBar.progress.gotoAndStop(4);
                  this.mcHealthBar.progressSmall.gotoAndStop(4);
               }
               else if(this.sideType == 3)
               {
                  this.mcHealthBar.progress.gotoAndStop(5);
                  this.mcHealthBar.progressSmall.gotoAndStop(5);
               }
            }
            this.isVisibleHealthBarValueBasic = param1;
            this.isVisibleHealthBarTxtHealthBasic = param2;
            this.isVisibleHealthBarValueAlt = param3;
            this.isVisibleHealthBarTxtHealthAlt = param4;
            this.isVisibleHealthBarBasic = Boolean(param1) || Boolean(param2);
            this.isVisibleHealthBarAlt = Boolean(param3) || Boolean(param4);
            if(Boolean(param1) || Boolean(param2))
            {
               this._posBasicY = this._posBasicY - this.mcHealthBar.height;
               this.yHealthBarBasic = this._posBasicY;
               this._posBasicY = this._posBasicY - POS_OFFSET_HEALTH;
            }
            if(Boolean(param3) || Boolean(param4))
            {
               this._posAltY = this._posAltY - this.mcHealthBar.height;
               this.yHealthBarAlt = this._posAltY;
               this._posAltY = this._posAltY - POS_OFFSET_HEALTH;
            }
            this.mcHealthBar.txtHealth.visible = !!this._isAltEnable?this.isVisibleHealthBarTxtHealthAlt:this.isVisibleHealthBarTxtHealthBasic;
            this.mcHealthBar.visible = !!this._isAltEnable?Boolean(this.isVisibleHealthBarAlt):Boolean(this.isVisibleHealthBarBasic);
            this.mcHealthBar.y = !!this._isAltEnable?Number(this.yHealthBarAlt):Number(this.yHealthBarBasic);
            this.setProgressVisible(!!this._isAltEnable?Boolean(this.isVisibleHealthBarValueAlt):Boolean(this.isVisibleHealthBarValueBasic));
            this.updateMcCommand();
         }
      }
      
      public function setHealthBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         if(this.mcHealthBar)
         {
            _loc1_ = 100 * (1 - this.health / this.maxHealth);
            if(this.mcHealthBar.progress.visible)
            {
               this.mcHealthBar.progress.value.gotoAndStop(_loc1_);
            }
            else if(this.mcHealthBar.progressSmall.visible)
            {
               this.mcHealthBar.progressSmall.value.gotoAndStop(_loc1_);
            }
            if(!!this._isAltEnable?Boolean(this.altStrengthIndicatorType):Boolean(this.basicStrengthIndicatorType))
            {
               _loc2_ = this.health * 100 / this.maxHealth;
               if(0 < _loc2_ && _loc2_ <= 1)
               {
                  this.mcHealthBar.txtHealth.text = "1%";
               }
               else
               {
                  this.mcHealthBar.txtHealth.text = Math.round(_loc2_) + "%";
               }
            }
            else
            {
               this.mcHealthBar.txtHealth.text = this.health;
            }
         }
      }
      
      public function setHealth(param1:int) : void
      {
         this.health = param1;
         this.setHealthBar();
      }
      
      public function setDamage(param1:int) : void
      {
         var _loc2_:Number = NaN;
         if(this.health > param1)
         {
            _loc2_ = this.health - param1;
            if(this.mcHealthBar.txtHp.text == "")
            {
               this.mcHealthBar.txtHp.text = _loc2_;
            }
            else
            {
               this.mcHealthBar.txtHp.text = Number(this.mcHealthBar.txtHp.text) + _loc2_;
            }
            this.mcHealthBar.txtHp.alpha = 1;
            this._updateTimeHp.reset();
            this._updateTimeHp.start();
            this.clearBlink();
            this.dirBlink = 1;
            this.valueBlink = 0;
            this._updateTimeBlink.reset();
            this._updateTimeBlink.start();
            this.health = param1;
            this.setHealthBar();
         }
      }
      
      private function showDamage(param1:int) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         var _loc2_:AnimMarkerDamage = new AnimMarkerDamage(param1);
         _loc2_.addEventListener(Event.DEACTIVATE,this.removeMarkerDamage);
         _loc2_.x = this._xyMcAnimHP.x;
         _loc2_.y = this._xyMcAnimHP.y;
         this._elementsMarkerDamage.push(_loc2_);
         this.mcHealthBar.addChild(_loc2_);
         _loc2_.start();
      }
      
      private function clearMarkersDamage() : void
      {
         while(this._elementsMarkerDamage.length)
         {
            this.removeMarker(this._elementsMarkerDamage[0]);
         }
      }
      
      private function removeMarkerDamage(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         this.removeMarker(_loc2_);
      }
      
      public function showCritDamage(param1:Array = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:AnimMarkerCrit = null;
         this.clearCritMarkers();
         if(this.sideType == 2 || this.sideType == 3)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         this._critModules = [];
         param1 = param1.reverse();
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = new AnimMarkerCrit();
            this._critModules.push(_loc3_);
            _loc3_.showPart(param1[_loc2_]);
            _loc2_++;
         }
         this.repositionCritDamage();
      }
      
      private function sortCritModules() : void
      {
         var _loc1_:int = 0;
         var _loc2_:AnimMarkerCrit = null;
         var _loc3_:int = 0;
         if(Boolean(this._previewModules) && this._previewModules.length > 0)
         {
            _loc1_ = 0;
            while(this._previewModules.length)
            {
               _loc2_ = this._previewModules.shift();
               _loc3_ = this._critModules.indexOf(_loc2_);
               if(_loc3_ != -1)
               {
                  this._critModules.splice(_loc3_,1);
                  this._critModules.push(_loc2_);
                  _loc1_ = _loc1_ + 1;
               }
            }
         }
         this._previewModules = this._critModules;
      }
      
      public function repositionCritDamage() : void
      {
         var _loc5_:AnimMarkerCrit = null;
         if(this._critModules == null || this.mcHealthBar == null)
         {
            return;
         }
         var _loc1_:Boolean = this.mcHealthBar.progress.visible;
         var _loc2_:Boolean = this.mcHealthBar.progress.visible == false && this.mcHealthBar.progressSmall.visible == false;
         var _loc3_:Boolean = this.mcHealthBar.progressSmall.visible;
         if(_loc3_)
         {
            if(_loc2_)
            {
               this._needPosition = this._baseTextPosSmall;
            }
            else
            {
               this._needPosition = this._basePosSmall;
            }
         }
         else if(_loc2_)
         {
            this._needPosition = this._baseTextPosBig;
         }
         else
         {
            this._needPosition = this._basePosBig;
         }
         var _loc4_:int = this._needPosition.x;
         var _loc6_:int = 0;
         while(_loc6_ < this._critModules.length)
         {
            _loc5_ = this._critModules[_loc6_];
            _loc5_.setIsTarget(!_loc3_,this._isAlternativeColor);
            _loc5_.y = this._needPosition.y;
            _loc5_.x = _loc4_;
            _loc4_ = _loc4_ - (_loc5_.getWidth() - 10);
            if(this.mcHealthBar)
            {
               this.mcHealthBar.addChild(_loc5_);
            }
            _loc6_++;
         }
      }
      
      public function setIsTargetMarker(param1:Boolean) : void
      {
         this._isTarget = param1;
      }
      
      private function clearCritMarkers() : void
      {
         if(this._critModules == null)
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this._critModules.length)
         {
            if(this.mcHealthBar.contains(this._critModules[_loc1_]))
            {
               this.mcHealthBar.removeChild(this._critModules[_loc1_]);
            }
            _loc1_++;
         }
         this._critModules = null;
      }
      
      public function hideCritDamage() : void
      {
      }
      
      private function removeMarker(param1:MovieClip) : void
      {
         param1.removeEventListener(Event.DEACTIVATE,this.removeMarkerDamage);
         param1["destroy"]();
         this.mcHealthBar.removeChild(param1);
         var _loc2_:int = this._elementsMarkerDamage.indexOf(param1);
         this._elementsMarkerDamage.splice(_loc2_,1);
      }
      
      public function addDistance(param1:Boolean, param2:Boolean) : void
      {
         if(this.mcDistance)
         {
            this.isVisibleDistanceBasic = param1;
            this.isVisibleDistanceAlt = param2;
            if(param1)
            {
               this._posBasicY = this._posBasicY - this.mcDistance.height;
               this.yDistanceBasic = this._posBasicY;
               this._posBasicY = this._posBasicY - POS_OFFSET_DISTANCE;
            }
            if(param2)
            {
               this._posAltY = this._posAltY - this.mcDistance.height;
               this.yDistanceAlt = this._posAltY;
               this._posAltY = this._posAltY - POS_OFFSET_DISTANCE;
            }
            this.mcDistance.visible = !!this._isAltEnable?Boolean(this.isVisibleDistanceAlt):Boolean(this.isVisibleDistanceBasic);
            this.mcDistance.y = !!this._isAltEnable?Number(this.yDistanceAlt):Number(this.yDistanceBasic);
            this.updateMcCommand();
         }
      }
      
      public function addIcon(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Number = ICON_HEIGHT;
         if(this.mcIcon)
         {
            this._posBasicY = this._posBasicY - _loc3_;
            this.yIconBasic = this._posBasicY + _loc3_ / 2;
            this._posAltY = this._posAltY - _loc3_;
            this.yIconAlt = this._posAltY + _loc3_ / 2;
            this.isVisibleIconBasic = param1;
            this.isVisibleIconAlt = param2;
            this.mcIcon.visible = !!this._isAltEnable?Boolean(this.isVisibleIconAlt):Boolean(this.isVisibleIconBasic);
            this.mcIcon.y = !!this._isAltEnable?Number(this.yIconAlt):Number(this.yIconBasic);
            this.updateMcCommand();
         }
      }
      
      public function setTargetType(param1:int, param2:int, param3:int) : void
      {
         if(param1 == 0)
         {
            this.mcIcon.gotoAndStop(param2);
         }
         else
         {
            this.mcIcon.gotoAndStop(COUNT_TYPES_PLANES + param3);
         }
         this.setScaleIcon(!!this._isAltEnable?int(this.altScaleIconType):int(this.basicScaleIconType));
         this.mcIcon.big.gotoAndStop(this.sideType);
         this.mcIcon.normal.gotoAndStop(this.sideType);
         this.mcIcon.small.gotoAndStop(this.sideType);
         if(this._isAlternativeColor)
         {
            if(this.sideType == 1)
            {
               this.mcIcon.big.gotoAndStop(4);
               this.mcIcon.normal.gotoAndStop(4);
               this.mcIcon.small.gotoAndStop(4);
            }
            else if(this.sideType == 3)
            {
               this.mcIcon.big.gotoAndStop(5);
               this.mcIcon.normal.gotoAndStop(5);
               this.mcIcon.small.gotoAndStop(5);
            }
         }
      }
      
      public function setScaleIcon(param1:int = 0) : void
      {
         switch(param1)
         {
            case 0:
               this.mcIcon.big.visible = false;
               this.mcIcon.normal.visible = false;
               this.mcIcon.small.visible = true;
               break;
            case 1:
               this.mcIcon.big.visible = false;
               this.mcIcon.normal.visible = true;
               this.mcIcon.small.visible = false;
               break;
            case 2:
               this.mcIcon.big.visible = true;
               this.mcIcon.normal.visible = false;
               this.mcIcon.small.visible = false;
         }
      }
      
      public function addNumber(param1:Boolean, param2:Boolean) : void
      {
         if(this.txtNumber)
         {
            this.isVisibleNumberBasic = param1;
            this.isVisibleNumberAlt = param2;
            if(param1)
            {
               this.yNumberBasic = this._posBasicY + POS_OFFSET_NUMBER;
            }
            if(param2)
            {
               this.yNumberAlt = this._posAltY + POS_OFFSET_NUMBER;
            }
            this.txtNumber.visible = !!this._isAltEnable?Boolean(this.isVisibleNumberAlt):Boolean(this.isVisibleNumberBasic);
            this.txtNumber.y = !!this._isAltEnable?Number(this.yNumberAlt):Number(this.yNumberBasic);
            this.updateMcCommand();
         }
      }
      
      public function setNumber() : void
      {
         if(this.txtNumber)
         {
            this.txtNumber.text = this.planeNumber;
         }
      }
      
      public function addEntityName(param1:Boolean, param2:Boolean) : void
      {
         if(this.mcEntityName)
         {
            this.mcEntityName.gotoAndStop(this.sideType);
            if(this._isAlternativeColor)
            {
               if(this.sideType == 1)
               {
                  this.mcEntityName.gotoAndStop(4);
               }
               else if(this.sideType == 3)
               {
                  this.mcEntityName.gotoAndStop(5);
               }
            }
            this.mcEntityName.txtName.text = this.entityName;
            this.isVisibleEntityNameBasic = param1;
            this.isVisibleEntityNameAlt = param2;
            if(Boolean(param1) && Boolean(this.entityName.length))
            {
               this._posBasicY = this._posBasicY - this.mcEntityName.height;
               this.yEntityNameBasic = this._posBasicY;
               this._posBasicY = this._posBasicY - POS_OFFSET_ENTITY_NAME;
            }
            if(Boolean(param2) && Boolean(this.entityName.length))
            {
               this._posAltY = this._posAltY - this.mcEntityName.height;
               this.yEntityNameAlt = this._posAltY;
               this._posAltY = this._posAltY - POS_OFFSET_ENTITY_NAME;
            }
            this.mcEntityName.visible = !!this._isAltEnable?Boolean(this.isVisibleEntityNameAlt):Boolean(this.isVisibleEntityNameBasic);
            this.mcEntityName.y = !!this._isAltEnable?Number(this.yEntityNameAlt):Number(this.yEntityNameBasic);
            this.updateMcCommand();
         }
      }
      
      public function setEntityName() : void
      {
         if(this.mcEntityName)
         {
            this.mcEntityName.txtName.text = this.entityName;
         }
      }
      
      public function addPlayerName(param1:Boolean, param2:Boolean) : void
      {
         if(this.mcPlayerName)
         {
            this.mcPlayerName.gotoAndStop(this.sideType);
            if(this._isAlternativeColor)
            {
               if(this.sideType == 1)
               {
                  this.mcPlayerName.gotoAndStop(4);
               }
               else if(this.sideType == 3)
               {
                  this.mcPlayerName.gotoAndStop(5);
               }
            }
            cutTextfieldName(this.mcPlayerName.txtName,this.playerName);
            this.isVisiblePlayerNameBasic = param1;
            this.isVisiblePlayerNameAlt = param2;
            if(Boolean(param1) && Boolean(this.playerName.length))
            {
               this._posBasicY = this._posBasicY - this.mcPlayerName.height;
               this.yPlayerNameBasic = this._posBasicY;
               this._posBasicY = this._posBasicY - POS_OFFSET_PLAYER_NAME;
            }
            if(Boolean(param2) && Boolean(this.playerName.length))
            {
               this._posAltY = this._posAltY - this.mcPlayerName.height;
               this.yPlayerNameAlt = this._posAltY;
               this._posAltY = this._posAltY - POS_OFFSET_PLAYER_NAME;
            }
            this.mcPlayerName.visible = !!this._isAltEnable?Boolean(this.isVisiblePlayerNameAlt):Boolean(this.isVisiblePlayerNameBasic);
            this.mcPlayerName.y = !!this._isAltEnable?Number(this.yPlayerNameAlt):Number(this.yPlayerNameBasic);
            this.updateMcCommand();
         }
      }
      
      public function setPlayerName() : void
      {
         if(this.mcPlayerName)
         {
            cutTextfieldName(this.mcPlayerName.txtName,this.playerName);
         }
      }
      
      public function addPlane(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         if(Boolean(this.iconLoader) && Boolean(this.txtPlaneLevel))
         {
            this.isVisibleIconLoaderBasic = param1;
            this.isVisiblePlaneLevelBasic = param2;
            this.isVisibleIconLoaderAlt = param3;
            this.isVisiblePlaneLevelAlt = param4;
            if((Boolean(param1) || Boolean(param2)) && !this.entityType)
            {
               this._posBasicY = this._posBasicY - this.iconLoader.height;
               this.yIconLoaderBasic = this._posBasicY;
               this.yPlaneLevelBasic = this._posBasicY + 2;
               this._posBasicY = this._posBasicY - POS_OFFSET_PLANE;
            }
            if((Boolean(param3) || Boolean(param4)) && !this.entityType)
            {
               this._posAltY = this._posAltY - this.iconLoader.height;
               this.yIconLoaderAlt = this._posAltY;
               this.yPlaneLevelAlt = this._posAltY + 2;
               this._posAltY = this._posAltY - POS_OFFSET_PLANE;
            }
            this.iconLoader.visible = !!this._isAltEnable?Boolean(this.isVisibleIconLoaderAlt):Boolean(this.isVisibleIconLoaderBasic);
            this.iconLoader.y = !!this._isAltEnable?Number(this.yIconLoaderAlt):Number(this.yIconLoaderBasic);
            this.txtPlaneLevel.visible = !!this._isAltEnable?Boolean(this.isVisiblePlaneLevelAlt):Boolean(this.isVisiblePlaneLevelBasic);
            this.txtPlaneLevel.y = !!this._isAltEnable?Number(this.yPlaneLevelAlt):Number(this.yPlaneLevelBasic);
            this.updateMcCommand();
         }
      }
      
      public function setPlane(param1:int) : void
      {
         if(this.txtPlaneLevel)
         {
            this.txtPlaneLevel.text = this.planeLevel;
            if(this.txtPlaneLevel.visible)
            {
               this.txtPlaneLevel.visible = !param1;
            }
         }
      }
      
      public function setLayoutEntity(param1:Object, param2:Object) : void
      {
         this._posBasicY = this._posAltY = this._posY;
         this.addHealthBar(param1["strength"],param1["strengthIndicator"],param2["strength"],param2["strengthIndicator"]);
         this.addDistance(param1["distanceToPlane"],param2["distanceToPlane"]);
         this.addPlayerName(param1["playerName"],param2["playerName"]);
         this.addEntityName(param1["planeName"],param2["planeName"]);
         this.addPlane(param1["planeType"],param1["planeLevel"],param2["planeType"],param2["planeLevel"]);
         this.addIcon(param1["icon"],param2["icon"]);
         this.addNumber(param1["indexInList"],param2["indexInList"]);
         this.basicStrengthIndicatorType = param1.strengthIndicatorType;
         this.altStrengthIndicatorType = param2.strengthIndicatorType;
         this.basicScaleIconType = param1.planeTypeIconSize;
         this.altScaleIconType = param2.planeTypeIconSize;
         this.updateMcCommand();
      }
      
      public function initEntity(param1:Object, param2:Object) : void
      {
         var _loc3_:HUDPlayerVO = null;
         this.resetEntity();
         this.entityId = param1.entityId;
         this.sideType = param1.sideType;
         this.mcMarkerPlane.gotoAndStop(param1.sideType);
         this.mcMarkerPlane.visible = !param1.entityType;
         if(param1.targetLevel != undefined && param1.targetLevel > 0)
         {
            this.planeLevel = Utils.arabic2Roman(param1.targetLevel);
         }
         else
         {
            this.planeLevel = "";
         }
         this.entityName = param1.entityName;
         this.playerName = param1.playerName;
         this.entityType = param1.entityType;
         this.targetType = param1.targetType;
         this.health = param1.health;
         this.maxHealth = param1.maxHealth;
         this.planeNumber = "";
         this.planeIconPath = "";
         this.mcHealthBar.txtHp.text = "";
         for each(_loc3_ in param2)
         {
            if(_loc3_.ID == param1.entityId)
            {
               this.planeNumber = String(_loc3_.planeNumber < 10?"0" + _loc3_.planeNumber:_loc3_.planeNumber);
               this.planeIconPath = _loc3_.planeIconPath;
               break;
            }
         }
         this.setHealthBar();
         this.setTargetType(this.entityType,this.targetType,param1.objectPartsType);
         this.setScaleIcon();
         this.setNumber();
         this.setEntityName();
         this.setPlayerName();
         this.setPlane(this.entityType);
         this.setDistanceState();
      }
      
      public function updateEntity(param1:Object) : void
      {
         this.setLayoutEntity(param1.basic,param1.alt);
         this.setDistanceState();
      }
      
      public function updateEntityData(param1:Object) : void
      {
         if(this.mcEntityName)
         {
            this.entityName = param1.entityName;
            this.mcEntityName.txtName.text = this.entityName;
         }
      }
      
      public function setTeamObjectData(param1:Object) : void
      {
         this.setTargetType(this.entityType,this.targetType,param1.objectPartsType);
      }
      
      public function setCommandType(param1:int) : void
      {
         switch(param1)
         {
            case 1:
               this.mcCommand.gotoAndStop("EnemyHere");
               break;
            case 2:
               this.mcCommand.gotoAndStop("EnemyMyAim");
               break;
            case 3:
               this.mcCommand.gotoAndStop("GotIt");
               break;
            case 4:
               this.mcCommand.gotoAndStop("JoinMe");
               break;
            case 5:
               this.mcCommand.gotoAndStop("MyLocation");
               break;
            case 6:
               this.mcCommand.gotoAndStop("NeedShelter");
               break;
            case 7:
               this.mcCommand.gotoAndStop("No");
               break;
            case 8:
               this.mcCommand.gotoAndStop("Sos");
               break;
            case 21:
               this.mcCommand.gotoAndStop("JoinMe_Enemy");
               break;
            case 22:
               this.mcCommand.gotoAndStop("EnemyMyAim_Enemy");
         }
      }
      
      public function entityCommands(param1:int, param2:Boolean) : void
      {
         if(this.mcCommand)
         {
            this.mcCommand.alpha = !!param2?Number(1):Number(0);
            this.mcCommand.visible = param2;
            if(param2)
            {
               this.updateMcCommand();
               this.setCommandType(param1);
               this._updateTimeCommand.reset();
               this._updateTimeCommand.start();
               this.setDistanceState();
            }
            else
            {
               this._updateTimeCommand.stop();
            }
         }
      }
      
      public function updateMcCommand() : void
      {
         this.yCommandBasic = this._posBasicY - this.mcCommand.height / 2;
         this.yCommandAlt = this._posAltY - this.mcCommand.height / 2;
         this.mcCommand.y = !!this._isAltEnable?Number(this.yCommandAlt):Number(this.yCommandBasic);
      }
   }
}
