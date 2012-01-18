package com.yf.playerapp.play
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class Play extends Sprite
	{
		private var info:Object;
		
		
		private var url:String;
		private var song:SoundChannel;
		public var message:String;
		
		private var request:URLRequest;
		private var soundFactory:Sound;
		private var loading:Boolean = false; //是否正在加载，加载完毕和io错误都要置成false。
		
		public function Play() 
		{
		}
		
		public function playHandler(_info:Object):void
		{
			info = _info;
			
			if (soundFactory)
				stopHandler(); //将正播放的歌曲停掉
			
			request = new URLRequest(info.mp3);
			soundFactory = new Sound();
			soundFactory.addEventListener(Event.COMPLETE, completeHandler);
			soundFactory.addEventListener(Event.ID3, id3Handler);
			soundFactory.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			soundFactory.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			soundFactory.load(request);
			song = soundFactory.play();
		}
		
		
		private function completeHandler(event:Event):void {
			loading = false;
			sendMessage("completeHandler: " + event);
		}
		
		private function id3Handler(event:Event):void {
			sendMessage("id3Handler: " + event);
		}
		
		private function ioErrorHandler(event:Event):void {
			loading = false;
			sendMessage("ioErrorHandler: " + event);
			
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function progressHandler(event:ProgressEvent):void {
			loading = true;
			//sendMessage("progressHandler: " + event);
		}
		
		private function sendMessage(_message:String):void
		{
			message = _message;
			dispatchEvent(new Event("senD"));
		}
		
		
		
		
		
		
		
		private function stopHandler():void
		{
			song.stop();
			
			if (loading)
				soundFactory.close(); //加载完毕，close方法失效。
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}