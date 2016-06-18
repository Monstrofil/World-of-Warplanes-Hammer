package WorldofWarplanesHammer
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import lesta.utils.Promise;
    import flash.system.ApplicationDomain;
	
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
				for each(var i:XML in modsList.mods.mod) {
					if (i.@path == "placeholder")
						continue;
					
					var tempLoader:Loader = new Loader();
					tempLoader.load(new URLRequest(i.@path), new LoaderContext(false, ApplicationDomain.currentDomain)); 
					addChild(tempLoader);
				}
			});
		}
		private var __global:__Global;
	}
	
}