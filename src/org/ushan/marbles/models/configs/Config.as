package org.ushan.marbles.models.configs
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	
	import org.ushan.marbles.models.Model;
	import org.ushan.utils.StringUtils;

	public class Config extends EventDispatcher
	{
		//----------------------------------------------------------------------
		//	readOnly 
		//----------------------------------------------------------------------
		
		private  var _sceneWidth					:Number;
		public function get sceneWidth()			:Number { return _sceneWidth}
		
		private  var _sceneHeight					:Number;
		public function get sceneHeight()			:Number { return _sceneHeight}
		
		private  var _nextMarbleEnabled				:Boolean;
		public function get nextMarbleEnabled()		:Boolean { return _nextMarbleEnabled}
		
		private  var _movingBasket					:Boolean;
		public function get movingBasket()			:Boolean { return _movingBasket}
		
		private  var _totalMarbles					:uint;
		public function get totalMarbles()			:uint { return _totalMarbles}
		
		private  var _marblesAppearDelay			:uint;
		public function get marblesAppearDelay()	:uint { return _marblesAppearDelay}
		
		private  var _marbleMin						:uint;
		public function get marbleMin()				:uint { return _marbleMin}
		
		private  var _marbleMax						:uint;
		public function get marbleMax()				:uint { return _marbleMax}
		
		private  var _nextMarbleTime				:uint;
		public function get nextMarbleTime()		:uint { return _nextMarbleTime}
		
		public function get handGribGrab()			:uint { return _handGribGrab}
		private  var _handGribGrab					:uint;
		
		public function get handRightLeft()			:uint { return _handRightLeft}
		private  var _handRightLeft					:uint;
		
		public function get hitAreaRadius()			:Number { return _hitAreaRadius}
		private  var _hitAreaRadius					:Number;
		
		public function get showArea()				:Boolean { return _showArea}
		private  var _showArea						:Boolean;
		
		public function get nextMarbleAgainEnabled():Boolean { return _nextMarbleAgainEnabled}
		private  var _nextMarbleAgainEnabled		:Boolean;
		
		public function get nextMarbleAgainDelay()	:uint { return _nextMarbleAgainDelay}
		private  var _nextMarbleAgainDelay			:uint = 0;
		
		public function get bonus()	:				uint { return _bonus}
		private  var _bonus							:uint = 0;
		
		public function get bonusIncrement()		:uint { return _bonusIncrement}
		private  var _bonusIncrement				:uint = 0;
		
		
		public function get showPassedTime()		:Boolean { return _showPassedTime}
		private  var _showPassedTime				:Boolean;
		
		//----------------------------------------------------------------------
		//	getters private
		//----------------------------------------------------------------------
		
		private var _xml			:XML;
		private var _userID			:uint;
		private var _handSize		:Number;
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model	:Model;
		private var usersSO	:SharedObject;

		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function Config()
		{
			init();
		}
		
		//----------------------------------------------------------------------
		//
		//	public methods
		//
		//----------------------------------------------------------------------
		
		public function setStageSize(initiator:Model, stage:Stage):void
		{
			_sceneWidth = stage.stageWidth;
			_sceneHeight = stage.stageHeight;
		}
		
		//----------------------------------------------------------------------
		//
		//	getters / setters
		//
		//----------------------------------------------------------------------
		
		public function get userID():uint
		{
			return _userID;
		}
		
		public function get xml():XML
		{
			return _xml;
		}
		
		public function setXml(initiator:Model, value:XML):void
		{
			_xml = value;
			parseXML();
		}
		
		public function get handSize():Number
		{
			return _handSize;
		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			model = Model.instance;
		}
		
		private function parseXML():void
		{
			_nextMarbleEnabled = StringUtils.parseBoolean(_xml.Config.NextMarbleEnabled[0]);
			_movingBasket = StringUtils.parseBoolean(_xml.Config.MovingBasket[0]);
			var basketSpeed:Number = parseFloat(_xml.Config.Basket[0].@speed)
			if (basketSpeed < 1)
			{
				_movingBasket = false;
			}
			_userID = parseInt(_xml.Config.UserID);
			_handSize = parseFloat(_xml.Config.HandSize);
			_handGribGrab = parseInt(_xml.Config.HandGribGrab[0]);
			_handRightLeft = parseInt(_xml.Config.HandRightLeft[0]);
			_totalMarbles = parseInt(_xml.Config.MarblesCount);
			_marblesAppearDelay = Math.round(parseFloat(_xml.Config.MarblesAppearDelay) * 31);
			_marbleMin = parseInt(_xml.Config.Marble[0].@radiusMin);
			_marbleMax = parseInt(_xml.Config.Marble[0].@radiusMax);
			_showArea = StringUtils.parseBoolean(_xml.Config.Marble[0].@showArea);
			_hitAreaRadius = parseFloat(_xml.Config.Marble[0].@hitAreaRadius);
			_nextMarbleTime = parseInt(_xml.Config.NextMarbleTime[0]);
			
			_nextMarbleAgainEnabled = StringUtils.parseBoolean(_xml.Config.NextMarbleAgainEnabled[0]);
			if (_nextMarbleAgainEnabled)
			{
				_nextMarbleAgainDelay = parseInt(_xml.Config.NextMarbleAgainDelay[0]);
			}
			
			_bonus = parseInt(_xml.Config.Bonus[0]);
			_bonusIncrement = parseInt(_xml.Config.ScorePoint[0]);
			_showPassedTime = StringUtils.parseBoolean(_xml.Config.ShowPassedTime[0]);
			

		}
		
	}
}