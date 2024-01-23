package uk.co.kempt.hannah.data.tiles
{
   public class StartTile extends AbstractTile
   {
       
      
      public function StartTile()
      {
         super();
      }
      
      override public function get renderable() : Boolean
      {
         return true;
      }
      
      override public function get fillHeight() : int
      {
         return 2;
      }
      
      override public function get spriteClass() : Class
      {
         return StartSprite;
      }
      
      override public function get unique() : Boolean
      {
         return true;
      }
   }
}
