package uk.co.kempt.hannah.data.tiles
{
   public class BlankTile extends AbstractTile
   {
       
      
      public function BlankTile()
      {
         super();
      }
      
      override public function get renderable() : Boolean
      {
         return true;
      }
      
      override public function get spriteClass() : Class
      {
         return BlankTileSprite;
      }
      
      override public function get gameClass() : Class
      {
         return null;
      }
   }
}
