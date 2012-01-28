package core
{
	import comps.Starfield;
	
	import flash.display.Sprite;

	public class BasicStarfieldController
	{
		protected static var CONTROL_LAYER:Sprite;
		
		protected var _starfield:Starfield;
		
		public static function setControlLayer(spr:Sprite):void
		{
			CONTROL_LAYER = spr;	
		}
		
		public function BasicStarfieldController($starfield:Starfield)
		{
			_starfield = $starfield;
			//probably want to register event listeners or something on this
		}
	}
}