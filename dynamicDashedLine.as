package {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.display.Graphics;


	public dynamic
	class dynamicDashedLine extends MovieClip {
		private var p1:Point=new Point();
		private var p2:Point=new Point();
		private var pStart:Point=new Point(0,0);
		private var _length:Number=0;
		private var pEnd:Point=new Point;
		private var lineWidth:Number;
		private var lineColor:Number;
		private var space:Number;
		private var perlinelength:Number;
		public function dynamicDashedLine(_pEnd:Point,_lineColor: uint = 0x000000,_lineWidth: uint = 1,_space:Number=5,_perlinelength:Number=5) {
			pEnd = _pEnd;
			lineWidth=_lineWidth;
			lineColor=_lineColor;
			space=_space;
			perlinelength=_perlinelength;
			graphics.lineStyle(lineWidth, lineColor);
			_length=_perlinelength+_lineWidth;
			while (_length < pEnd.length) {
				p1=Point.interpolate(pEnd,pStart,_length/pEnd.length);
				graphics.lineTo(p1.x,p1.y);
				_length += _space;
				if(_length>=pEnd.length )
				break;				
				p2=Point.interpolate(pEnd,pStart,_length/pEnd.length);
				graphics.moveTo(p2.x,p2.y);
				if(_length+_perlinelength>=pEnd.length )
						graphics.lineTo(pEnd.x,pEnd.y);
				_length += _perlinelength;
			}
		}
	}
}