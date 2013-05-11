package org.ushan.marbles.views
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	
	import fl.motion.Color;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.ushan.core.ExtSprite;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.events.ConfigEvent;
	import org.ushan.marbles.events.ControllerEvent;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.utils.ColorObject;

	public class BackGround extends ExtSprite implements IActionInitiator
	{
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model		:Model;
		private var controller	:Controller;
		private var grafRect	:Shape;
		private var image		:Sprite;
		
		private var _tint		:Number = 0;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function BackGround()
		{
			super();
			
		}
		
		//----------------------------------------------------------------------
		//
		//	overreded methods
		//
		//----------------------------------------------------------------------
		
		override protected function onCreationComplete():void
		{
			init();
		}
		
		//----------------------------------------------------------------------
		//
		//	getters / setters
		//
		//----------------------------------------------------------------------
		public function get tint():Number
		{
			return _tint;
		}

		public function set tint(value:Number):void
		{
			_tint = value;
			ColorObject.setTint(this, 0x000000, tint);
		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			initSingletons();
			initListeners();
			
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
			controller = Controller.instance;
		}
		
		private function initListeners():void
		{
			//addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
			controller.addEventListener(ControllerEvent.VIEW_INITED, 
				controller_viewInitedHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.START_GAME, model_startGameHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.WIN, model_winHandler, false, 0, true);
		}
		
		private function initVisual():void
		{
			trace(model.config.sceneWidth);
			width = model.config.sceneWidth;
			height = model.config.sceneHeight;
			
		}
		
		private function clearDark():void
		{
			TweenLite.killTweensOf(this);
			TweenLite.to(this, 5, {tint:0, ease:Quad.easeOut, 
				overwrite:true, useFrames:true});
			
		}
		
		private function makeDark():void
		{
			TweenLite.killTweensOf(this);
			TweenLite.to(this, 10, {tint:100, ease:Quad.easeOut, 
				overwrite:true, useFrames:true});
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function controller_viewInitedHandler (e:ControllerEvent):void
		{
			initVisual();
		}
		
		private function mouseDownHandler(e:MouseEvent):void
		{
		}
		
		private function model_startGameHandler(e:Event):void
		{
			//clearDark();
		}
		
		private function model_winHandler(e:Event):void
		{
			//makeDark();
		}
		
		
	}
}