package  {
	
	import flash.display.MovieClip;
	import flash.display.Graphics;
	import flash.display.Shape;
	
	dynamic public class exam extends MovieClip {
		private var windowweight:Number = 1600;
		private var windowheight:Number = 900;
		
		
		public function exam() {
			var linesp:Shape=new Shape();
			var x:Number=0;
			var i:Number=1;
			while (x<windowweight)
			{
				linesp.graphics.lineStyle(20,0x000000);
				linesp.graphics.moveTo(x,0);
				linesp.graphics.lineTo(x,windowheight);
				
				linesp.graphics.beginFill(0xFFFFFF);
				linesp.graphics.lineStyle(1,0xFFFFFF);
				linesp.graphics.moveTo(x+10,windowheight/8+i*6);
				linesp.graphics.lineTo(x+10,windowheight/8+i*6+10);
				linesp.graphics.lineTo(x-10,windowheight/8+i*6);
				linesp.graphics.lineTo(x+10,windowheight/8+i*6);
				linesp.graphics.endFill();
				
				linesp.graphics.beginFill(0x000000);
				linesp.graphics.lineStyle(1,0x000000);
				linesp.graphics.moveTo(x+30,windowheight/8+i*6);
				linesp.graphics.lineTo(x+30,windowheight/8+i*6+10);
				linesp.graphics.lineTo(x+10,windowheight/8+i*6);
				linesp.graphics.lineTo(x+30,windowheight/8+i*6);
				linesp.graphics.endFill();
				
				x+=40;
				i+=1;
				}
			this.stage.addChild(linesp);
			/*var curvesp:Shape=new Shape();
			curvesp.graphics.lineStyle(10,0x000000);
			curvesp.graphics.moveTo(0,windowheight/8);
			curvesp.graphics.cubicCurveTo(windowweight/3,windowheight,windowweight/3*2,-windowheight/2,windowweight,windowheight/4);
			this.stage.addChild(curvesp);
				// constructor code*/
		}
	}
	
}
