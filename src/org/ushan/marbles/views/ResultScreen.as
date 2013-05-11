package org.ushan.marbles.views
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.ushan.core.ExtSprite;
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.events.ConfigEvent;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.utils.StringUtils;
	
	public class ResultScreen extends ExtSprite
	{
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model		:Model;
		private var controller	:Controller;
		private var view		:View;
		
		private var boxWidth	:int = 460;
		private var resultText	:TextField;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function ResultScreen()
		{
			super();
			
		}
		
		//----------------------------------------------------------------------
		//
		//	ovarrided methods
		//
		//----------------------------------------------------------------------
		
		override protected function onCreationComplete():void
		{
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
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
			controller = Controller.instance;
			view = View.instance;
		}
		
		private function initVisual():void
		{
			mouseEnabled = false;
			var container:Sprite = new Sprite();
			addChild(container);

			
/*			var shp:Shape = new Shape();
			shp.graphics.beginFill(0xffffff, 0.2);
			shp.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			container.addChild(shp);*/
			
			
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0xffffff, 0.8);
			sp.graphics.drawRoundRect(0,0,boxWidth,110,15,15);
			container.addChild(sp);

			
			var tf:TextField;
			var format:TextFormat;
			
			tf = new TextField();
			tf.selectable = false;
			tf.mouseEnabled = false;
			tf.width = boxWidth;
			
			tf.text = "Round finished!"
			tf.y = 15;
			
			
			format = new TextFormat();
			format.bold = true;
			format.font = "Verdana"
			format.size = 22;
			format.align = TextFormatAlign.CENTER;
			format.color = 0x000000;
			
			
			tf.setTextFormat(format);
			
			sp.addChild(tf);
			
			resultText = new TextField();
			resultText.multiline = false;
			resultText.selectable = false;
			resultText.mouseEnabled = false;
			resultText.width = boxWidth;
			
			
			//tf.text = "Time passed: " + model.currentState.gameTime.toString();
/*			tf.text = "Mistakes: " + model.currentState.gameTime + 
				";    matched: " + _currentRoundCorrect * 2 + "   from: " +  _numOfAllCards + " cards";*/
			resultText.y = 55;
			
			format = new TextFormat();
			format.bold = true;
			format.font = "Verdana"
			format.size = 16;
			format.align = TextFormatAlign.CENTER;
			format.color = 0x000000;
			
			resultText.defaultTextFormat = format;
			
			sp.addChild(resultText);
			
			setPosition();
		}
		
		private function initListeners():void
		{
			model.addEventListener(GamePlayEvent.START_GAME, model_startGameHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.WIN, model_winHandler, false, 0, true);

		}
		
		private function updateInfo():void
		{
			resultText.text = "Time passed: " + StringUtils.millisecondsToMinSec(model.currentState.gameTime);
		}
		
		private function setPosition():void
		{
			x = (stage.stageWidth - boxWidth) / 2;
			y = stage.stageHeight *  0.45;
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		
		private function model_startGameHandler(e:GamePlayEvent):void
		{
			visible = false;
		}
		
		private function model_winHandler(e:GamePlayEvent):void
		{
			updateInfo();
			if (model.config.showPassedTime)
			{
				visible = true;
			}
		}
	}
}