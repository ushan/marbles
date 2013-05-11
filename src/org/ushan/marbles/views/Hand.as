package org.ushan.marbles.views
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.easing.Linear;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	import org.ushan.core.ExtMovieClip;
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.events.ModelEvent;
	import org.ushan.marbles.models.Model;

	public class Hand extends ExtMovieClip
	{
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model				:Model;
		private var controller			:Controller;
		private var view				:View;
		
		private var virtualScale		:Number;
		
		private var handGribGrab		:uint;
		private var handRightLeft		:uint;
		private var normalHandFrame		:uint;
		private var holdHandFrame		:uint;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function Hand()
		{
			super();
			stop();
			visible = false;
			init();
			
		}
		
		
		
		//----------------------------------------------------------------------
		//
		//	overreded methods
		//
		//----------------------------------------------------------------------
		
		override protected function onCreationComplete():void
		{
			//init();
		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			initSingletons();
			model.addEventListener(ModelEvent.XML_WAS_INITED, 
				model_xmlWasInitedHadler, false, 0, true);
			
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
			controller = Controller.instance;
			view = View.instance;
		}
		
		private function initHand():void
		{
			if (model.config.handSize > 0)
			{
				virtualScale = model.config.handSize / 100;
				scaleX = virtualScale;
				scaleY = virtualScale;
				mouseEnabled = false;
				visible = true;
				Mouse.hide();
				initListeners();
				
				handGribGrab = model.config.handGribGrab;
				handRightLeft = model.config.handRightLeft;
				
				switch (true)
				{
					case handGribGrab == 0 && handRightLeft == 0:
						normalHandFrame = 1;
						holdHandFrame = 2;
						break;
					case handGribGrab == 0 && handRightLeft == 1:
						normalHandFrame = 3;
						holdHandFrame = 4;
						break;
					case handGribGrab == 1 && handRightLeft == 0:
						normalHandFrame = 5;
						holdHandFrame = 6;
						break;
					case handGribGrab == 1 && handRightLeft == 1:
						normalHandFrame = 7;
						holdHandFrame = 8;
						break;
					default:
						normalHandFrame = 1;
						holdHandFrame = 2;
						
				}
				
				setNormal();
			}
			else
			{
				visible = false;
			}
		}
		
		private function initListeners():void
		{
			
			model.addEventListener(GamePlayEvent.DRAGED_ELEMENT, 
				model_dragedElementHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.DROPED_ELEMENT, 
				model_dropedElementHandler, false, 0, true);
			
			model.addEventListener(GamePlayEvent.HAND_MOVE, 
				model_moveHandEvent, false, 0, true);
			//addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
			
		}
		
		private function setDrag():void
		{
			gotoAndStop(holdHandFrame);
		}
		
		private function setNormal():void
		{
			gotoAndStop(normalHandFrame);
		}
		
		private function updateMove():void
		{
			var mousePoint:Point = new Point(mouseX, mouseY);
			mousePoint = localToGlobal(mousePoint);
			
			x = mousePoint.x;
			y = mousePoint.y;
			
			var elbow:Point = new Point (stage.stageWidth * 0.4, stage.stageHeight * 1.2);
			rotation = Math.atan2(elbow.y - y, elbow.x - x) * 180 / Math.PI - 90;
		}

		private function updateStep():void
		{
			scaleX = virtualScale*model.ballManager.selected.h;
			scaleY = scaleX;
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function model_dragedElementHandler(e:GamePlayEvent):void
		{
			setDrag();
			model.addEventListener(GamePlayEvent.STEP, model_stepHandler, false, 0, true);
			TweenLite.killTweensOf(this);
		}
		
		private function model_dropedElementHandler(e:GamePlayEvent):void
		{
			setNormal();
			model.removeEventListener(GamePlayEvent.STEP, model_stepHandler);
			TweenLite.to(this, 5, {scaleX:virtualScale, ease:Linear.easeInOut, 
				overwrite:false, useFrames:true});
			TweenLite.to(this, 5, {scaleY:virtualScale, ease:Linear.easeInOut, 
				overwrite:false, useFrames:true});
		}
		
		private function model_xmlWasInitedHadler(e:ModelEvent):void
		{
			initHand();
		}
		
		private function model_stepHandler(e:GamePlayEvent):void 
		{
			updateStep();
		}
		
		private function model_moveHandEvent(e:GamePlayEvent):void
		{
			updateMove();
		}
	}
}