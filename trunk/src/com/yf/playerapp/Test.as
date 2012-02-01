package com.yf.playerapp
{
	import flash.events.MouseEvent;
	
	import spark.components.Button;
	import spark.components.Label;
	import spark.components.SkinnablePopUpContainer;
	import spark.components.VGroup;
	
	public class Test extends SkinnablePopUpContainer
	{
		//private var spc:SkinnablePopUpContainer = new SkinnablePopUpContainer();
		private var vg:VGroup = new VGroup();
		private var la:Label = new Label();
		private var btn:Button = new Button();
		
		public function Test()
		{
			this.addElement(vg);
			vg.addElement(la);
			vg.addElement(btn);
			btn.addEventListener(MouseEvent.CLICK, btnHandler);
		}
		
		public function test1(_info:Object):void
		{
			this.visible = true;
			la.text = _info.toString();
		}
	
		private function btnHandler(event:MouseEvent):void
		{
			this.visible = false;
		}
		
		
	}
}