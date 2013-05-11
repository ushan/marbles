package org.ushan.marbles.views
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Quad;
	
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.geom.MathUtils;
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.events.ConfigEvent;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.models.configs.EConfigConstants;
	import org.ushan.marbles.views.anims.ColorfulFireworks;
	import org.ushan.marbles.views.anims.Firework;
	import org.ushan.marbles.views.anims.Star;
	import org.ushan.utils.ColorObject;

	public class WinAnimation extends MovieClip implements IActionInitiator
	{
		//----------------------------------------------------------------------
		//	instances on scene
		//----------------------------------------------------------------------
		public var circle1	:Sprite;
		public var circle2	:Sprite;
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model		:Model;
		private var controller	:Controller;
		private var view		:View;
		
		private var counter		:uint;
		
		private var colorfulFireworks	:ColorfulFireworks;
		
		
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function WinAnimation()
		{
			super();
			init();
		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			visible = false;
			initSingletons();
			initVisual();
			initListeners();
			setPosition();
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
			controller = Controller.instance;
			view = View.instance;
		}
		
		private function initVisual():void
		{

		}
		
		private function initListeners():void
		{
			model.addEventListener(GamePlayEvent.START_GAME, model_startGameHandler, 
				false, 0, true);
			model.addEventListener(GamePlayEvent.WIN, model_winHandler, 
				false, 0, true);
		}
		

		private function setPosition():void
		{
			//x = EConfigConstants.SCENE_WIDTH/2;
			//y = EConfigConstants.SCENE_HEIGHT/2;
/*			x = -200;
			y = -160;*/
		}
		
		private function playAnimation():void
		{
			visible = true;
			colorfulFireworks = new ColorfulFireworks();
			addChild(colorfulFireworks);
			colorfulFireworks.start();
			
			TweenLite.killTweensOf(this);
			TweenLite.to(this, 20, {alpha:1, onComplete:onPlayAnimationComlete, ease:Linear.easeOut, 
				overwrite:true, useFrames:true});
			
			//addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
		}
		
		private function onPlayAnimationComlete():void
		{
			
		}	 
		
		private function stopAnimation():void
		{
			TweenLite.killTweensOf(this);
			TweenLite.to(this, 20, {alpha:0, ease:Linear.easeOut, 
				overwrite:true, onComplete:onStopAnimationComlete, useFrames:true});
			//removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function onStopAnimationComlete():void
		{
			visible = false;
			if (colorfulFireworks && contains(colorfulFireworks)) removeChild(colorfulFireworks);
		}
		
		private function addFirework():void
		{
			var fire:Firework = new Firework();
			fire.x = MathUtils.randRangeInt(150, model.config.sceneWidth - 150);
			fire.y = MathUtils.randRangeInt(150, model.config.sceneHeight - 150);
			fire.scaleX = MathUtils.random(0.6, 3);
			fire.scaleY = fire.scaleX;

			addChild(fire);
			//fire.blendMode = BlendMode.HARDLIGHT;
			
		}
		
		private function addFirework2():void
		{

		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		

		private function model_winHandler(e:GamePlayEvent):void
		{
			
			playAnimation();
		}
		
		private function model_startGameHandler(e:GamePlayEvent):void
		{
			stopAnimation();
		}
		
		private function enterFrameHandler(e:Event):void
		{
			counter++;
			
			var delim:uint = MathUtils.randRangeInt(12, 26);
			if (counter / delim ==  Math.round(counter / delim))
			{
				addFirework();
			}
		}

	}
}