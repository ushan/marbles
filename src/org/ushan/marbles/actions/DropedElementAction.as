package org.ushan.marbles.actions
{
	import org.ushan.core.mvc.actions.ActionAbstract;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.marbles.models.ModelBall;
	import org.ushan.marbles.views.balls.ViewBall;
	
	public class DropedElementAction extends ActionAbstract
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _element			:ModelBall;
		public function get element()	:ModelBall { return _element };
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function DropedElementAction(initiator:IActionInitiator, element:ModelBall)
		{
			super(initiator, DropedElementAction);
			_element = element;
		}
	}
}