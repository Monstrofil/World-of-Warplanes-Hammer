package WorldofWarplanesDemoModification
{
	import com.junkbyte.console.Cc;
	import flash.display.Sprite;
	import flash.events.Event;
	import lesta.controls.ButtonsSwitcher;
	import lesta.controls.JellyScrollbar;
	import lesta.controls.Slider;
	import lesta.controls.TextAreaNoEnter;
	import lesta.display.Sector;
	
	/**
	 * ...
	 * @author Monstrofil
	 */
	public class DemoModificationEntry extends Sprite 
	{
		
		public function DemoModificationEntry() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var lestaTest:Sector = new Sector();
			lestaTest.arc = 200;
			lestaTest.color = 0xEEEEEE;
			lestaTest.radius = 100;
			lestaTest.width = 100;
			lestaTest.height = 100;			
			
			this.addChild(lestaTest);
			
			Cc.log("I am Alive!11");
		}
		
	}
	
}