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
		private var song:SoundChannel = new SoundChannel();
		public var message:String;
		
		private var request:URLRequest;
		private var soundFactory:Sound;
		private var loading:Boolean = false; //是否正在加载，加载完毕和io错误都要置成false。
		private var pausePosition:int = 0;
		public var btns:Array = [];//播 暂 上 下
		public var state:int = 0; //0初始化，1播，2暂停
		
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
			
			state = 1;
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
		 * 过程
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
		
		/**
		 * 强制停止 
		 * 
		 */		
		private function stopHandler():void
		{
			song.stop();
			
			if (loading)
				soundFactory.close(); //加载完毕，close方法失效。
		}
		
		
		
		
		/**
		 * 暂停 
		 * 
		 */
		public function pauseHandler():void
		{
			song.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			
			pausePosition = song.position;
			song.stop();
			
			btns[0].visible = true;
			btns[1].visible = false;
			
			state = 2;
		}
		
		/**
		 * 恢复 
		 * 
		 */		
		public function resumeHandler():void
		{
			song = soundFactory.play(pausePosition);
			song.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			
			btns[0].visible = false;
			btns[1].visible = true;
		}
		
		
		/**
		 * 播放结束 
		 * @param event
		 * 
		 */		
		private function soundCompleteHandler(event:Event):void
		{
			btns[0].visible = true;
			btns[1].visible = false;
			state = 0;
			
			song.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
		}
		
		
		
		
		
		
	}
}