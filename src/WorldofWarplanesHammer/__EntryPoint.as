package WorldofWarplanesHammer
{
	import flash.display.Sprite;
	import flash.events.Event;
	import lesta.utils.Promise;
	
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
			
			Promise.load("modsList.xml").then(function(arg1:String) {
				var modsList:XML = new XML(arg1);
				for each(var i:XML in modsList.mod) {
					trace(i);
				}
			});
		}
		private var __global:__Global;
	}
	
}