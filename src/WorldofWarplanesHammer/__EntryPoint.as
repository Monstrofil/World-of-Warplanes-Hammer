package WorldofWarplanesHammer
{
	import com.junkbyte.console.Cc;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import WorldofWarplanesCommon.ML_SWFLoader;
	import wowp.core.LocalizationManager;
	
	import flash.system.*;
	
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