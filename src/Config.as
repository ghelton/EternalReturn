package
{
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	/**
	 * This class handles all configurable data for the game for easy value tweaking
	 * 
	 * author: alec
	 */
	
	public class Config
	{
		public static const A_KEY_ROTATION_SPEED:uint = 2;
		public static const D_KEY_ROTATION_SPEED:uint = 2;
		public static const STARFIELD_BUFFER:uint = 100;
		
		public static const JOHNNY_DGROTATE_ACCEL:Number = 0.05; // degrees clockwise rotation
		public static const JOHNNY_DGROTATE_DECEL:Number = 0.04; // deceleration of rotation in degrees
		
		public static const FRAME_FREQUENCY:Number = 1 / 25;  // seconds per frame
		
		public static const JOHNNY_GREEN_RESOURCE_PER_SECOND:Number = 5;
		public static const JOHNNY_RED_RESOURCE_PER_SECOND:Number = 10;
		public static const JOHNNY_BLUE_RESOURCE_PER_SECOND:Number = 25; // hold scanning button for long range before releasing sonar pulse?
		
		public static const STARTING_POINT:Point = new Point(0, 0);
		public static const STARTING_RESOURCES:Vector3D = new Vector3D(200, 200, 100);
		public static const BASE_MAGNITUDE:Number = 0;
		
		public function Config()
		{
		}
	}
}