package org.ushan.marbles.events
{
	import flash.events.Event;
	
	import org.ushan.core.progresses.ProgressTaskAbstract;
	import org.ushan.marbles.models.TimeInfo;
	
	public class ControllerEvent extends Event
	{
		public static const VIEW_INITED			:String = "viewInited";
		public static const PREVIEWS_LOADED		:String = "previewsLoaded";
		public static const SOUNDS_LOADED		:String = "soundsLoaded";
		public static const SET_LOADED			:String = "setLoaded";
		public static const PUZZLE_IMAGE_LOADED	:String = "puzzleImageLoaded";
		public static const TIME_STEP			:String = "teimeStep";
		
		//----------------------------------------------------------------------
		//	private vars
		//----------------------------------------------------------------------
		private var _progressTask	:ProgressTaskAbstract;
		private var _timeInfo		:TimeInfo;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function ControllerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//----------------------------------------------------------------------
		//
		//	getters / setters
		//
		//----------------------------------------------------------------------
		
		public function get progressTask():ProgressTaskAbstract
		{
			return _progressTask;
		}
		
		public function setProgressTask(value:ProgressTaskAbstract):void
		{
			_progressTask = value;
		}
		
		public function get timeInfo():TimeInfo
		{
			return _timeInfo;
		}
		
		public function setTimeInfo(value:TimeInfo):void
		{
			_timeInfo = value;
		}
		

	}
}