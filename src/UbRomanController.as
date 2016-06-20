package 
{
	import lesta.constants.RDigits;
	import lesta.unbound.core.UbController;
	import lesta.unbound.expression.IUbExpression;
	import wowp.hud.HUD;
	
	/**
	 * ...
	 * @author Monstrofil
	 */
	public class UbRomanController extends UbController 
	{
		
		public function UbRomanController() 
		{
			super();
		}
		
		public override function init(arg1:Vector.<IUbExpression>):void
		{
			super.init(arg1);
			scope.roman = RDigits.rdigits;
		}
	}

}