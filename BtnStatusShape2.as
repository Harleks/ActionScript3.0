
﻿package{
	import flash.display.Shape;
	internal class BtnStatusShape2 extends Shape {

		public function BtnStatusShape2(bgColor: uint, w: uint, h: uint) {

			graphics.lineStyle(1, 0x000000, 0)

			graphics.beginFill(bgColor, 0.8);

			graphics.drawRoundRect(0, 0, w, h, 8);

			graphics.endFill();

		}

	}
}