
package core
{
	import flash.events.Event;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jan 29, 2012
	 */
	public class AnimationEvent extends Event
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		public static const ANIMATION_KILL:String = "ANIMATION_KILL";
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function AnimationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
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