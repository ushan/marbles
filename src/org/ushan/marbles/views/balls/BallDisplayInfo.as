package org.ushan.marbles.views.balls
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.events.ModelEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.models.configs.EConfigConstants;
	import org.ushan.marbles.models.configs.EGameMode;
	
	import su.silin.filters.FishEyeMap;
	
	public class BallDisplayInfo extends Sprite
	{
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model		:Model;
		private var type		:uint = 0;
		private var radius		:uint;
		
		private var texture		:BallTextures;
		private var timeOutId	:uint;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function BallDisplayInfo()
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
			radius = EConfigConstants.DISPLAY_BALL_RADIUS;
			var textureID:uint = type;
			texture = new BallTextures(textureID);
			initSingletons();
			initVisual();
			initListeners();
		}
		private function initSingletons():void
		{
			model = Model.instance;
			
		}
		
		private function initVisual():void
		{
			var shadow:BallDrapShadow = new BallDrapShadow();
			shadow.width = radius * 2;
			shadow.height = radius * 2;
			shadow.cacheAsBitmap = true;
			shadow.alpha = 0.3;
			//addChild(shadow);
			
			var ballMask:Shape = new Shape();
			ballMask.graphics.beginFill(0x0);
			ballMask.graphics.drawCircle(0, 0, radius);
			
			 var body:Sprite = new Sprite();
			body.addChild(texture);
			body.addChild(ballMask);
			body.mask = ballMask;
			addChild(body);
			
			var ballLight:BallLight = new BallLight();
			ballLight.width = radius * 2 + 2;
			ballLight.height = radius * 2 + 2;
			ballLight.cacheAsBitmap = true;
			addChild(ballLight);
			
			body.filters = [new FishEyeMap(2 * radius, 2 * radius).filter];
			
/*			var glowFilter:GlowFilter = new GlowFilter(0xddffee);
			glowFilter.blurX = 16;
			glowFilter.blurY = 16;
			glowFilter.strength = 4;
			glowFilter.quality = BitmapFilterQuality.HIGH;
			var f:Array = [];
			f.push(glowFilter);
			filters = f;*/
		}
		
		private function initListeners():void
		{
			model.addEventListener(GamePlayEvent.START_GAME, model_startGameHandler, 
				false, GamePlayEvent.$ORDER_STARTGAME_BALLDISPLAYINFO, true);
			model.addEventListener(GamePlayEvent.SUCCESS_DROP, model_successDropHandler, 
				false, GamePlayEvent.$ORDER_SUCCESSDROP_BALLDISPLAYINFO, true);
			model.addEventListener(ModelEvent.XML_WAS_INITED, model_xmlWasInitedHandler, 
				false, 0, true);
			

		}
		
		private function updateTextureType():void
		{
			type = model.currentState.nextBallType;
			texture.setTexture(type);
			if (model.currentState.nextBallType != 0)
			{
				flashMarble();
			}
			else
			{
				alpha = 0;
			}

		}
		
		private function setGameMode():void
		{
			if (model.config.nextMarbleEnabled == false)
			{
				visible = false;
			}
			else
			{
				visible = true;
			}
		}
		
		private function flashMarble():void
		{
			TweenLite.killTweensOf(this);
			setGameMode();
			//alpha = 1;
			TweenLite.to(this, 10, {alpha:1, ease:Linear.easeOut, 
				overwrite:true, useFrames:true});
			clearTimeout(timeOutId);
			timeOutId = setTimeout(hide, model.config.nextMarbleTime);
			//trace("flashMarble");
		}
		
		private function hide():void
		{
			TweenLite.to(this, 40, {alpha:0, ease:Linear.easeOut, 
				overwrite:true, useFrames:true});
			
			//run Again
			
			if (model.config.nextMarbleAgainEnabled)
			{
				clearTimeout(timeOutId);
				timeOutId = setTimeout(showAgain, model.config.nextMarbleAgainDelay);
			}
		}
		
		
		private function showAgain():void
		{
			TweenLite.to(this, 10, {alpha:1, ease:Linear.easeOut, 
				overwrite:true, useFrames:true});
			
			clearTimeout(timeOutId);
			timeOutId = setTimeout(hide, model.config.nextMarbleTime);
			
			//visible = false;
		}
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function model_startGameHandler(e:GamePlayEvent):void
		{
			updateTextureType();
		}
		private function model_successDropHandler(e:GamePlayEvent):void
		{
			updateTextureType();
			
		}
		
		private function model_xmlWasInitedHandler(e:ModelEvent):void
		{
			setGameMode();
		}
	}
}