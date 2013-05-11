package org.ushan.tools.curves
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Transform;
	
	import org.ushan.puzzle.models.LineAbstruct;
	
	public class BezierPointsEditablesDrawer extends Sprite
	{
		private var _points					:Vector.<Point>;
		public function get points()		:Vector.<Point> {return _points}
		
		private var _pointsBezier			:Vector.<PointBezierAbstract>;
		public function get pointsBezier()	:Vector.<Point> {return _points}
		
		private var shape:Shape;
		
		public function BezierPointsEditablesDrawer(points:Vector.<Point>)
		{
			super();
			_points = points;
			//Num of points mu
			if (points.length/2 == Math.round(points.length/2))
			{
				throw new Error("UError. Point has not an anchor points");
			}
			init();
		}
		
		private function init():void
		{
			initPoints();
			initVisual();
			initListeners();
		}
		
		private function initPoints():void
		{
			_pointsBezier = new Vector.<PointBezierAbstract>();
			for (var i:uint = 1; i<_points.length; i+=2)
			{
				var point:Point = _points[i-1];
				var pointBezier:PointBezier = new PointBezier();
				pointBezier.x = point.x;
				pointBezier.y = point.y;
				var pointAnchor:PointAnchor = new PointAnchor();
				point = _points[i];
				pointAnchor.x = point.x;
				pointAnchor.y = point.y;
				_pointsBezier.push(pointBezier);
				_pointsBezier.push(pointAnchor);
				addChild(pointBezier);
				addChild(pointAnchor);
			}
			//Last point
			point = _points[_points.length-1];
			pointBezier = new PointBezier();
			pointBezier.x = point.x;
			pointBezier.y = point.y;
			_pointsBezier.push(pointBezier);
			addChild(pointBezier);

		}
		
		private function initVisual():void
		{
			shape = new Shape();
			addChild(shape);
		}
		
		private function initListeners():void
		{
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		private function update():void
		{
			shape.graphics.clear();
			shape.graphics.lineStyle(1, 0x00ff00);
			shape.graphics.moveTo(_pointsBezier[0].x, _pointsBezier[0].y);
			
			for (var i:uint = 1; i<_pointsBezier.length; i+=2)
			{
				var pointAnchor:PointAnchor = _pointsBezier[i] as PointAnchor;
				var pointBezier:PointBezier = _pointsBezier[i+1] as PointBezier;
				
					shape.graphics.curveTo(pointAnchor.x, pointAnchor.y, 
					pointBezier.x, pointBezier.y);
			}
		}
		
		private function pointsToAS():void
		{
			for (var i:uint = 0; i<_pointsBezier.length; i++)
			{
				var point:PointBezierAbstract = _pointsBezier[i];
				var pX:Number = point.x;
				var pY:Number = point.y;
			}
			for (i = 0; i<_pointsBezier.length; i++)
			{

			}
		}
		
		private function movePoints(point:Point):void
		{
			for (var i:uint = 0; i<_pointsBezier.length; i++)
			{
				_pointsBezier[i].x +=point.x;
				_pointsBezier[i].y +=point.y;

			}
		}
		
		private function flipX():void
		{
			for (var i:uint = 0; i<_pointsBezier.length; i++)
			{
				_pointsBezier[i].x = - _pointsBezier[i].x;

			}
		}
		
		private function Rotate90():void
		{
			for (var i:uint = 0; i<_pointsBezier.length; i++)
			{
				var xPos:Number =  _pointsBezier[i].x;
				_pointsBezier[i].x = _pointsBezier[i].y;
				_pointsBezier[i].y = xPos;
			}
		}
		
		private function flipY():void
		{
			for (var i:uint = 0; i<_pointsBezier.length; i++)
			{
				_pointsBezier[i].y = - _pointsBezier[i].y;

			}
		}
		
		private function copyToPoints(points:Vector.<PointBezierAbstract>):Vector.<Point>
		{
			var pointsReturned:Vector.<Point> = new Vector.<Point>();
			for (var i:uint = 0; i<_pointsBezier.length; i++)
			{
				var point:Point = new Point (	_pointsBezier[i].x,
												_pointsBezier[i].y);
				pointsReturned.push(point);

			}
			return pointsReturned;
		}
		
		
		private function applyToBezierPoints(points:Vector.<Point>):void
		{
			for (var i:uint = 0; i<_pointsBezier.length; i++)
			{
				_pointsBezier[i].x = points[i].x;
				_pointsBezier[i].y = points[i].y;	
							
			}
		}
		
		private function applyTransform():void
		{
			var pointsSimple:Vector.<Point> = copyToPoints(_pointsBezier);
			var p1:Point = new Point(1, 3);
			var p2:Point = new Point(0, 10);
			var p3:Point = new Point(0, 0);
			var p4:Point = new Point(10, 10);
			var matrix:Matrix = getTransformByPointsVertical(p1, p2, p3, p4);
			_points = applyMatrix(pointsSimple, matrix);

			applyToBezierPoints(_points);
			
		}
		
		private function getTransformByPointsVertical(pStartProto		:Point, 
													pEndProto			:Point,
													pStartTrnasformed	:Point,
													pEndTransformed		:Point):Matrix
		{
			var p1:Point = pStartProto;
			var p2:Point = pEndProto;
			var p3:Point = pStartTrnasformed;
			var p4:Point = pEndTransformed;
			var lenProto:Number = Point.distance(p1, p2);
			var lenTransformed:Number = Point.distance(p3, p4);
			var transformedHeight:Number = p4.y - p3.y;
			var protoHeight:Number = p2.y - p1.y;
			var scaleTransform:Number = transformedHeight/protoHeight;
			var skewXTrnasform:Number = (p4.x - p3.x)/transformedHeight;
			var matrix:Matrix = new Matrix();
			matrix.a = scaleTransform;
			matrix.d = scaleTransform;
			matrix.translate(p3.x, p3.y);
			var skewMatrix:Matrix = new Matrix(1, 0, skewXTrnasform, 1, 0, 0);
			matrix.concat(skewMatrix);
			return matrix;
			
		}
		
		private function getTransformByPointsHorizontal(pStartProto		:Point, 
													pEndProto			:Point,
													pStartTrnasformed	:Point,
													pEndTransformed		:Point):Matrix
		{
			var p1:Point = pStartProto;
			var p2:Point = pEndProto;
			var p3:Point = pStartTrnasformed;
			var p4:Point = pEndTransformed;
			var lenProto:Number = Point.distance(p1, p2);
			var lenTransformed:Number = Point.distance(p3, p4);
			var transformedWidth:Number = p4.x - p3.x;
			var protoWidth:Number = p2.x - p1.x;
			var scaleTransform:Number = transformedWidth/protoWidth;
			var skewXTrnasform:Number = (p4.y - p3.y)/transformedWidth;
			var matrix:Matrix = new Matrix();
			matrix.a = scaleTransform;
			matrix.d = scaleTransform;
			matrix.translate(p3.x, p3.y);
			var skewMatrix:Matrix = new Matrix(1, skewXTrnasform, 0, 1, 0, 0);
			matrix.concat(skewMatrix);
			return matrix;
			
		}
		
		private function applyMatrix(points:Vector.<Point>, matrix:Matrix):Vector.<Point>
		{
			var pointsTransformed:Vector.<Point> = new Vector.<Point>();
			for (var i:uint = 0; i<points.length; i++)
			{
				var point:Point = applyMatrixToPoint(points[i], matrix);
				pointsTransformed.push(point);
			}
			return pointsTransformed;
		}
		
		private function applyMatrixToPoint(point:Point, matrix:Matrix):Point
		{
			var p:Point = point;
			var pointTransformed:Point = new Point();
			var m:Matrix = matrix;
			pointTransformed.x = p.x * m.a + p.y*m.c + m.tx; 
			pointTransformed.y = p.x * m.b + p.y*m.d + m.ty; 
			return pointTransformed;
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function enterFrameHandler(e:Event):void
		{
			update();
		}
		
		private function keyDownHandler(e:KeyboardEvent):void
		{
			if (e.keyCode == 37) flipX();
			if (e.keyCode == 38) Rotate90();
			if (e.keyCode == 40) applyTransform();
			if (e.keyCode == 32) pointsToAS();
		}
	}
}