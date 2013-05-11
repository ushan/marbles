package org.ushan.utils
{
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	
	public class ColorObject
	{
		public static function setTint(object:DisplayObject, rgb:uint, percent:uint):void
		{
			var t:Transform = new Transform(object);
			var ct:ColorTransform = t.colorTransform;
			   
			var ratio : Number = percent / 100;
			ct.redOffset = (rgb >> 16)*ratio;
			ct.greenOffset = ((rgb >> 8) & 0xFF)*ratio;
			ct.blueOffset = (rgb & 0xFF)*ratio;
			   
			ct.redMultiplier = ct.greenMultiplier = ct.blueMultiplier = 1 - percent/100;
			   
			t.colorTransform = ct;
		}
		
		public static function clearTransform(object:DisplayObject):void
		{
			object.transform.colorTransform = new ColorTransform();
		}

	}
}