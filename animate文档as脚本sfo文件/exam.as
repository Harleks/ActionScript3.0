﻿
package
{
	import flash.display.MovieClip;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class exam extends MovieClip
	{
		private var lineWidth: Number = stage.stageWidth / 40;
		private var fArr: Array = new Array();
		private var colorArr: Array = new Array();
		private var linesp: Shape = new Shape();
		private var curveWidth = 20;
		private var i: uint = 0;private var num: uint = 0;
		private var color: uint = 0xffffff;
		private var frameNum: uint = 0;
		private var Amplitude: uint = 200;



		public function exam()
		{
			for (i = 0; i < 100; i++)
			{
				fArr.push(Amplitude * Math.sin(i / 40 * 2 * Math.PI) + 300);
			}
			for (var i: uint = 0; i < 100; i++)
			{
				colorArr[i] = 0xffffff * Math.random();
			}
			stage.addEventListener(Event.ENTER_FRAME, drawCurve);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, changeColor);
			linesp.x = 0.5 * lineWidth;
			stage.addChild(linesp);
		}
		private function changeColor(e: MouseEvent)
		{
			num++;
			if (num % 2 == 0) color = 0xffffff;
			else color = 0xffffff * Math.random();
		}

		private function drawCurve(e: Event)
		{
			if (frameNum > 1000000) frameNum = 0;
			frameNum++;
			linesp.graphics.clear();
			for (i = 0; i < 100; i++)
			{
				fArr[i] = (Amplitude * Math.sin((i / 40 + frameNum / 160) * 2 * Math.PI) + 300);
			}
			for (i = 0; i < 100; i++)
			{
				color = 255-color;
				linesp.graphics.lineStyle(lineWidth, color);
				linesp.graphics.moveTo(i * lineWidth, 0);
				linesp.graphics.lineTo(i * lineWidth, stage.stageHeight);
				var x0 = (i - 0.5) * lineWidth;
				var x1 = (i + 0.5) * lineWidth;
				linesp.graphics.lineStyle(1, 255 - color);
				linesp.graphics.beginFill(255 - color);
				linesp.graphics.moveTo(x0, fArr[i]);
				linesp.graphics.lineTo(x1, fArr[i + 1]);
				linesp.graphics.lineTo(x1, fArr[i + 1] + curveWidth);
				linesp.graphics.lineTo(x0, fArr[i]);
				linesp.graphics.endFill();
			}

		}
	}

}