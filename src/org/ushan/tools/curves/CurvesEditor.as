package org.ushan.tools.curves
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class CurvesEditor extends Sprite
	{
		private var points:Vector.<PointBezierAbstract>;
		
		public function CurvesEditor()
		{
			super();
			init();
		}
		
		private function init ():void
		{
			var p1:Point = new Point(0, 0);
			var p2:Point = new Point(8.95, 64.05);
			var p3:Point = new Point(-0.5, 91.4);
			var p4:Point = new Point(-10.7, 125.15);
			var p5:Point = new Point(-47.85, 90.2);
			var p6:Point = new Point(-100.9, 48.05);
			var p7:Point = new Point(-100.15, 118);
			var p8:Point = new Point(-101.45, 199);
			var p9:Point = new Point(-42.45, 143.7);
			var p10:Point = new Point(-4.55, 110.8);
			var p11:Point = new Point(1.9, 171.45);
			var p12:Point = new Point(6.5, 199.75);
			var p13:Point = new Point(0, 264.4);
			var points:Vector.<Point> = new Vector.<Point>();
			points.push(p1);
			points.push(p2);
			points.push(p3);
			points.push(p4);
			points.push(p5);
			points.push(p6);
			points.push(p7);
			points.push(p8);
			points.push(p9);
			points.push(p10);
			points.push(p11);
			points.push(p12);
			points.push(p13);
			
			var drawer:BezierPointsEditablesDrawer = new BezierPointsEditablesDrawer(points);
			addChild(drawer);
		}
	}
}