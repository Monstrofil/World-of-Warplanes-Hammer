package WorldofWarplanesCommon 
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import lesta.utils.Promise;
    import flash.system.ApplicationDomain;
	/**
	 * ...
	 * @author Monstrofil
	 */
	public class ML_SWFLoader 
	{
		
		public function ML_SWFLoader() 
		{
			
		}
		
		public function load(filename:String, parent:Sprite) {
			Promise.load(filename).then(function(arg1:String) {
				var modsList:XML = new XML(arg1);
				for each(var i:XML in modsList.mods.mod) {
					if (i.@path == "placeholder")
						continue;
					
					var tempLoader:Loader = new Loader();
					tempLoader.load(new URLRequest(i.@path), new LoaderContext(false, ApplicationDomain.currentDomain)); 
					parent.addChild(tempLoader);
				}
			});
		}
		
	}

}