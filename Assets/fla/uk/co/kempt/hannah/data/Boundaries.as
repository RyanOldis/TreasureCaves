package uk.co.kempt.hannah.data
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Boundaries
   {
       
      
      private var _rightEdge:uk.co.kempt.hannah.data.LineData;
      
      private var _leftEdge:uk.co.kempt.hannah.data.LineData;
      
      private var _width:Number;
      
      private var _bottom:Number;
      
      private var _height:Number;
      
      private var _top:Number;
      
      private var _right:Number;
      
      private var _topRight:Point;
      
      private var _bottomEdge:uk.co.kempt.hannah.data.LineData;
      
      private var _left:Number;
      
      private var _bottomLeft:Point;
      
      private var _bottomRight:Point;
      
      private var _topEdge:uk.co.kempt.hannah.data.LineData;
      
      private var _center:Point;
      
      private var _topLeft:Point;
      
      public function Boundaries(param1:Rectangle = null)
      {
         super();
         this.setBounds(param1 || new Rectangle());
      }
      
      public function get rightEdge() : uk.co.kempt.hannah.data.LineData
      {
         return this._rightEdge = this._rightEdge || new uk.co.kempt.hannah.data.LineData(this.topRight,this.bottomRight);
      }
      
      public function get bottomEdge() : uk.co.kempt.hannah.data.LineData
      {
         return this._bottomEdge = this._bottomEdge || new uk.co.kempt.hannah.data.LineData(this.bottomRight,this.bottomLeft);
      }
      
      public function get leftEdge() : uk.co.kempt.hannah.data.LineData
      {
         return this._leftEdge = this._leftEdge || new uk.co.kempt.hannah.data.LineData(this.bottomLeft,this.topLeft);
      }
      
      public function get bottomLeft() : Point
      {
         return this._bottomLeft;
      }
      
      public function get top() : Number
      {
         return this._top;
      }
      
      public function get width() : Number
      {
         return this._width;
      }
      
      public function get left() : Number
      {
         return this._left;
      }
      
      public function get right() : Number
      {
         return this._right;
      }
      
      public function get topRight() : Point
      {
         return this._topRight;
      }
      
      public function get bottom() : Number
      {
         return this._bottom;
      }
      
      public function get height() : Number
      {
         return this._height;
      }
      
      public function get center() : Point
      {
         return this._center = this._center || new Point(this.left + (this.right - this.left) / 2,this.top + (this.bottom - this.top) / 2);
      }
      
      public function get bottomRight() : Point
      {
         return this._bottomRight;
      }
      
      public function get topEdge() : uk.co.kempt.hannah.data.LineData
      {
         return this._topEdge = this._topEdge || new uk.co.kempt.hannah.data.LineData(this.topLeft,this.topRight);
      }
      
      public function get topLeft() : Point
      {
         return this._topLeft;
      }
      
      public function setBounds(param1:Rectangle) : *
      {
         this._left = param1.x;
         this._top = param1.y;
         this._right = param1.x + param1.width;
         this._bottom = param1.y + param1.height;
         this._topRight = new Point(this.right,this.top);
         this._bottomRight = new Point(this.right,this.bottom);
         this._bottomLeft = new Point(this.left,this.bottom);
         this._topLeft = new Point(this.left,this.top);
         this._width = param1.width;
         this._height = param1.height;
         this._topEdge = null;
         this._leftEdge = null;
         this._rightEdge = null;
         this._bottomEdge = null;
         this._center = null;
      }
   }
}
