package org.ushan.core
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.ushan.core.events.SpriteEvent;
	
	
	public class ExtSprite extends Sprite
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
		
		public function ExtSprite()
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
			addEventListener(Event.ENTER_FRAME, first_enterFrameHandler);
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