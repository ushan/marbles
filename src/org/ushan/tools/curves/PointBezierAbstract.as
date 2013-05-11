package org.ushan.tools.curves
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class PointBezierAbstract extends Sprite
	{
		public function PointBezierAbstract(x:uint = 0, y:uint = 0)
		{
			super();
			init();
			this.x = x;
			this.y = y;
			
		}
		
		private function init ():void
		{
			useHandCursor = true;
			buttonMode = true;
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			//addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function mouseDownHandler (e:MouseEvent):void
		{
			startDrag();
		}
		
		private function mouseUpHandler (e:MouseEvent):void
		{
			stopDrag();
		}
		
		private function clickHandler (e:MouseEvent):void
		{
		}
		
	}
}