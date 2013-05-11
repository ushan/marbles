package org.ushan.marbles.actions
{
	import org.ushan.core.mvc.actions.ActionAbstract;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	
	public class ShowHideInfoAction extends ActionAbstract
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
		
		public function ShowHideInfoAction(initiator:IActionInitiator, show:Boolean)
		{
			super(initiator, ShowHideInfoAction);
			_show = show;
		}
	}
}