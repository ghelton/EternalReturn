
package datas
{
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jan 28, 2012
	 */
	public class JohnnyData
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		private var _resources:Vector3D = new Vector3D();
		public var maxResourcesRGB:Vector3D = new Vector3D(600,600,600);
		public var magnitude:uint = 0;
		public var position:Point = new Point();
		public var starfieldCoord:Point;  	// coordinates of johnny relative to the starfield
		public var dgRotation:Number = 1.5707; 		// rotation of johnny relative to the starfield
		public var rotationChange:Number = 0;
		public var entropyModifier:Number = 0;
		public var peakEntropyModifier:Number = 0;
		public var timeLeftToShift:Number = 0;
		public var timeShift:Number = 0;
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function JohnnyData($position:Point, $startingResources:Vector3D, $magnitude:uint)
		{
			position = $position;
			_resources = _resources.add($startingResources);
			magnitude = $magnitude;
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		public function get resources():Vector3D
		{
			return _resources;
		}
		
		public function addResources(newResources:Vector3D, awesomeBonusMultiplierThatIsntAtAllAShortComingOfVector3DHack:Number = 1):void
		{
			//resources.add(newResources);
			resources.x += newResources.x * awesomeBonusMultiplierThatIsntAtAllAShortComingOfVector3DHack;
			resources.y += newResources.y * awesomeBonusMultiplierThatIsntAtAllAShortComingOfVector3DHack;
			resources.z += newResources.z * awesomeBonusMultiplierThatIsntAtAllAShortComingOfVector3DHack;
		}
		
		public function get green():Number
		{
			return _resources.y;
		}
		
		public function get red():Number
		{
			return _resources.x;
		}
		
		public function get blue():Number
		{
			return _resources.z;
		}
		
		public function set red(value:Number):void {
			_resources.x += value;
		}
		
		public function set green(value:Number):void {
			_resources.y += value;
		}
		
		public function set blue(value:Number):void {
			_resources.z += value;
		}
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}