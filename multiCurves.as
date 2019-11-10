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
		private var lineSp: Sprite = new Sprite(); //阿基米德螺线
		private var background: Sprite = new Sprite(); //阿基米德螺线背景
		private var lineNum: uint = 6; //阿基米德螺线条数
		private var RMAX: uint = 1000; //最大半径
		private var frameNum: uint = 0; //帧数
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
			toolRegion.addChild(ArchimedesSp);


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

			toolRegion.addChild(toolBox);
			toolRegion.addChild(ArchimedesSp);

		}
		private function chooseTool(e: MouseEvent)
		{
			toolBox.x = e.target.x;
			toolBox.y = e.target.y;
			currentTool = e.target.name;
			trace(currentTool);
			switch (e.target.name)
			{
				case 'Archimedes':

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
					for (var j: uint = 0; j < RMAX / 60; j++)
					{
						background.graphics.drawCircle(stage.stageHeight / 2, stage.stageHeight / 2, j * 60);
					}

					background.x = toolRegionWidth;
					pic.addChild(background);
					stage.addEventListener(Event.ENTER_FRAME, drawArchimedes);
					for (var i: uint = 0; i < lineNum; i++)
					{
						colorArr[i] = 0xffffff * Math.random();
					}
					break;

			}

			//pic.addEventListener(MouseEvent.MOUSE_DOWN, downHd);
			//pic.addEventListener(MouseEvent.MOUSE_UP, upHd);
		}

		private function drawArchimedes(e: Event)
		{
			lineSp.graphics.clear();
			frameNum++;
			lineSp.rotation -= 1;
			lineSp.x = toolRegionWidth + stage.stageHeight / 2;
			lineSp.y = stage.stageHeight / 2;
			pic.addChild(lineSp);

			for (var j: uint = 0; j < lineNum; j++)
			{
				lineSp.graphics.moveTo(0, 0);
				var theta: Number = j / lineNum * Math.PI * 2;
				lineSp.graphics.lineStyle(3, colorArr[j]);
				for (var i: uint = 0; i < RMAX; i++)
				{
					var p: Point = Point.polar(i, i / 50 + theta);
					lineSp.graphics.lineTo(p.x, p.y);
				}
			}

		}
	}

}