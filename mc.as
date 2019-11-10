package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	import flash.display.Graphics;


	public dynamic
	class mc extends MovieClip {



		public function mc() {
			var btn = new SimpleButton();

			btn.name = "btn";

			btn.downState = new BtnStatusShape2(0x000000, 100, 100);

			btn.overState = new BtnStatusShape2(0x666666, 100, 100);

			btn.upState = new BtnStatusShape2(0xff0000, 100, 100);

			btn.hitTestState = btn.upState;

			addChild(btn);
			btn.addEventListener(MouseEvent.CLICK, clickhd);

			//initialize();
			// constructor code
		}
		
		private function clickhd(e: MouseEvent) {
			trace("12345");
			// constructor code
		}
	}
	

}