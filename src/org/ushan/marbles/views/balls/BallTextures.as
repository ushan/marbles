package org.ushan.marbles.views.balls
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class BallTextures extends MovieClip
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _textureID			:uint;
		public function get textureID()	:uint { return _textureID };
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function BallTextures(textureID:uint = 1)
		{
			super();
			stop();
			_textureID = textureID;
			init();
		}
		
		public function setTexture(textureID:uint):void
		{
			_textureID = textureID;
			if (_textureID != 0)
			{
				visible = true;
				gotoAndStop(_textureID);
			}
			else
			{
				visible = false;
			}
		}
		
		private function init():void
		{
			setTexture(_textureID);
		}
	}
}