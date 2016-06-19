package wowp.hud.model.tutorial
{
   import wowp.hud.core.HUDModelComponent;
   import wowp.utils.data.binding.Signal;
   import flash.utils.setTimeout;
   import scaleform.clik.controls.Button;
   import flash.display.MovieClip;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   
   public class HUDTutorialModel extends HUDModelComponent
   {
       
      public var onShowTutorial:Signal;
      
      public var onHideTutorial:Signal;
      
      public var onGotMessage:Signal;
      
      public var onLayoutTutorialInit:Signal;
      
      public var onClearTutorial:Signal;
      
      public var onShowShadowTutorial:Signal;
      
      public var onShowCaptionTutorial:Signal;
      
      public var onShowHeaderTutorial:Signal;
      
      public var onShowHintTutorial:Signal;
      
      public var onShowHintControlTutorial:Signal;
      
      public var onShowHintResultTutorial:Signal;
      
      public var onShowLimitAreaTutorial:Signal;
      
      public var onRotLimitAreaTutorial:Signal;
      
      public var onShowLimitAreaExTutorial:Signal;
      
      public var onRotLimitAreaExTutorial:Signal;
      
      public var onShowLimitAreaCircleTutorial:Signal;
      
      public var onRotLimitAreaCircleTutorial:Signal;
      
      public var onHitLimitAreaCircleTutorial:Signal;
      
      public var onShowTimerTutorial:Signal;
      
      public var onResetTimerTutorial:Signal;
      
      public var onStartTimerTutorial:Signal;
      
      public var onStopTimerTutorial:Signal;
      
      public var onGetTimerTutorial:Signal;
      
      public var onShowCircleTutorial:Signal;
      
      public var onRotCircleTutorial:Signal;
      
      public var onSetElementsVisibleTutorial:Signal;
      
      public var onUpdateProgressBarTutorial:Signal;
      
      public var onShowTutorialResultWindow:Signal;
      
      public var onShowNecessaryCommandWindow:Signal;
      
      public var onShowArrowPointerTutorial:Signal;
      
      public var onShowArrowPointerBlinkTutorial:Signal;
      
      public var onShowMarkerPointerTutorial:Signal;
      
      public var onShowBlinkingHighlightTutorial:Signal;
      
      public var positionBlinkingHighlightTutorial:Signal;
      
      public var onLockAmmo:Signal;
      
      public var onShowWeaponRocketBlinkTutorial:Signal;
      
      public var onShowWeaponBombBlinkTutorial:Signal;
      
      public var onShowWeaponGunBlinkTutorial:Signal;
      
      public var onShowShadowHintTutorial:Signal;
      
      public var onShowShadowPlayerList:Signal;
      
      public var lastMessage:String;
      
      public var dataDeviceState:Object;
      
      private var _isTutorialStarted:Boolean = false;
      
      private var _isPause:Boolean = false;
      
      private var _isShowCursor:Boolean = false;
      
      private var _isFromMenuState:Boolean = false;
      
      private var _isShowModalWindow:Boolean = false;
      
      private var _isGoToHangar:Boolean = false;
      
      private var _showTimer:Boolean = false;
      
      private var _isArrowPointerBlink:Boolean = false;
      
      private var _isWeaponRocketBlink:Boolean = false;
      
      private var _isWeaponBombBlink:Boolean = false;
      
      private var _isWeaponGunBlink:Boolean = false;
      
      private var _showNecessarySettings:Boolean = false;
      
      private var _showTutorialResultWindow:Boolean = false;
      
      private var _isLayoutTutorialInit:Boolean = false;
      
      private var _isMarkerPointerVisible:Boolean = false;
      
      private var _isHintControlVisible:Boolean = false;
      
      private var _miniMapState:int = 0;
      
      private var _progressValue:Object;
      
      private var _dataCircle:Object;
      
      private var _dataCaption:Object;
      
      private var _dataHeader:Object;
      
      private var _dataHint:Object;
      
      private var _dataHintControl:Object;
      
      private var _dataHintResult:Object;
      
      private var _dataShadow:Object;
      
      private var _dataShowLimitArea:Object;
      
      private var _dataShowLimitAreaEx:Object;
      
      private var _dataShowLimitAreaCircle:Object;
      
      private var _dataHitLimitAreaCircle:Object;
      
      private var _dataElementsVisible:Object;
      
      private var _dataArrowPointer:Object;
      
      private var _dataMarkerPointer:Object;
      
      private var _dataBlinkingHighlight:Object;
      
      private var _dataBlinkingHighlightPosition:Object;
      
      private var _dataAmmoLock:Object;
      
      private var _dataShadowHint:Object;
      
      private var _dataShadowPlayerList:Object;
      
      public function HUDTutorialModel()
      {
         this.onShowTutorial = new Signal();
         this.onHideTutorial = new Signal();
         this.onGotMessage = new Signal();
         this.onLayoutTutorialInit = new Signal();
         this.onClearTutorial = new Signal();
         this.onShowShadowTutorial = new Signal();
         this.onShowCaptionTutorial = new Signal();
         this.onShowHeaderTutorial = new Signal();
         this.onShowHintTutorial = new Signal();
         this.onShowHintControlTutorial = new Signal();
         this.onShowHintResultTutorial = new Signal();
         this.onShowLimitAreaTutorial = new Signal();
         this.onRotLimitAreaTutorial = new Signal();
         this.onShowLimitAreaExTutorial = new Signal();
         this.onRotLimitAreaExTutorial = new Signal();
         this.onShowLimitAreaCircleTutorial = new Signal();
         this.onRotLimitAreaCircleTutorial = new Signal();
         this.onHitLimitAreaCircleTutorial = new Signal();
         this.onShowTimerTutorial = new Signal();
         this.onResetTimerTutorial = new Signal();
         this.onStartTimerTutorial = new Signal();
         this.onStopTimerTutorial = new Signal();
         this.onGetTimerTutorial = new Signal();
         this.onShowCircleTutorial = new Signal();
         this.onRotCircleTutorial = new Signal();
         this.onSetElementsVisibleTutorial = new Signal();
         this.onUpdateProgressBarTutorial = new Signal();
         this.onShowTutorialResultWindow = new Signal();
         this.onShowNecessaryCommandWindow = new Signal();
         this.onShowArrowPointerTutorial = new Signal();
         this.onShowArrowPointerBlinkTutorial = new Signal();
         this.onShowMarkerPointerTutorial = new Signal();
         this.onShowBlinkingHighlightTutorial = new Signal();
         this.positionBlinkingHighlightTutorial = new Signal();
         this.onLockAmmo = new Signal();
         this.onShowWeaponRocketBlinkTutorial = new Signal();
         this.onShowWeaponBombBlinkTutorial = new Signal();
         this.onShowWeaponGunBlinkTutorial = new Signal();
         this.onShowShadowHintTutorial = new Signal();
         this.onShowShadowPlayerList = new Signal();
         this.dataDeviceState = new Object();
         this._progressValue = new Object();
         this._dataCircle = new Object();
         this._dataCaption = new Object();
         this._dataHeader = new Object();
         this._dataHint = new Object();
         this._dataHintControl = new Object();
         this._dataHintResult = new Object();
         this._dataShadow = new Object();
         this._dataShowLimitArea = new Object();
         this._dataShowLimitAreaEx = new Object();
         this._dataShowLimitAreaCircle = new Object();
         this._dataHitLimitAreaCircle = new Object();
         this._dataElementsVisible = new Object();
         this._dataArrowPointer = new Object();
         this._dataMarkerPointer = new Object();
         this._dataBlinkingHighlight = new Object();
         this._dataBlinkingHighlightPosition = new Object();
         this._dataAmmoLock = new Object();
         this._dataShadowHint = new Object();
         this._dataShadowPlayerList = new Object();
         super();
      }
      
      public function get isMarkerPointerVisible() : Boolean
      {
         return this._isMarkerPointerVisible;
      }
      
      public function get isTutorialStarted() : Boolean
      {
         return this._isTutorialStarted;
      }
      
      public function get isShowTimer() : Boolean
      {
         return this._showTimer;
      }
      
      public function get progressValue() : Object
      {
         return this._progressValue;
      }
      
      public function get dataCaption() : Object
      {
         return this._dataCaption;
      }
      
      public function get dataCircle() : Object
      {
         return this._dataCircle;
      }
      
      public function get dataHeader() : Object
      {
         return this._dataHeader;
      }
      
      public function get dataHint() : Object
      {
         return this._dataHint;
      }
      
      public function get isHintControlVisible() : Boolean
      {
         return this._isHintControlVisible;
      }
      
      public function set isHintControlVisible(param1:Boolean) : void
      {
         this._isHintControlVisible = param1;
      }
      
      public function get miniMapState() : int
      {
         return this._miniMapState;
      }
      
      public function set miniMapState(param1:int) : void
      {
         this._miniMapState = param1;
      }
      
      public function get dataHintControl() : Object
      {
         return this._dataHintControl;
      }
      
      public function set dataHintControl(param1:Object) : void
      {
         this._dataHintControl = param1;
      }
      
      public function get dataHintResult() : Object
      {
         return this._dataHintResult;
      }
      
      public function get dataArrowPointer() : Object
      {
         return this._dataArrowPointer;
      }
      
      public function get dataMarkerPointer() : Object
      {
         return this._dataMarkerPointer;
      }
      
      public function get dataShadow() : Object
      {
         return this._dataShadow;
      }
      
      public function get dataShowLimitArea() : Object
      {
         return this._dataShowLimitArea;
      }
      
      public function get dataShowLimitAreaEx() : Object
      {
         return this._dataShowLimitAreaEx;
      }
      
      public function get dataShowLimitAreaCircle() : Object
      {
         return this._dataShowLimitAreaCircle;
      }
      
      public function get dataHitLimitAreaCircle() : Object
      {
         return this._dataHitLimitAreaCircle;
      }
      
      public function get dataElementsVisible() : Object
      {
         return this._dataElementsVisible;
      }
      
      public function get dataBlinkingHighlight() : Object
      {
         return this._dataBlinkingHighlight;
      }
      
      public function get dataBlinkingHighlightPosition() : Object
      {
         return this._dataBlinkingHighlightPosition;
      }
      
      public function get dataAmmoLock() : Object
      {
         return this._dataAmmoLock;
      }
      
      public function get dataShadowHint() : Object
      {
         return this._dataShadowHint;
      }
      
      public function get dataShadowPlayerList() : Object
      {
         return this._dataShadowPlayerList;
      }
      
      public function get isShowCursor() : Boolean
      {
         return this._isShowCursor;
      }
      
      public function set isShowCursor(param1:Boolean) : void
      {
         this._isShowCursor = param1;
      }
      
      public function get isFromMenuState() : Boolean
      {
         return this._isFromMenuState;
      }
      
      public function set isFromMenuState(param1:Boolean) : void
      {
         this._isFromMenuState = param1;
      }
      
      public function get isArrowPointerBlink() : Boolean
      {
         return this._isArrowPointerBlink;
      }
      
      public function set isArrowPointerBlink(param1:Boolean) : void
      {
         this._isArrowPointerBlink = param1;
      }
      
      public function get isWeaponRocketBlink() : Boolean
      {
         return this._isWeaponRocketBlink;
      }
      
      public function set isWeaponRocketBlink(param1:Boolean) : void
      {
         this._isWeaponRocketBlink = param1;
      }
      
      public function get isWeaponBombBlink() : Boolean
      {
         return this._isWeaponBombBlink;
      }
      
      public function set isWeaponBombBlink(param1:Boolean) : void
      {
         this._isWeaponBombBlink = param1;
      }
      
      public function get isWeaponGunBlink() : Boolean
      {
         return this._isWeaponGunBlink;
      }
      
      public function set isWeaponGunBlink(param1:Boolean) : void
      {
         this._isWeaponGunBlink = param1;
      }
      
      public function get isShowTutorialResultWindow() : Boolean
      {
         return this._showTutorialResultWindow;
      }
      
      public function set isShowTutorialResultWindow(param1:Boolean) : void
      {
         this._showTutorialResultWindow = param1;
      }
      
      public function get isShowModalWindow() : Boolean
      {
         return this._isShowModalWindow;
      }
      
      public function set isShowModalWindow(param1:Boolean) : void
      {
         this._isShowModalWindow = param1;
         if(param1)
         {
            model.layout.onStateChanged.fire();
         }
      }
      
      public function get isGoToHangar() : Boolean
      {
         return this._isGoToHangar;
      }
      
      public function set isGoToHangar(param1:Boolean) : void
      {
         this._isGoToHangar = param1;
      }
      
      private function setPause(param1:Boolean = false) : void
      {
         this._isPause = param1;
         backend.call("hud.tutorialPaused",param1);
      }
      
      public function get isPause() : Boolean
      {
         return this._isPause;
      }
      
      public function set isPause(param1:Boolean) : void
      {
         if(param1)
         {
            this.setPause(true);
         }
         else
         {
            setTimeout(this.setPause,1);
         }
      }
      
      public function get isLayoutTutorialInit() : Boolean
      {
         return this._isLayoutTutorialInit;
      }
      
      public function set isLayoutTutorialInit(param1:Boolean) : void
      {
         this._isLayoutTutorialInit = param1;
      }
      
      public function get showNecessarySettings() : Boolean
      {
         return this._showNecessarySettings;
      }
      
      public function set showNecessarySettings(param1:Boolean) : void
      {
         this._showNecessarySettings = param1;
      }
      
      override protected function onInit() : void
      {
         trace("HUDTutorialModel::onInit");
         backend.addCallback("hud.showTutorial",this.showTutorial);
         backend.addCallback("hud.hideTutorial",this.hideTutorial);
         backend.addCallback("hud.tutorialMessage",this.showTutorialMessage);
         backend.addCallback("settings.showNecessarySettings",this.showNecessaryCommandWindow);
         backend.addCallback("hud.clearTutorial",this.clear);
         backend.addCallback("hud.showShadow",this.showShadow);
         backend.addCallback("hud.showCaptionTutorial",this.showCaption);
         backend.addCallback("hud.showHeaderTutorial",this.showHeader);
         backend.addCallback("hud.showHintTutorial",this.showHint);
         backend.addCallback("hud.showLimitArea",this.showLimitArea);
         backend.addCallback("hud.rotLimitArea",this.rotLimitArea);
         backend.addCallback("hud.showLimitAreaEx",this.showLimitAreaEx);
         backend.addCallback("hud.rotLimitAreaEx",this.rotLimitAreaEx);
         backend.addCallback("hud.showLimitAreaCircle",this.showLimitAreaCircle);
         backend.addCallback("hud.rotLimitAreaCircle",this.rotLimitAreaCircle);
         backend.addCallback("hud.isHitLimitAreaCircle",this.hitLimitAreaCircle);
         backend.addCallback("hud.showTimer",this.showTimer);
         backend.addCallback("hud.resetTimer",this.resetTimer);
         backend.addCallback("hud.startTimer",this.startTimer);
         backend.addCallback("hud.stopTimer",this.stopTimer);
         backend.addCallback("hud.getTimer",this.getTimer);
         backend.addCallback("hud.showCircle",this.showCircle);
         backend.addCallback("hud.rotCircle",this.rotCircle);
         backend.addCallback("hud.setElementsVisible",this.setElementsVisible);
         backend.addCallback("hud.updateProgressBar",this.updateProgressBar);
         backend.addCallback("hud.showHintControlTutorial",this.showHintControl);
         backend.addCallback("hud.showHintResultTutorial",this.showHintResult);
         backend.addCallback("hud.showArrowPointerTutorial",this.showArrowPointer);
         backend.addCallback("hud.showMarkerPointerTutorial",this.showMarkerPointer);
         backend.addCallback("hud.showBlinkingHighlight",this.showBlinkingHighlight);
         backend.addCallback("hud.positionBlinkingUpdate",this.positionBlinkingUpdate);
         backend.addCallback("hud.setLockAmmo",this.setLockAmmo);
         backend.addCallback("hud.showShadowHintTutorial",this.showShadowHintTutorial);
         backend.addCallback("hud.showShadowPlayerList",this.showShadowPlayerList);
         backend.addCallback("hangar.showTutorial",this.showTutorialResultWindow);
      }
      
      override protected function onDispose() : void
      {
      }
      
      private function updateProgressBar(param1:Number, param2:String = "", param3:int = 1) : void
      {
         trace("HUDTutorialModel::hud.updateProgressBar::currentSegment::" + param1 + ", progressText::" + param2 + ", segmentsNumber::" + param3);
         this._progressValue.value = int(param1);
         this._progressValue.text = param2;
         this._progressValue.segments = param3;
         this.onUpdateProgressBarTutorial.fire();
      }
      
      private function setElementsVisible(param1:Object) : void
      {
         var _loc2_:* = null;
         trace("HUDTutorialModel::hud.setElementsVisible");
         for(_loc2_ in param1)
         {
            trace("    ",_loc2_,":  ",param1[_loc2_]);
         }
         if(param1.hasOwnProperty("markerPointer"))
         {
            this._isMarkerPointerVisible = Boolean(param1.markerPointer);
         }
         if(param1.hasOwnProperty("hintControl"))
         {
            this._isHintControlVisible = Boolean(param1.hintControl);
         }
         this._dataElementsVisible = param1;
         this.onSetElementsVisibleTutorial.fire();
      }
      
      public function setLockAmmo(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false) : void
      {
         trace("HUDTutorialModel::hud.setLockAmmo::rocket::" + param1 + ", bomb::" + param2 + ", cannon::" + param3);
         this._dataAmmoLock.rocket = param1;
         this._dataAmmoLock.bomb = param2;
         this._dataAmmoLock.cannon = param3;
         this.onLockAmmo.fire();
      }
      
      public function showBlinkingHighlight(param1:Object, param2:Number = 0, param3:Number = 0, param4:String = "green") : void
      {
         var _loc5_:* = null;
         trace("HUDTutorialModel::hud.showBlinkingHighlight::blinkX::" + param2 + ", blinkY::" + param3 + ", color::" + param4);
         for(_loc5_ in param1)
         {
            trace("    ",_loc5_,":  ",param1[_loc5_]);
         }
         this._dataBlinkingHighlight = param1;
         this._dataBlinkingHighlight.blinkX = param2;
         this._dataBlinkingHighlight.blinkY = param3;
         if(param4 != "")
         {
            this._dataBlinkingHighlight.color = param4;
         }
         else
         {
            this._dataBlinkingHighlight.color = "green";
         }
         this.onShowBlinkingHighlightTutorial.fire();
      }
      
      public function showShadowHintTutorial(param1:Object) : void
      {
         var _loc2_:* = null;
         trace("HUDTutorialModel::hud.showShadowHintTutorial");
         for(_loc2_ in param1)
         {
            trace("    ",_loc2_,":  ",param1[_loc2_]);
         }
         this._dataShadowHint = param1;
         this.onShowShadowHintTutorial.fire();
      }
      
      public function showShadowPlayerList(param1:Boolean, param2:int, param3:int, param4:String = "") : void
      {
         this._dataShadowPlayerList.isShadow = param1;
         this._dataShadowPlayerList.myTeam = param2;
         this._dataShadowPlayerList.enemyTeam = param3;
         this._dataShadowPlayerList.killer = param4;
         this.onShowShadowPlayerList.fire();
      }
      
      public function positionBlinkingUpdate(param1:Number, param2:Number, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Number = 0) : void
      {
         this._dataBlinkingHighlightPosition.blinkX = param1;
         this._dataBlinkingHighlightPosition.blinkY = param2;
         this._dataBlinkingHighlightPosition.blinkZ = param3;
         this.positionBlinkingHighlightTutorial.fire();
      }
      
      private function rotCircle(param1:int) : void
      {
         trace("HUDTutorialModel::hud.rotCircle");
         this._dataCircle.angle = param1;
         this.onRotCircleTutorial.fire();
      }
      
      private function showCircle(param1:Boolean) : void
      {
         trace("HUDTutorialModel::hud.showCircle");
         this._dataCircle.visible = param1;
         this.onShowCircleTutorial.fire();
      }
      
      private function getTimer() : void
      {
         trace("HUDTutorialModel::hud.getTimer");
         this.onGetTimerTutorial.fire();
      }
      
      private function stopTimer() : void
      {
         trace("HUDTutorialModel::hud.stopTimer");
         this.onStopTimerTutorial.fire();
      }
      
      private function startTimer() : void
      {
         trace("HUDTutorialModel::hud.startTimer");
         this.onStartTimerTutorial.fire();
      }
      
      private function resetTimer() : void
      {
         trace("HUDTutorialModel::hud.resetTimer");
         this.onResetTimerTutorial.fire();
      }
      
      private function showTimer(param1:Boolean) : void
      {
         trace("HUDTutorialModel::hud.showTimer");
         this._showTimer = param1;
         this.onShowTimerTutorial.fire();
      }
      
      private function hitLimitAreaCircle(param1:int, param2:int) : void
      {
         trace("HUDTutorialModel::hud.hitLimitAreaCircle");
         this._dataHitLimitAreaCircle.x = param1;
         this._dataHitLimitAreaCircle.y = param2;
         this.onHitLimitAreaCircleTutorial.fire();
      }
      
      private function rotLimitAreaCircle(param1:int) : void
      {
         trace("HUDTutorialModel::hud.rotLimitAreaCircle");
         this._dataShowLimitAreaCircle.angle = param1;
         this.onRotLimitAreaCircleTutorial.fire();
      }
      
      private function showLimitAreaCircle(param1:Boolean, param2:Number, param3:Number, param4:Number, param5:Number, param6:int = 0) : void
      {
         trace("HUDTutorialModel::hud.showLimitAreaCircle");
         this._dataShowLimitAreaCircle.visible = param1;
         this._dataShowLimitAreaCircle.x = param2;
         this._dataShowLimitAreaCircle.y = param3;
         this._dataShowLimitAreaCircle.width = param4;
         this._dataShowLimitAreaCircle.height = param5;
         this._dataShowLimitAreaCircle.angle = param6;
         this.onShowLimitAreaCircleTutorial.fire();
      }
      
      private function rotLimitAreaEx(param1:int) : void
      {
         trace("HUDTutorialModel::hud.rotLimitAreaEx");
         this._dataShowLimitAreaEx.angle = param1;
         this.onRotLimitAreaExTutorial.fire();
      }
      
      private function showLimitAreaEx(param1:Boolean, param2:Number, param3:Number, param4:Number, param5:int = 0) : void
      {
         trace("HUDTutorialModel::hud.showLimitAreaEx");
         this._dataShowLimitAreaEx.visible = param1;
         this._dataShowLimitAreaEx.width = param2;
         this._dataShowLimitAreaEx.height = param3;
         this._dataShowLimitAreaEx.width2 = param4;
         this._dataShowLimitAreaEx.angle = param5;
         this.onShowLimitAreaExTutorial.fire();
      }
      
      private function rotLimitArea(param1:int) : void
      {
         trace("HUDTutorialModel::hud.rotLimitArea");
         this._dataShowLimitArea.angle = param1;
         this.onRotLimitAreaTutorial.fire();
      }
      
      private function showLimitArea(param1:Boolean, param2:Number, param3:Number, param4:int = 0) : void
      {
         trace("HUDTutorialModel::hud.showLimitArea");
         this._dataShowLimitArea.visible = param1;
         this._dataShowLimitArea.width = param2;
         this._dataShowLimitArea.height = param3;
         this._dataShowLimitArea.angle = param4;
         this.onShowLimitAreaTutorial.fire();
      }
      
      private function showHint(param1:Object) : void
      {
         trace("HUDTutorialModel::hud.showHint");
         this._dataHint = param1;
         this.onShowHintTutorial.fire();
      }
      
      private function showHintControl(param1:Object) : void
      {
         var _loc2_:* = null;
         trace("HUDTutorialModel::hud.showHintControl");
         for(_loc2_ in param1)
         {
            trace("    ",_loc2_,":  ",param1[_loc2_]);
         }
         this._dataHintControl = param1;
         this.onShowHintControlTutorial.fire();
      }
      
      private function showHintResult(param1:Object) : void
      {
         var _loc2_:* = null;
         trace("HUDTutorialModel::hud.showHintResult");
         for(_loc2_ in param1)
         {
            trace("    ",_loc2_,":  ",param1[_loc2_]);
         }
         this._dataHintResult = param1;
         this.onShowHintResultTutorial.fire();
      }
      
      private function showArrowPointer(param1:Number, param2:String) : void
      {
         this._dataArrowPointer.angle = Math.round(param1);
         this._dataArrowPointer.distance = param2;
         this.onShowArrowPointerTutorial.fire();
      }
      
      private function showMarkerPointer(param1:Number, param2:Number, param3:String) : void
      {
         this._dataMarkerPointer.x = Math.round(param1);
         this._dataMarkerPointer.y = Math.round(param2);
         this._dataMarkerPointer.distance = param3;
         this.onShowMarkerPointerTutorial.fire();
      }
      
      private function showHeader(param1:Object) : void
      {
         trace("HUDTutorialModel::hud.showHeader");
         this._dataHeader = param1;
         this.onShowHeaderTutorial.fire();
      }
      
      private function showCaption(param1:Object) : void
      {
         trace("HUDTutorialModel::hud.showCaption");
         this._dataCaption = param1;
         this.onShowCaptionTutorial.fire();
      }
      
      private function showShadow(param1:Boolean, param2:Boolean = false) : void
      {
         trace("HUDTutorialModel::hud.showShadow::visible::" + param1 + ", isFadeIn::" + param2);
         this._dataShadow.visible = param1;
         this._dataShadow.isFadeIn = param2;
         this.onShowShadowTutorial.fire();
      }
      
      private function clear() : void
      {
         trace("HUDTutorialModel::clear");
         this.onClearTutorial.fire();
         this._isShowCursor = false;
         if(!this._isPause)
         {
            backend.call("hud.requestHideCursor");
         }
      }
      
      private function showTutorial() : void
      {
         trace("HUDTutorialModel::showTutorial");
         this._isTutorialStarted = true;
         this.onShowTutorial.fire();
      }
      
      private function hideTutorial() : void
      {
         trace("HUDTutorialModel::hideTutorial");
         this._isTutorialStarted = false;
         this.onHideTutorial.fire();
      }
      
      public function sendEnterState() : void
      {
         backend.call("tutorial.onEnterState");
      }
      
      public function sendTutorialInitialized() : void
      {
         backend.call("hud.tutorialInitialized");
      }
      
      public function showTutorialMessage(param1:String) : void
      {
         this.lastMessage = param1;
         this.onGotMessage.fire();
      }
      
      public function onMouseClick(param1:Object) : void
      {
         if(!this._isPause && !(param1.target is Button))
         {
            backend.call("hud.onTutorialMouseClick");
         }
      }
      
      public function removeImages(param1:MovieClip, param2:Class) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         while(_loc4_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc4_);
            if(!(_loc3_ is TextField) && !(_loc3_ is param2))
            {
               param1.removeChildAt(_loc4_);
               _loc4_--;
            }
            _loc4_++;
         }
      }
      
      public function showTutorialResultWindow() : void
      {
         trace("HUDTutorialModel::hangar.showTutorial");
         this.setPause(true);
         this.clear();
         this._showTutorialResultWindow = true;
         this.onShowTutorialResultWindow.fire();
      }
      
      public function showNecessaryCommandWindow() : void
      {
         trace("HUDTutorialModel::settings.showNecessaryCommandWindow");
         this._showNecessarySettings = true;
         this.setPause(true);
         this.clear();
         this.onShowNecessaryCommandWindow.fire();
      }
   }
}
