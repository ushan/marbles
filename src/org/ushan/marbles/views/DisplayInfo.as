package org.ushan.marbles.views
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.events.ModelEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.models.configs.EGameMode;
	import org.ushan.marbles.views.balls.BallDisplayInfo;
	
	public class DisplayInfo extends MovieClip
	{
		//----------------------------------------------------------------------
		//	instances pn the scene
		//----------------------------------------------------------------------
		public var nextCaption		:TextField;
		public var mistakeCaption	:TextField;
		public var mistakes			:TextField;
		public var packedMarbles	:TextField;
		public var totalMarbles		:TextField;
		public var score			:TextField;
		public var scoreCaption		:TextField;
		public var rightPanel		:Sprite;
		
		public var displayBall		:BallDisplayInfo;
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model		:Model;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		public function DisplayInfo()
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
			stop();
			initSingletons();
			initListeners();
			visible = false;

			initVisual();
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
		}
		
		private function initListeners():void
		{
			model.addEventListener(GamePlayEvent.START_GAME, model_startGameHandler, 
				false, GamePlayEvent.$ORDER_STARTGAME_DISPLAYINFO, true);
			model.addEventListener(GamePlayEvent.SUCCESS_DROP, model_successDropHandler, 
				false, GamePlayEvent.$ORDER_SUCCESSDROP_DISPLAYINFO, true);
			model.addEventListener(GamePlayEvent.MISTAKE, model_mistakeHandler, 
				false, GamePlayEvent.$ORDER_MISTAKE_DISPLAYINFO, true);
			model.addEventListener(ModelEvent.XML_WAS_INITED, model_xmlWasInitedHandler, 
				false, 0, true);
			
		}
		
		private function initVisual():void
		{
			var shadow:DropShadowFilter = new DropShadowFilter(3, 45, 0, 0.6, 3, 3);
			filters = [shadow];
			
		}
		
		private function fill():void
		{
			mistakes.text = model.currentState.mistakesTotal.toString();
			packedMarbles.text = model.currentState.successes.toString();
			totalMarbles.text = model.config.totalMarbles.toString();
			score.text = model.currentState.score.toString();
			
			
			
		}
		
		private function setGameMode():void
		{
			if (model.config.nextMarbleEnabled == false)
			{
				gotoAndStop(2);
				nextCaption.visible = false;
				mistakeCaption.visible = false;
				mistakes.visible = false;
				rightPanel.visible = false;
				
			}
		}
		private function setPosition():void
		{
			nextCaption.x = model.config.sceneWidth - 170 - 6;
			rightPanel.x = model.config.sceneWidth - 180 - 6;
			displayBall.x = model.config.sceneWidth - 37 - 6;
		}
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function model_startGameHandler(e:GamePlayEvent):void
		{
			visible = true;
			fill();
		}
		
		private function model_successDropHandler(e:GamePlayEvent):void
		{
			fill();
		}
		private function model_mistakeHandler(e:GamePlayEvent):void
		{
			fill();
		}
		
		private function model_xmlWasInitedHandler(e:ModelEvent):void
		{
			setGameMode();
			setPosition();
		}
	}
}