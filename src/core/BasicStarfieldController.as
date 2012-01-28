package core
{
	import comps.Starfield;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * This class handles the interface between the main player hardware controls
	 * and the starfield in game
	 * 
	 * author: alec
	 */
	
	public class BasicStarfieldController
	{
		protected static var CONTROL_LAYER:DisplayObject;
		
		protected var _starfield:Starfield;
		
		public static function setControlLayer(spr:DisplayObject):void
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