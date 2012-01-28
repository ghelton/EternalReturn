package datas
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;

	/**
	 * KeyPressData coordinates information for the keymapperengine about registered keypresses
	 * 
	 * author: alec
	 */
	
	public class KeyPressData
	{
		public var obj:DisplayObject;
		public var type:String;
		public var func:Function;
		public var keyCode:uint = uint.MAX_VALUE;
		
		public function KeyPressData($obj:DisplayObject, $type:String, $func:Function, $keyCode:uint)
		{
			obj = $obj;
			type = $type;
			func = $func;
			keyCode = $keyCode;
		}
		
	}
}