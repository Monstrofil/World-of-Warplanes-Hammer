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
	import WorldofWarplanesCommon.ML_UnboundApplication;
	
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
			
			var unboundApp:ML_UnboundApplication = new ML_UnboundApplication("ML_Unbound.xml", this.stage, "RootBlock");
			this.addChild(unboundApp);
		}
		
	}
	
}