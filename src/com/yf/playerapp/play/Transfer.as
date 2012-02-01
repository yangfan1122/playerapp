package com.yf.playerapp.play
{

	/**
	 * ...
	 * @author yangfan1122@gmail.com
	 */
	public class Transfer
	{
		internal static function setWidth(now:Number, total:Number, mcWidth:Number):Number //进度条
		{
			var temp:Number;
			temp = Math.floor((now * mcWidth) / total);

			if (temp > mcWidth)
			{
				return mcWidth;
			}
			else
			{
				return temp;
			}

		}

		internal static function transferTimeHandler(__sec:Number):String //__sec 秒
		{
			var min:Number;
			var sec:Number;
			var minStr:String;
			var secStr:String;
			var _sec:Number;

			_sec = Math.floor(__sec);

			min = Math.floor(_sec / 60);
			sec = _sec % 60;

			if (min < 10)
			{
				minStr = "0" + min;
			}
			else
			{
				minStr = min.toString();
			}

			if (sec < 10)
			{
				secStr = "0" + sec;
			}
			else
			{
				secStr = sec.toString();
			}

			return minStr + ":" + secStr;
		}
		
		/**
		 * x/y = m/n
		 */
		internal static function barTransfer(_m:Number, _n:Number, _y:Number):Number
		{
			var _x:Number;
			_x = (_y * _m) / _n;
			return _x;
		}



	}

}