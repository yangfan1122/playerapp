import com.yf.playerapp.play.Play;

import flash.events.Event;

private var play:Play = new Play();

public function main():void
{
}
public function playHandler(_info:Object):void
{
	songImage.source = _info.img;
	songText.text = _info.title + " - " + _info.singer;
	
	
	play.playHandler(_info);
}