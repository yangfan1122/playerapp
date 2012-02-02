import com.yf.playerapp.DataDispatch;
import com.yf.playerapp.event.CustomizeEvent;
import com.yf.playerapp.play.Play;
import com.yf.playerapp.statics.Events;
import com.yf.playerapp.statics.Statics;

import components.Test;

import flash.events.Event;
import flash.events.MouseEvent;

import mx.core.IVisualElement;

private var test:Test = new Test();

private var play:Play;
private var info:Object = new Object();

public function main():void
{
	pauseBtn.visible = false;
	this.addElement(test);
	
	//panelRigthSide.width = Statics.panelWidth;
	proBarContainer.width = Statics.panelWidth;
	
	playBtn.addEventListener(MouseEvent.CLICK, playBtnHandler);
	pauseBtn.addEventListener(MouseEvent.CLICK, pauseBtnBtnHandler);
	
	DataDispatch.getInstance().addEventListener(Events.SONG_ID, getSongIdHandler);
	
	play = new Play();
	try
	{
		this.addElement(play as IVisualElement);
	}
	catch(error:Error)
	{
		//test.AlertMain(error);
		throw error;
	}
	
	play.displayObjectsArr = [playBtn, pauseBtn, prevBtn, nextBtn, proBarDownload, proBarPlaying, proBarContainer];
}

/**
 * 监听歌曲id 
 * @param event
 * 
 */
private function getSongIdHandler(event:CustomizeEvent):void
{
	playHandler(event.customizeObj);
}





/**
 * 播放歌曲，传递歌曲信息参数 
 * @param _info
 * 
 */
private function playHandler(_info:Object):void
{
	info = _info;
	
	songImage.source = _info.img;
	songText.text = _info.title;
	singerText.text = _info.singer;
	
	play.playHandler(_info);
}


/**
 * 播放按钮 
 * @param event
 */
private function playBtnHandler(event:MouseEvent):void
{
	if (play.state == 0)
		playHandler(info);
	if (play.state == 2)
		play.resumeHandler();
}


/**
 * 暂停按钮 
 * @param event
 */
private function pauseBtnBtnHandler(event:MouseEvent):void
{
	play.pauseHandler();
}