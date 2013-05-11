package org.ushan.utils
{
	public class StringUtils
	{
		public static function getFormatedNumber(beforPoint:uint, afterPoint:uint, value:Number):String
		{
			var numString:String = String(value);
			var numParts:Array = numString.split(".");
			var partFirst:String = numParts[0];
			var partSecond:String;
			if (numParts[1])
			{
				partSecond = numParts[1];
			} else {
				partSecond = "";
			}
			var i:uint
			for (i = partFirst.length; i<beforPoint; i++)
			{
				partFirst ="0" + partFirst;
			}
			if (partSecond.length<afterPoint)
			{
				for (i = partSecond.length; i<afterPoint; i++)
				{
					partSecond =partSecond + "0";
				}
			}
			if (partSecond.length>afterPoint) partSecond = partSecond.substr(0, afterPoint);
			numString = partFirst + "." + partSecond;
			return numString;
		}
		
		public static function trimString (value:String, length:uint):String
		{
			//var returnString:String;
			if (value.length > length)
			{
				return value.substr(0, length) + "...";
			}
			return value;
		}
		
		public static function parseBoolean (value:String, defaultValue:Boolean = false):Boolean
		{
			if (!value) return false;
			if (value == "true") return true;
			if (value == "false") return false;
			if (value == "True") return true;
			if (value == "False") return false;
			if (value == "TRUE") return true;
			if (value == "FALSE") return false;
			if (value == "yes") return true;
			if (value == "no") return false;			
			if (value == "YES") return true;
			if (value == "NO") return false;
			if (value == "1") return true;
			if (value == "0") return false;

			return defaultValue;
		}
		
		
		public static function millisecondsToMinSec (value:int):String
		{
			var sec:int = Math.floor(value / 1000);
			return String(int(sec / 60) + ":" + (sec % 60 < 10 ? "0" : "") + sec % 60); 
		}
		
/*		public static function getFileType (filename:String):uint
		{

		}*/

	}
}