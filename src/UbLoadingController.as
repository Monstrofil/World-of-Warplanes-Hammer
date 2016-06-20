package 
{
	import lesta.unbound.core.UbController;
	import lesta.unbound.expression.IUbExpression;
	import wowp.hud.HUD;
	
	/**
	 * ...
	 * @author Monstrofil
	 */
	public class UbLoadingController extends UbController 
	{
		
		public function UbLoadingController() 
		{
			super();
		}
		
		public override function init(arg1:Vector.<IUbExpression>):void
		{
			super.init(arg1);
			scope.copyDataFrom(HUD._model.loading);
			HUD._model.loading.onSetBattleMap.add(this.onInfoChanged);
			HUD._model.loading.onSetBattleType.add(this.onInfoChanged);
			HUD._model.loading.onPlayerInfoData.add(this.onInfoChanged);
			HUD._model.loading.onUpdateProgressBar.add(this.onInfoChanged);			
		}
		
		private function onInfoChanged(...rest):void {
			scope.copyDataFrom(HUD._model.loading);
		}
	}

}