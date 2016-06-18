package WorldofWarplanesHammer
{
	import flash.display.Sprite;
	import flash.events.Event;
	import WorldofWarplanesCommon.ML_SWFLoader;
	
	/**
	 * ...
	 * @author Monstrofil
	 */
	public class __EntryPoint extends Sprite 
	{
		
		public function __EntryPoint() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var loader:ML_SWFLoader = new ML_SWFLoader();
			loader.load("modsList.xml", this);
		}
		private var __global:__Global;
	}
	
}