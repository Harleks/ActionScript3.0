//////////////////
//   画虚线
//////////////////
package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.Shape;
	public class drawline2 extends MovieClip {
		//画板
		private var drawboard: Sprite = new Sprite();
        //起始点坐标		
		private var startp: Object = new Object();
        //画的一条线		
		private var myline: Sprite;
		public function drawline2() {
			addChild(drawboard);
			drawboard.stage.addEventListener(MouseEvent.MOUSE_DOWN, downHd);
			drawboard.stage.addEventListener(MouseEvent.MOUSE_UP, upHd);
			
		}
		private function downHd(e: MouseEvent) {
			myline = new Sprite();
			drawboard.addChild(myline);
			startp.x = e.localX;
			startp.y = e.localY;
			drawboard.stage.addEventListener(MouseEvent.MOUSE_MOVE, moveHd);
		}
		private function upHd(e: MouseEvent) {
			drawboard.stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveHd);
		}
		private function moveHd(e: MouseEvent) {
			myline.graphics.clear();
			myline.graphics.lineStyle(1, 0x666666);
			myline.graphics.moveTo(startp.x, startp.y);
            //每一段小虚线始末端的x、y坐标			
			var _x: Number = startp.x;
			var _y: Number = startp.y;
			var _linelength: Number = Math.sqrt(Math.pow(e.localX - startp.x, 2) + Math.pow(e.localY - startp.y, 2));
			while (_linelength != 0) {
                //画虚线				
				_x += 5 * (e.localX - startp.x) / _linelength;
				_y += 5 * (e.localY - startp.y) / _linelength;
				if (Math.pow(_x - startp.x, 2) + Math.pow(_y - startp.y, 2) > Math.pow(e.localX - startp.x, 2) + Math.pow(e.localY - startp.y, 2)) {
					myline.graphics.lineTo(e.localX, e.localY);
					break;
				}
				myline.graphics.lineTo(_x, _y);
				//移动画线位置
				_x += 5 * (e.localX - startp.x) / _linelength;
				_y += 5 * (e.localY - startp.y) / _linelength;
				if (Math.pow(_x - startp.x, 2) + Math.pow(_y - startp.y, 2) > Math.pow(e.localX - startp.x, 2) + Math.pow(e.localY - startp.y, 2)) {
					break;
				}
				myline.graphics.moveTo(_x, _y);
			}
		}

	}

}