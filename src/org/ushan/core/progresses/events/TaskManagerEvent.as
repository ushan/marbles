package org.ushan.core.progresses.events
{
	import flash.events.Event;
	
	public class TaskManagerEvent extends Event
	{
		public function TaskManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}