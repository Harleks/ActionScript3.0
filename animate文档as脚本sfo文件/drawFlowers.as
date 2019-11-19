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
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.net.URLRequest;


	public class drawFlowers extends MovieClip
	{
		private var pic: Sprite = new Sprite(); //绘图区域
		private var toolRegion: Sprite = new Sprite(); //工具区域
		private var toolRegionWidth: Number = stage.stageWidth - stage.stageHeight; //工具区域宽度
		private var toolWidth: Number = stage.stageHeight / 10; //工具区域宽度
		private var currentTool: String = ""; //当前选择的工具
		private var toolBox: Shape = new Shape(); //工具选择指示框

		private var Rose: SimpleButton = new SimpleButton(); //玫瑰线按钮
		private var RoseSp: Shape = new Shape(); //玫瑰线按钮上的图形
		private var Flowers: SimpleButton = new SimpleButton(); //花朵（位图）按钮
		private var FlowersSp: Shape = new Shape(); //花朵（位图）按钮上的图形

		private var lineSp: Sprite = new Sprite(); //玫瑰线
		private var lineSp2: Sprite = new Sprite(); //花朵（位图）

		private var background: Sprite = new Sprite(); //玫瑰线背景
		private var background2: Sprite = new Sprite(); //玫瑰线背景
		private var petalNum: Number = 3 / 2; //玫瑰花瓣数		
		private var petal: uint = 0; //玫瑰花瓣数		
		private var flowerNum: uint = 0; //玫瑰花层数
		private var rotationSpeed: Number = 0; //旋转速度
		private var RMAX: uint = 200; //玫瑰线最大半径
		private var RArr: Array = new Array(); //玫瑰线半径数组		
		private var alphaArr: Array = new Array(); //透明度数组		
		private var p1: Point = new Point();
		private var p2: Point = new Point();
		private var angle: Number = 0;

		private var frameNum: Number = 0; //帧数
		private var colorArr: Array = new Array(); //随机颜色数组
		private var loader: Loader = new Loader();

		public function drawFlowers()
		{
			//绘制绘图区
			drawPic();
			//绘制工具区
			drawToolRegion();
			//绘制指示框
			drawBox();
			//绘制按钮
			drawBtn();
			Rose.addEventListener(MouseEvent.CLICK, chooseTool);
			Flowers.addEventListener(MouseEvent.CLICK, chooseTool);




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
			//玫瑰线工具
			Rose.name = "Rose";
			Rose.downState = new BtnStatusShape2(0x303030, toolWidth, toolWidth);
			Rose.overState = new BtnStatusShape2(0x303030, toolWidth, toolWidth);
			Rose.upState = new BtnStatusShape2(0x535353, toolWidth, toolWidth);
			Rose.hitTestState = Rose.upState;
			Rose.x = toolRegionWidth / 2;
			Rose.y = stage.stageHeight / 10;
			toolRegion.addChild(Rose);

			//玫瑰线工具图标
			RoseSp.graphics.lineStyle(2, 0xC3C3C3);
			for (var i: uint = 0; i < toolWidth / 2.5; i++)
			{
				var p: Point = Point.polar(i, i / 3);
				RoseSp.graphics.lineTo(p.x, p.y);
			}
			RoseSp.x = toolRegionWidth / 2 + toolWidth / 2;
			RoseSp.y = stage.stageHeight / 10 + toolWidth / 2;

			//文字注释
			var RoseText: TextField = new TextField();
			RoseText.width = toolWidth * 1.5;
			RoseText.x = toolRegionWidth / 2 - toolWidth * 1.5;
			RoseText.y = stage.stageHeight / 10 + toolWidth * 0.25;
			RoseText.text = "玫瑰线:";
			var mytf: TextFormat = new TextFormat();
			mytf.size = toolWidth / 4;
			mytf.color = 0xC7C7C7;
			mytf.letterSpacing = 1;
			RoseText.setTextFormat(mytf);
			RoseText.selectable = false;
			toolRegion.addChild(RoseText);



			//花朵（位图）工具
			Flowers.name = "Flowers";
			Flowers.downState = new BtnStatusShape2(0x303030, toolWidth, toolWidth);
			Flowers.overState = new BtnStatusShape2(0x303030, toolWidth, toolWidth);
			Flowers.upState = new BtnStatusShape2(0x535353, toolWidth, toolWidth);
			Flowers.hitTestState = Flowers.upState;
			Flowers.x = toolRegionWidth / 2;
			Flowers.y = stage.stageHeight / 10 * 2.5;
			toolRegion.addChild(Flowers);

			//花朵（位图）工具图标
			FlowersSp.graphics.lineStyle(2, 0xC3C3C3);
			for (var i: uint = 0; i < toolWidth / 2.5; i++)
			{
				var p: Point = Point.polar(i, i / 3);
				FlowersSp.graphics.lineTo(p.x, p.y);
			}
			FlowersSp.x = toolRegionWidth / 2 + toolWidth / 2;
			FlowersSp.y = stage.stageHeight / 10 * 2.5 + toolWidth / 2;

			//文字注释
			var FlowersText: TextField = new TextField();
			FlowersText.width = toolWidth * 1.5;
			FlowersText.x = toolRegionWidth / 2 - toolWidth * 1.5;
			FlowersText.y = stage.stageHeight / 10 * 2.5 + toolWidth * 0.25;
			FlowersText.text = "花朵（位图）:";
			var mytf: TextFormat = new TextFormat();
			mytf.size = toolWidth / 4;
			mytf.color = 0xC7C7C7;
			mytf.letterSpacing = 1;
			FlowersText.setTextFormat(mytf);
			FlowersText.selectable = false;
			toolRegion.addChild(FlowersText);

			toolRegion.addChild(toolBox);
			toolRegion.addChild(RoseSp);
			toolRegion.addChild(FlowersSp);

		}
		private function chooseTool(e: MouseEvent)
		{
			toolBox.x = e.target.x;
			toolBox.y = e.target.y;
			currentTool = e.target.name;
			trace(currentTool);
			rotationSpeed = 0;
			if (pic.contains(background)) pic.removeChild(background);

			pic.removeEventListener(Event.ENTER_FRAME, drawRose);

			switch (e.target.name)
			{
				case 'Rose':
					//pic.removeChild(bmp);
					lineSp2.graphics.clear();
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
					/*for (var i: uint = 0; i < 21; i++)
					{
						var random = Math.random();
						colorArr[i] = uint(random*  0xff0066) + uint((1 - random ) * 0xff00ff);
					}*/
					colorArr.push(0xff0066);
					colorArr.push(0xff0099);
					colorArr.push(0xff00cc);
					colorArr.push(0xff33cc);
					colorArr.push(0xff3399);
					colorArr.push(0xff3366);
					RArr.push(300);
					RArr.push(300);
					pic.addEventListener(Event.ENTER_FRAME, drawRose);
					break;

				case 'Flowers':
					pic.removeEventListener(Event.ENTER_FRAME, drawRose);
					pic.removeEventListener(Event.ENTER_FRAME, rotateRose);
					lineSp.graphics.clear();
					frameNum = 0;
					flowerNum = 0;
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



					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
					loader.load(new URLRequest("flowers.jpg"));




					break;

			}

			//pic.addEventListener(MouseEvent.MOUSE_DOWN, downHd);
			//pic.addEventListener(MouseEvent.MOUSE_UP, upHd);
		}
		private function rotateRose(e: Event)
		{
			lineSp.rotation -= 1;
		}
		function completeHandler(event: Event)
		{
			var _content: DisplayObject = event.target.content;
			var bmpData: BitmapData = new BitmapData(900, 900);
			bmpData.draw(loader);
			var bmp: Bitmap = new Bitmap(bmpData);
			pic.addChild(bmp);
			bmp.x = 300;
			bmp.y = 0;
		}

		private function drawRose(e: Event)
		{
			if (flowerNum >= 2) return;
			if (frameNum == 7 * (360 / petalNum / 2) - 1)
			{
				frameNum = 0;
				flowerNum++;
				if (flowerNum == 2)
				{
					lineSp.graphics.beginFill(0xff9900);
					lineSp.graphics.drawCircle(0, 0, 50);
					lineSp.graphics.endFill();
					pic.addEventListener(Event.ENTER_FRAME, rotateRose);
					return;
				}
			}
			petal = frameNum / (360 / petalNum / 2);
			lineSp.graphics.lineStyle(0, colorArr[petal], 0);
			lineSp.graphics.beginFill(colorArr[petal]);
			if (frameNum >= (6 * (360 / petalNum / 2) - 1) && (frameNum <= (6 * (360 / petalNum / 2) + (360 / petalNum / 4))))
			{
				frameNum++;
			}
			else
			{
				if (frameNum >= (6 * (360 / petalNum / 2) + (360 / petalNum / 4)) - 1)
				{
					lineSp.graphics.lineStyle(1, colorArr[0], 0);
					lineSp.graphics.beginFill(colorArr[0]);
				}
				frameNum++;
				angle = frameNum / 360 * 2 * Math.PI;
				p1 = Point.polar(RArr[flowerNum] * Math.sin(petalNum * angle), angle + flowerNum * (1 + 1 / 6) * Math.PI);
				angle = (frameNum + 1) / 360 * 2 * Math.PI;
				p2 = Point.polar(RArr[flowerNum] * Math.sin(petalNum * angle), angle + flowerNum * (1 + 1 / 6) * Math.PI);

				lineSp.graphics.lineTo(p1.x, p1.y);
				lineSp.graphics.lineTo(p2.x, p2.y);
				lineSp.graphics.lineTo(0, 0);
				lineSp.graphics.endFill();
			}


		}
	}

}