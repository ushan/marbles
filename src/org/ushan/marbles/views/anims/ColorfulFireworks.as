package org.ushan.marbles.views.anims {
	
	/*
	*	A Colorful Fireworks Demonstration in Actionscript 3
	*   from shinedraw.com
	*/
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.ushan.geom.MathUtils;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.models.configs.EConfigConstants;
	import org.ushan.utils.ColorObject;
	
	public class ColorfulFireworks extends Sprite {
		
        private static var model			:Model        // The minimum dot size
        private static var DOT_SIZE_MIN		:Number = 1.5;        // The minimum dot size
        private static var DOT_SIZE_MAX		:Number = 3.5;        // The maximum dot size
        private static var COLOR_OFFSET		:Number = 100;      // Configure the brightness of the dots
	    private static var X_VELOCITY		:Number = 3;              // Maximum X Velocity
        private static var Y_VELOCITY		:Number = 8;              // Maximum Y Velocity
		private static var GRAVITY			:Number = 0.5;               // Gravity
		private static var FIREWORK_NUM		:Number = 4;            // Number of Dot generated each time
		private static var CRITICAL_POS		:Number = 700;	

		private static var t:Number = 0	;		// Critical Point for removing useless dots
		private static var colors:Array = new Array (	0xff0000,
														0x0000ff,
														0x00ff00,
														0xffff00,
														0x00ffff,
														0xff00ff,
														0x00ffff,
														0x00ff00,
														0xf0ff00,
														0x0fff00,
														0x00fff0);
		
		// List for storing the added dots in the stage
        private var _fireworks 	: Array = new Array();
        
		public function ColorfulFireworks() 
		{
		}

        /////////////////////////////////////////////////////        
        // Handlers
        /////////////////////////////////////////////////////	
        

        
		private function on_enter_frame(e:Event):void
		{
			// reposition all the magic dots
			moveFirework();
			var p:Point = getXYByFunctionT();
			addFirework(p.x, p.y);
			t += 0.1;
		}
		
        /////////////////////////////////////////////////////        
        // Private Methods
        /////////////////////////////////////////////////////	


       	private function moveFirework():void
        {
            for (var i:int = _fireworks.length - 1; i >= 0; i--)
            {
                var dot : Star = _fireworks[i] as Star;
                dot.runFirework();
                
                // remove the dot if the alpha is too small
                if (dot.y >= CRITICAL_POS)
                {
                    removeChild(dot);
                    _fireworks.splice(i, 1);
                }
            }
        }

        private function addFirework(x:Number, y:Number):void
        {

            for (var i:int = 0; i < FIREWORK_NUM; i++)
            {
                
				var id:uint = MathUtils.randRangeInt(0, colors.length - 1);
				var color:uint = colors[id];

                var xVelocity:Number = X_VELOCITY/2 +  - X_VELOCITY * Math.random();
                var yVelocity:Number = -Y_VELOCITY * Math.random();
				
				
				
                var dot : Star = new Star();
				ColorObject.setTint(dot, color, 100);
                dot.x = x;
                dot.y = y;
                dot.xVelocity = xVelocity;
                dot.yVelocity = yVelocity;
                dot.gravity = GRAVITY;
                dot.runFirework();
                _fireworks.push(dot);

                addChild(dot);
            }
        }
		
		private function getXYByFunctionT():Point
		{
			model = Model.instance;
			var w:Number = model.config.sceneWidth - 200;
			var h:Number = model.config.sceneHeight - 200;
			var point:Point = new Point();
			point.x = Math.sin (2 * t) * w / 2 + model.config.sceneWidth /2;
			point.y = Math.cos (3 * t) * h / 2 + model.config.sceneHeight / 2;
			return point;
			
		}
        
        /////////////////////////////////////////////////////        
        // Private Methods
        /////////////////////////////////////////////////////	

		public function start():void{
			this.addEventListener(Event.ENTER_FRAME, on_enter_frame, false, 0, true);	
		}
	}
}
