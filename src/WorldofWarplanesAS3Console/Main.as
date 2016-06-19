package WorldofWarplanesAS3Console
{
	import com.junkbyte.console.Cc;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Monstrofil
	 */
	public class Main extends Sprite 
	{
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Cc.start(this);
			Cc.x = this.stage.stageWidth / 2 - Cc.width / 2;
			Cc.y = this.stage.stageHeight / 2 - Cc.height / 2;
		}
		
	}
	
}