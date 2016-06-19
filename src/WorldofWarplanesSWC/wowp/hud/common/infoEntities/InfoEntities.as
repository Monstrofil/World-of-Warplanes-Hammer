package wowp.hud.common.infoEntities
{
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import flash.utils.Timer;
   import wowp.hud.model.HUDModel;
   import flash.external.ExternalInterface;
   import flash.events.TimerEvent;
   import wowp.utils.domain.getDefinition;
   
   public class InfoEntities extends Sprite
   {
       
      private var _countEntities:int = 0;
      
      private var _countGroupEntities:int = 0;
      
      private var _countPartEntities:int = 0;
      
      private var _infoTables:Array;
      
      private var _infoGroupTables:Array;
      
      private var _infoPartTables:Array;
      
      private var _targetMarker:MovieClip;
      
      private var _targetMarkerId:int = -1;
      
      private var _targetMarkerWidth:int = 0;
      
      private var _targetMarkerHeight:int = 0;
      
      private var _anticipationPoint:wowp.hud.common.infoEntities.AnticipationPoint;
      
      private var _effectiveShootingDist:int = 0;
      
      private var _updateTimeSort:Timer;
      
      private var _isAlternativeColor:Boolean = false;
      
      private var _model:HUDModel;
      
      public function InfoEntities()
      {
         this._infoTables = new Array();
         this._infoGroupTables = new Array();
         this._infoPartTables = new Array();
         super();
         this._targetMarker = new getDefinition("TargetMarker",loaderInfo)();
         this._targetMarker.name = "marker";
         this._targetMarker.visible = this._targetMarker.isVisible = false;
         this._targetMarker.alpha = 0.75;
         this._targetMarkerWidth = this._targetMarker.leftUp.width + this._targetMarker.rightUp.width;
         this._targetMarkerHeight = this._targetMarker.leftUp.height + this._targetMarker.leftDown.height;
         addChild(this._targetMarker);
         this._anticipationPoint = new wowp.hud.common.infoEntities.AnticipationPoint();
         this._anticipationPoint.name = "anticipationPoint";
         addChild(this._anticipationPoint);
         ExternalInterface.addCallback("hud.createEntities",this.createEntities);
         ExternalInterface.addCallback("hud.createEntitiesGroup",this.createEntitiesGroup);
         ExternalInterface.addCallback("hud.createMarkersParts",this.createMarkersParts);
         ExternalInterface.addCallback("hud.setMarkerPartData",this.setMarkerPartData);
         ExternalInterface.addCallback("hud.initEffectiveShootingDist",this.initEffectiveShootingDist);
         ExternalInterface.addCallback("hud.addEntity",this.addEntity);
         ExternalInterface.addCallback("hud.addMarkerGroup",this.addMarkerGroup);
         ExternalInterface.addCallback("hud.removeEntity",this.removeEntity);
         ExternalInterface.addCallback("hud.removeAllEntities",this.removeAllEntities);
         ExternalInterface.addCallback("hud.updateEntity",this.updateEntity);
         ExternalInterface.addCallback("hud.updateEntityData",this.updateEntityData);
         ExternalInterface.addCallback("hud.setGroupIcon",this.setGroupIcon);
         ExternalInterface.addCallback("hud.setTeamObjectData",this.setTeamObjectData);
         ExternalInterface.addCallback("hud.entityCommands",this.entityCommands);
         ExternalInterface.addCallback("hud.setMarker",this.setMarker);
         ExternalInterface.addCallback("hud.removeMarker",this.removeMarker);
         ExternalInterface.addCallback("hud.markerInfo",this.markerInfo);
         ExternalInterface.addCallback("hud.setFPState",this.setFPState);
         ExternalInterface.addCallback("hud.setFPColor",this.setFPColor);
         ExternalInterface.addCallback("hud.setDamage",this.blinkAnticipationPoint);
         this._updateTimeSort = new Timer(1000);
         this._updateTimeSort.addEventListener(TimerEvent.TIMER,this.updateTimeSort);
         this._updateTimeSort.start();
      }
      
      private function blinkAnticipationPoint() : void
      {
      }
      
      private function tututu(param1:*) : void
      {
      }
      
      public function setModel(param1:HUDModel) : void
      {
         this._model = param1;
         this._model.control.onHideBackendGraphics.add(this.resolveVisibility);
         this._model.control.onShowBackendGraphics.add(this.resolveVisibility);
         this._model.control.onAltPressed.add(this.altPressed);
         this._model.layout.onAlternativeColorChange.add(this.setAlternativeColor);
         this._model.targetCapture.onVictimInformAboutCrit.add(this.onVictimInformAboutCrit);
         this.resolveVisibility();
         this.setAlternativeColor();
      }
      
      private function onVictimInformAboutCrit() : void
      {
      }
      
      private function updateDamageTarget() : void
      {
      }
      
      public function dispose() : void
      {
         this._model.control.onHideBackendGraphics.remove(this.resolveVisibility);
         this._model.control.onShowBackendGraphics.remove(this.resolveVisibility);
         this._model.control.onAltPressed.remove(this.altPressed);
         this._model.layout.onAlternativeColorChange.remove(this.setAlternativeColor);
         this._model.targetCapture.onCritDamageUpdate.remove(this.updateDamageTarget);
         this._anticipationPoint.dispose();
         ExternalInterface.addCallback("hud.createEntities",null);
         ExternalInterface.addCallback("hud.createEntitiesGroup",null);
         ExternalInterface.addCallback("hud.createMarkersParts",null);
         ExternalInterface.addCallback("hud.setMarkerPartData",null);
         ExternalInterface.addCallback("hud.initEffectiveShootingDist",null);
         ExternalInterface.addCallback("hud.addEntity",null);
         ExternalInterface.addCallback("hud.addMarkerGroup",null);
         ExternalInterface.addCallback("hud.removeEntity",null);
         ExternalInterface.addCallback("hud.removeAllEntities",null);
         ExternalInterface.addCallback("hud.updateEntity",null);
         ExternalInterface.addCallback("hud.updateEntityData",null);
         ExternalInterface.addCallback("hud.setGroupIcon",null);
         ExternalInterface.addCallback("hud.setTeamObjectData",null);
         ExternalInterface.addCallback("hud.entityCommands",null);
         ExternalInterface.addCallback("hud.setMarker",null);
         ExternalInterface.addCallback("hud.removeMarker",null);
         ExternalInterface.addCallback("hud.markerInfo",null);
         ExternalInterface.addCallback("hud.setFPState",null);
         ExternalInterface.addCallback("hud.setFPColor",null);
         ExternalInterface.addCallback("hud.setDamage",null);
         this._updateTimeSort.removeEventListener(TimerEvent.TIMER,this.updateTimeSort);
         var _loc1_:int = 0;
         while(_loc1_ < this._countEntities)
         {
            this._infoTables[_loc1_].dispose();
            _loc1_++;
         }
      }
      
      public function swapMarkersDepth(param1:String, param2:String) : void
      {
         swapChildren(getChildByName(param1),getChildByName(param2));
      }
      
      private function altPressed() : void
      {
         var _loc1_:Boolean = this._model.control.isAltPress;
         var _loc2_:int = 0;
         while(_loc2_ < this._countEntities)
         {
            this._infoTables[_loc2_].isAltEnable = _loc1_;
            this._infoTables[_loc2_].setDistanceState();
            _loc2_++;
         }
         if(!this._model.loading.loadingFinished)
         {
            visible = _loc1_;
         }
      }
      
      private function setAlternativeColor() : void
      {
         this._isAlternativeColor = this._model.layout.isAlternativeColor;
         var _loc1_:int = 0;
         while(_loc1_ < this._countEntities)
         {
            this._infoTables[_loc1_].setAlternativeColor(this._isAlternativeColor);
            _loc1_++;
         }
         this._targetMarker.leftUp.gotoAndStop(!!this._isAlternativeColor?2:1);
         this._targetMarker.rightUp.gotoAndStop(!!this._isAlternativeColor?2:1);
         this._targetMarker.leftDown.gotoAndStop(!!this._isAlternativeColor?2:1);
         this._targetMarker.rightDown.gotoAndStop(!!this._isAlternativeColor?2:1);
         _loc1_ = 0;
         while(_loc1_ < this._countPartEntities)
         {
            this._infoPartTables[_loc1_].setAlternativeColor(this._isAlternativeColor);
            _loc1_++;
         }
         this._anticipationPoint.setAlternativeColor(this._isAlternativeColor);
      }
      
      private function resolveVisibility() : void
      {
         visible = this._model.control.isBackendGraphicsVisible;
      }
      
      private function initEffectiveShootingDist(param1:int) : void
      {
         this._effectiveShootingDist = param1;
      }
      
      private function updateTimeSort(param1:TimerEvent) : void
      {
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this._countEntities)
         {
            _loc2_[_loc3_] = this._infoTables[_loc3_];
            _loc3_++;
         }
         _loc2_.sortOn("distance",Array.NUMERIC | Array.DESCENDING);
         _loc3_ = 0;
         while(_loc3_ < this._countEntities)
         {
            if(_loc2_[_loc3_].distance != 0)
            {
               setChildIndex(_loc2_[_loc3_],_loc3_);
            }
            _loc3_++;
         }
      }
      
      private function createEntities(param1:int, param2:int) : void
      {
         this._countEntities = param1;
         var _loc3_:int = 0;
         while(_loc3_ < this._countEntities)
         {
            this._infoTables[_loc3_] = new Marker(param2);
            this._infoTables[_loc3_].name = "entity" + _loc3_;
            this._infoTables[_loc3_].resetEntity(false);
            this._infoTables[_loc3_].setAlternativeColor(this._isAlternativeColor);
            addChild(this._infoTables[_loc3_]);
            _loc3_++;
         }
      }
      
      private function createEntitiesGroup(param1:int) : void
      {
         this._countGroupEntities = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this._countGroupEntities)
         {
            this._infoGroupTables[_loc2_] = new MarkerGroup();
            this._infoGroupTables[_loc2_].name = "groupEntity" + _loc2_;
            this._infoGroupTables[_loc2_].resetEntity(false);
            addChild(this._infoGroupTables[_loc2_]);
            _loc2_++;
         }
      }
      
      private function createMarkersParts(param1:int) : void
      {
         this._countPartEntities = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this._countPartEntities)
         {
            this._infoPartTables[_loc2_] = new MarkerPart();
            this._infoPartTables[_loc2_].name = "markerPart" + _loc2_;
            this._infoPartTables[_loc2_].resetEntity(false);
            this._infoPartTables[_loc2_].setAlternativeColor(this._isAlternativeColor);
            addChild(this._infoPartTables[_loc2_]);
            _loc2_++;
         }
      }
      
      private function setMarkerPartData(param1:int, param2:int) : void
      {
         this._infoPartTables[param1].setType(param2);
      }
      
      private function addEntity(param1:int, param2:Object) : void
      {
         this._infoTables[param1].initEntity(param2,this._model.players.players);
      }
      
      private function addMarkerGroup(param1:int, param2:Object) : void
      {
         this._infoGroupTables[param1].initEntity(param2);
      }
      
      private function removeEntity(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._countEntities)
         {
            if(this._infoTables[_loc2_].entityId == param1)
            {
               this._infoTables[_loc2_].resetEntity(false);
               break;
            }
            _loc2_++;
         }
      }
      
      private function removeAllEntities() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._countEntities)
         {
            this._infoTables[_loc1_].resetEntity(false);
            _loc1_++;
         }
      }
      
      private function updateEntity(param1:int, param2:Object, param3:Array = null) : void
      {
         this._infoTables[param1].updateEntity(param2);
         this.updateCritTargetMarker();
         this._infoTables[param1].showCritDamage(param3);
      }
      
      private function updateCritTargetMarker() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._countEntities)
         {
            this._infoTables[_loc1_].repositionCritDamage();
            _loc1_++;
         }
      }
      
      private function updateEntityData(param1:int, param2:Object) : void
      {
         this._infoTables[param1].updateEntityData(param2);
      }
      
      private function setGroupIcon(param1:int, param2:Object) : void
      {
         this._infoGroupTables[param1].updateEntity(param2);
      }
      
      private function setTeamObjectData(param1:int, param2:Object) : void
      {
         this._infoTables[param1].setTeamObjectData(param2);
      }
      
      private function entityCommands(param1:int, param2:int, param3:Boolean = true) : void
      {
         var _loc4_:int = 0;
         while(_loc4_ < this._countEntities)
         {
            if(this._infoTables[_loc4_].entityId == param1)
            {
               this._infoTables[_loc4_].entityCommands(param2,param3);
               break;
            }
            _loc4_++;
         }
      }
      
      private function setMarker(param1:int) : void
      {
         this._targetMarker.visible = this._targetMarker.isVisible = true;
         if(this._targetMarkerId >= 0)
         {
            this._infoTables[this._targetMarkerId].isTargetMarker = false;
            this._infoTables[this._targetMarkerId].setDistanceState();
         }
         this._targetMarkerId = param1;
         if(this._targetMarkerId >= 0)
         {
            this._infoTables[this._targetMarkerId].isTargetMarker = true;
            this._infoTables[this._targetMarkerId].setDistanceState();
         }
      }
      
      private function removeMarker() : void
      {
         this._targetMarker.visible = this._targetMarker.isVisible = false;
         if(this._targetMarkerId >= 0)
         {
            this._infoTables[this._targetMarkerId].isTargetMarker = false;
            this._infoTables[this._targetMarkerId].setDistanceState();
         }
      }
      
      private function markerInfo(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:* = (param2 < this._targetMarkerWidth?this._targetMarkerWidth:param2) / 2;
         var _loc5_:* = (param3 < this._targetMarkerHeight?this._targetMarkerHeight:param3) / 2;
         this._targetMarker.leftUp.x = -_loc4_;
         this._targetMarker.leftUp.y = -_loc5_;
         this._targetMarker.rightUp.x = _loc4_ - this._targetMarker.rightUp.width;
         this._targetMarker.rightUp.y = -_loc5_;
         this._targetMarker.leftDown.x = -_loc4_;
         this._targetMarker.leftDown.y = _loc5_ - this._targetMarker.leftDown.height;
         this._targetMarker.rightDown.x = _loc4_ - this._targetMarker.rightDown.width;
         this._targetMarker.rightDown.y = _loc5_ - this._targetMarker.rightDown.height;
         if(param1 < this._effectiveShootingDist)
         {
            this._targetMarker.visible = this._targetMarker.isVisible;
         }
         else
         {
            this._targetMarker.visible = false;
         }
      }
      
      private function setFPState(param1:int) : void
      {
         this._anticipationPoint.setFPState(param1 + 1);
      }
      
      private function setFPColor(param1:int) : void
      {
         this._anticipationPoint.setFPColor(param1 + 1);
      }
   }
}
