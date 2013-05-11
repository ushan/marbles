package org.ushan.core.mvc.actions
{
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	
	public class ShowHideHelpAction extends ActionAbstract
	{
		//----------------------------------------------------------------------
		//	getters
		//----------------------------------------------------------------------
		private var _show			:Boolean;
		public function get show()	:Boolean { return _show };
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function ShowHideHelpAction(initiator:IActionInitiator, show:Boolean)
		{
			super(initiator, ShowHideHelpAction);
			_show = show;
		}
	}
}