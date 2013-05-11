package org.ushan.marbles.views.anims {
	
	/*
	*	A Colorful Fireworks Demonstration in Actionscript 3
	*   from shinedraw.com
	*/
	
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import org.ushan.geom.MathUtils;
	
	public class Star extends Sprite {
        // Please study the code for the usage of these variables

        public var counter		:int = 0;
        public var swingSpeed	:int = 5;
        public var upSpeed		:Number = 1;
        public var centerX		:Number;
        		
        // for firwork
        public var xVelocity			:Number = 1;
        public var yVelocity			:Number = 1;
        public var gravity				:Number = 1;
        		
		public function Star() 
		{
			cacheAsBitmap = true;
			scaleX = MathUtils.random(0.6, 2);
			scaleY = scaleX;
			swingSpeed = MathUtils.random(-6, 6);
			alpha = 1;
			
        }

        /////////////////////////////////////////////////////        
        // Public Methods
        /////////////////////////////////////////////////////	

        // move the dot 
        public function runFirework():void
        {
           // this.alpha += fireworkOpacityInc;
			
			rotation = rotation + swingSpeed;
            yVelocity += gravity;
            x = x + xVelocity;
            y = y + yVelocity;
        }		
	}
}
