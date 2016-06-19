/**
 * ...
 * @author Monstrofil
 */
package WorldofWarplanesCommon
{
	import com.junkbyte.console.*;
	import flash.display.*;
	import flash.geom.*;
	import lesta.constants.*;
	import lesta.cpp.*;
	import lesta.datahub.*;
	import lesta.dialogs.dock.constants.*;
	import lesta.libs.unbound.*;
	import lesta.managers.*;
	import lesta.managers.constants.*;
	import lesta.managers.windows.*;
	import lesta.structs.*;
	import lesta.unbound.bindings.*;
	import lesta.unbound.core.*;
	import lesta.unbound.layout.*;
	import lesta.unbound.style.*;
	import lesta.utils.*;
	import scaleform.clik.managers.*;
	import scaleform.gfx.*;
	import wowp.hud.HUD;
	
	public final class ML_UnboundApplication extends Overlay
	{
		private var central:UbCentral;
		private var blockFactory:UbBlockFactory;
		
		private var xml:XML;
		private var mStage:Stage;
		private var rootBlock:String;
		
		private var mSizeStage:Point = new Point(0, 0);
		
		private const LINE_TO_REMOVE:String = "DONT'T REMOVE THIS LINE!!!";
		
		public function ML_UnboundApplication(filename:String, rootStage:Stage, rootBlock:String)
		{
			this.mStage = rootStage;
			this.rootBlock = rootBlock;
			Promise.together([Promise.load(filename)]).then(Promise.apply(this.onReady));
			initialize(100, 'RootBlock');
			
			Extensions.enabled = true;
			Extensions.noInvisibleAdvance = true;
			//FocusHandler.init(mStage, null);
			//GameInputHandler.instance.initialize();
			//HotKeyManager.instance.init();
			super(null, false, 0, -1);
		}
		
		private function updateStage(arg1:Number, arg2:Number):void
		{
			this.mSizeStage.x = arg1;
			this.mSizeStage.y = arg2;
			Cc.info(arg1, arg2);
			return;
		}
		
		private function onReady(arg1:String):void
		{
			Cc.log("HUD._model");
			Cc.log(HUD._model);
			xml = new XML(arg1.replace(LINE_TO_REMOVE, ""));
			this.makeBlocks(xml);
		}
		
		public var ubGlobal:UbGlobalDefinitions = new UbGlobalDefinitions();
		
		private function makeBlocks(xml:XML)
		{
			this.setupUnbound();
			super.beforeOpen({});
			dispatchState(WindowStates.READY_FOR_DATA);
			
			Extensions.enabled = true;
			Extensions.noInvisibleAdvance = true;
			FocusHandler.init(mStage, null);
			
			var blockFactory:UbBlockFactory = new UbBlockFactory(central);
			blockFactory.loadPlansFromXml(xml);
			
			var ubScope:UbRootScope = new UbRootScope(this.ubGlobal);
			var _root:UbRootBlock = blockFactory.constructAsRoot(this.rootBlock);
			_root.style
			this.central.forceUpdate();
			_root.update(true);
			
			var layoutWindows:UbBlock = new lesta.unbound.layout.UbBlock();
			layoutWindows.style.widthMode = UbStyle.DIMENSION_ABSOLUTE;
			layoutWindows.style.heightMode = lesta.unbound.style.UbStyle.DIMENSION_ABSOLUTE;
			layoutWindows.style.position = lesta.unbound.style.UbStyle.POSITION_ABSOLUTE;
			var layoutTooltips:UbBlock = new lesta.unbound.layout.UbBlock();
			layoutTooltips.style.widthMode = lesta.unbound.style.UbStyle.DIMENSION_ABSOLUTE;
			layoutTooltips.style.heightMode = lesta.unbound.style.UbStyle.DIMENSION_ABSOLUTE;
			layoutTooltips.style.position = lesta.unbound.style.UbStyle.POSITION_ABSOLUTE;
			
			_root.style.widthMode = lesta.unbound.style.UbStyle.DIMENSION_ABSOLUTE;
			_root.style.heightMode = lesta.unbound.style.UbStyle.DIMENSION_ABSOLUTE;
			_root.style.width = mSizeStage.x;
			_root.style.height = mSizeStage.y;
			
			this.addChild(_root);
			
			_root.addChildProperly(layoutWindows);
			_root.addChildProperly(layoutTooltips);
			
			this.central.onEvent("startShow", null, lesta.unbound.core.UbScope.EVENT_DIRECTION_DOWN);
			this.central.start();
			
			central.setGlobalDefinition("layoutTooltips", layoutTooltips);
			central.setGlobalDefinition("layoutWindows", layoutWindows);
			
			this.central.onEvent("onBecomeTop", null, UbScope.EVENT_DIRECTION_DOWN);
			return;
		}
		
		public function makeRootBlock(id:String):UbRootBlock
		{
			var _root:UbRootBlock = this.blockFactory.constructAsRoot(id);
			_root.update(true);
			return _root;
		}
		
		protected function setupUnbound():void
		{
			var injector:lesta.unbound.core.UbInjector;
			var ChannelGroup:Object;
			var InviteType:Object;
			var WindowTooltipStateDict:Object;
			var wowsBindingsSet:Object;
			var p:String;
			var datahub = new DataHub();
			
			var loc1:*;
			p = null;
			injector = new lesta.unbound.core.UbInjector();
			//injector.addPreconstructed(new FocusWindowsManager());
			injector.addPreconstructed(datahub);
			//injector.addPreconstructed(new DragAndDropManager(this.mStage, this));
			//injector.addPreconstructed(AccountLevelingManager.instance);
			//injector.addPreconstructed(GameInfoHolder.instance);
			injector.addPreconstructed(injector);
			
			this.central = new UbCentral(mStage, injector, this.ubGlobal);
			central.setGlobalDefinition("tr", function(arg1:String):String
			{
				return arg1 ? Translator.translate(arg1) : "";
			})
			central.setGlobalDefinition("subst", lesta.utils.StringUtils.asprintf);
			central.setGlobalDefinition("toUpperCase", function(arg1:String):String
			{
				return String(arg1).toUpperCase();
			})
			central.setGlobalDefinition("toLowerCase", function(arg1:String):String
			{
				return String(arg1).toLowerCase();
			})
			central.setGlobalDefinition("format", StringUtils.format);
			central.setGlobalDefinition("timestampToHourMinSec", lesta.utils.DateTime.timestampToHourMinSec);
			central.setGlobalDefinition("getDescendantByName", function(arg1:String):flash.display.DisplayObject
			{
				return lesta.utils.DisplayObjectUtils.getDescendantByName(mStage as flash.display.DisplayObjectContainer, arg1);
			})
			central.setGlobalDefinition("PriceInfoSet", lesta.structs.PriceInfoSet);
			central.setGlobalDefinition("URL", lesta.constants.URL);
			central.setGlobalDefinition("Path", lesta.constants.Path);
			central.setGlobalDefinition("ExteriorConfig", lesta.structs.ExteriorConfig);
			central.setGlobalDefinition("AccountLevelConstants", lesta.constants.AccountLevelConstants);
			central.setGlobalDefinition("LobbyConstants", LobbyConstants);
			central.setGlobalDefinition("BattleTypes", lesta.constants.BattleTypes);
			central.setGlobalDefinition("GameMode", lesta.constants.GameMode);
			central.setGlobalDefinition("EvaluationType", lesta.constants.EvaluationType);
			central.setGlobalDefinition("EvaluationTopic", lesta.constants.EvaluationTopic);
			central.setGlobalDefinition("UIStrings", lesta.utils.UIStrings);
			central.setGlobalDefinition("RankedBattleStatus", lesta.constants.RankedBattleStatus);
			central.setGlobalDefinition("RBDeny", lesta.constants.RBDeny);
			central.setGlobalDefinition("RewardReason", lesta.constants.RewardReason);
			central.setGlobalDefinition("RankBattlesStages", lesta.constants.RankBattlesStages);
			central.setGlobalDefinition("ObjectTypes", lesta.constants.ObjectTypes);
			central.setGlobalDefinition("ExteriorTypes", lesta.constants.ExteriorTypes);
			central.setGlobalDefinition("SSETypes", lesta.constants.SSETypes);
			central.setGlobalDefinition("CapturePointType", lesta.structs.CapturePointType);
			central.setGlobalDefinition("ShipTypes", lesta.constants.ShipTypes);
			central.setGlobalDefinition("Country", lesta.constants.Country);
			central.setGlobalDefinition("ShipLevels", lesta.constants.ShipLevels);
			central.setGlobalDefinition("dataHub", datahub)
			this.mSizeStage.x = this.mStage.stageWidth;
			this.mSizeStage.y = this.mStage.stageHeight;
			central.setGlobalDefinition("stageSize", mSizeStage);
			central.setGlobalDefinition("CC", lesta.constants.ComponentClass);
			central.setGlobalDefinition("VoteTypes", lesta.constants.VoteConstants);
			ChannelGroup = {"UNKNOWN": 0, "SHARED": 1, "MYCHANNELS": 2, "HISTORY": 3, "SEARCHRESULT": 4, "FAVORITES": 5};
			central.setGlobalDefinition("ChannelGroup", ChannelGroup);
			InviteType = {"COMMON": 1, "SEEKER_ONLY": 2};
			central.setGlobalDefinition("InviteType", InviteType);
			WindowTooltipStateDict = {"pinned": lesta.managers.constants.WindowTooltipState.pinned, "dragging": lesta.managers.constants.WindowTooltipState.dragging, "free": lesta.managers.constants.WindowTooltipState.free};
			central.setGlobalDefinition("WindowTooltipState", WindowTooltipStateDict);
			wowsBindingsSet = {"child": lesta.unbound.bindings.UbChildBinding, "instance": lesta.unbound.bindings.UbInstanceBinding, "event": lesta.unbound.bindings.UbEventBinding, "dispatch": lesta.unbound.bindings.UbDispatchBinding, "style": lesta.unbound.bindings.UbStyleBinding, "class": lesta.unbound.bindings.UbStyleClassBinding, "sync": lesta.unbound.bindings.UbSyncBinding, "repeat": lesta.unbound.bindings.UbRepeatBinding, "dataRefDH": lesta.libs.unbound.DHDataRefBinding, "watchDH": lesta.libs.unbound.DHWatchBinding, "entityDH": lesta.libs.unbound.DHEntityBinding, "handleEventDH": lesta.libs.unbound.DHHandleEventBinding, "collectionDH": lesta.libs.unbound.DHCollectionBinding, "collectionRepeatDH": lesta.libs.unbound.DHCollectionRepeatBinding, "clikList": lesta.unbound.bindings.UbClikListBinding, "draggable": lesta.libs.unbound.WowsDraggableBinding, "resize": lesta.libs.unbound.WowsResizeBinding, "appear": lesta.unbound.bindings.UbAppearBinding, "fade": lesta.unbound.bindings.UbFadeBinding, "transition": lesta.unbound.bindings.UbTransitionBinding, "pluralText": lesta.unbound.bindings.UbPluralTextBinding, "tooltip": lesta.unbound.bindings.UbTooltipBinding, "menu": lesta.unbound.bindings.UbContextMenuBinding, "blurLayer": lesta.unbound.bindings.UbBlurLayerBinding, "blurMap": lesta.unbound.bindings.UbBlurMapBinding, "input": lesta.libs.unbound.InputMappingBinding, "request": lesta.libs.unbound.SFMRequestBinding, "action": lesta.libs.unbound.SFMActionBinding, "focus": lesta.libs.unbound.FocusBinding, "sequence": lesta.unbound.bindings.UbSequenceBinding, "feature": lesta.libs.unbound.UBAccountLevelBinding, "catch": lesta.unbound.bindings.UbCatchEventBinding, "var": lesta.unbound.bindings.UBVariablesBinding, "watch": lesta.unbound.bindings.UbWatchBinding, "actionIsDisplay": lesta.libs.unbound.ActionIsDisplayBinding, "scopeHoldRepeat": lesta.unbound.bindings.UbRepeatWithScopeHoldBinding, "stageSize": lesta.unbound.bindings.UbStageSizeBinding, "clickSplit": lesta.unbound.bindings.UBClickSplitBinding, "substitute": lesta.unbound.bindings.UbSubstituteBinding, "trace": lesta.unbound.bindings.UbTraceBinding, "changeDispatch": lesta.unbound.bindings.UbChangeDispatchBinding, "countdown": lesta.unbound.bindings.UbCountdownBinding, "file": lesta.unbound.bindings.UbFileBinding, "imeEnable": lesta.unbound.bindings.UbIMEEnableBinding, "linearChart": lesta.unbound.bindings.UbLinearChartBinding, "eventSequence": lesta.unbound.bindings.UbEventSequenceBinding, "contains": lesta.unbound.bindings.UbContainsBinding, "levelToFeature": lesta.libs.unbound.UbFeatureCheckBinding, "timeFormat": lesta.unbound.bindings.UbTimeFormatBinding, "serverTime": lesta.unbound.bindings.UBServerTimeBinding, "generator": lesta.unbound.bindings.UbGeneratorBinding, "generatorDH": lesta.libs.unbound.DHCollectionGeneratorBinding, "clock": lesta.unbound.bindings.UbClockBinding};
			
			var loc2:* = 0;
			
			var loc3:* = wowsBindingsSet;
			for (p in loc3)
			{
				central.registerBindingType(p, wowsBindingsSet[p]);
			}
			
			UbPlanLoaderManager.init(central);
			return;
		}
		
		internal function setLocalizations(arg1:Object):void
		{
			lesta.cpp.Translator.localizations = arg1;
			return;
		}
		
		internal static function __indexOf(arg1:Object, arg2:Object):int
		{
			if (arg2)
			{
				if (arg2 is Array || arg2 is String || arg2 is Vector.<Object>)
				{
					return arg2.indexOf(arg1);
				}
			}
			return -1;
		}
		
		internal static function __isIn(arg1:Object, arg2:Object):Boolean
		{
			if (arg2)
			{
				if (arg2 is Array || arg2 is String || arg2 is Vector.<Object>)
				{
					return arg2.indexOf(arg1) >= 0;
				}
				return arg1 in arg2;
			}
			return false;
		}
	
	}
}
