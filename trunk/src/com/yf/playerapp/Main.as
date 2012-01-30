import com.yf.playerapp.play.Play;

import flash.events.Event;
import flash.events.MouseEvent;

private var play:Play;
private var info:Object = new Object();

public function main():void
{
	pauseBtn.visible = false;
	
	playBtn.addEventListener(MouseEvent.CLICK, playBtnHandler);
	pauseBtn.addEventListener(MouseEvent.CLICK, pauseBtnBtnHandler);
	
	play = new Play();
	play.btns = [playBtn, pauseBtn, prevBtn, nextBtn];
}
public function playHandler(_info:Object):void
{
	info = _info;
	
	songImage.source = _info.img;
	songText.text = _info.title + " - " + _info.singer;
	
	
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
	
}