package
{
	import com.junkbyte.console.Cc;
	import lesta.unbound.core.UbController;
	import lesta.unbound.expression.IUbExpression;
	import wowp.hud.HUD;
	import wowp.hud.model.players.vo.HUDPlayerVO;
	
	/**
	 * ...
	 * @author Monstrofil
	 */
	public class UbPlayersController extends UbController
	{
		
		public function UbPlayersController()
		{
			super();
		
		}
		
		public override function init(arg1:Vector.<IUbExpression>):void
		{
			super.init(arg1);
			
			HUD._model.players.onPlayersChanged.add(this.validatePlayerList);
			HUD._model.players.onSwitchedVehicle.add(this.validatePlayerList);
			
			scope.allies = [];
			scope.enemies = [];
			
		}
		
		private function validatePlayerList():void {
			var player:HUDPlayerVO = null;
			var _leftPlayers = [];
			var _rightPlayers = [];
			var _loc1_:Object = HUD._model.players.players;
			for each (player in _loc1_)
			{
				if (player)
				{					
					if (player.teamID == 0)
					{
						_leftPlayers[_leftPlayers.length] = player;
					}
					else
					{
						_rightPlayers[_rightPlayers.length] = player;
					}
				}
			}
			HUD._model.players.applySortStrategy(_leftPlayers);
			HUD._model.players.applySortStrategy(_rightPlayers);
			
			scope.allies = _leftPlayers;
			scope.enemies = _rightPlayers;
		}
	
	}

}