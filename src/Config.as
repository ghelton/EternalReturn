package
{
	
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
		
		public static const PLAYER_GREEN_RESOURCE_PER_SECOND:Number = 5;
		public static const PLAYER_RED_RESOURCE_PER_SECOND:Number = 1;
		public static const PLAYER_BLUE_RESOURCE_PER_SECOND:Number = 25; // hold scanning button for long range before releasing sonar pulse?
		
		public function Config()
		{
		}
	}
}