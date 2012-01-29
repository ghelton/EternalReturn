
package core
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Oct 20, 2011
	 */
	public class ParallaxBitmap extends Shape
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		private var _bitmap:BitmapData;
		private var _size:Rectangle;
		private var _translateMatrix:Matrix = new Matrix();
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function ParallaxBitmap(size:Rectangle, bitmapData:BitmapData)
		{
			super();
			_size = size;
			_bitmap = bitmapData;
			redraw();
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	

		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		override public function set x(value:Number):void
		{
			//			trace('parallaxBitmap x:', value);
			_translateMatrix.tx = value;
		}
		
		override public function set y(value:Number):void
		{
			//			trace('parallaxBitmap y:', value);
			_translateMatrix.ty = value;
		}
		
		override public function get y():Number
		{
			return _translateMatrix.ty;
		}
		
		override public function get x():Number
		{
			return _translateMatrix.tx;
		}
		
		public function setScale(value:Number):void
		{
			_translateMatrix.a = _translateMatrix.d = value;
			redraw();
		}
		
		override public function get scaleX():Number
		{
			return _translateMatrix.a;
		}
		
		override public function get scaleY():Number
		{
			return _translateMatrix.d;
		}
		public function redraw():void
		{
			//			trace('parallaxBitmap redraw');
			if(_bitmap != null)
			{
				graphics.clear();
				graphics.beginBitmapFill(_bitmap, _translateMatrix, true, true);
				graphics.drawRect(_size.x, _size.y, _size.width, _size.height);
				graphics.endFill();
			}
		}
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}