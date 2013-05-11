package org.ushan.core
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.ushan.core.events.SpriteEvent;
	
	public class SubSprite extends Sprite
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
		
		public function SubSprite()
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
		
		protected function initAfterCreation():void
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
			init();
			dispatchEvent(new SpriteEvent(SpriteEvent.CREATION_COMPLETE));
		}
	}
}