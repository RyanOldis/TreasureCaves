package uk.co.kempt.hannah.display
{
   import flash.display.Sprite;
   
   public class AbstractBar extends Sprite
   {
       
      
      private var _value:Number = 0;
      
      public var progress:Sprite;
      
      public function AbstractBar()
      {
         super();
         this.progress.scaleX = 0;
         this.value = 1;
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function update() : void
      {
         var _loc1_:Number = (this.value - this.progress.scaleX) / 8;
         _loc1_ = Math.min(_loc1_,16);
         _loc1_ = Math.max(_loc1_,-2);
         var _loc2_:Number = Math.abs(_loc1_) > 0.01 ? this.progress.scaleX + _loc1_ : this.value;
         if(this.progress.scaleX != _loc2_)
         {
            this.progress.scaleX = _loc2_;
         }
      }
      
      public function set value(param1:Number) : void
      {
         this._value = Math.max(0,Math.min(1,param1));
      }
   }
}
