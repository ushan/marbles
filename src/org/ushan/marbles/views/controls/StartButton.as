package org.ushan.marbles.views.controls
{
	import fl.controls.Button;
	
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.core.mvc.interfaces.IView;
	import org.ushan.marbles.actions.ToStartGameAction;
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.events.ControllerEvent;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.models.configs.EConfigConstants;
	import org.ushan.marbles.views.View;
	
	[Event(name="org.ushan.marbles.events.GamePlayEvent", type="win")]
	public class StartButton extends Button implements IView, IActionInitiator
	{
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model				:Model;
		private var controller			:Controller;
		private var view				:View;
		
		private var virtualScale		:Number;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		public function StartButton()
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
			hide();
			initSingletons();
			initListeners();
			initVisual();
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
			controller = Controller.instance;
		}
		
		private function initVisual():void
		{
			width = 200;
			height = 80;
			label = "Start";
			var format:TextFormat = new TextFormat();
			format.size = 30;
			setStyle("textFormat", format);
			setPosition();
		}
			
		private function setPosition():void
		{
			
			x = (model.config.sceneWidth - width)/2;
			y = model.config.sceneHeight *  0.3;
		}
		
		private function initListeners():void
		{
			controller.addEventListener(ControllerEvent.SOUNDS_LOADED, 
				controller_soundsLoadedHadler, false, 0, true);
			model.addEventListener(GamePlayEvent.START_GAME,
				model_startGameHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.WIN,
				model_winHandler, false, 0, true);
			addEventListener(MouseEvent.CLICK,
				clickHandler, false, 0, true);
		}
		
		private function hide():void
		{
			visible = false;
		}
		
		private function show():void
		{
			visible = true;
		}
		
		private function sendStartGameAction():void
		{
			var action:ToStartGameAction = new ToStartGameAction(this);
			controller.accepViewAction(this, action);
		}
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function controller_soundsLoadedHadler(e:ControllerEvent):void
		{
			show();
		}
		
		private function model_startGameHandler(e:GamePlayEvent):void
		{
			hide();
		}
		
		private function model_winHandler(e:GamePlayEvent):void
		{
			show();
			y = model.config.sceneHeight *  0.15;
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			sendStartGameAction();
		}
	}
}