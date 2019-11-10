package {
	import flash.display.Sprite;

	public class myPoint extends Sprite {
		//public var circle: Sprite = new Sprite();
		public var xx:Number;
		public var yy:Number;
		public function myPoint(_x: Number,_y: Number,_r: Number) {
			xx=_x;
			yy=_y;
			this.graphics.lineStyle(2,0x000000);
			this.graphics.drawCircle(_x,_y,_r);	

		}
	}
}