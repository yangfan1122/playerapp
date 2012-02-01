package com.yf.playerapp.event
{
    import flash.events.Event;
    /**
    * 带参数自定义事件
    * @author yangfan1122@gmail.com
    */
    public class CustomizeEvent extends Event
    {
        public var customizeObj:Object;
        public function CustomizeEvent(evt:String , _obj:Object):void
        {
            super(evt);
			customizeObj = _obj;
        }
    }
}
