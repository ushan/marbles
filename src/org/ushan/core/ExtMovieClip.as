package org.ushan.core
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import org.ushan.core.events.SpriteEvent;
	
	
	public class ExtMovieClip extends MovieClip
	{
		//----------------------------------------------------------------------
		//	instance on the scene
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//	public fields
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function ExtMovieClip()
		{
			super();
			init();
		}
		
		//----------------------------------------------------------------------
		//
		//	public methods
		//
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//
		//	protected methods
		//
		//----------------------------------------------------------------------
		
		protected function onCreationComplete():void
		{
			
		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			stop();
			addEventListener(Event.ENTER_FRAME, first_enterFrameHandler, false, 0, true);
		}
		
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function first_enterFrameHandler(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, first_enterFrameHandler);
			onCreationComplete();
			dispatchEvent(new SpriteEvent(SpriteEvent.CREATION_COMPLETE));
		}
	}
}