package core
{
	import datas.KeyPressData;
	
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;

	/**
	 * This class abstracts key checking for registered keyboard events without
	 * the need to do it when events are caught in a switch
	 * 
	 * author: alec
	 */
	
	public class KeyMapperEngine
	{
		public static var A_KEY:uint = 65;
		public static var D_KEY:uint = 68;
		
		private var _keys:Dictionary;
		
		public function KeyMapperEngine()
		{
			_keys = new Dictionary();
		}
		
		public function register(keysToMap:Vector.<KeyPressData>):void
		{
			//take in a key you want to listen for/function you want to call
			//event you want to hear
			//will fire when that event happens
			var keykey:KeyPressData;
			
			for each (keykey in keysToMap)
			{
				//trace('key regsiter:',keykey.keyCode,' ', keykey.type);
				//add the event listeners
				keykey.obj.addEventListener(keykey.type, checkKeys);
				
				//store the key/event/code pairings
				_keys[String(keykey.keyCode)+keykey.type] = keykey;
			}
			
		}
		
		private function checkKeys(e:KeyboardEvent):void
		{
			trace('checkkeys',e.keyCode, e.type);
			var key:KeyPressData = _keys[String(e.keyCode)+e.type];
			if(key == null)
				return;
			if (key != null && e.keyCode == key.keyCode)
			{
				key.func(key, e);
			}
		}
	}
}