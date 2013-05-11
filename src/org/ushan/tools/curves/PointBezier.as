package org.ushan.tools.curves
{
	import flash.display.Shape;

	public class PointBezier extends PointBezierAbstract
	{
		public function PointBezier(x:uint = 0, y:uint = 0)
		{
			super(x, y);
			init();

		}
		
		private function init ():void
		{
			initVisual();
		}
		
		private function initVisual ():void{
			var shape:Shape = new Shape();
			addChild(shape);
			shape.graphics.beginFill(0x0000ff, 0.7);
			shape.graphics.drawCircle(0, 0, 4);
		}
	}
}