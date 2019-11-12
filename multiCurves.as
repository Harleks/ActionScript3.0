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
	import flash.display.CapsStyle;

	public class multiCurves extends MovieClip
	{
		private var pic: Sprite = new Sprite(); //绘图区域
		private var toolRegion: Sprite = new Sprite(); //工具区域
		private var toolRegionWidth: Number = stage.stageWidth - stage.stageHeight; //工具区域宽度
		private var toolWidth: Number = stage.stageHeight / 10; //工具区域宽度
		private var currentTool: String = ""; //当前选择的工具
		private var toolBox: Shape = new Shape(); //工具选择指示框

		private var Archimedes: SimpleButton = new SimpleButton(); //阿基米德螺旋线按钮
		private var ArchimedesSp: Shape = new Shape(); //阿基米德螺旋线按钮上的图形
		private var Fibonacci: SimpleButton = new SimpleButton(); //斐波那契螺旋线按钮
		private var FibonacciSp: Shape = new Shape(); //斐波那契螺旋线按钮上的图形

		private var lineSp: Sprite = new Sprite(); //阿基米德螺旋线
		private var lineSp2: Sprite = new Sprite(); //斐波那契螺旋线

		private var background: Sprite = new Sprite(); //阿基米德螺线背景
		private var background2: Sprite = new Sprite(); //阿基米德螺线背景
		private var lineNum: uint = 6; //阿基米德螺线条数
		private var rotationSpeed: Number = 0; //旋转速度
		private var RMAX: uint = 500; //阿基米德螺线最大半径
		private var RMIN: uint = 10; //Fibonacci初始半径
		private var RFibonacci: uint = 10; //Fibonacci半径
		private var lastRFibonacci: uint = 10; //前一个Fibonacci半径
		private var frameNum: Number = 0; //帧数
		private var Num: uint = 0; //第几个90°
		private var lastNum: uint = 0; //第几个90°
		private var xArr: Array = new Array(); //圆心x
		private var yArr: Array = new Array(); //圆心y
		private var fArr: Array = new Array(); //f函数
		private var colorArr: Array = new Array(); //随机颜色数组

		public function multiCurves()
		{
			//绘制绘图区
			drawPic();
			//绘制工具区
			drawToolRegion();
			//绘制指示框
			drawBox();
			//绘制按钮
			drawBtn();
			Archimedes.addEventListener(MouseEvent.CLICK, chooseTool);
			Fibonacci.addEventListener(MouseEvent.CLICK, chooseTool);

			fArr.push(0);

			fArr.push(0);
			fArr.push(1);
			for (var i: uint = 0; i < 50; i++)
			{
				fArr.push(fArr[fArr.length - 2] + fArr[fArr.length - 1]);
			}
			xArr.push(0);
			xArr.push(0);
			yArr.push(0);
			yArr.push(0);
			for (var i: uint = 2; i < 50; i++)
			{
				xArr.push(xArr[i - 1] + ((i + 1) % 2) * fArr[i] * Math.pow(-1, 1 + ((i % 2) + i) / 2));
				yArr.push(yArr[i - 1] + ((i) % 2) * fArr[i] * Math.pow(-1, 1 + ((i % 2) + i) / 2));
				trace(xArr[i - 2], yArr[i - 2], fArr[i - 2]);
			}




		}
		private function drawToolRegion()
		{
			toolRegion.graphics.beginFill(0x535353);
			toolRegion.graphics.drawRect(0, 0, toolRegionWidth, stage.stageHeight);
			toolRegion.graphics.endFill();
			stage.addChild(toolRegion);
		}
		private function drawBox()
		{
			//绘制指示框
			toolBox.graphics.lineStyle(1, 0x000000, 0);
			toolBox.graphics.beginFill(0x202020, 0.8);
			toolBox.graphics.drawRoundRect(0, 0, toolWidth, toolWidth, 8);
			toolBox.graphics.endFill();
			//初始化在舞台外侧
			toolBox.x = -100;
		}
		private function drawPic()
		{
			pic.name = 'pic';
			pic.graphics.beginFill(0xFFFFFF);
			pic.graphics.drawRect(toolRegionWidth, 0, stage.stageWidth, stage.stageHeight);
			pic.graphics.endFill();
			stage.addChild(pic);
		}
		private function drawBtn()
		{
			//阿基米德线工具
			Archimedes.name = "Archimedes";
			Archimedes.downState = new BtnStatusShape2(0x303030, toolWidth, toolWidth);
			Archimedes.overState = new BtnStatusShape2(0x303030, toolWidth, toolWidth);
			Archimedes.upState = new BtnStatusShape2(0x535353, toolWidth, toolWidth);
			Archimedes.hitTestState = Archimedes.upState;
			Archimedes.x = toolRegionWidth / 2;
			Archimedes.y = stage.stageHeight / 10;
			toolRegion.addChild(Archimedes);

			//阿基米德线工具图标
			ArchimedesSp.graphics.lineStyle(2, 0xC3C3C3);
			for (var i: uint = 0; i < toolWidth / 2.5; i++)
			{
				var p: Point = Point.polar(i, i / 3);
				ArchimedesSp.graphics.lineTo(p.x, p.y);
			}
			ArchimedesSp.x = toolRegionWidth / 2 + toolWidth / 2;
			ArchimedesSp.y = stage.stageHeight / 10 + toolWidth / 2;

			//文字注释
			var ArchimedesText: TextField = new TextField();
			ArchimedesText.width = toolWidth * 1.5;
			ArchimedesText.x = toolRegionWidth / 2 - toolWidth * 1.5;
			ArchimedesText.y = stage.stageHeight / 10 + toolWidth * 0.25;
			ArchimedesText.text = "阿基米德线:";
			var mytf: TextFormat = new TextFormat();
			mytf.size = toolWidth / 4;
			mytf.color = 0xC7C7C7;
			mytf.letterSpacing = 1;
			ArchimedesText.setTextFormat(mytf);
			ArchimedesText.selectable = false;
			toolRegion.addChild(ArchimedesText);



			//斐波那契线工具
			Fibonacci.name = "Fibonacci";
			Fibonacci.downState = new BtnStatusShape2(0x303030, toolWidth, toolWidth);
			Fibonacci.overState = new BtnStatusShape2(0x303030, toolWidth, toolWidth);
			Fibonacci.upState = new BtnStatusShape2(0x535353, toolWidth, toolWidth);
			Fibonacci.hitTestState = Fibonacci.upState;
			Fibonacci.x = toolRegionWidth / 2;
			Fibonacci.y = stage.stageHeight / 10 * 2.5;
			toolRegion.addChild(Fibonacci);

			//斐波那契线工具图标
			FibonacciSp.graphics.lineStyle(2, 0xC3C3C3);
			for (var i: uint = 0; i < toolWidth / 2.5; i++)
			{
				var p: Point = Point.polar(i, i / 3);
				FibonacciSp.graphics.lineTo(p.x, p.y);
			}
			FibonacciSp.x = toolRegionWidth / 2 + toolWidth / 2;
			FibonacciSp.y = stage.stageHeight / 10 * 2.5 + toolWidth / 2;

			//文字注释
			var FibonacciText: TextField = new TextField();
			FibonacciText.width = toolWidth * 1.5;
			FibonacciText.x = toolRegionWidth / 2 - toolWidth * 1.5;
			FibonacciText.y = stage.stageHeight / 10 * 2.5 + toolWidth * 0.25;
			FibonacciText.text = "斐波那契线:";
			var mytf: TextFormat = new TextFormat();
			mytf.size = toolWidth / 4;
			mytf.color = 0xC7C7C7;
			mytf.letterSpacing = 1;
			FibonacciText.setTextFormat(mytf);
			FibonacciText.selectable = false;
			toolRegion.addChild(FibonacciText);

			toolRegion.addChild(toolBox);
			toolRegion.addChild(ArchimedesSp);
			toolRegion.addChild(FibonacciSp);

		}
		private function chooseTool(e: MouseEvent)
		{
			toolBox.x = e.target.x;
			toolBox.y = e.target.y;
			currentTool = e.target.name;
			trace(currentTool);
			rotationSpeed = 0;
			if (pic.contains(background)) pic.removeChild(background);
			pic.removeEventListener(MouseEvent.MOUSE_DOWN, ArchimedesDown);
			pic.removeEventListener(Event.ENTER_FRAME, drawArchimedes);
			pic.removeEventListener(Event.ENTER_FRAME, drawFibonacci);
			switch (e.target.name)
			{
				case 'Archimedes':
					lineSp2.graphics.clear();
					pic.addEventListener(MouseEvent.MOUSE_DOWN, ArchimedesDown);
					background.graphics.clear();
					background.graphics.beginFill(0xcccccc, 0.5);
					background.graphics.drawRect(0, 0, stage.stageHeight, stage.stageHeight);
					background.graphics.endFill();
					background.graphics.lineStyle(2, 0xffffff, 0.5);
					background.graphics.moveTo(0, stage.stageHeight / 2);
					background.graphics.lineTo(stage.stageHeight, stage.stageHeight / 2);
					background.graphics.moveTo(stage.stageHeight / 2, 0);
					background.graphics.lineTo(stage.stageHeight / 2, stage.stageHeight);
					background.graphics.moveTo(0, 0);
					background.graphics.lineTo(stage.stageHeight, stage.stageHeight);
					background.graphics.moveTo(stage.stageHeight, 0);
					background.graphics.lineTo(0, stage.stageHeight);
					for (var j: uint = 0; j < 1000 / 60; j++)
					{
						background.graphics.drawCircle(stage.stageHeight / 2, stage.stageHeight / 2, j * 60);
					}

					background.x = toolRegionWidth;
					lineSp.x = toolRegionWidth + stage.stageHeight / 2;
					lineSp.y = stage.stageHeight / 2;
					pic.addChild(background);
					pic.addChild(lineSp);
					pic.addEventListener(Event.ENTER_FRAME, drawArchimedes);
					for (var i: uint = 0; i < 21; i++)
					{
						colorArr[i] = 0xffffff * Math.random();
					}
					break;

				case 'Fibonacci':
					frameNum = 0;
					lastNum = 0;
					Num = 0;
					RFibonacci = RMIN;
					lastRFibonacci = RMIN;
					background2.graphics.clear();
					background2.graphics.beginFill(0xcccccc, 0.5);
					background2.graphics.drawRect(0, 0, stage.stageHeight, stage.stageHeight);
					background2.graphics.endFill();
					background2.x = toolRegionWidth;
					pic.addChild(background2);

					lineSp.graphics.clear();
					lineSp2.graphics.clear();
					pic.addChild(lineSp2);
					for (var i: uint = 0; i < 21; i++)
					{
						colorArr[i] = 0xffffff * Math.random();
					}
					lineSp2.x = toolRegionWidth + 11 * stage.stageHeight / 16 + stage.stageHeight / 32;
					lineSp2.y = stage.stageHeight / 2 - stage.stageHeight / 16;
					lineSp2.graphics.moveTo(0, 0);

					lineSp2.graphics.lineStyle(3, colorArr[0], 1.0, false, "normal", CapsStyle.SQUARE);
					pic.addEventListener(Event.ENTER_FRAME, drawFibonacci);
					break;

			}

			//pic.addEventListener(MouseEvent.MOUSE_DOWN, downHd);
			//pic.addEventListener(MouseEvent.MOUSE_UP, upHd);
		}

		private function drawArchimedes(e: Event)
		{
			
			if(frameNum>1000000)frameNum=0;
			lineSp.graphics.clear();
			frameNum++;
			lineSp.rotation -= rotationSpeed;
			if (rotationSpeed > 0)
			{
				rotationSpeed = rotationSpeed - 0.05
			};
			for (var j: uint = 0; j < lineNum; j++)
			{
				lineSp.graphics.moveTo(0, 0);
				var theta: Number = j / lineNum * Math.PI * 2;

				for (var i: uint = 0; i < RMAX; i += 1)
				{
					var _i = 0;
					lineSp.graphics.lineStyle(1, colorArr[0], 1.0, false, "normal", CapsStyle.SQUARE);
					if (i > 400) _i = 400;
					else _i = i;
					var p1: Point = Point.polar(_i, i / 50 + theta - i / 1000);
					var p2: Point = Point.polar(_i, i / 50 + theta + i / 1000);

					lineSp.graphics.moveTo(p1.x, p1.y);
					lineSp.graphics.lineTo(p2.x, p2.y);
				}
			}
		}

		private function drawFibonacci(e: Event)
		{
			if (frameNum >= 299) return;

			frameNum++;
			lastNum = Num;
			Num = frameNum / 30;
			if (Num - lastNum == 1)
			{
				lineSp2.graphics.lineStyle(2, colorArr[Num % 20], 1.0, false, "normal", CapsStyle.SQUARE);


			}
			var p2: Point = Point.polar(RMIN * fArr[Num + 3], (frameNum + 1) / 30 / 2 * Math.PI + Math.PI / 2);
			var p1: Point = Point.polar(RMIN * fArr[Num + 3], frameNum / 30 / 2 * Math.PI + Math.PI / 2);
			//lineSp2.graphics.lineTo(p1.x, p1.y);
			//trace(xArr[Num+1],yArr[Num+1],fArr[Num+3]);
			lineSp2.graphics.beginFill(colorArr[Num % 20]);
			lineSp2.graphics.moveTo(p1.x + RMIN * xArr[Num + 1], +p1.y - RMIN * yArr[Num + 1]);
			lineSp2.graphics.lineTo(RMIN * xArr[Num + 1], -RMIN * yArr[Num + 1]);
			lineSp2.graphics.lineTo(p2.x + RMIN * xArr[Num + 1], p2.y - RMIN * yArr[Num + 1]);
			lineSp2.graphics.lineTo(p1.x + RMIN * xArr[Num + 1], +p1.y - RMIN * yArr[Num + 1]);
			lineSp2.graphics.endFill();

		}

		private function ArchimedesDown(e: MouseEvent)
		{
			rotationSpeed += 1;
		}
	}

}