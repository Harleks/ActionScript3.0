package
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;


	public class pencilTool extends MovieClip

	{
		private var anchorPointArr: Array = new Array(); //保存锚点的数组
		private var leftControlPointArr: Array = new Array(); //保存左控制点的数组
		private var rightControlPointArr: Array = new Array(); //保存右控制点的数组
		private var curveArr: Array = new Array(); //保存曲线的数组
		private var _currentlineWidth: uint = 1;
		private var anchorNum: uint = 0;//锚点数量
		private var downX: Number, downY: Number; //按下鼠标的位置
		private var curvesp: Sprite = new Sprite(); //画的曲线
		private var guidelinesp: Sprite = new Sprite(); //辅助直线
		private var moveName: String = new String();//移动的点的名字
		private var controlColor: uint = 0xff0000;//控制点颜色
		private var anchorColor: uint = 0x0000ff;//锚点颜色
		private var movePoint: Boolean = false;
		public function pencilTool()
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, downHd);
			stage.addEventListener(MouseEvent.MOUSE_UP, upHd);


		}

		private function downHd(e: MouseEvent)
		{
			if (e.target.name == null)
			{
				movePoint = false;
				downX = e.localX, downY = e.localY;
				var newAnchorPoint: Sprite = new Sprite();
				newAnchorPoint.graphics.lineStyle(1, anchorColor);
				newAnchorPoint.graphics.beginFill(anchorColor);
				newAnchorPoint.graphics.drawCircle(0, 0, _currentlineWidth * 10);
				newAnchorPoint.graphics.endFill();
				newAnchorPoint.x = e.localX;
				newAnchorPoint.y = e.localY;
				newAnchorPoint.name = 'apoint'.concat(anchorPointArr.length);

				anchorPointArr.push(newAnchorPoint);
				anchorNum += 1;
				stage.addChild(newAnchorPoint);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, moveHd);
			}
			else if (e.target.name.substr(1, 5) == 'point')
			{
				movePoint = true;
				moveName = e.target.name;
				stage.addEventListener(MouseEvent.MOUSE_MOVE, movePointHd);
			}



		}

		private function moveHd(e: MouseEvent)
		{



		}

		private function movePointHd(e: MouseEvent)
		{

			switch (moveName.substr(0, 1))
			{
				case 'a':
					anchorPointArr[uint(moveName.substr(6, moveName.length - 6))].x = e.stageX;
					anchorPointArr[uint(moveName.substr(6, moveName.length - 6))].y = e.stageY;
					break;
				case 'r':
					rightControlPointArr[uint(moveName.substr(6, moveName.length - 6))].x = e.stageX;
					rightControlPointArr[uint(moveName.substr(6, moveName.length - 6))].y = e.stageY;
					break;
				case 'l':
					leftControlPointArr[uint(moveName.substr(6, moveName.length - 6))].x = e.stageX;
					leftControlPointArr[uint(moveName.substr(6, moveName.length - 6))].y = e.stageY;
					break;
			}
		}

		private function upHd(e: MouseEvent)
		{
			if (movePoint)
			{

				stage.removeEventListener(MouseEvent.MOUSE_MOVE, movePointHd);
			}
			else if (rightControlPointArr.length < anchorPointArr.length)
			{
				var newRightControlPoint: Sprite = new Sprite();
				newRightControlPoint.graphics.lineStyle(1, controlColor);
				newRightControlPoint.graphics.beginFill(controlColor);
				newRightControlPoint.graphics.drawCircle(0, 0, _currentlineWidth * 10);
				newRightControlPoint.graphics.endFill();
				newRightControlPoint.x = e.stageX;
				newRightControlPoint.y = e.stageY;
				newRightControlPoint.name = 'rpoint'.concat(rightControlPointArr.length);
				
				rightControlPointArr.push(newRightControlPoint);
				if (rightControlPointArr.length == 1)
				{
					stage.addChild(rightControlPointArr[rightControlPointArr.length-1]);
				}
				
				else if (rightControlPointArr.length > 1)
				{
					stage.addChild(rightControlPointArr[rightControlPointArr.length-2]);
				}

				var newLeftControlPoint: Sprite = new Sprite();
				newLeftControlPoint.graphics.lineStyle(1, controlColor);
				newLeftControlPoint.graphics.beginFill(controlColor);
				newLeftControlPoint.graphics.drawCircle(0, 0, _currentlineWidth * 10);
				newLeftControlPoint.graphics.endFill();
				newLeftControlPoint.x = 2 * downX - e.stageX;
				newLeftControlPoint.y = 2 * downY - e.stageY;
				newLeftControlPoint.name = 'lpoint'.concat(leftControlPointArr.length);
				leftControlPointArr.push(newLeftControlPoint);
				if (leftControlPointArr.length > 1)
				{
					stage.addChild(newLeftControlPoint);
				}
			}
			curvesp.graphics.clear();
			guidelinesp.graphics.clear();
			var i: uint = 1;
			while (i < anchorNum)
			{
				curvesp.graphics.lineStyle(2, 0x000000);
				curvesp.graphics.moveTo(anchorPointArr[i - 1].x, anchorPointArr[i - 1].y);
				curvesp.graphics.cubicCurveTo(rightControlPointArr[i - 1].x, rightControlPointArr[i - 1].y, leftControlPointArr[i].x, leftControlPointArr[i].y, anchorPointArr[i].x, anchorPointArr[i].y);

				stage.addChild(curvesp);

				guidelinesp.graphics.lineStyle(2, 0x000000, 0.3);
				guidelinesp.graphics.moveTo(anchorPointArr[i - 1].x, anchorPointArr[i - 1].y);
				guidelinesp.graphics.lineTo(rightControlPointArr[i - 1].x, rightControlPointArr[i - 1].y);
				guidelinesp.graphics.lineTo(leftControlPointArr[i].x, leftControlPointArr[i].y);
				guidelinesp.graphics.lineTo(anchorPointArr[i].x, anchorPointArr[i].y);
				stage.addChild(guidelinesp);
				i += 1;

			}
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveHd);
		}
	}
}