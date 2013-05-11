package org.ushan.core.mvc.actions
{
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	
	public class AcceptXMLAction extends ActionAbstract
	{
		//----------------------------------------------------------------------
		//	getters
		//----------------------------------------------------------------------
		private var			_xml	:XML;
		public function get xml()	:XML { return _xml };
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function AcceptXMLAction(initiator:IActionInitiator, xml:XML)
		{
			super(initiator, AcceptXMLAction);
			_xml = xml;
		}
	}
}