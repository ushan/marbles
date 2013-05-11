package org.ushan.core.events
{
	import flash.events.Event;
	
	public class SpriteEvent extends Event
	{
		public static const CREATION_COMPLETE:String = "creationComplete";
		public function SpriteEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}