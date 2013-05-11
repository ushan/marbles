package org.ushan.marbles.actions
{
	import flash.geom.Point;
	
	import org.ushan.core.mvc.actions.ActionAbstract;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.marbles.models.ModelBall;
	import org.ushan.marbles.views.balls.ViewBall;
	
	public class DragedElementAction extends ActionAbstract
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
		
		public function DragedElementAction(initiator	:IActionInitiator, 
											element		:ModelBall,
											point		:Point)
		{
			super(initiator, DragedElementAction);
			_element = element;
			_point = point;
		}
	}
}