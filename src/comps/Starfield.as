package comps
{
	import core.Element;
	
	import flash.events.Event;
	import flash.geom.Point;

	public class Starfield extends Element
	{
		private var _size:Point;
		private var _position:Point;
		public function Starfield($fieldWidth:uint, $fieldHeight:uint)
		{
			_size = new Point($fieldWidth, $fieldHeight);
			_position = new Point(0, 0);
			super();
		}
		
		override protected function init(e:Event):void 
		{
			super.init(e);
		}
		
		override protected function draw():void
		{
			var xLoc:int = _size.x / 2;
			var yLoc:int = _size.y / 2;
			graphics.beginFill(0x000000);
			graphics.drawRect(-xLoc, -yLoc, _size.x, _size.y);
			graphics.endFill();
			this.x = xLoc;
			this.y = yLoc;
			super.draw();
		}
		
		public function resize($fieldWidth:uint, $fieldHeight:uint):void
		{
			_size = new Point($fieldWidth, $fieldHeight);
			redraw();
		}
		
		override public function set rotation(value:Number):void
		{
			super.rotation = value; /// maybe tween this
		}
		
		override public function set x(value:Number):void
		{
			_position.x = value; /// maybe tween this
		}
		
		override public function set y(value:Number):void
		{
			_position.y = value; /// maybe tween this
		}
	}
}