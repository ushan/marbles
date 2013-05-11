package org.ushan.core
{
	import org.ushan.ETypesConstants;

	public class PairsList
	{
		private var _keysClass				:Class;
		public function get keysClass()		:Class { return _keysClass };

		private var _valuesClass			:Class;
		public function get valuesClass()	:Class { return _valuesClass };
		
		private var keys	:Array;
		private var values	:Array;
		
		public function PairsList(keysClass:Class, valuesClass:Class, isUnique:Boolean = false)
		{
			keys = new Array();
			values = new Array();
			_keysClass = keysClass;
			_valuesClass = valuesClass;
			
		}
		
		public function push(key:*, value:*):void
		{
			if (! key is _keysClass)
			{
				throw new Error("UError. Variable key: '" +key + " is not instance of the class : '" + _keysClass + "'." );
				return;
			}
			if (! key is _keysClass)
			{
				throw new Error("UError. Variable value: '" +values + " is not instance of the class : '" + _valuesClass + "'." );
				return;
			}
			var newIndex:uint;
			if (isUnique)
			{
				for (var i:uint = 0; i< keys.length; i++)
				{
					if (key == keys[i])
					{
						
					}
				}
			}
			else
			{
				keys.push(key);
				values.push(value);
			}
		}
		
		public function deleteByValue():void
		{
			
		}
	}
}