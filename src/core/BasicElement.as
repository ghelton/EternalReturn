package core
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * [Description]
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.0
	 * 
	 */
	public class Element extends Sprite
	{
		
		//--------------------------------------
		// CLASS CONSTANTS 
		//--------------------------------------
		
		
		//--------------------------------------
		// PUBLIC VARIABLES
		//--------------------------------------		
		//		public var id:String = '';
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function Element()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, initComplete, false, 0, true);
		}
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		
		protected var _drawn:Boolean = false;
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		
		private function initComplete(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initComplete);
			init(e);
			addedToStage(e);
			draw();
			_drawn = true;
		}
		
		//--------------------------------------
		//  SERVER CALLBACKS
		//--------------------------------------
		
		
		//--------------------------------------
		//  PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------
		
		protected function init(e:Event):void
		{
			//initializes children, adds children to stage, instantiates timers
		}
		
		protected function removedFromStage(e:Event):void
		{
			// - removes EventListeners, stops & resets timers, cleans up mem intensive objects
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
		}
		
		protected function addedToStage(e:Event):void
		{
			// - adds EventListeners, plays timers, 
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage, false, 0, true);
			//sub classes must call redraw manually if it is needed
		}
		
		public function destruct():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			// calls destruct on children
			// does not remove children from stage
			// destruction of super class happens after calling destruct on children
			if(parent != null)
				parent.removeChild(this);
		}
		
		protected final function redraw():void
		{
			if(_drawn)
			{
				clear();
				draw();
			}
		}
		
		protected function clear():void
		{
			graphics.clear();
		}
		
		protected function draw():void
		{
			// positions children, render current state, draws graphics
		}
	}
}