package org.ushan.utils
{
	public class XMLUtils
	{
		public static function sortXMLList(list:XMLList, attribute:String, options:Object = null):XMLList 
		{
			var arr : Array = [];
			for each(var item:XML in list) {
				arr.push({order:item.@[attribute], data:item});
			}
			arr.sortOn('order', options);
			
			var sortedList : XMLList = new XMLList();
			for each(var obj:Object in arr) {
				sortedList += obj.data;
			}
			return sortedList;
		}
		
		public static function sortXMLListByNumber(list:XMLList, attribute:String):XMLList 
		{
			var arr : Array = [];
			for each(var item:XML in list) 
			{
				var value:Number = parseFloat(item.@[attribute]);
				arr.push({order:value, data:item});
			}
			arr.sortOn('order', [Array.NUMERIC]);
			
			var sortedList : XMLList = new XMLList();
			for each(var obj:Object in arr) 
			{
				sortedList += obj.data;
			}
			return sortedList;
		}

	}
}