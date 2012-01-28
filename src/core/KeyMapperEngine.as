package core
{
	import datas.KeyPressData;
	
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;

	//purpose of this class is to abstract the searching of which key was pressed from other locations
	//alec
	
	public class KeyMapperEngine
	{
		public static var A_KEY:uint = 65;
		public static var D_KEY:uint = 68;
		
		private var _keys:Dictionary;
		
		public function KeyMapperEngine()
		{
			
		}
		
		public function register(keysToMap:Vector.<KeyPressData>):void
		{
			//take in a key you want to listen for/function you want to call
			//event you want to hear
			//will fire when that event happens
			var keykey:KeyPressData;
			_keys = new Dictionary();
			for each (keykey in keysToMap)
			{
				//add the event listeners
				keykey.obj.addEventListener(keykey.type, checkKeys);
				
				//store the key/event/code pairings
				_keys[keykey.obj] = keykey;
			}
			
		}
		
		private function checkKeys(e:KeyboardEvent):void
		{
			var key:KeyPressData = _keys[e.currentTarget];
			if (e.keyCode == key.keyCode)
			{
				key.func();
			}
		}
	}
}