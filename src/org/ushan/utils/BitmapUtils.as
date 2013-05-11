package org.ushan.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	public class BitmapUtils
	{

		public static function getResizedBitmapData(source	:BitmapData, 
												newWidth	:uint, 
												newHeight	:uint):BitmapData
		{
			var bitmapData:BitmapData = source.clone();
			var bitmap:Bitmap = new Bitmap(bitmapData);
			var cont:Sprite = new Sprite();
			cont.addChild(bitmap);
			bitmap.width = newWidth;
			bitmap.height = newHeight;
			var resultBitmap:BitmapData = new BitmapData(newWidth, newHeight);
			resultBitmap.draw(cont);
			return resultBitmap;
			
		}
		
		public static function getResizedBitmap(source	:Bitmap, 
											newWidth	:uint, 
											newHeight	:uint):Bitmap
		{
			var resultBitmapData:BitmapData = getResizedBitmapData(source.bitmapData,
				Math.round(newWidth), Math.round(newHeight));
			return new Bitmap(resultBitmapData);
			
		}
	}
}