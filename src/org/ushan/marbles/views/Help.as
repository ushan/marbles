package org.ushan.marbles.views
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.events.ConfigEvent;
	import org.ushan.marbles.events.ModelEvent;
	import org.ushan.marbles.events.ShowHidePanelEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.models.configs.EConfigConstants;
	
	public class Help extends MovieClip implements IActionInitiator
	{
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model		:Model;
		private var controller	:Controller;
		private var view		:View;
		//public var piece		:Sprite;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function Help()
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
			visible = false;
			initSingletons();
			//initVisual();
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
			x =  (model.config.sceneWidth - width)/2;
			y = 100;
			var back:Shape = new Shape();
			back.graphics.beginFill(0xffffff, 0.9);
			back.graphics.drawRect(-x, -y, model.config.sceneWidth + 20,
				model.config.sceneHeight + 20);
			back.cacheAsBitmap = true;
			addChildAt(back, 0);
		}
		
		private function setVisualRotatingMode():void
		{
			gotoAndStop(1);

		}
		private function setVisualNoRotatingMode():void
		{
			gotoAndStop(2);
		}
		
		private function initListeners():void
		{
			model.addEventListener(ModelEvent.XML_WAS_INITED, model_xmlWasInitedHandler,
				false, 0, true);
			model.addEventListener(ShowHidePanelEvent.SHOW_HELP, 
				model_showHelpHandler, false, 0, true);
			model.addEventListener(ShowHidePanelEvent.HIDE_HELP, 
				model_hideHelpHandler, false, 0, true);
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		
		private function model_xmlWasInitedHandler(e:ModelEvent):void
		{
			initVisual();
		}
		
		private function model_config_puzzleImageSelectedHandler(e:ConfigEvent):void
		{
		}
		
		private function model_showHelpHandler(e:ShowHidePanelEvent):void
		{
			visible = true;
		}
		
		private function model_hideHelpHandler(e:ShowHidePanelEvent):void
		{
			visible = false;
		}
	}
}