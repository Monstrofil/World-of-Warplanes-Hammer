package WorldofWarplanesCommon 
{
	import flash.display.*;
	import flash.net.*;
	import flash.system.*;
	import lesta.utils.*;
	/**
	 * ...
	 * @author Monstrofil
	 */
	public class ML_SWFLoader 
	{
		
		public function ML_SWFLoader() 
		{
			
		}
		
		public function load(filename:String, parent:Sprite) :void {
			Promise.load(filename).then(function(arg1:String):void {
				var modsList:XML = new XML(arg1);
				for each(var i:XML in modsList.mods.mod) {
					if (i.path == "placeholder")
						continue;
					var tempLoader:Loader = new Loader();
					tempLoader.load(new URLRequest(i.path), new LoaderContext(false, ApplicationDomain.currentDomain)); 
					parent.addChild(tempLoader);
				}
			});
		}
		
	}

}