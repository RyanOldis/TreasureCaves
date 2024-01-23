package com.asliceofcrazypie.geom2d
{
   import flash.utils.*;
   
   public class Grid
   {
      
      public static const DEFAULT_GRID_CLASS:Class = GridSquare;
       
      
      protected var m_squaresHash:Dictionary;
      
      protected var m_defaultGridClass:Class;
      
      protected var m_squares:Vector.<com.asliceofcrazypie.geom2d.IGridSquare>;
      
      protected var m_width:int;
      
      protected var m_height:int;
      
      public function Grid(param1:int, param2:int, param3:Class = null, param4:Vector.<com.asliceofcrazypie.geom2d.IGridSquare> = null)
      {
         var tNumSquares:int;
         var i:int;
         var pWidth:int = param1;
         var pHeight:int = param2;
         var pGridSquareClass:Class = param3;
         var pSquares:Vector.<com.asliceofcrazypie.geom2d.IGridSquare> = param4;
         super();
         if(pWidth < 1)
         {
            throw new Error("Width must be greater than 0");
         }
         if(pHeight < 1)
         {
            throw new Error("Height must be greater than 0");
         }
         this.m_width = pWidth;
         this.m_height = pHeight;
         this.m_defaultGridClass = pGridSquareClass;
         this.m_squaresHash = new Dictionary(true);
         if(this.m_defaultGridClass)
         {
            if(!describeType(this.m_defaultGridClass).factory.implementsInterface.(@type == getQualifiedClassName(IGridSquare)).length())
            {
               throw new Error("class " + this.m_defaultGridClass + " does not implement IGridSquare");
            }
         }
         tNumSquares = this.numSquares;
         this.m_squares = new Vector.<com.asliceofcrazypie.geom2d.IGridSquare>(tNumSquares,true);
         i = 0;
         while(i < tNumSquares)
         {
            if(pSquares)
            {
               if(pSquares.length > i)
               {
                  this.setSquare(i,pSquares[i]);
               }
            }
            if(this.m_defaultGridClass != null)
            {
               if(!this.m_squares[i])
               {
                  this.setSquare(i,new this.m_defaultGridClass());
               }
            }
            if(!this.m_squares[i])
            {
               this.setSquare(i,null);
            }
            i++;
         }
      }
      
      public function manhattanDistance(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false) : int
      {
         var _loc6_:int = param1 - param3;
         var _loc7_:int = param2 - param4;
         if(_loc6_ < 0)
         {
            _loc6_ = -_loc6_;
         }
         if(_loc7_ < 0)
         {
            _loc7_ = -_loc7_;
         }
         if(param5)
         {
            return _loc6_ > _loc7_ ? _loc6_ : _loc7_;
         }
         return _loc6_ + _loc7_;
      }
      
      protected function getCoordsOfIndex(param1:int) : Vector.<int>
      {
         var _loc2_:Vector.<int> = null;
         if(param1 > -1 && param1 < this.numSquares)
         {
            _loc2_ = new Vector.<int>(2,true);
            _loc2_[0] = param1 % this.m_width;
            _loc2_[1] = int(Math.floor(param1 / this.m_width));
            return _loc2_;
         }
         throw new Error("invalid index: " + param1);
      }
      
      public function squaresOnLine(param1:Number, param2:Number, param3:Number, param4:Number) : Vector.<com.asliceofcrazypie.geom2d.IGridSquare>
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:Function = null;
         var _loc19_:Function = null;
         var _loc20_:Function = null;
         var _loc21_:Function = null;
         var _loc22_:int = 0;
         var _loc5_:Vector.<com.asliceofcrazypie.geom2d.IGridSquare> = new Vector.<com.asliceofcrazypie.geom2d.IGridSquare>();
         if(param3 - param1 != 0)
         {
            _loc11_ = (param4 - param2) / (param3 - param1);
            _loc12_ = param2 - _loc11_ * param1;
            _loc13_ = Math.floor(param1);
            if(param3 - param1 >= 0)
            {
               _loc14_ = 1;
               _loc15_ = Math.ceil(param3);
               _loc16_ = 0;
               _loc17_ = 1;
            }
            else
            {
               _loc14_ = -1;
               _loc15_ = Math.floor(param3) - 1;
               _loc16_ = 1;
               _loc17_ = 0;
            }
            if(param4 - param2 >= 0)
            {
               _loc8_ = 1;
               _loc18_ = Math.floor;
               _loc19_ = Math.ceil;
               _loc20_ = Math.max;
               _loc21_ = Math.min;
               _loc22_ = 0;
            }
            else
            {
               _loc8_ = -1;
               _loc18_ = Math.ceil;
               _loc19_ = Math.floor;
               _loc20_ = Math.min;
               _loc21_ = Math.max;
               _loc22_ = 1;
            }
            _loc6_ = _loc13_;
            while(_loc6_ != _loc15_)
            {
               _loc9_ = _loc18_(_loc20_(_loc11_ * (_loc6_ + _loc16_) + _loc12_,param2)) - _loc22_;
               _loc10_ = _loc19_(_loc21_(_loc11_ * (_loc6_ + _loc17_) + _loc12_,param4)) - _loc22_;
               _loc7_ = _loc9_;
               while(_loc7_ != _loc10_)
               {
                  if(!this.isPointInGrid(_loc6_,_loc7_))
                  {
                     break;
                  }
                  _loc5_.push(this.getSquareAt(_loc6_,_loc7_));
                  _loc7_ += _loc8_;
               }
               _loc6_ += _loc14_;
            }
         }
         else
         {
            if(param4 - param2 > 0)
            {
               _loc8_ = 1;
               _loc9_ = Math.floor(param2);
               _loc10_ = Math.ceil(param4);
            }
            else
            {
               _loc8_ = -1;
               _loc9_ = Math.ceil(param2) - 1;
               _loc10_ = Math.floor(param4) - 1;
            }
            _loc7_ = _loc9_;
            while(_loc7_ != _loc10_)
            {
               if(!this.isPointInGrid(param1,_loc7_))
               {
                  break;
               }
               _loc5_.push(this.getSquareAt(param1,_loc7_));
               _loc7_ += _loc8_;
            }
         }
         return _loc5_;
      }
      
      public function getSquareAbove(param1:com.asliceofcrazypie.geom2d.IGridSquare) : com.asliceofcrazypie.geom2d.IGridSquare
      {
         var _loc2_:int = this.getSquareIndex(param1);
         _loc2_ -= this.m_width;
         if(_loc2_ > -1)
         {
            return this.m_squares[_loc2_];
         }
         return null;
      }
      
      public function getSquaresWithin(param1:com.asliceofcrazypie.geom2d.IGridSquare, param2:int, param3:Boolean = false) : Vector.<com.asliceofcrazypie.geom2d.IGridSquare>
      {
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc4_:Vector.<com.asliceofcrazypie.geom2d.IGridSquare> = new Vector.<com.asliceofcrazypie.geom2d.IGridSquare>();
         var _loc5_:Dictionary = new Dictionary(true);
         var _loc6_:int = 1;
         var _loc7_:int = 1;
         var _loc8_:int = 1;
         var _loc9_:int = 1;
         var _loc10_:int = 0;
         var _loc11_:Vector.<int>;
         var _loc12_:int = (_loc11_ = this.getSquareCoords(param1))[0];
         var _loc13_:int = _loc11_[1];
         while(_loc6_ <= param2)
         {
            while(_loc10_ <= _loc6_)
            {
               _loc14_ = _loc12_ + _loc9_ * _loc7_;
               _loc15_ = _loc13_ + _loc10_ * _loc8_;
               if(this.isPointInGrid(_loc14_,_loc15_))
               {
                  param1 = this.getSquareAt(_loc14_,_loc15_);
                  if(!_loc5_[param1])
                  {
                     _loc4_.push(param1);
                     _loc5_[param1] = true;
                  }
               }
               if(!param3)
               {
                  _loc9_--;
                  _loc10_++;
               }
               else if(_loc9_ == _loc6_)
               {
                  _loc9_ = 0;
                  _loc10_++;
               }
               else
               {
                  _loc9_++;
               }
            }
            if(_loc7_ == 1)
            {
               if(_loc8_ == 1)
               {
                  _loc8_ = -1;
               }
               else
               {
                  _loc7_ = -1;
               }
            }
            else if(_loc8_ == -1)
            {
               _loc8_ = 1;
            }
            else
            {
               _loc7_ = _loc8_ = 1;
               _loc6_++;
            }
            _loc9_ = _loc6_;
            _loc10_ = 0;
         }
         return _loc4_;
      }
      
      public function getColumn(param1:int) : Vector.<com.asliceofcrazypie.geom2d.IGridSquare>
      {
         var _loc2_:Vector.<com.asliceofcrazypie.geom2d.IGridSquare> = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this.isXInRange(param1))
         {
            _loc2_ = new Vector.<com.asliceofcrazypie.geom2d.IGridSquare>(this.m_height,true);
            _loc3_ = this.numSquares;
            _loc4_ = 0;
            _loc5_ = param1;
            while(_loc5_ < _loc3_)
            {
               var _loc6_:*;
               _loc2_[_loc6_ = _loc4_++] = this.m_squares[_loc5_];
               _loc5_ += this.m_width;
            }
            return _loc2_;
         }
         throw new Error("x is out of range: " + param1 + ", 0-" + this.m_width);
      }
      
      public function get width() : int
      {
         return this.m_width;
      }
      
      public function getSquareToRight(param1:com.asliceofcrazypie.geom2d.IGridSquare) : com.asliceofcrazypie.geom2d.IGridSquare
      {
         var square:com.asliceofcrazypie.geom2d.IGridSquare = param1;
         var coords:Vector.<int> = this.getSquareCoords(square);
         ++coords[0];
         if(coords[0] < this.numSquares)
         {
            try
            {
               return this.getSquareAt(coords[0],coords[1]);
            }
            catch(e:Error)
            {
            }
         }
         return null;
      }
      
      public function get numSquares() : int
      {
         return this.m_width * this.m_height;
      }
      
      public function getSquareCoords(param1:com.asliceofcrazypie.geom2d.IGridSquare) : Vector.<int>
      {
         return this.getCoordsOfIndex(this.getSquareIndex(param1));
      }
      
      protected function getIndexOf(param1:int, param2:int) : int
      {
         return param2 * this.m_width + param1;
      }
      
      public function isInGrid(param1:com.asliceofcrazypie.geom2d.IGridSquare) : Boolean
      {
         return Boolean(this.m_squaresHash[param1]);
      }
      
      public function setColumn(param1:int, param2:Vector.<com.asliceofcrazypie.geom2d.IGridSquare> = null) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(this.isXInRange(param1))
         {
            if(!param2)
            {
               _loc3_ = 0;
            }
            else
            {
               _loc3_ = int(param2.length);
            }
            _loc4_ = this.numSquares;
            _loc5_ = 0;
            _loc6_ = param1;
            while(_loc6_ < _loc4_)
            {
               if(_loc5_ < _loc3_)
               {
                  this.setSquare(_loc6_,param2[_loc5_++]);
               }
               else
               {
                  this.setSquare(_loc6_,null);
               }
               _loc6_ += this.m_width;
            }
            return;
         }
         throw new Error("x is out of range: " + param1 + ", 0-" + this.m_width);
      }
      
      public function isXInRange(param1:int) : Boolean
      {
         return param1 > -1 && param1 < this.m_width;
      }
      
      public function getSlice(param1:int, param2:int, param3:int, param4:int) : Vector.<com.asliceofcrazypie.geom2d.IGridSquare>
      {
         var _loc5_:Vector.<com.asliceofcrazypie.geom2d.IGridSquare> = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(this.isXInRange(param1))
         {
            if(this.isXInRange(param1 + param3 - 1))
            {
               if(this.isYInRange(param2))
               {
                  if(this.isYInRange(param2 + param4 - 1))
                  {
                     _loc5_ = new Vector.<com.asliceofcrazypie.geom2d.IGridSquare>(param3 * param4,true);
                     _loc8_ = 0;
                     _loc6_ = param2;
                     while(_loc6_ < param2 + param4)
                     {
                        _loc7_ = param1;
                        while(_loc7_ < param1 + param3)
                        {
                           var _loc9_:*;
                           _loc5_[_loc9_ = _loc8_++] = this.getSquareAt(_loc7_,_loc6_);
                           _loc7_++;
                        }
                        _loc6_++;
                     }
                     return _loc5_;
                  }
                  throw new Error("height out of range: " + (param2 + param4) + " 0-" + this.m_height);
               }
               throw new Error("y out of range: " + param2 + " 0-" + this.m_height);
            }
            throw new Error("width out of range: " + (param1 + param3) + " 0-" + this.m_width);
         }
         throw new Error("x out of range: " + param1 + " 0-" + this.m_width);
      }
      
      public function getSquareBelow(param1:com.asliceofcrazypie.geom2d.IGridSquare) : com.asliceofcrazypie.geom2d.IGridSquare
      {
         var _loc2_:int = this.getSquareIndex(param1);
         _loc2_ += this.m_width;
         if(_loc2_ < this.numSquares)
         {
            return this.m_squares[_loc2_];
         }
         return null;
      }
      
      public function insertGrid(param1:Grid, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = Math.max(0,param2);
         var _loc7_:int = Math.min(this.m_width,param2 + param1.width);
         var _loc8_:int = Math.min(this.m_height,param3 + param1.height);
         _loc5_ = Math.max(0,param3);
         while(_loc5_ < _loc8_)
         {
            _loc4_ = _loc6_;
            while(_loc4_ < _loc7_)
            {
               this.setSquareAt(_loc4_,_loc5_,param1.getSquareAt(_loc4_ - param2,_loc5_ - param3));
               _loc4_++;
            }
            _loc5_++;
         }
      }
      
      public function get defaultGridClass() : Class
      {
         return this.m_defaultGridClass;
      }
      
      public function set defaultGridClass(param1:Class) : void
      {
         this.m_defaultGridClass = param1;
      }
      
      public function getSquareX(param1:com.asliceofcrazypie.geom2d.IGridSquare) : int
      {
         var _loc2_:int = this.getSquareIndex(param1);
         return _loc2_ % this.m_width;
      }
      
      public function getSquareAt(param1:int, param2:int) : com.asliceofcrazypie.geom2d.IGridSquare
      {
         if(this.isXInRange(param1))
         {
            if(this.isYInRange(param2))
            {
               return this.m_squares[this.getIndexOf(param1,param2)];
            }
            throw new Error("y is out of range: " + param2 + ", 0-" + this.m_height);
         }
         throw new Error("x is out of range: " + param1 + ", 0-" + this.m_width);
      }
      
      public function setRow(param1:int, param2:Vector.<com.asliceofcrazypie.geom2d.IGridSquare>) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(this.isYInRange(param1))
         {
            if(!param2)
            {
               _loc3_ = 0;
            }
            else
            {
               _loc3_ = int(param2.length);
            }
            _loc4_ = (param1 + 1) * this.m_width;
            _loc5_ = 0;
            _loc6_ = param1 * this.m_width;
            while(_loc6_ < _loc4_)
            {
               if(_loc5_ < _loc3_)
               {
                  this.setSquare(_loc6_,param2[_loc5_++]);
               }
               else
               {
                  this.setSquare(_loc6_,null);
               }
               _loc6_++;
            }
            return;
         }
         throw new Error("y is out of range: " + param1 + ", 0-" + this.m_height);
      }
      
      public function isYInRange(param1:int) : Boolean
      {
         return param1 > -1 && param1 < this.m_height;
      }
      
      public function distanceBetweenSquares(param1:com.asliceofcrazypie.geom2d.IGridSquare, param2:com.asliceofcrazypie.geom2d.IGridSquare, param3:Boolean = false) : int
      {
         var _loc4_:Vector.<int> = this.getSquareCoords(param1);
         var _loc5_:Vector.<int> = this.getSquareCoords(param2);
         return this.manhattanDistance(_loc4_[0],_loc4_[1],_loc5_[0],_loc5_[1],param3);
      }
      
      public function toString() : String
      {
         return "[Grid: " + this.m_width + ", " + this.m_height + "]";
      }
      
      public function getSquareY(param1:com.asliceofcrazypie.geom2d.IGridSquare) : int
      {
         var _loc2_:int = this.getSquareIndex(param1);
         return int(Math.floor(_loc2_ / this.m_width));
      }
      
      protected function setSquare(param1:int, param2:com.asliceofcrazypie.geom2d.IGridSquare) : void
      {
         var _loc3_:com.asliceofcrazypie.geom2d.IGridSquare = this.m_squares[param1];
         if(_loc3_)
         {
            delete this.m_squaresHash[_loc3_];
         }
         this.m_squares[param1] = param2;
         if(param2)
         {
            this.m_squaresHash[param2] = param1;
         }
      }
      
      public function getSubGrid(param1:int, param2:int, param3:int, param4:int) : Grid
      {
         return new Grid(param3,param4,this.m_defaultGridClass,this.getSlice(param1,param2,param3,param4));
      }
      
      public function isPointInGrid(param1:int, param2:int) : Boolean
      {
         return param1 > -1 && param1 < this.m_width && (param2 > -1 && param2 < this.m_height);
      }
      
      public function setSquareAt(param1:int, param2:int, param3:com.asliceofcrazypie.geom2d.IGridSquare) : void
      {
         if(this.isXInRange(param1))
         {
            if(this.isXInRange(param2))
            {
               this.setSquare(this.getIndexOf(param1,param2),param3);
               return;
            }
            throw new Error("y is out of range: " + param2 + ", 0-" + this.m_height);
         }
         throw new Error("x is out of range: " + param1 + ", 0-" + this.m_width);
      }
      
      public function setSubGrid(param1:int, param2:int, param3:int, param4:int, param5:Vector.<com.asliceofcrazypie.geom2d.IGridSquare>) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(this.isXInRange(param1))
         {
            if(this.isXInRange(param1 + param3 - 1))
            {
               if(this.isYInRange(param2))
               {
                  if(this.isYInRange(param2 + param4 - 1))
                  {
                     if(!param5)
                     {
                        _loc6_ = 0;
                     }
                     else
                     {
                        _loc6_ = int(param5.length);
                     }
                     _loc9_ = 0;
                     _loc7_ = param2;
                     while(_loc7_ < param2 + param4)
                     {
                        _loc8_ = param1;
                        while(_loc8_ < param1 + param3)
                        {
                           if(_loc9_ < _loc6_)
                           {
                              this.setSquare(this.getIndexOf(_loc8_,_loc7_),param5[_loc9_++]);
                           }
                           else
                           {
                              this.setSquare(this.getIndexOf(_loc8_,_loc7_),null);
                           }
                           _loc8_++;
                        }
                        _loc7_++;
                     }
                     return;
                  }
                  throw new Error("height out of range: " + (param2 + param4) + " 0-" + this.m_height);
               }
               throw new Error("y out of range: " + param2 + " 0-" + this.m_height);
            }
            throw new Error("width out of range: " + (param1 + param3) + " 0-" + this.m_width);
         }
         throw new Error("x out of range: " + param1 + " 0-" + this.m_width);
      }
      
      public function get height() : int
      {
         return this.m_height;
      }
      
      public function getSquareToLeft(param1:com.asliceofcrazypie.geom2d.IGridSquare) : com.asliceofcrazypie.geom2d.IGridSquare
      {
         var square:com.asliceofcrazypie.geom2d.IGridSquare = param1;
         var coords:Vector.<int> = this.getSquareCoords(square);
         --coords[0];
         if(coords[0] > -1)
         {
            try
            {
               return this.getSquareAt(coords[0],coords[1]);
            }
            catch(e:Error)
            {
            }
         }
         return null;
      }
      
      public function getRow(param1:int) : Vector.<com.asliceofcrazypie.geom2d.IGridSquare>
      {
         var _loc2_:Vector.<com.asliceofcrazypie.geom2d.IGridSquare> = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this.isYInRange(param1))
         {
            _loc2_ = new Vector.<com.asliceofcrazypie.geom2d.IGridSquare>(this.m_width,true);
            _loc3_ = (param1 + 1) * this.m_width;
            _loc4_ = 0;
            _loc5_ = param1 * this.m_width;
            while(_loc5_ < _loc3_)
            {
               var _loc6_:*;
               _loc2_[_loc6_ = _loc4_++] = this.m_squares[_loc5_];
               _loc5_++;
            }
            return _loc2_;
         }
         throw new Error("y is out of range: " + param1 + ", 0-" + this.m_height);
      }
      
      protected function getSquareIndex(param1:com.asliceofcrazypie.geom2d.IGridSquare) : int
      {
         if(this.m_squaresHash[param1] !== null)
         {
            return this.m_squaresHash[param1];
         }
         throw new Error("Square not found in this grid");
      }
   }
}
