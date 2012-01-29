
package events
{
	import flash.events.Event;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jan 28, 2012
	 */
	public class JohnnyEvent extends Event
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		public static const JOHNNY_LEFT:String = 'JOHNNY_LEFT';
		public static const JOHNNY_RIGHT:String = 'JOHNNY_RIGHT';
		public static const JOHNNY_LAUNCH:String = 'JOHNNY_LAUNCH';
		public static const JOHNNY_BLUE_POWER:String = 'JOHNNY_BLUE_POWER';
		public static const JOHNNY_OPEN_MAW:String = 'JOHNNY_OPEN_MAW';
		public static const JOHNNY_CLOSE_MAW:String = 'JOHNNY_CLOSE_MAW';
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function JohnnyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}