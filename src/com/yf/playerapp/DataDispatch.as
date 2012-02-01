package com.yf.playerapp
{
	import com.yf.playerapp.event.CustomizeEvent;
	import com.yf.playerapp.statics.Events;
	
	import flash.events.EventDispatcher;
	
	public class DataDispatch extends EventDispatcher
	{
		private static var _dataDispatch:DataDispatch = new DataDispatch();
		
		public function DataDispatch() 
		{
			if (_dataDispatch) 
			{
				throw new Error("只能用getInstance()来获取实例");
			}
		}
		public static function getInstance():DataDispatch 
		{
			return _dataDispatch;
		}
		
		public function dispatchEventHandler(_event:String, _info:Object):void
		{
			dispatchEvent(new CustomizeEvent(_event, _info));
		}
		
	}
}