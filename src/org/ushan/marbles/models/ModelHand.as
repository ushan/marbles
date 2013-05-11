package org.ushan.marbles.models
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.ushan.core.mvc.interfaces.IModel;
	
	public class ModelHand extends EventDispatcher implements IModel
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _x				:Number;
		public function get x()		:Number { return _x};
		
		private var _y				:Number;
		public function get y()		:Number { return _y};
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model		:Model;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		public function ModelHand()
		{
			super();
			init();
		}
		
		//----------------------------------------------------------------------
		//
		//	internal methods
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
			//initListeners();
			
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
			scale = EConfigConstants.PH_SCALE;
			conveyor = new ConveyorBranche();
			
		}
		

	}
}