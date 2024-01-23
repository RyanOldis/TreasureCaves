package uk.co.kempt.hannah.display
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class GameBackground extends Sprite
   {
      
      private static const HORIZONTAL_RATIO:Number = 0.1;
      
      private static const VERTICAL_RATIO:Number = 0.1;
      
      private static const OFFSET:Point = new Point(0,-192);
       
      
      public function GameBackground()
      {
         super();
      }
      
      public function update(param1:Rectangle) : void
      {
         x = OFFSET.x - param1.x * HORIZONTAL_RATIO;
         y = OFFSET.y - param1.y * VERTICAL_RATIO;
         while(x > 0)
         {
            x -= width / 2;
         }
         while(x < param1.width - width)
         {
            x += width / 2;
         }
         y = Math.max(-height + param1.height,Math.min(0,y));
      }
   }
}
