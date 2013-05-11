package org.ushan.marbles.actions
{
	import flash.geom.Point;
	
	import org.ushan.core.mvc.actions.ActionAbstract;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.marbles.models.ModelBall;
	
	public class SuccessDropAction extends ActionAbstract
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _element			:ModelBall;
		public function get element()	:ModelBall { return _element };
		
		private var _point				:Point;
		public function get point()		:Point { return _point };
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function SuccessDropAction(initiator	:IActionInitiator,
										  element	:ModelBall,
										  point		:Point)
		{
			super(initiator, SuccessDropAction);
			_element = element;
			_point = point;
		}
	}
}