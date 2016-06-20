package 
{
	import lesta.unbound.core.UbController;
	import lesta.unbound.expression.IUbExpression;
	import wowp.hud.HUD;
	
	/**
	 * ...
	 * @author Monstrofil
	 */
	public class UbMapController extends UbController 
	{
		
		public function UbMapController() 
		{
			super();
		}
		
		public override function init(arg1:Vector.<IUbExpression>):void
		{
			super.init(arg1);
			scope.copyDataFrom(HUD._model.map);
			HUD._model.map.onMapInfoChanged.add(this.onMapInfoChanged);
		}
		
		private function onMapInfoChanged(...rest):void {
			scope.copyDataFrom(HUD._model.map);
		}
	}

}