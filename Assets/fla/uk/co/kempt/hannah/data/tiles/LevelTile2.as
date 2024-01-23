package uk.co.kempt.hannah.data.tiles
{
   public class LevelTile2 extends AbstractTile
   {
       
      
      public function LevelTile2()
      {
         super();
         variant = Math.floor(Math.random() * 3);
      }
      
      override public function get renderable() : Boolean
      {
         return false;
      }
      
      override public function get spriteClass() : Class
      {
         return LevelTile2Sprite;
      }
      
      override public function get solid() : Boolean
      {
         return true;
      }
      
      override public function get crusting() : Boolean
      {
         return true;
      }
   }
}
