package {
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.MovieClip;
3
	public class drawline extends MovieClip {
		private var _length: uint = 500;
		private var _height: uint = 80;
		private var _space: uint = 20;

		public function drawline() {
			//三种粗细的实线
			for (var i: uint = 1; i <= 3; i++)
				drawsolidline(i);
			//三种颜色的实线
			drawsolidline(1, 0x0000FF);
			drawsolidline(1, 0x00FF00);
			drawsolidline(1, 0xFF0000);
			drawdottedline();
			drawdottedline2();
			drawwavyline();

			refreshLayout();

		}
		
		//对各条线进行排版
		private function refreshLayout(): void {
			var ln: uint = numChildren;
			var child: DisplayObject;
			var lastChild: DisplayObject = getChildAt(0);
			lastChild.x = _space;
			lastChild.y = _space;
			for (var i: uint = 1; i < ln; i++) {
				child = getChildAt(i);
				child.x = _space;
				child.y = _space + lastChild.y + lastChild.height;
				lastChild = child;
			}
		}
		
        //画实线
		private function drawsolidline(_thickness: uint = 1, _color: uint = 0x666666): void {
			var child: Shape = new Shape();
			child.graphics.lineStyle(_thickness, _color);
			child.graphics.lineTo(_length, 0);
			addChild(child);
		}
        
		//画虚线
		private function drawdottedline(_thickness: uint = 1, _color: uint = 0x666666, _linespace: uint = 5, _linelength: uint = 5): void {
			var child: Shape = new Shape();
			child.graphics.lineStyle(_thickness, _color);

			var _x = 0;
			while (true) {

				_x += _linelength;
				if (_x > _length) {
					child.graphics.lineTo(_length, 0);
					break;
				}
				child.graphics.lineTo(_x, 0);
				_x += _linespace;
				child.graphics.moveTo(_x, 0);


			}
			addChild(child);
		}
		
		//画带点的虚线
		private function drawdottedline2(_thickness: uint = 1, _color: uint = 0x666666, _linespace: uint = 7, _linelength: uint = 5): void {
			var child: Shape = new Shape();
			child.graphics.lineStyle(_thickness, _color);

			var _x: uint = 0;
			while (true) {

				_x += _linelength;
				if (_x > _length) {
					child.graphics.lineTo(_length, 0);
					break;
				}
				child.graphics.lineTo(_x, 0);
				_x += _linespace;
				if (_x > _length) {
					child.graphics.lineTo(_length, 0);
					break;
				}
				child.graphics.moveTo(_x, 0);
				child.graphics.beginFill(_color);
				child.graphics.drawCircle(_x, 0, 0.5);
				child.graphics.endFill();
				_x += _linespace;
				if (_x > _length)
					break;
				child.graphics.moveTo(_x, 0);


			}
			addChild(child);
		}
		
		//画波浪线（贝塞尔曲线）
		private function drawwavyline(_thickness: uint = 1, _color: uint = 0x666666, _linelength: uint = 10): void {
			var child: Shape = new Shape();
			child.graphics.lineStyle(_thickness, _color);
			var _x: uint = 0;
			while (true) {
				child.graphics.curveTo(_x+ _linelength / 2, -5, _x+_linelength, 0);
				_x += _linelength;
				if (_x >= _length) 
					break;
				child.graphics.curveTo(_x+_linelength / 2, 5,_x+_linelength, 0);
				_x += _linelength;
				if (_x >= _length) 
					break;

			}
			addChild(child);
		}
	}
}