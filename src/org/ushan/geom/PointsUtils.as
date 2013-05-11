package org.ushan.geom
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class PointsUtils
	{
		public static function applyMatrixToVector(points:Vector.<Point>, 
												   matrix:Matrix, 
												   isCopy:Boolean = true):Vector.<Point>
		{
			var pointsTransformed:Vector.<Point>
			if (isCopy)
			{
				pointsTransformed = new Vector.<Point>();
			}
			else
			{
				pointsTransformed = points;
			}
			for (var i:uint = 0; i<points.length; i++)
			{
				var point:Point = applyMatrixToPoint(points[i], matrix);
				pointsTransformed.push(point);
			}
			return pointsTransformed;
		}
		

		public static function applyMatrixToPoint(	point:Point, 
											matrix:Matrix, 
											isCopy:Boolean = true):Point
		{
			var pointTransformed:Point;
			if (isCopy)
			{
				pointTransformed = new Point();
			}
			else
			{
				pointTransformed = point;
			}
			var p:Point = point;
			var m:Matrix = matrix;
			pointTransformed.x = p.x * m.a + p.y*m.c + m.tx; 
			pointTransformed.y = p.x * m.b + p.y*m.d + m.ty; 
			return pointTransformed;
		}
		
		
		public static  function getMatrixTransformByVerticalPoints(
													pStartProto			:Point, 
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
			var skewMatrix:Matrix = new Matrix(1, 0, skewXTrnasform, 1, 0, 0);
			matrix.concat(skewMatrix);
			matrix.translate(p3.x, p3.y);
			return matrix;
			
		}
		
		public static  function randemizeInnerPoints(points:Vector.<Point>, ampl:Number):void
		{
			for (var i:uint = 1; i < points.length - 1; i++)
			{
				points[i].x = points[i].x + MathUtils.random(-ampl, ampl);
				points[i].y = points[i].y + MathUtils.random(-ampl, ampl);
			}
		}
			
		public static  function getMatrixTransformByHorizontalPoints(
													pStartProto			:Point, 
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
			var skewYTrnasform:Number = (p4.y - p3.y)/transformedWidth;
			var matrix:Matrix = new Matrix();
			matrix.a = scaleTransform;
			matrix.d = scaleTransform;
			var skewMatrix:Matrix = new Matrix(1, skewYTrnasform, 0, 1, 0, 0);
			matrix.concat(skewMatrix);
			matrix.translate(p3.x, p3.y);
			return matrix;
			
		}
		
		public static function rotate90(points:Vector.<Point>, isCopy:Boolean = true):Vector.<Point>
		{
			var pointsResult:Vector.<Point>
			if (isCopy)
			{
				pointsResult = new Vector.<Point>();
				
			}
			else
			{
				pointsResult = points;
			}
			for (var i:uint = 0; i<points.length; i++)
			{
				if (isCopy)
				{
					var point:Point = new Point();
					pointsResult.push(point);
				}
				var xPos:Number =  points[i].x;
				pointsResult[i].x = points[i].y;
				pointsResult[i].y = xPos;
			}
			return pointsResult;
		}
/*		public static  function getMatrixTransformByVerticalPoints(pStartProto			:Point, 
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
			
		}*/
		
		public static function scaleDistanceAlongLine(p1:Point, p2:Point, scale:Number):Point
		{
			var angle:Number = Math.atan2(p2.x - p1.x, p1.y - p2.y);
			var len:Number = Point.distance(p1, p2)*scale;
			var pNew:Point = Point.polar(len, angle);
			return pNew;
		}
		
		public static function movePointAlongLine(pZero:Point, pTarget:Point, distance:Number):Point
		{
			
			var angle:Number = Math.atan2(pTarget.y - pZero.y, pTarget.x - pZero.x);
			var len:Number = Point.distance(pZero, pTarget) + distance;
			var pDisplace:Point = Point.polar(len, angle);
			var angle2:Number = Math.atan2(pDisplace.y - pZero.y, pDisplace.x - pZero.x);
			var pNew:Point = new Point (pZero.x + pDisplace.x, pZero.y + pDisplace.y); 
			return pNew;
		}
		
		public static function movePointAlongLineInBox(	pZero		:Point, 
														pTarget		:Point, 
												 	 	distance	:Number,
														rect		:Rectangle):Point
		{

			var angle:Number = Math.atan2(pTarget.y - pZero.y, pTarget.x - pZero.x);
			var len:Number = Point.distance(pZero, pTarget) + distance;
			var pDisplace:Point = Point.polar(len, angle);
			var angle2:Number = Math.atan2(pDisplace.y - pZero.y, pDisplace.x - pZero.x);
			var pNew:Point = new Point (pZero.x + pDisplace.x, pZero.y + pDisplace.y);
			
			var intresectP:Point = intersectBoxAndSegment(pZero, pNew, rect);
			
			var pTarget:Point;
			if (intresectP)
			{
				PointsUtils.roundPoint(intresectP);
				pNew = intresectP;
			}
			return pNew;
		}
		
		public static function getAngleBetweenPoints(zero:Point, target:Point):Number
		{
			//ha-ha
			var angle:Number = Math.atan2(target.y - zero.y, target.x - zero.x);  
			return angle;
		}
		
		public static function intersectBoxAndSegment(p1:Point, p2:Point, rect:Rectangle):Point
		{

			var p:Point;
			var topRight:Point = new Point(rect.right, rect.top);
			var bottomLeft:Point = new Point(rect.left, rect.bottom);
			p = intersect2Segments(p1, p2, rect.topLeft, topRight);
			var s:String;
			if (!p) 
			{
				p = intersect2Segments(p1, p2, topRight, rect.bottomRight);
				s = "topRight, rect.bottomRight" + topRight + rect.bottomRight;
			}
			else
			{
				s = "rect.topLeft, topRight" + bottomLeft + rect.bottomRight;
			}
			if (!p) 
			{
				p = intersect2Segments(p1, p2, bottomLeft, rect.bottomRight);
				s = "bottomLeft, rect.bottomRight" + bottomLeft + rect.bottomRight;
			}
			if (!p) 
			{
				p = intersect2Segments(p1, p2, bottomLeft, rect.topLeft);
				s = "bottomLeft, rect.bottomRight" + bottomLeft + rect.bottomRight;
			}
			return p;
		}
		
		/**
		 * Calculates an intersection between two line segments.
		 *
		 * @param       a1      the first end point of the first line segment.
		 * @param       b1      the second end point of the first line segment.
		 * @param       a2      the first end point of the second line segment.
		 * @param       b2      the second end point of the second line segment.
		 *
		 * @return
		 */
		public static function intersect2Segments(a1:Point, b1:Point, a2:Point, b2:Point):Point 
		{
			
			if (a1.equals(a2) || a1.equals(b2))
			{
				return a1.clone();
			}
			
			if (b1.equals(a2) || b1.equals(b2))
			{
				return b1.clone();
			}
			
			var x1:Number = a1.x;
			var y1:Number = a1.y;
			var x2:Number = b1.x;
			var y2:Number = b1.y;
			
			var x3:Number = a2.x;
			var y3:Number = a2.y;
			var x4:Number = b2.x;
			var y4:Number = b2.y;
			
			var UBottom:Number = ((y4-y3)*(x2-x1))-((x4-x3)*(y2-y1));
			if (UBottom != 0) 
			{
				var Ua:Number = (((x4-x3)*(y1-y3))-((y4-y3)*(x1-x3)))/UBottom;
				var Ub:Number = (((x2-x1)*(y1-y3))-((y2-y1)*(x1-x3)))/UBottom;
				if ((Ua>=0) && (Ua<=1) && (Ub>=0) && (Ub<=1)) 
				{
					var i:Point = new Point();
					i.x = x1+(Ua*(x2-x1));
					i.y = y1+(Ua*(y2-y1));
					return i;
				}
			}
			return null;
			
		}

		
		/**
		 Returns the point of intersection between two lines.
		 
		 Parameters:
		 p1, p2 - two points on first line
		 p3, p4 - two points on second line
		 
		 Returns:
		 Point of intersection
		 */
		public static function intersect2Lines(p1:Point, p2:Point, p3:Point, p4:Point):Point
		{
			var x1:Number = p1.x; var y1:Number = p1.y;
			var x4:Number = p4.x; var y4:Number = p4.y;
			
			var dx1:Number = p2.x - x1;
			var dx2:Number = p3.x - x4;
			
			if (!dx1 && !dx2) return null; // new Point(NaN, NaN);
			
			var m1:Number = (p2.y - y1) / dx1;
			var m2:Number = (p3.y - y4) / dx2;
			
			if (!dx1) {
				// infinity
				return new Point(x1, m2 * (x1 - x4) + y4);
			} else if (!dx2) {
				// infinity
				return new Point(x4, m1 * (x4 - x1) + y1);
			}
			var xInt:Number = (-m2 * x4 + y4 + m1 * x1 - y1) / (m1 - m2);
			var yInt:Number = m1 * (xInt - x1) + y1;
			
			return new Point(xInt, yInt);
		}

		/**
		 * Will always give back a positive angle between 0 and 360
		 *
		 * @param a The angle.
		 */
		public static function resolveAngle(a:Number):Number
		{
			var mod:Number = a % 360;
			return (mod < 0) ? 360 + mod : mod;
		}
		
		public static function roundPoint(p:Point):void
		{
			p.x = Math.round(p.x);
			p.y = Math.round(p.y);
		}

		public static function getRandomRectanglePoint(r	:Rectangle, 
													   area	:Number, 
													   start:Number = 0,
														end	:Number = 1):Point
		{
			var pos:Number = MathUtils.random(start, end);
			var p:Point = new Point;
			var perim:Number = 2*(r.width  + r.height);
			var absPos:Number = perim * pos;
			switch (true)
			{
				case (absPos > 0 && absPos <= r.width):
					p.y = r.top;
					p.x = r.left + absPos;
					break;
				case (absPos > r.width && absPos <= r.width + r.height):
					p.x = r.right;			
					p.y = r.top + (absPos - r.width);
					break;
				case (absPos > r.width + r.height && absPos <= 2*r.width + r.height):
					p.y = r.bottom;
					p.x = r.right - (absPos - r.width - r.height);
					break;			
				case (absPos > 2*r.width + r.height && absPos <=  perim):
					p.x = r.left;
					p.y = r.bottom - (absPos - 2*r.width - r.height);
					break;				
				default:
					throw new Error("UError. Extend out of range");
			}
			var blurX:Number = MathUtils.random(-area, area);
			var blurY:Number = MathUtils.random(-area, area);
			p.x = p.x + blurX;
			p.y = p.y + blurY;
			return p;
		}
	

	}
}