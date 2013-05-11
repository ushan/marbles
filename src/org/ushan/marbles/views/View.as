package org.ushan.marbles.views
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.ui.Mouse;
	
	import org.ushan.core.ExtSprite;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.core.mvc.interfaces.IView;
	import org.ushan.geom.MathUtils;
	import org.ushan.marbles.actions.RegisterViewAction;
	import org.ushan.marbles.actions.SetDebugerAction;
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.events.ConfigEvent;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.events.ModelEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.views.balls.BallsManager;
	import org.ushan.marbles.views.balls.ViewBall;
	import org.ushan.marbles.views.balls.bitmaps.*;
	import org.ushan.marbles.views.controls.StartButton;
	
	public class View extends ExtSprite implements IActionInitiator, IView
	{

		//----------------------------------------------------------------------
		//
		//	singletone
		//
		//----------------------------------------------------------------------
		
		private static var ins:View;
		public static function get instance():View
		{
			return ins;
		}
		
		public function View()
		{
			ins = this;
			//init();
			
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
		
		public function set backImage (value	:Sprite):void {_backImage = value; }
		private var _backImage					:Sprite;
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		public function get debuger()	:Sprite { return _debuger;}
		private var _debuger			:Sprite;
		
		public function get basketBack():BasketBack { return _basketBack;}
		private var _basketBack			:BasketBack;
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model				:Model;
		private var controller			:Controller;
		private var soundManager		:SoundManager;
		private var ballsContainer		:BallsManager;
		private var basketOver			:BasketOver;
		private var startButton			:StartButton;
		private var displayInfo			:DisplayInfo;
/*		private var userInterface		:UserInterface;

		private var back				:BackGround;


		private var winAnimation		:WinAnimation;*/
		private var winAnimation		:WinAnimation;
		private var progressBar			:ProgressBar;
		private var help				:Help;
		private var hand				:Hand;
		
		//----------------------------------------------------------------------
		//
		//	public methods
		//
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			initSingletons();
			initVisual();
			initListeners();
			var now:Date = new Date();
			//if (now.getMonth() > 9 )  visible = false; 
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
			controller = Controller.instance;
			registerViewAction();
			soundManager = new SoundManager();
		}
		
		private function initListeners():void
		{
			model.addEventListener(ModelEvent.XML_WAS_INITED, model_xmlWasInitedHandler, 
				false, 0, true);
			model.addEventListener(GamePlayEvent.START_GAME, model_startGameHandler, 
				false, 0, true);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function initVisual():void
		{
			
			
			_basketBack = new BasketBack();
			
			ballsContainer = new BallsManager();
			addChild(ballsContainer);
			
			displayInfo = new DisplayInfo();
			addChild(displayInfo);
			displayInfo.y = stage.stageHeight - 80;
			
			var resultScreen:ResultScreen = new ResultScreen();
			addChild(resultScreen);
			
			winAnimation = new WinAnimation();
			addChild(winAnimation);
			
			startButton = new StartButton();
			addChild(startButton);
			
			
			initDebuger();
			

			
			progressBar = new ProgressBar();
			addChild(progressBar);
			
			hand = new Hand();
			addChild(hand);
			
		}
		
		private function registerViewAction():void
		{
			var action:RegisterViewAction = new RegisterViewAction(this, this);
			controller.accepViewAction(this, action);
		}
		
		private function initDebuger():void
		{
			_debuger = new Sprite();
			_debuger.mouseEnabled = false;
/*			_debuger.scaleX = 0.6;
			_debuger.scaleY = 0.6;
			_debuger.x = 200;
			_debuger.y = 200;*/
			_debuger.visible = false;
			addChild(debuger);
			setSize();
			
		}
		
		
		private function registerDebuger():void
		{
			var action:SetDebugerAction = new SetDebugerAction(this, _debuger);
			controller.accepViewAction(this, action);
		}
		
		private function setSize():void
		{
			_backImage.width = stage.stageWidth;
			_backImage.height = stage.stageHeight;
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		private function model_xmlWasInitedHandler(e:ModelEvent):void
		{
			registerDebuger();
		}
		
		private function model_startGameHandler(e:GamePlayEvent):void
		{
			//createElements();
			//setGameMode();
			//initMarbles();
			
		}
		
		private function enterFrameHandler(e:Event):void
		{
			
		}
		
		private function model_winHandler(e:GamePlayEvent):void
		{
			
		}
		
		
		private function model_config_puzzleImageSelectedHandler(e:ConfigEvent):void
		{
			//setImage();
			//setViewImageBeforGame();
		}
		

	}
}