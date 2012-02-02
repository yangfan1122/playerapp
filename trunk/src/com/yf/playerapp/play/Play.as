package com.yf.playerapp.play
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import spark.components.Group;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	import com.yf.playerapp.Test;
	import com.yf.playerapp.statics.Statics;
	
	public class Play extends Group
	{
		private var info:Object;
		
		private var test:Test = new Test();
		
		private var url:String;
		private var song:SoundChannel = new SoundChannel();
		public var message:String;
		
		private var request:URLRequest;
		private var soundFactory:Sound;
		private var loading:Boolean = false; //是否正在加载，加载完毕和io错误都要置成false。
		private var pausePosition:int = 0;
		public var displayObjectsArr:Array = [];//显示对象。0播放， 1暂停， 2上一首， 3下一首, 4加载进度, 5播放进度, 6bar容器
		public var state:int = 0; //0初始化，1播，2暂停
		
		private var timer:Timer = new Timer(100); //播放时间用
		
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
			song.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			playingStyle();
			
			//播放状态
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.start();
			
			state = 1;
			
			displayObjectsArr[6].addEventListener(MouseEvent.CLICK, progressBarHandler);
		}
		
		/**
		 * 加载完毕 
		 * @param event
		 * 
		 */		
		private function completeHandler(event:Event):void 
		{
			loading = false;
			
			soundFactory.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			displayObjectsArr[4].width = Statics.panelWidth;
			//displayObjectsArr[2].label = "completeHandler";
			
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
		 * 加载过程
		 * @param event
		 * 
		 */		
		private function progressHandler(event:ProgressEvent):void {
			loading = true;
			timer.start();
			
			this.addElement(test);
			test.test1(Transfer.setWidth(event.bytesLoaded, event.bytesTotal, Statics.panelWidth));
			
			displayObjectsArr[4].width = Transfer.setWidth(event.bytesLoaded, event.bytesTotal, Statics.panelWidth);//下载
		}
		
		/**
		 * 播放过程 
		 * @param event
		 * 
		 */		
		private function timerHandler(event:TimerEvent):void
		{
			var now:Number = song.position;
			var duration:Number;
			var lrcStyle:Boolean;
			
			if (loading)
			{
				duration = Math.ceil(soundFactory.length / (soundFactory.bytesLoaded / soundFactory.bytesTotal));
			}
			else
			{
				duration = soundFactory.length;
			}
			
			//_totalTimeTxt.text = Transfer.transferTimeHandler(duration);//时间
			
			displayObjectsArr[5].width = Transfer.setWidth(now, duration, Statics.panelWidth); //播放条

			/*
			//缓冲提示
			if (sound.isBuffering && loading)
			{
				_playingTimeTxt.htmlText = StaticsAlertTxt.IS_BUFFERING;
			}
			else
			{
				_playingTimeTxt.text = TransferTime.transferTimeHandler(now);
			}
			*/
			
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
			
			pauseStyle();
		}
		
		
		private function playingStyle():void
		{
			displayObjectsArr[0].visible = false;
			displayObjectsArr[1].visible = true;
		}
		private function pauseStyle():void
		{
			displayObjectsArr[0].visible = true;
			displayObjectsArr[1].visible = false;
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
			
			state = 2;
			
			pauseStyle();
		}
		
		/**
		 * 恢复 
		 * 
		 */		
		public function resumeHandler():void
		{
			song = soundFactory.play(pausePosition);
			song.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			
			playingStyle();
		}
		
		/**
		 * 点击进度条
		 * @param event
		 * 
		 */		
		private function progressBarHandler(event:MouseEvent):void
		{
			//mouseX - 事件对象相对于舞台的x位置!!
			goto(Transfer.barTransfer((mouseX - 188), displayObjectsArr[6].width, soundFactory.length));
		}

		
		/**
		 * 跳转
		 * @param	_time
		 */
		private function goto(_time:uint):void
		{
			
			song.stop(); //少此步骤会出现多个声音
			
			song = soundFactory.play(_time); //需分配声道，否则快进、拖拽后声音有变化，毫秒
			song.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			
			playingStyle();
		}
		
		
		/**
		 * 播放结束 
		 * @param event
		 * 
		 */		
		private function soundCompleteHandler(event:Event):void
		{
			pauseStyle();
			state = 0;
			
			song.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
		}
		
		
		
		
		
		
	}
}