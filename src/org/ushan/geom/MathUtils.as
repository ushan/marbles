package org.ushan.geom
{
	public class MathUtils
	{
		
		/**
		 * 
		 * @param $min
		 * @param $max
		 * @return 
		 * 
		 */
		public static function randRangeInt(min:Number, max:Number):int 
		{
			return Math.floor(Math.random() * (max + 1 - min)) + min;
		}
		
		/**
		 * Convert an integer to binary string representation.
		 *
		 * @param n The integer to convert.
		 */
		public function toBinary(n:int):String
		{
			var result:String = "";
			for(var i:Number = 0;i < 32; i++)
			{
				var lsb:int = n & 1;
				result = (lsb?"1":"0") + result;
				n >>= 1;
			}
			return result;
		}

		/**
		 * Convert a binary string (000001010) to an integer.
		 *
		 * @param binaryString The string to convert.
		 */
		public function toDecimal(binaryString:String):int
		{
			var result:Number = 0;
			for(var i:int = binaryString.length;i > 0; i--) result += parseInt(binaryString.charAt(binaryString.length - i))*Math.pow(2,i-1);
			return result;
		}

		/**
		 * Returns the floor of a number, with optional decimal precision.
		 *
		 * @param val The number.
		 * @param decimal How many decimals to include.
		 */
		public static function floor(val:Number, decimal:Number):Number
		{
			var n:Number = Math.pow(10,decimal);
			return Math.floor(val * n) / n;
		}
		
		/**
		 * Round to a given amount of decimals.
		 *
		 * @param val The number.
		 * @param decimal The decimal precision.
		 */
		public static function round(val:Number, decimal:Number):Number
		{
			return Math.round(val*Math.pow(10,decimal))/Math.pow(10,decimal);
		}
		
		/**
		 * Returns a random number inside a specific range.
		 *
		 * @param start The first number.
		 * @param end The end number.
		 */
		public static function random(start:Number, end:Number):Number
		{
			return Math.random()*(end-start)+start;
		}
		
		
		/**
		 * Check if number is odd (convert to Integer if necessary).
		 *
		 * @param n The number.
		 */
		public static function isOdd(n:Number):Boolean
		{
			var i:Number = new Number(n);
			var e:Number = new Number(2);
			return Boolean(i % e);
		}
		
		/**
		 * Check if number is even (convert to Integer if necessary).
		 *
		 * @param n The number.
		 */
		public static function isEven(n:Number):Boolean
		{
			var int:Number = new Number(n);
			var e:Number = new Number(2);
			return (int % e == 0);
		}

		/**
		 * Evaluate if two numbers are nearly equal.
		 *
		 * @param n1 The first number.
		 * @param n2 The second number.
		 *
		 * @see http://www.zeuslabs.us/2007/01/30/flash-floating-point-number-errors/
		 */
		public static function fuzzyEval(n1:Number, n2:Number, precision:int = 5):Boolean
		{
			var d:Number = n1 - n2;
			var r:Number = Math.pow(10,-precision);
			return d < r && d > -r;
		}

		
		
		/**
		 * Return a "tilted" random Boolean value.
		 *
		 * @example
		 * <listing>
		 * math.utils.boolean(); //returns 50% chance of true.
		 * math.utils.boolean(.75); //returns 75% chance of true.
		 * </listing>
		 *
		 * @param chance The percentage chance that the return value will be true.
		 */
		public static function randBool(chance:Number = 0.5):Boolean
		{
			return (Math.random()<chance);
		}

		/**
		 * Return a "tilted" value of 1 or -1.
		 *
		 * @example
		 * <listing>
		 * math.utils.sign(); //returns 50% chance of 1.
		 * math.utils.sign(.75); //returns 75% chance of 1.
		 * </listing>
		 *
		 * @param chance The percentage chance that the return value will be true.
		 */
		public static function sign(chance:Number=0.5):int
		{
			return (Math.random()<chance)?1:-1;
		}

		/**
		 * Return a "tilted" value of 1 or 0.
		 *
		 * @example
		 * <listing>
		 * math.utils.bit(); //returns 50% chance of 1.
		 * math.utils.bit(.75); //returns 75% chance of 1.
		 * </listing>
		 *
		 * @param chance The percentage chance that the return value will be true.
		 */
		public static function randBit(chance:Number = 0.5):int
		{
			return (Math.random()<chance)?1:0;
		}

		/**
		 * Check if a number is in range.
		 *
		 * @param n The number.
		 * @param min The minimum number.
		 * @param max The maximum number.
		 * @param blacklist An array of numbers that cannot be considered in range.
		 */
		public static function isInRange(n:Number,min:Number,max:Number,blacklist:Array=null):Boolean
		{
			if(!blacklist || blacklist.length < 1) return (n >= min && n <= max);
			if(blacklist.length > 0)
			{
				for(var i:String in blacklist) if(n == blacklist[i]) return false;
			}
			return false;
		}

		/**
		 * Returns a set of random numbers inside a specific range, optionally unique numbers only.
		 *
		 * @param min The minimum number.
		 * @param max The maximum number.
		 * @param count How many mubers to generate.
		 * @param unique Whether or not the numbers generated must be unique.
		 */
		public static function randRangeSet(min:Number, max:Number, count:Number, unique:Boolean):Array
		{
			var rnds:Array = new Array();
			var i:int = 0;
			if(unique && count <= (max-min)+1)
			{
				var nums:Array = new Array();
				i = min;
				for(i;i<=max;i++)nums.push(i);
				i=1;
				for(i;i<=count;i++)
				{
					var rn:Number = Math.floor(Math.random() * nums.length);
					rnds.push(nums[rn]);
					nums.splice(rn,1);
				}
			}
			else
			{
				i = 1;
				for (i;i<=count;i++) rnds.push(randRangeInt(min,max));
			}
			return rnds;
		}


	}
}