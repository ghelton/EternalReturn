package core
{
	import comps.Starfield;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;

	/**
	 * This class handles the interface between the main player hardware controls
	 * 
	 * author: alec
	 */
	
	public class BasicController extends EventDispatcher
	{
		protected static var CONTROL_LAYER:DisplayObject;
		
		protected var _starfield:Starfield;
		
		public static function setControlLayer(spr:DisplayObject):void
		{
			CONTROL_LAYER = spr;	
		}
		
		public function BasicController()
		{
			//probably want to register event listeners or something on this
		}
	}
}