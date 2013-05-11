package org.ushan.marbles.events
{
	import flash.events.Event;
	
	public class ShowHidePanelEvent extends Event
	{
		public static const SHOW_INFO	:String = "showInfo";
		public static const HIDE_INFO	:String = "hideInfo";
		public static const SHOW_HELP	:String = "showHelp";
		public static const HIDE_HELP	:String = "hideHelp";
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function ShowHidePanelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}