
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
		public static const JOHNNY_LAUNCH:String = 'JOHNNY_SONAR';
		
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