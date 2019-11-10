package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
<<<<<<< HEAD
	import flash.display.Shape;
	import flash.display.SimpleButton;

	public class paint extends MovieClip {
		private var pic:Sprite = new Sprite();
=======
	import flash.display.Shape;
	import flash.display.SimpleButton;

	public class paint extends MovieClip {
		private var pic:Sprite = new Sprite();
>>>>>>> ccaa775c44d9c38a97443a28be53aa1d791d940d
		private var toolRegion:Sprite = new Sprite();
		private var currentTool: String = ""; //当前选择的工具
		private var currentlineWidth: uint = 1; //当前线条宽度
		private var color: Array = new Array(); //保存颜色值的数组
		private var currentColor: uint = 0x000000; //当前颜色
		private var downX: Number, downY: Number; //按下鼠标的位置
		private var picArr: Array = new Array(); //保存图形的数组
		private var toolBox: Shape = new Shape(); //工具选择指示框
		private var lineBox: Shape = new Shape(); //线条宽度选择指示框
<<<<<<< HEAD
		private var colorBox: Shape = new Shape(); //颜色选择指示框		
		private var line:SimpleButton = new SimpleButton();//直线按钮
		private var linesp: Shape = new Shape();//直线按钮上的图形
		private var line1:SimpleButton = new SimpleButton();
		private var line2:SimpleButton = new SimpleButton();
		/*public var line:Button;
		public var line1:Button;
		public var line2:Button;
=======
		private var colorBox: Shape = new Shape(); //颜色选择指示框		
		private var line:SimpleButton = new SimpleButton();//直线按钮
		private var linesp: Shape = new Shape();//直线按钮上的图形
		private var line1:SimpleButton = new SimpleButton();
		private var line2:SimpleButton = new SimpleButton();
		/*public var line:Button;
		public var line1:Button;
		public var line2:Button;
>>>>>>> ccaa775c44d9c38a97443a28be53aa1d791d940d
		public var pic:MovieClip;*/


		//构造函数 初始化界面 注册鼠标单击事件
<<<<<<< HEAD
		public function paint() {
			//绘制工具区
			drawToolRegion();
			//绘制绘图区
			drawPic();
			//绘制按钮
			drawBtn();
			//绘制调色板			
			drawColorPlate();
			
			//注册鼠标单击侦听函数			
			line.addEventListener(MouseEvent.CLICK, chooseTool);
			line1.addEventListener(MouseEvent.CLICK, chooseLineWidth);
			line2.addEventListener(MouseEvent.CLICK, chooseLineWidth);
			//绘制指示框
			toolBox.graphics.lineStyle(1, 0x000000,0);
			toolBox.graphics.beginFill(0x202020, 0.8);
			toolBox.graphics.drawRoundRect(0, 0, 60, 60,8);
			toolBox.graphics.endFill();
			lineBox.graphics.lineStyle(1, 0x000000);
			lineBox.graphics.drawRect(0, 0, 60, 60);
			colorBox.graphics.lineStyle(1, 0x000000);
			colorBox.graphics.drawRect(0, 0, 60, 20);
			//定位指示框，初始在舞台外侧
			toolBox.x = -100;
			addChild(toolBox);
			addChild(linesp);
			lineBox.x = -100;
			addChild(lineBox);
			colorBox.x = -100;
			addChild(colorBox);
			
		}


		//--------------------------------工具区域---------------------------------------------
		private function drawToolRegion(){
			toolRegion.width=360;
			toolRegion.height=720;
			toolRegion.graphics.drawRect(0,0,360,720);
		}
		
		//绘制工具按钮
		private function drawBtn() {			
			line.name = "line";
			line.downState = new BtnStatusShape2(0x303030, 60, 60);
			line.overState = new BtnStatusShape2(0x303030, 60, 60);
			line.upState = new BtnStatusShape2(0x535353, 60, 60);
			line.hitTestState = line.upState;
			line.x=150;
			line.y=20;
			addChild(line);
			
			linesp.graphics.lineStyle(2,0xC3C3C3);
			linesp.graphics.moveTo(160,70);
			linesp.graphics.lineTo(200,30);
			addChild(linesp);
			line1.name = "line1";
			line1.downState = new BtnStatusShape2(0x000000, 60, 60);
			line1.overState = new BtnStatusShape2(0x333333, 60, 60);
			line1.upState = new BtnStatusShape2(0x666666, 60, 60);
			line1.hitTestState = line.upState;
			line1.x=150;
			line1.y=360;
			addChild(line1);
			line2.name = "line2";
			line2.downState = new BtnStatusShape2(0x000000, 60, 60);
			line2.overState = new BtnStatusShape2(0x333333, 60, 60);
			line2.upState = new BtnStatusShape2(0x666666, 60, 60);
			line2.hitTestState = line.upState;
			line2.x=150;
			line2.y=423;
			addChild(line2);
		}
		//--------------------------------画图区域---------------------------------------------
		//绘制画板
		private function drawPic(){
			pic.x=360;
			pic.y=0;
			pic.width=920;
			pic.height=720;
			pic.graphics.drawRect(0,0,920,720);
			addChild(pic);
		}
		
		//工具按钮单击事件处理函数，画图区域注册鼠标事件
		private function chooseTool(e: MouseEvent) {
			trace("123");
			toolBox.x = e.target.x;
			toolBox.y = e.target.y;
			currentTool = e.target.name;
=======
		public function paint() {
			//绘制工具区
			drawToolRegion();
			//绘制绘图区
			drawPic();
			//绘制按钮
			drawBtn();
			//绘制调色板			
			drawColorPlate();
			
			//注册鼠标单击侦听函数			
			line.addEventListener(MouseEvent.CLICK, chooseTool);
			line1.addEventListener(MouseEvent.CLICK, chooseLineWidth);
			line2.addEventListener(MouseEvent.CLICK, chooseLineWidth);
			//绘制指示框
			toolBox.graphics.lineStyle(1, 0x000000,0);
			toolBox.graphics.beginFill(0x202020, 0.8);
			toolBox.graphics.drawRoundRect(0, 0, 60, 60,8);
			toolBox.graphics.endFill();
			lineBox.graphics.lineStyle(1, 0x000000);
			lineBox.graphics.drawRect(0, 0, 60, 60);
			colorBox.graphics.lineStyle(1, 0x000000);
			colorBox.graphics.drawRect(0, 0, 60, 20);
			//定位指示框，初始在舞台外侧
			toolBox.x = -100;
			addChild(toolBox);
			addChild(linesp);
			lineBox.x = -100;
			addChild(lineBox);
			colorBox.x = -100;
			addChild(colorBox);
			
		}


		//--------------------------------工具区域---------------------------------------------
		private function drawToolRegion(){
			toolRegion.width=360;
			toolRegion.height=720;
			toolRegion.graphics.drawRect(0,0,360,720);
		}
		
		//绘制工具按钮
		private function drawBtn() {			
			line.name = "line";
			line.downState = new BtnStatusShape2(0x303030, 60, 60);
			line.overState = new BtnStatusShape2(0x303030, 60, 60);
			line.upState = new BtnStatusShape2(0x535353, 60, 60);
			line.hitTestState = line.upState;
			line.x=150;
			line.y=20;
			addChild(line);
			
			linesp.graphics.lineStyle(2,0xC3C3C3);
			linesp.graphics.moveTo(160,70);
			linesp.graphics.lineTo(200,30);
			addChild(linesp);
			line1.name = "line1";
			line1.downState = new BtnStatusShape2(0x000000, 60, 60);
			line1.overState = new BtnStatusShape2(0x333333, 60, 60);
			line1.upState = new BtnStatusShape2(0x666666, 60, 60);
			line1.hitTestState = line.upState;
			line1.x=150;
			line1.y=360;
			addChild(line1);
			line2.name = "line2";
			line2.downState = new BtnStatusShape2(0x000000, 60, 60);
			line2.overState = new BtnStatusShape2(0x333333, 60, 60);
			line2.upState = new BtnStatusShape2(0x666666, 60, 60);
			line2.hitTestState = line.upState;
			line2.x=150;
			line2.y=423;
			addChild(line2);
		}
		//--------------------------------画图区域---------------------------------------------
		//绘制画板
		private function drawPic(){
			pic.x=360;
			pic.y=0;
			pic.width=920;
			pic.height=720;
			pic.graphics.drawRect(0,0,920,720);
			addChild(pic);
		}
		
		//工具按钮单击事件处理函数，画图区域注册鼠标事件
		private function chooseTool(e: MouseEvent) {
			trace("123");
			toolBox.x = e.target.x;
			toolBox.y = e.target.y;
			currentTool = e.target.name;
>>>>>>> ccaa775c44d9c38a97443a28be53aa1d791d940d
			trace(currentTool);
			pic.addEventListener(MouseEvent.MOUSE_DOWN, downHd);
			pic.addEventListener(MouseEvent.MOUSE_UP, upHd);
		}

		//画图区域按下鼠标事件处理函数
		private function downHd(e: MouseEvent) {
<<<<<<< HEAD
			downX = e.localX;
			downY= e.localY;
			/*trace(downX,downY);*/
			var newPic:Shape =new Shape();
			picArr.push(newPic);
			pic.addChild(newPic);
			newPic.graphics.moveTo(e.localX,e.localY);
=======
			downX = e.localX;
			downY= e.localY;
			/*trace(downX,downY);*/
			var newPic:Shape =new Shape();
			picArr.push(newPic);
			pic.addChild(newPic);
			newPic.graphics.moveTo(e.localX,e.localY);
>>>>>>> ccaa775c44d9c38a97443a28be53aa1d791d940d
			pic.addEventListener(MouseEvent.MOUSE_MOVE,moveHd);

		}

		//画图区域抬起鼠标事件处理函数
<<<<<<< HEAD
		private function upHd(e: MouseEvent){
=======
		private function upHd(e: MouseEvent){
>>>>>>> ccaa775c44d9c38a97443a28be53aa1d791d940d
			pic.removeEventListener(MouseEvent.MOUSE_MOVE,moveHd);
		}

		//画图区域移动鼠标事件处理函数
<<<<<<< HEAD
		private function moveHd(e: MouseEvent){
			var newPic:Shape = picArr[picArr.length-1];
			switch(currentTool){
				case"line":
					newPic.graphics.clear();
				    newPic.graphics.moveTo(downX,downY);
				    newPic.graphics.lineStyle(currentlineWidth,currentColor);
				    newPic.graphics.lineTo(e.localX,e.localY);
=======
		private function moveHd(e: MouseEvent){
			var newPic:Shape = picArr[picArr.length-1];
			switch(currentTool){
				case"line":
					newPic.graphics.clear();
				    newPic.graphics.moveTo(downX,downY);
				    newPic.graphics.lineStyle(currentlineWidth,currentColor);
				    newPic.graphics.lineTo(e.localX,e.localY);
>>>>>>> ccaa775c44d9c38a97443a28be53aa1d791d940d
				break;
			}
		}

		//--------------------------------调色板区域---------------------------------------------

		private function drawColorPlate() {
			for (var r: int = 255; r >= 0; r -= 255) {
				for (var g: int = 255; g >= 0; g -= 255) {
					for (var b: int = 255; b >= 0; b -= 255) {
						var mc: colorSpr = new colorSpr();
						mc.color = r << 16 | g << 8 | b;
						mc.graphics.beginFill(mc.color);
						mc.graphics.drawRect(0, 0, 60, 20);
						color.push(mc);
						mc.x = 150;
						mc.y = 500 + 20 * color.length + 1;
						mc.buttonMode = true;
						addChild(mc);
						mc.addEventListener(MouseEvent.CLICK, pickColor);
					}
				}
			}
		}
		private function pickColor(e: MouseEvent): void {
			currentColor = e.target.color;
			trace(currentColor);
		}

		//--------------------------------选择线条宽度---------------------------------------------
<<<<<<< HEAD
		private function chooseLineWidth(e: MouseEvent){
			trace("currentlineWidth");
			lineBox.x=e.target.x;
			lineBox.y=e.target.y;
			currentlineWidth=uint(e.target.name.substr(e.target.name.length-1,1));
			trace(currentlineWidth);
		}
=======
		private function chooseLineWidth(e: MouseEvent){
			trace("currentlineWidth");
			lineBox.x=e.target.x;
			lineBox.y=e.target.y;
			currentlineWidth=uint(e.target.name.substr(e.target.name.length-1,1));
			trace(currentlineWidth);
		}
>>>>>>> ccaa775c44d9c38a97443a28be53aa1d791d940d
		
	}
}