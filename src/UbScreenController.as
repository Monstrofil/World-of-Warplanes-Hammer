package 
{
	import lesta.unbound.core.UbController;
	import lesta.unbound.expression.IUbExpression;
	import wowp.hud.HUD;
	/**
	 * ...
	 * @author Monstrofil
	 */
	public class UbScreenController extends UbController
	{
		
		public function UbScreenController() 
		{
			super();
		}
		
		public override function init(arg1:Vector.<IUbExpression>):void
		{
			super.init(arg1);
			
			HUD._model.loading.onLoadingScreenHide.add(this.onLoadingScreenHide);
			scope.screenIndex = int(HUD._model.loading.isLoadingHidden);
		}
		
		private function onLoadingScreenHide(...rest):void {
			scope.screenIndex = int(HUD._model.loading.isLoadingHidden);
		}
		
	}

}