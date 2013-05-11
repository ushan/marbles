package org.ushan.tools.curves
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.ushan.geom.PointsUtils;
	
	public class PointsScale extends Sprite
	{
		public function PointsScale()
		{
			super();
			init();
		}
		
		private var pMouse	:PointAnchor;
		private var pInt	:PointAnchor;
		private var pTarget	:PointBezier;
		private var rect	:Rectangle;
		private function init():void
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandle);
			pTarget = new PointBezier(100 + Math.random()*300, 100 + Math.random()*300);
			pMouse = new PointAnchor(100 + Math.random()*300, 100 + Math.random()*300);
			pInt = new PointAnchor(10, 10);
			addChild(pTarget);
			addChild(pMouse);
			addChild(pInt);
			
			rect = new Rectangle (20, 20, 300, 200);
			var sh:Shape = new Shape();
			sh.graphics.lineStyle(1, 0x00ff00);
			sh.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			addChild(sh);
			
		}
		
		private function update(e:MouseEvent):void
		{
			
			var pM:Point = new Point(e.stageX, e.stageY);
			pMouse.x = pM.x;
			pMouse.y = pM.y;
			var pT:Point = new Point(pTarget.x, pTarget.y);
			
			var pNew:Point = PointsUtils.movePointAlongLine(pM, pT, -1);
			pTarget.x = pNew.x;
			pTarget.y = pNew.y;
			
			var pIntterect:Point = PointsUtils.intersectBoxAndSegment(pM, pNew, rect);
			if (pIntterect)
			{
				pInt.x = pIntterect.x;
				pInt.y = pIntterect.y;
			}
			else
			{
				pInt.x = 10;
				pInt.y = 10;
			}
		}
		
		private function updateV2(e:MouseEvent):void
		{
			
			var pM:Point = new Point(e.stageX, e.stageY);
			pMouse.x = pM.x;
			pMouse.y = pM.y;
			var pT:Point = new Point(pTarget.x, pTarget.y);
			
			var pNew:Point = PointsUtils.movePointAlongLine(pM, pT, -2);
			pTarget.x = pNew.x;
			pTarget.y = pNew.y;
		}
		
		private function addedToStageHandle(e:Event):void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, update);
		}
	}
}