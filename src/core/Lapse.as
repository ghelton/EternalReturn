package core
{
	import flash.events.Event;
	import flash.utils.getTimer;

	/** everything in here is in seconds */
	public class Lapse
	{
		public function Lapse()
		{
		}
		
		/* Should only be run once per frame!  Will break otherwise! */
		public static function calculateTime():void {
			var now:Number = getTimer()*0.001;
			dt = now - prevDt; 
		}
		
		public static var prevDt:Number = 0; // in seconds
		public static var dt:Number = 1; // in seconds
		
	}
}