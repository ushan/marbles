package org.ushan.marbles.views
{
	import flash.events.Event;
	
	import org.ushan.core.progresses.UniversalProgressoror;
	import org.ushan.marbles.events.ModelEvent;
	import org.ushan.marbles.models.Model;
	
	public class ProgressBar extends UniversalProgressoror
	{
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model:Model;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function ProgressBar()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	overrided methods
		//
		//----------------------------------------------------------------------
		
		override protected function initExtended():void
		{
			initSingletons();
			initListeners();
		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		
		private function setToCenter():void
		{
			x = stage.stageWidth/2;
			y = stage.stageHeight/2;
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
		}
		
		private function initListeners():void
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true);
			model.addEventListener(ModelEvent.PROGRESS_TARGET_CHANGE,
				model_progressTargetChangeHandler, false, 0, true);
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function addedToStageHandler(e:Event):void
		{
			setToCenter();
		}
		
		private function model_progressTargetChangeHandler(e:ModelEvent):void
		{
			setTarget(e.progressTarget);
		}
	}
}