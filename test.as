package {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.MouseEvent;


	public dynamic
	class test extends MovieClip {
		private var _point: Point = new Point();
		private var downX: Number;
		private var downY: Number;
		private var picArr: Array = new Array(); //保存图形的数组
		public function test() {
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN, downHd);

		}
		private function downHd(e: MouseEvent) {
			var newPic: MovieClip = new MovieClip();
			picArr.push(newPic);
			this.stage.addChild(newPic);
			downX = e.localX;
			downY = e.localY;
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, moveHd);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, upHd);

		}
		private function moveHd(e: MouseEvent) {
			var newPic: MovieClip = picArr[picArr.length - 1];
			_point.x = e.localX;
			_point.y = e.localY;
			var line1: dynamicDashedLine = new dynamicDashedLine(_point);
			line1.x = downX, y = downY;
			newPic.addChild(line1);

		}
		private function upHd(e: MouseEvent) {
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveHd);
		}
	}
}