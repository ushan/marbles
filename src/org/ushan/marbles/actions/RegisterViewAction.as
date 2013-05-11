package org.ushan.marbles.actions
{
	import org.ushan.core.mvc.actions.ActionAbstract;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.marbles.views.View;
	
	public class RegisterViewAction extends ActionAbstract
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _view			:View;
		public function get view()	:View { return _view };
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function RegisterViewAction(initiator:IActionInitiator, view:View)
		{
			super(initiator, RegisterViewAction);
			_view = view;
		}
	}
}