package comps
{
	import core.Element;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import org.osmf.layout.AbsoluteLayoutFacet;
		
	public class JohnnySprite extends Element
	{
		
		private var _idle:IdleVessel;
		private var _moving:MovingVessel;
		private var _turnLight:TurnLight;
		private var _turnMild:TurnMild;
		private var _turnMedium:TurnMedium;
		private var _turnHeavy:TurnHeavy;
		private var _bite:JohnnyBite;
		private var _death:JohnnyDeath;
		
		private var _onStage:MovieClip;
	
		public function JohnnySprite()
		{
			super();
			
		}
		
		public function idle():void
		{
			if (_onStage == _idle)
				return
			
			add(_idle);
		}
		
		public function move():void
		{
			if (_onStage == _idle)
				return;
			
			add(_idle);
		}
		
		public function turn(num:Number):void
		{
			
			var index:int = int(num + 6);
				
			add(_turns[index]);
		}
		
		public function die():void
		{
			if (_onStage == _death)
				return;
			
			add(_death);
		}
		
		public function bite():void
		{	
			if (_onStage == _bite)
				return;
			
			add(_bite);
		}
		
		private function add(mov:MovieClip):void
		{	
			if (mov == _onStage)
				return;
			
			addChild(mov);	
			//mov.play();
			
			if (_onStage != null && contains(_onStage))
			{
				removeChild(_onStage);
			}
			
			_onStage = mov;
		}
		
		
		private var _turns:Array;
		override protected function init(e:Event):void
		{
			super.init(e);
			
			_idle = new IdleVessel();
			_moving = new MovingVessel();
			_turnLight = new TurnLight();
			_turnMild = new TurnMild();
			_turnMedium = new TurnMedium();
			_turnHeavy = new TurnHeavy();
			_bite = new JohnnyBite();
			_death = new JohnnyDeath();
			
			_turns = [_turnHeavy, _turnMedium, _turnMedium, _turnMild, _turnLight,_moving, _moving, _turnLight, _turnMild, _turnMedium, _turnMedium, _turnHeavy];
			
			idle();
		}
		
		override protected function removedFromStage(e:Event):void
		{
			super.removedFromStage(e);
			
			
		}
	}
}