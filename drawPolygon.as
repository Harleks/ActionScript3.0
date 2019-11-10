//---------------------------------------------------------------------------------------
//
//                            正多边形、多角星工具
//                                  赵健龙
//                                2019.10.19
//
//---------------------------------------------------------------------------------------
//待完成功能：花瓣雪花工具

package
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import fl.controls.ColorPicker;
	import fl.controls.Slider;
	import fl.events.ColorPickerEvent;
	import fl.events.SliderEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.geom.Point;


	public dynamic
	class drawPolygon extends MovieClip
	{
		private var picRegion: Sprite = new Sprite(); //绘图区域
		private var toolRegion: Sprite = new Sprite(); //工具区域
		private var currentTool: String = ""; //当前选择的工具
		private var sideLength: uint = 100; //当前边长宽度
		private var lineWideLength: uint = 1; //当前边线粗细
		private var currentLineColor: uint = 0x000000; //当前边线颜色
		private var currentFillColor: uint = 0xFFFFFF; //当前填充颜色
		private var toolBox: Shape = new Shape(); //工具选择指示框
		private var polygon: SimpleButton = new SimpleButton(); //正多边形按钮
		private var polygonsp: Shape = new Shape(); //正多边形按钮上的图形
		private var polygonalstar: SimpleButton = new SimpleButton(); //实心正多角星按钮
		private var polygonalstarsp: Shape = new Shape(); //实心正多角星按钮上的图形
		private var holepolygonalstar: SimpleButton = new SimpleButton(); //空心正多角星按钮
		private var holepolygonalstarsp: Shape = new Shape(); //空心正多角星按钮上的图形
		private var fillColorPicker: ColorPicker = new ColorPicker(); //颜色选择
		private var lineColorPicker: ColorPicker = new ColorPicker(); //颜色选择

		private var sideLengthSlider: Slider = new Slider(); //边长滑轨
		private var _x: Number = 0,
			_y: Number = 0; //绘制点
		private var n: uint = 3; //边数
		private var newPic: Sprite = new Sprite(); //作的图
		public function drawPolygon()
		{
			//绘制工具区
			drawToolRegion();
			//绘制绘图区
			drawPicRegion();
			//绘制指示框
			drawBox();
			//绘制按钮
			drawBtn();
			//绘制调色板				
			drawColorPlate();
			//绘制边长滑轨			
			drawSlider();
			//注册鼠标单击侦听函数			
			polygon.addEventListener(MouseEvent.CLICK, chooseTool);
			polygonalstar.addEventListener(MouseEvent.CLICK, chooseTool);
			holepolygonalstar.addEventListener(MouseEvent.CLICK, chooseTool);
			initPolygon();


		}
		private function drawPicRegion()
		{
			picRegion.x = 360;
			picRegion.y = 0;
			picRegion.graphics.beginFill(0xFFFFFF);
			picRegion.graphics.drawRect(0, 0, 920, 720);
			picRegion.graphics.endFill();
			addChild(picRegion);
		}
		private function drawToolRegion()
		{
			toolRegion.graphics.beginFill(0x535353);
			toolRegion.graphics.drawRect(0, 0, 360, 720);
			toolRegion.graphics.endFill();
			addChild(toolRegion);
		}
		private function drawBox()
		{
			//绘制指示框
			toolBox.graphics.lineStyle(1, 0x000000, 0);
			toolBox.graphics.beginFill(0x202020, 0.8);
			toolBox.graphics.drawRoundRect(0, 0, 60, 60, 8);
			toolBox.graphics.endFill();
			//初始化在舞台外侧
			toolBox.x = -100;
		}
		private function drawBtn()
		{
			//正多边形工具
			polygon.name = "polygon";
			polygon.downState = new BtnStatusShape2(0x303030, 60, 60);
			polygon.overState = new BtnStatusShape2(0x303030, 60, 60);
			polygon.upState = new BtnStatusShape2(0x535353, 60, 60);
			polygon.hitTestState = polygon.upState;
			polygon.x = 150;
			polygon.y = 20;
			addChild(polygon);

			polygonsp.graphics.lineStyle(2, 0xC3C3C3);

			var i: uint = 0;
			while (i <= 5)
			{
				var angle = Math.PI * (+0.5 - 1 / 5 + (5 - 1) * 2 * i / 5);
				var a = 180 + 25 * Math.cos(angle);
				var b = 50 + 25 * Math.sin(angle);
				if (i == 0) polygonsp.graphics.moveTo(a, b);
				polygonsp.graphics.lineTo(a, b);
				i++;
			}

			//正多角星工具
			polygonalstar.name = "polygonalstar";
			polygonalstar.downState = new BtnStatusShape2(0x303030, 60, 60);
			polygonalstar.overState = new BtnStatusShape2(0x303030, 60, 60);
			polygonalstar.upState = new BtnStatusShape2(0x535353, 60, 60);
			polygonalstar.hitTestState = polygonalstar.upState;
			polygonalstar.x = 150;
			polygonalstar.y = 20 + 60 + 10;
			addChild(polygonalstar);

			polygonalstarsp.graphics.lineStyle(1, 0xC3C3C3);
			polygonalstarsp.graphics.beginFill(0xC3C3C3);
			i = 0;
			angle = Math.PI * ( 0.5);
			while (i <= 5)
			{
				angle += Math.PI /5;
				a = 180 + 25 * Math.cos(angle);
				b = 120 + 25 * Math.sin(angle);
				if (i == 0) polygonalstarsp.graphics.moveTo(a, b);
				polygonalstarsp.graphics.lineTo(a, b);
				
				angle += Math.PI /5;
				a = 180 + 10 * Math.cos(angle);
				b = 120 + 10 * Math.sin(angle);
				polygonalstarsp.graphics.lineTo(a, b);
				i++;
			}
			polygonalstarsp.graphics.endFill();
			
			//空心正多角星工具
			holepolygonalstar.name = "holepolygonalstar";
			holepolygonalstar.downState = new BtnStatusShape2(0x303030, 60, 60);
			holepolygonalstar.overState = new BtnStatusShape2(0x303030, 60, 60);
			holepolygonalstar.upState = new BtnStatusShape2(0x535353, 60, 60);
			holepolygonalstar.hitTestState = holepolygonalstar.upState;
			holepolygonalstar.x = 150;
			holepolygonalstar.y = 20 + 60 + 10+70;
			addChild(holepolygonalstar);

			holepolygonalstarsp.graphics.lineStyle(2, 0xC3C3C3);
			i = 0;
			while (i <= 5)
			{
				angle = Math.PI * (+0.5 - 1 / 5 + (5 - 1) * 4 * i / 5);
				a = 180 + 25 * Math.cos(angle);
				b = 120+70 + 25 * Math.sin(angle);
				if (i == 0) holepolygonalstarsp.graphics.moveTo(a, b);
				holepolygonalstarsp.graphics.lineTo(a, b);
				i++;
			}
			//调整工具图案和指示框的层次
			addChild(toolBox);
			addChild(polygonsp);
			addChild(polygonalstarsp);
			addChild(holepolygonalstarsp);
		}

		private function chooseTool(e: MouseEvent)
		{
			toolBox.x = e.target.x;
			toolBox.y = e.target.y;
			currentTool = e.target.name;
			trace(currentTool);
			/*picRegion.addEventListener(MouseEvent.MOUSE_DOWN, downHd);
			picRegion.addEventListener(MouseEvent.MOUSE_UP, upHd);
			toolRegion.addEventListener(MouseEvent.MOUSE_UP, upHd);*/
		}
		private function drawColorPlate()
		{
			//ColorPicker组件
			lineColorPicker.addEventListener(ColorPickerEvent.CHANGE, pickLineColor);
			lineColorPicker.setSize(160, 20);
			lineColorPicker.move(100, 550);
			addChild(lineColorPicker);

			fillColorPicker.addEventListener(ColorPickerEvent.CHANGE, pickFillColor);
			fillColorPicker.setSize(160, 20);
			fillColorPicker.move(100, 600);
			addChild(fillColorPicker);
			//文字注释
			var tf: TextField = new TextField();
			tf.width = 100;
			tf.x = 20 - 3;
			tf.y = 550;
			tf.text = "边线颜色:";
			var mytf: TextFormat = new TextFormat();
			mytf.size = 15;
			mytf.bold = true;
			mytf.color = 0xC7C7C7;
			mytf.letterSpacing = 2;
			tf.setTextFormat(mytf);
			tf.selectable = false;
			addChild(tf);

			var tf2: TextField = new TextField();
			tf2.width = 100;
			tf2.x = 20 - 3;
			tf2.y = 600;
			tf2.text = "填充颜色:";
			var mytf2: TextFormat = new TextFormat();
			mytf2.size = 15;
			mytf2.bold = true;
			mytf2.color = 0xC7C7C7;
			mytf2.letterSpacing = 2;
			tf2.setTextFormat(mytf2);
			tf2.selectable = false;
			addChild(tf2);

		}
		private function pickLineColor(e: ColorPickerEvent): void
		{
			currentLineColor = e.color;
			drawNewPic();
		}
		private function pickFillColor(e: ColorPickerEvent): void
		{
			currentLineColor = e.color;
			currentFillColor = e.color;
			drawNewPic();
		}
		private function initPolygon()
		{
			_x = 720, _y = 360;
			var myTimer: Timer = new Timer(1000, 10000);
			myTimer.addEventListener(TimerEvent.TIMER, timeHd);
			myTimer.start();

		}
		private function timeHd(event: TimerEvent)
		{
			drawNewPic();
			newPic.addEventListener(MouseEvent.MOUSE_DOWN, downHd);
			newPic.addEventListener(MouseEvent.MOUSE_UP, upHd);
			n++;
			if (n == 11) n = 3;
		}

		private function downHd(e: MouseEvent)
		{
			newPic.addEventListener(MouseEvent.MOUSE_MOVE, moveHd);
		}
		private function moveHd(e: MouseEvent)
		{
			_x = e.localX;
			_y = e.localY;
			drawNewPic();
		}
		//画图区域抬起鼠标事件处理函数
		private function upHd(e: MouseEvent)
		{
			newPic.removeEventListener(MouseEvent.MOUSE_MOVE, moveHd);
		}
		private function drawSlider()
		{
			//Slider组件
			sideLengthSlider.move(100, 500);
			sideLengthSlider.setSize(160, 3);
			sideLengthSlider.liveDragging = true;
			sideLengthSlider.value = 100;
			sideLengthSlider.minimum = 10;
			sideLengthSlider.maximum = 300;
			sideLengthSlider.snapInterval = 10;
			sideLengthSlider.addEventListener(Event.CHANGE, chooseSideLength);
			addChild(sideLengthSlider);
			//文字注释
			var tf: TextField = new TextField();
			tf.width = 50;
			tf.x = 50 - 3;
			tf.y = 500 - 7.5;
			tf.text = "边长:";
			//字体颜色设置
			var mytf: TextFormat = new TextFormat();
			mytf.size = 15;
			mytf.bold = true;
			mytf.color = 0xC7C7C7;
			mytf.letterSpacing = 3;
			tf.setTextFormat(mytf);
			tf.selectable = false;
			addChild(tf);
		}
		private function chooseSideLength(e: Event)
		{
			sideLength = sideLengthSlider.value;
			drawNewPic();
		}
		private function drawNewPic()
		{
			switch (currentTool)
			{
				case "polygon":
					_drawPolygon();
					break;
				case "polygonalstar":
					_drawPolygonalStar();
					break;
				case"holepolygonalstar":
					_drawHolePolygonalStar();
				break;
				default:
					_drawPolygon();
			}
		}

		//绘制正多边形
		private function _drawPolygon()
		{
			newPic.graphics.clear();
			var r: Number = sideLength; //边长
			var coun: uint = 0; //画到第几个点了
			var jd: Number = Math.PI * ((2 * coun - 1) / n + 0.5); //画到这个点的角度
			newPic.graphics.lineStyle(lineWideLength, currentLineColor);
			newPic.graphics.beginFill(currentFillColor);
			newPic.graphics.moveTo(_x + r * Math.cos(jd), _y + r * Math.sin(jd));
			while (coun <= n)
			{
				jd = Math.PI * ((2 * coun - 1) / n + 0.5);
				var aa = _x + r * Math.cos(jd);
				var bb = _y + r * Math.sin(jd);
				newPic.graphics.lineTo(aa, bb);
				coun++;
			}
			newPic.graphics.endFill();
			addChild(newPic);
		}

		//绘制正多角星
		private function _drawPolygonalStar()
		{
			newPic.graphics.clear();
			var r1: Number = sideLength; //大边长
			var r2: Number = new Number(); //小边长
			var coun: uint = 0; //画到第几个点了
			var _n = n+2; //2n-1正角星
			var jd: Number = 0; //画到这个点的角度
			r2 = r1 * Math.sin(Math.PI * (0.5 - 2 / _n)) / Math.sin(Math.PI * (0.5 + 1 / _n));

			newPic.graphics.lineStyle(lineWideLength, currentLineColor);
			newPic.graphics.beginFill(currentFillColor);
			newPic.graphics.moveTo(_x + r2 * Math.cos(jd), _y + r2 * Math.sin(jd));
			while (coun <= _n-1)
			{
				jd = jd+Math.PI / _n;
				var aa = _x + r1 * Math.cos(jd);
				var bb = _y + r1 * Math.sin(jd);
				newPic.graphics.lineTo(aa, bb);
				jd = jd + Math.PI / _n;
				aa = _x + r2 * Math.cos(jd);
				bb = _y + r2 * Math.sin(jd);
				newPic.graphics.lineTo(aa, bb);
				coun++;
			}
			newPic.graphics.endFill();
			addChild(newPic);
		}

		//绘制镂空正多角星
		private function _drawHolePolygonalStar()
		{
			newPic.graphics.clear();
			var r: Number = sideLength; //边长
			var coun: uint = 0; //画到第几个点了
			var _n = 2 * n - 1; //2n-1正角星
			var jd: Number = Math.PI * (-0.5 - 1 / _n); //画到这个点的角度
			newPic.graphics.lineStyle(lineWideLength, currentLineColor);
			newPic.graphics.beginFill(0xFFFFFF);
			newPic.graphics.moveTo(_x + r * Math.cos(jd), _y + r * Math.sin(jd));
			while (coun <= _n)
			{
				jd = Math.PI * (-0.5 - 1 / _n + (n - 1) * 2 * coun / _n);
				var aa = _x + r * Math.cos(jd);
				var bb = _y + r * Math.sin(jd);
				newPic.graphics.lineTo(aa, bb);
				coun++;
			}
			newPic.graphics.endFill();
			addChild(newPic);
		}




	}
}