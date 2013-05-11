package org.ushan.marbles.views.anims
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Firework extends MovieClip
	{
		private var showedFrames:uint;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function Firework()
		{
			super();
			init();
		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			initListeners();
		}
		
		private function initListeners():void
		{
			addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
		}
		
		private function removeThis():void
		{
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			parent.removeChild(this);
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function enterFrameHandler(e:Event):void
		{
			
			if (showedFrames >= totalFrames)
			{
				removeThis();
			}
			showedFrames++;
		}
	}
}