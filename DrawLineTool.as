//---------------------------------------------------------------------------------------
//
//                               绘制直线工具
//                                  赵健龙
//                                2019.10.3
//
//---------------------------------------------------------------------------------------
//目前bug：
//橡皮擦工具生效在按下鼠标后 而非抬起鼠标时
//波浪线最小绘制单位为半个圆弧
//波浪线最小绘制单位为半个圆弧
//11.5更新：钢笔、铅笔工具
package
{
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
	import flash.geom.Point;

	public dynamic
	class DrawLineTool extends MovieClip
	{
		private var pic: Sprite = new Sprite(); //绘图区域
		private var toolRegion: Sprite = new Sprite(); //工具区域
		private var currentTool: String = ""; //当前选择的工具
		private var currentlineWidth: uint = 1; //当前线条宽度
		private var _currentlineWidth: uint = 1; //非0值的线条宽度
		private var currentColor: uint = 0x000000; //当前颜色
		private var downX: Number, downY: Number; //按下鼠标的位置
		private var picArr: Array = new Array(); //保存图形的数组
		private var anchorPointArr: Array = new Array(); //保存锚点的数组
		private var leftControlPointArr: Array = new Array(); //保存左控制点的数组
		private var rightControlPointArr: Array = new Array(); //保存右控制点的数组
		private var curveArr: Array = new Array(); //保存曲线的数组
		private var curvesp: Sprite = new Sprite(); //画的曲线
		private var guidelinesp: Sprite = new Sprite(); //辅助直线
		private var moveName: String = new String(); //移动的点的名字
		private var controlColor: uint = 0xff0000; //控制点颜色
		private var anchorColor: uint = 0x0000ff; //锚点颜色
		private var anchorNum: uint = 0; //锚点的数量
		private var toolBox: Shape = new Shape(); //工具选择指示框
		private var line: SimpleButton = new SimpleButton(); //直线按钮
		private var linesp: Shape = new Shape(); //直线按钮上的图形
		private var dashedline: SimpleButton = new SimpleButton(); //虚线按钮
		private var dashedlinesp: Shape = new Shape(); //虚线按钮上的图形
		private var dottedline: SimpleButton = new SimpleButton(); //点状线按钮
		private var dottedlinesp: Shape = new Shape(); //点状线按钮上的图形
		private var wavyline: SimpleButton = new SimpleButton(); //波浪线按钮
		private var wavylinesp: Shape = new Shape(); //波浪线按钮上的图形
		private var pen: SimpleButton = new SimpleButton(); //钢笔按钮
		private var pensp: Shape = new Shape(); //钢笔按钮上的图形
		private var pencil: SimpleButton = new SimpleButton(); //铅笔按钮
		private var pencilsp: Shape = new Shape(); //铅笔按钮上的图形
		private var brush: SimpleButton = new SimpleButton(); //橡皮擦按钮
		private var brushsp: Shape = new Shape(); //橡皮擦上的图形
		private var myColorPicker: ColorPicker = new ColorPicker(); //颜色选择
		private var lineWidthSlider: Slider = new Slider(); //线宽滑轨
		private var _x: Number, _y: Number; //绘制点
		private var cursorsp1: Shape = new Shape(); //鼠标指针图形-十字
		private var cursorsp2: Shape = new Shape(); //鼠标指针图形-圆形
		public static const PI: Number = 3.141592653589793; //圆周率

		//构造函数 初始化界面 注册鼠标单击事件
		public function DrawLineTool()
		{
			//绘制工具区
			drawToolRegion();
			//绘制绘图区
			drawPic();
			//绘制指示框
			drawBox();
			//绘制按钮
			drawBtn();
			//绘制线宽选择滑轨			
			drawSlider();
			//绘制鼠标指针
			drawCursor();
			//绘制调色板				
			drawColorPlate();
			//注册鼠标单击侦听函数			
			line.addEventListener(MouseEvent.CLICK, chooseTool);
			dashedline.addEventListener(MouseEvent.CLICK, chooseTool);
			dottedline.addEventListener(MouseEvent.CLICK, chooseTool);
			wavyline.addEventListener(MouseEvent.CLICK, chooseTool);
			pen.addEventListener(MouseEvent.CLICK, chooseTool);
			pencil.addEventListener(MouseEvent.CLICK, chooseTool);
			brush.addEventListener(MouseEvent.CLICK, chooseTool);

		}


		//--------------------------------工具区域---------------------------------------------
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

		//绘制工具按钮
		private function drawBtn()
		{
			//直线工具
			line.name = "line";
			line.downState = new BtnStatusShape2(0x303030, 60, 60);
			line.overState = new BtnStatusShape2(0x303030, 60, 60);
			line.upState = new BtnStatusShape2(0x535353, 60, 60);
			line.hitTestState = line.upState;
			line.x = 150;
			line.y = 20;
			addChild(line);

			linesp.graphics.lineStyle(2, 0xC3C3C3);
			linesp.graphics.moveTo(160, 20 + 60 - 10);
			linesp.graphics.lineTo(200, 20 + 10);

			//虚线工具
			dashedline.name = "dashedline";
			dashedline.downState = new BtnStatusShape2(0x303030, 60, 60);
			dashedline.overState = new BtnStatusShape2(0x303030, 60, 60);
			dashedline.upState = new BtnStatusShape2(0x535353, 60, 60);
			dashedline.hitTestState = dashedline.upState;
			dashedline.x = 150;
			dashedline.y = 20 + 60 + 10;
			addChild(dashedline);

			dashedlinesp.graphics.lineStyle(2, 0xC3C3C3);
			dashedlinesp.graphics.moveTo(160, 90 + 60 - 10);
			_x = 160;
			while (true)
			{
				_x += 40 / 7;
				if ((_x - 160) > 40)
				{
					dashedlinesp.graphics.lineTo(200, 90 + 60 - 10 - 40);
					break;
				}
				dashedlinesp.graphics.lineTo(_x, 140 - (_x - 160));
				_x += 40 / 7;
				if ((_x - 160) > 40)
					break;
				dashedlinesp.graphics.moveTo(_x, 140 - (_x - 160));
			}

			//点状线工具
			dottedline.name = "dottedline";
			dottedline.downState = new BtnStatusShape2(0x303030, 60, 60);
			dottedline.overState = new BtnStatusShape2(0x303030, 60, 60);
			dottedline.upState = new BtnStatusShape2(0x535353, 60, 60);
			dottedline.hitTestState = dottedline.upState;
			dottedline.x = 150;
			dottedline.y = 160;
			addChild(dottedline);

			_x = 160;
			while (true)
			{
				dottedlinesp.graphics.beginFill(0xC3C3C3);
				dottedlinesp.graphics.drawCircle(_x, 210 - (_x - 160), 2);
				dottedlinesp.graphics.endFill();
				_x += 40 / 5;
				if ((_x - 160) > 40)
					break;
			}

			//波浪线工具
			wavyline.name = "wavyline";
			wavyline.downState = new BtnStatusShape2(0x303030, 60, 60);
			wavyline.overState = new BtnStatusShape2(0x303030, 60, 60);
			wavyline.upState = new BtnStatusShape2(0x535353, 60, 60);
			wavyline.hitTestState = wavyline.upState;
			wavyline.x = 150;
			wavyline.y = 230;
			addChild(wavyline);

			_x = 160;
			var _wavylinespspace = 5;
			wavylinesp.graphics.lineTo(160, 280);
			wavylinesp.graphics.lineStyle(2, 0xC3C3C3);
			while (true)
			{
				wavylinesp.graphics.curveTo(_x, 280 - (_x - 160) - _wavylinespspace, _x + _wavylinespspace, 280 - (_x - 160) - _wavylinespspace);
				_x += _wavylinespspace;
				if ((_x + _wavylinespspace - 160) > 40)
					break;
				wavylinesp.graphics.curveTo(_x + _wavylinespspace, 280 - (_x - 160), _x + _wavylinespspace, 280 - (_x - 160) - _wavylinespspace);

				_x += _wavylinespspace;
				if ((_x + _wavylinespspace - 160) > 40)
					break;
			}

			//钢笔工具
			pen.name = "pen";
			pen.downState = new BtnStatusShape2(0x303030, 60, 60);
			pen.overState = new BtnStatusShape2(0x303030, 60, 60);
			pen.upState = new BtnStatusShape2(0x535353, 60, 60);
			pen.hitTestState = pen.upState;
			pen.x = 150;
			pen.y = 300;
			addChild(pen);



			pensp.x = 160;
			pensp.y = 430 - 70;
			pensp.graphics.lineStyle(2, 0xC3C3C3);
			pensp.graphics.beginFill(0xC3C3C3);
			pensp.graphics.moveTo(0, 4);
			pensp.graphics.lineTo(20, 14);
			pensp.graphics.lineTo(35, 9);
			pensp.graphics.lineTo(35, -9);
			pensp.graphics.lineTo(20, -14);
			pensp.graphics.lineTo(0, -4);
			pensp.graphics.lineTo(0, 4);
			pensp.graphics.endFill();
			pensp.graphics.beginFill(0xC3C3C3);
			pensp.graphics.drawRect(40, -9, 8, 18);
			pensp.graphics.endFill();
			pensp.graphics.lineStyle(2, 0x535353);
			pensp.graphics.moveTo(0, 0);
			pensp.graphics.lineTo(18, 0);
			pensp.graphics.beginFill(0x535353);
			pensp.graphics.drawCircle(18, 0, 1);
			pensp.graphics.endFill();
			pensp.rotation -= 45;
			pensp.x = 162;
			pensp.y = 420 - 70;

			//铅笔工具
			pencil.name = "pencil";
			pencil.downState = new BtnStatusShape2(0x303030, 60, 60);
			pencil.overState = new BtnStatusShape2(0x303030, 60, 60);
			pencil.upState = new BtnStatusShape2(0x535353, 60, 60);
			pencil.hitTestState = pencil.upState;
			pencil.x = 150;
			pencil.y = 370;
			addChild(pencil);
			pencilsp.x = 160;
			pencilsp.y = 430;
			pencilsp.graphics.lineStyle(2, 0xC3C3C3);
			pencilsp.graphics.lineTo(10, -5);
			pencilsp.graphics.lineTo(10, 5);
			pencilsp.graphics.lineTo(0, 0);
			pencilsp.graphics.beginFill(0xC3C3C3);
			pencilsp.graphics.drawRect(10, -5, 30, 10);
			pencilsp.graphics.drawRect(44, -5, 5, 10);
			pencilsp.graphics.endFill();
			pencilsp.rotation -= 45;
			pencilsp.x = 162;
			pencilsp.y = 420;


			//橡皮擦工具
			brush.name = "brush";
			brush.downState = new BtnStatusShape2(0x303030, 60, 60);
			brush.overState = new BtnStatusShape2(0x303030, 60, 60);
			brush.upState = new BtnStatusShape2(0x535353, 60, 60);
			brush.hitTestState = brush.upState;
			brush.x = 150;
			brush.y = 440;
			addChild(brush);
			brushsp.x = 160;
			brushsp.y = 500;
			brushsp.graphics.lineStyle(2, 0xC3C3C3);
			brushsp.graphics.drawRect(0, -27, 10, 24);
			brushsp.graphics.beginFill(0xC3C3C3);
			brushsp.graphics.drawRect(10, -30, 33, 30);
			brushsp.graphics.endFill();
			brushsp.rotation -= 45;
			brushsp.x = 175;
			brushsp.y = 497;



			//调整工具图案和指示框的层次
			addChild(toolBox);
			addChild(linesp);
			addChild(dashedlinesp);
			addChild(dottedlinesp);
			addChild(wavylinesp);
			addChild(pensp);
			addChild(pencilsp);
			addChild(brushsp);
		}
		//--------------------------------画图区域---------------------------------------------
		//绘制画板
		private function drawPic()
		{
			pic.x = 360;
			pic.y = 0;
			pic.y = 0;
			pic.name = 'pic';
			pic.graphics.beginFill(0xFFFFFF);
			pic.graphics.drawRect(0, 0, 920, 720);
			pic.graphics.endFill();
			addChild(pic);
		}

		//工具按钮单击事件处理函数，画图区域注册鼠标事件
		private function chooseTool(e: MouseEvent)
		{
			toolBox.x = e.target.x;
			toolBox.y = e.target.y;
			currentTool = e.target.name;
			trace(currentTool);
			pic.addEventListener(MouseEvent.MOUSE_DOWN, downHd);
			pic.addEventListener(MouseEvent.MOUSE_UP, upHd);
			toolRegion.addEventListener(MouseEvent.MOUSE_UP, upHd);
			switch (currentTool)
			{
				case "brush":
					addChild(cursorsp2);
					pic.removeEventListener(MouseEvent.MOUSE_MOVE, cursormoveHd1);
					pic.addEventListener(MouseEvent.MOUSE_MOVE, brushmoveHd);
					break;
				default:
					pic.removeEventListener(MouseEvent.MOUSE_MOVE, brushmoveHd);
					pic.addEventListener(MouseEvent.MOUSE_MOVE, cursormoveHd1);
			}

		}

		//画图区域按下鼠标事件处理函数
		private function downHd(e: MouseEvent)
		{
			downX = e.localX;
			downY = e.localY;
			var newPic: Shape = new Shape();
			picArr.push(newPic);
			pic.addChild(newPic);
			newPic.graphics.moveTo(e.localX, e.localY);
			pic.addEventListener(MouseEvent.MOUSE_MOVE, moveHd);

			if (currentTool == "pen")
			{

			}

			//橡皮擦按下后立即生效			
			if (currentTool == "brush")
			{
				if (e.localX < _currentlineWidth * 5)
				{
					newPic.graphics.beginFill(0xffffff);
					newPic.graphics.drawCircle(_currentlineWidth * 5, e.localY, _currentlineWidth * 5);
					newPic.graphics.endFill();
				}
				else
				{
					newPic.graphics.beginFill(0xffffff);
					newPic.graphics.drawCircle(e.localX, e.localY, _currentlineWidth * 5);
					newPic.graphics.endFill();
				}
			}
		}

		//画图区域抬起鼠标事件处理函数

		private function upHd(e: MouseEvent)
		{
			pic.removeEventListener(MouseEvent.MOUSE_MOVE, moveHd);
		}

		//画图区域移动十字光标事件处理函数

		private function cursormoveHd1(e: MouseEvent)
		{
			Mouse.hide();
			toolRegion.addEventListener(MouseEvent.MOUSE_MOVE, cursormoveHd2);
			cursorsp1.x = e.localX + 360;
			cursorsp1.y = e.localY;
		}
		private function brushmoveHd(e: MouseEvent)
		{
			Mouse.hide();
			toolRegion.addEventListener(MouseEvent.MOUSE_MOVE, cursormoveHd2);
			cursorsp2.x = e.localX + 360;
			cursorsp2.y = e.localY;
		}
		private function cursormoveHd2(e: MouseEvent)
		{
			cursorsp1.x = -100;
			cursorsp2.x = -100;
			Mouse.show();

		}

		//画图区域移动鼠标事件处理函数
		private function moveHd(e: MouseEvent)
		{
			var newPic: Shape = picArr[picArr.length - 1];
			_x = downX; //绘制点的x坐标
			_y = downY; //绘制点的y坐标			
			var _linelength: Number = Math.sqrt(Math.pow(e.localX - downX, 2) + Math.pow(e.localY - downY, 2));
			//待画线的总长度
			if (_linelength == 0) return;
			if (e.localX < 0) return; //超出画板左侧边界时

			switch (currentTool)
			{
				//实线
				case "line":
					if (e.localX < currentlineWidth / 2) return; //超出画板左侧边界时
					newPic.graphics.clear();
					newPic.graphics.moveTo(downX, downY);
					newPic.graphics.lineStyle(currentlineWidth, currentColor);
					newPic.graphics.lineTo(e.localX, e.localY);
					break;

					//虚线
				case "dashedline":
					newPic.graphics.clear();
					newPic.graphics.moveTo(downX, downY);
					newPic.graphics.lineStyle(currentlineWidth, currentColor);
					var _perdashedlinelength: Number = _currentlineWidth * 5; //每个虚线段的长度
					var _space: Number = _perdashedlinelength + 2 * currentlineWidth; //实线之间的间距
					while (true)
					{
						//画一小段虚线				
						_x += _perdashedlinelength * (e.localX - downX) / _linelength;
						_y += _perdashedlinelength * (e.localY - downY) / _linelength;
						//超过待画长度停止绘制
						if (Math.pow(_x - downX, 2) + Math.pow(_y - downY, 2) > Math.pow(e.localX - downX, 2) + Math.pow(e.localY - downY, 2))
						{
							newPic.graphics.lineTo(e.localX, e.localY);
							break;
						}
						newPic.graphics.lineTo(_x, _y);
						//移动画线位置
						_x += _space * (e.localX - downX) / _linelength;
						_y += _space * (e.localY - downY) / _linelength;
						//超过待画长度停止移动
						if (Math.pow(_x - downX, 2) + Math.pow(_y - downY, 2) > Math.pow(e.localX - downX, 2) + Math.pow(e.localY - downY, 2))
							break;
						newPic.graphics.moveTo(_x, _y);
					}
					break;

					//点状线
				case "dottedline":
					newPic.graphics.clear();
					var _dotspace = _currentlineWidth * 5;
					while (true)
					{
						newPic.graphics.beginFill(currentColor);
						if (currentlineWidth == 0)
						{
							newPic.graphics.drawCircle(_x, _y, 1);
						}
						else
						{
							newPic.graphics.drawCircle(_x, _y, currentlineWidth);
						}
						newPic.graphics.endFill();
						_x += _dotspace * (e.localX - downX) / _linelength;
						_y += _dotspace * (e.localY - downY) / _linelength;
						if (Math.pow(_x - downX, 2) + Math.pow(_y - downY, 2) > Math.pow(e.localX - downX, 2) + Math.pow(e.localY - downY, 2))
							break;
					}
					break;

					//波浪线
				case "wavyline":
					if (e.localX < currentlineWidth / 2) return; //超出画板左侧边界时
					newPic.graphics.clear();
					newPic.graphics.moveTo(downX, downY);
					newPic.graphics.lineStyle(currentlineWidth, currentColor);
					var _perwavylinelength: Number = _currentlineWidth * 5; //每个波浪线段的长度
					var _angle: Number = Math.atan2(-(e.localY - downY), e.localX - downX);
					while (true)
					{
						//超出画板左侧边界时
						if (_x + _perwavylinelength * (e.localX - downX) / _linelength < currentlineWidth / 2) return;

						newPic.graphics.curveTo(_x + _perwavylinelength * Math.cos(PI / 4 + _angle) * Math.cos(PI / 4), _y - _perwavylinelength * Math.sin(PI / 4 + _angle) * Math.cos(PI / 4), _x + _perwavylinelength * (e.localX - downX) / _linelength, _y + _perwavylinelength * (e.localY - downY) / _linelength);
						_x += _perwavylinelength * (e.localX - downX) / _linelength;
						_y += _perwavylinelength * (e.localY - downY) / _linelength;
						//绘制点超出鼠标移动点时停止绘制
						if (Math.pow(_x - downX, 2) + Math.pow(_y - downY, 2) > Math.pow(e.localX - downX, 2) + Math.pow(e.localY - downY, 2))
						{
							break;
						}
						if (_x + _perwavylinelength * (e.localX - downX) / _linelength < currentlineWidth / 2) return;

						newPic.graphics.curveTo(_x + _perwavylinelength * Math.cos(_angle - PI / 4) * Math.cos(PI / 4), _y - _perwavylinelength * Math.sin(_angle - PI / 4) * Math.cos(PI / 4), _x + _perwavylinelength * (e.localX - downX) / _linelength, _y + _perwavylinelength * (e.localY - downY) / _linelength);
						_x += _perwavylinelength * (e.localX - downX) / _linelength;
						_y += _perwavylinelength * (e.localY - downY) / _linelength;

						if (Math.pow(_x - downX, 2) + Math.pow(_y - downY, 2) > Math.pow(e.localX - downX, 2) + Math.pow(e.localY - downY, 2))
						{
							break;
						}
					}
					break;

					//钢笔
				case "pen":


					break;

					//铅笔
				case "pencil":
					if (e.localX < _currentlineWidth / 2)
					{
						newPic.graphics.lineTo(_currentlineWidth / 2, e.localY);
						return;
					} //超出画板左侧边界时
					newPic.graphics.lineStyle(currentlineWidth, currentColor);
					newPic.graphics.lineTo(e.localX, e.localY);
					break;

					//橡皮擦
				case "brush":
					//超出画板左侧边界时
					if (e.localX < _currentlineWidth * 5)
					{
						newPic.graphics.beginFill(0xffffff);
						newPic.graphics.drawCircle(_currentlineWidth * 5, e.localY, _currentlineWidth * 5);
						newPic.graphics.endFill();
					}
					else
					{
						newPic.graphics.beginFill(0xffffff);
						newPic.graphics.drawCircle(e.localX, e.localY, _currentlineWidth * 5);
						newPic.graphics.endFill();
					}
					break;
			}
		}

		//--------------------------------调色板区域---------------------------------------------

		private function drawColorPlate()
		{
			//ColorPicker组件
			myColorPicker.addEventListener(ColorPickerEvent.CHANGE, pickColor);
			myColorPicker.setSize(160, 20);
			myColorPicker.move(100, 600);
			addChild(myColorPicker);
			//文字注释
			var tf: TextField = new TextField();
			tf.width = 50;
			tf.x = 50 - 3;
			tf.y = 600;
			tf.text = "颜色:";
			var mytf: TextFormat = new TextFormat();
			mytf.size = 15;
			mytf.bold = true;
			mytf.color = 0xC7C7C7;
			mytf.letterSpacing = 3;
			tf.setTextFormat(mytf);
			tf.selectable = false;
			addChild(tf);

		}
		private function pickColor(e: ColorPickerEvent): void
		{
			currentColor = e.color;
		}

		//--------------------------------选择线条宽度---------------------------------------------
		private function drawSlider()
		{
			//Slider组件
			lineWidthSlider.move(100, 550);
			lineWidthSlider.setSize(160, 3);
			lineWidthSlider.liveDragging = true;
			lineWidthSlider.value = 1;
			lineWidthSlider.minimum = 0;
			lineWidthSlider.maximum = 10;
			lineWidthSlider.snapInterval = 1;
			lineWidthSlider.addEventListener(Event.CHANGE, chooseLineWidth);
			addChild(lineWidthSlider);
			//文字注释
			var tf: TextField = new TextField();
			tf.width = 50;
			tf.x = 50 - 3;
			tf.y = 550 - 7.5;
			tf.text = "线宽:";
			var mytf: TextFormat = new TextFormat();
			mytf.size = 15;
			mytf.bold = true;
			mytf.color = 0xC7C7C7;
			mytf.letterSpacing = 3;
			tf.setTextFormat(mytf);
			tf.selectable = false;
			addChild(tf);
		}
		private function chooseLineWidth(e: Event)
		{
			currentlineWidth = lineWidthSlider.value;
			//设置非零的线宽 避免根据线宽设置的间距或线条长度为0
			if (currentlineWidth == 0)
				_currentlineWidth = 1;
			else
				_currentlineWidth = currentlineWidth;

			//根据线宽更改橡皮擦光标大小
			cursorsp2.graphics.clear();
			cursorsp2.graphics.lineStyle(1, 0x000000);
			cursorsp2.graphics.drawCircle(0, 0, _currentlineWidth * 5);
		}

		//--------------------------------鼠标指针---------------------------------------------
		private function drawCursor()
		{
			//十字指针
			cursorsp1.graphics.lineStyle(2, 0x000000);
			cursorsp1.x = -100;
			//cursorsp1.x = 500, cursorsp1.y = 500;
			var _start: Number = 5;
			var _end: Number = 9;
			cursorsp1.graphics.moveTo(-_start, 0);
			cursorsp1.graphics.lineTo(-_end, 0);
			cursorsp1.graphics.moveTo(_start, 0);
			cursorsp1.graphics.lineTo(_end, 0);
			cursorsp1.graphics.moveTo(0, _start);
			cursorsp1.graphics.lineTo(0, _end);
			cursorsp1.graphics.moveTo(0, -_start);
			cursorsp1.graphics.lineTo(0, -_end);
			cursorsp1.graphics.lineStyle(1, 0x000000);
			cursorsp1.graphics.beginFill(0x000000);
			cursorsp1.graphics.drawCircle(0, 0, 1);
			cursorsp1.graphics.endFill();
			addChild(cursorsp1);

			//橡皮擦的圆形指针
			cursorsp2.graphics.lineStyle(1, 0x000000);
			cursorsp2.x = -100;
			//cursorsp2.x = 500, cursorsp2.y = 500;
			cursorsp2.graphics.drawCircle(0, 0, _currentlineWidth * 5);
			addChild(cursorsp2);
		}

	}
}