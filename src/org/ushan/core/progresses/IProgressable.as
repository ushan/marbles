package org.ushan.core.progresses
{
	import flash.events.IEventDispatcher;

	[Event(name="START", type="org.ushan.progresses.ProgressEventAbstract")]
	[Event(name="PROGRESS", type="org.ushan.progresses.ProgressEventAbstract")]
	[Event(name="COMPLETE", type="org.ushan.progresses.ProgressEventAbstract")]
	
	public interface IProgressable extends IEventDispatcher
	{
		function get title():String;
		function get percentage():Number;
	}
}