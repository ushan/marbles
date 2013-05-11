package org.ushan.marbles.actions
{
	import org.ushan.core.mvc.actions.ActionAbstract;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.marbles.models.ModelBall;
	
	public class MistakeAction extends ActionAbstract
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
		
		public function MistakeAction(initiator:IActionInitiator, element:ModelBall)
		{
			super(initiator, MistakeAction);
			_element = element;
		}
	}
}