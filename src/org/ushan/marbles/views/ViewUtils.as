package org.ushan.marbles.views
{
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	

	public class ViewUtils
	{
		public function ViewUtils()
		{
		}
		
		public static function createRect():Shape
		{
			//var model:Model = Model.instance;
			var back:Shape = new Shape();
			//back.alpha = 0.4;
			
			var fillType:String = GradientType.LINEAR;
			//var colors:Array = [0x99CC00, 0xFFCC32];
			var colors:Array = [0x6633CC, 0x66CCCC];
			var alphas:Array = [1, 1];
			var ratios:Array = [0x00, 0xFF];
			
			var w:Number = EConfigConstants.SCENE_WIDTH;
			var h:Number = EConfigConstants.SCENE_HEIGHT;
			var matr:Matrix = new Matrix();
			matr.createGradientBox(w, h, 0.4, 0.8, 0.3);
			var spreadMethod:String = SpreadMethod.PAD;
			back.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
			back.graphics.drawRect(0, 0, w, h);
			//back.cacheAsBitmap = true;
			//addChild(back);
			return back;
			
		}
		
		
		
	}
}