package org.ushan.marbles.events
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.ushan.marbles.models.ModelBall;
	import org.ushan.marbles.views.balls.ViewBall;
	
	
	public class GamePlayEvent extends Event
	{
		public static const START_GAME			:String = "startGame";
		public static const APPEAR_COMPLETE		:String = "appearComplete";
		public static const DRAGED_ELEMENT		:String = "dragedElement";
		public static const DROPED_ELEMENT		:String = "dropedElement";
		public static const DROPED_FINISHED		:String = "dropedFinished";
		public static const HAND_MOVE			:String = "handMove";
		public static const SUCCESS_DROP		:String = "successDrop";
		public static const FAILED_DROP			:String = "failedDrop";
		public static const MISTAKE			:String = "mistake";
		public static const STEP				:String = "step";
		public static const WIN					:String = "win";
		
		//----------------------------------------------------------------------
		//	orders
		//----------------------------------------------------------------------

		public static const $ORDER_WIN_HISTORYMANAGER			:uint = 100;
		
		public static const $ORDER_STEP_VIEWBALL				:uint = 100;
		public static const $ORDER_STEP_BALLMATRIXTEXTURE		:uint = 100;
		
		public static const $ORDER_SUCCESSDROP_CURRENTSTATE		:uint = 100;
		public static const $ORDER_SUCCESSDROP_BALLDISPLAYINFO	:uint = 0;
		public static const $ORDER_SUCCESSDROP_DISPLAYINFO		:uint = 0;
		
		public static const $ORDER_STARTGAME_CURRENTSTATE		:uint = 100;
		public static const $ORDER_STARTGAME_BALLDISPLAYINFO	:uint = 0;
		public static const $ORDER_STARTGAME_DISPLAYINFO		:uint = 0;
		
		public static const $ORDER_MISTAKE_CURRENTSTATE			:uint = 100;
		public static const $ORDER_MISTAKE_DISPLAYINFO			:uint = 0;
		
		public static const $ORDER_DROPEDFINISHED_CURRENTSTATE	:uint = 0;
		public static const $ORDER_FAILEDDROP_CURRENTSTATE		:uint = 0;
		
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var _element	:ModelBall;
		private var _point		:Point;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function GamePlayEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//----------------------------------------------------------------------
		//
		//	getters / setters
		//
		//----------------------------------------------------------------------
		
		public function get element():ModelBall
		{
			return _element;
		}
		
		public function setElement(value:ModelBall):void
		{
			_element = value;
		}
		
		public function get point():Point
		{
			return _point;
		}
		
		public function setPoint(value:Point):void
		{
			_point = value;
		}

	}
}