package org.ushan.tools.curves
{
	import flash.display.Shape;

	public class PointAnchor extends PointBezierAbstract
	{
		public function PointAnchor(x:uint = 0, y:uint = 0)
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
			shape.graphics.beginFill(0xff0000, 0.7);
			shape.graphics.drawCircle(0, 0, 4);
			trace("-");
		}
	}
}