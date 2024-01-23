package uk.co.kempt.hannah.data
{
   import flash.geom.Point;
   
   public class LineData
   {
       
      
      private var _start:Point;
      
      private var _constant:Number;
      
      private var _gradient:Number;
      
      private var _end:Point;
      
      public function LineData(param1:Point, param2:Point)
      {
         super();
         this._start = param1;
         this._end = param2;
         this._gradient = NaN;
         this._constant = NaN;
      }
      
      public function get isVertical() : Boolean
      {
         return this._start.x == this._end.x;
      }
      
      public function get displacementX() : Number
      {
         return this._end.x - this._start.x;
      }
      
      public function get displacementY() : Number
      {
         return this._end.y - this._start.y;
      }
      
      public function get constant() : Number
      {
         return this._constant = isNaN(this._constant) ? this._start.y - this.gradient * this._start.x : this._constant;
      }
      
      public function getPointOnLine(param1:Number) : Point
      {
         var _loc2_:Point = this._start.clone();
         _loc2_.x += (this._end.x - this._start.x) * param1;
         _loc2_.y += (this._end.y - this._start.y) * param1;
         return _loc2_;
      }
      
      public function get minY() : Number
      {
         return Math.min(this._start.y,this._end.y);
      }
      
      public function get start() : Point
      {
         return this._start;
      }
      
      public function set start(param1:Point) : void
      {
         this._start = param1;
         this.invalidate();
      }
      
      public function get isHorizontal() : Boolean
      {
         return this._start.y == this._end.y;
      }
      
      public function get gradient() : Number
      {
         return this._gradient = isNaN(this._gradient) ? (this._end.y - this._start.y) / (this._end.x - this._start.x) : this._gradient;
      }
      
      public function get maxX() : Number
      {
         return Math.max(this._start.x,this._end.x);
      }
      
      public function get minX() : Number
      {
         return Math.min(this._start.x,this._end.x);
      }
      
      public function set end(param1:Point) : void
      {
         this._end = param1;
         this.invalidate();
      }
      
      public function get maxY() : Number
      {
         return Math.max(this._start.y,this._end.y);
      }
      
      public function get end() : Point
      {
         return this._end;
      }
      
      private function invalidate() : void
      {
         this._gradient = NaN;
         this._constant = NaN;
      }
   }
}
