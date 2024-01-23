package uk.co.kempt.hannah.data.tiles
{
   public class BlankAssociateTile extends BlankTile
   {
       
      
      public function BlankAssociateTile()
      {
         super();
      }
      
      override public function get spriteClass() : Class
      {
         return BlankAssociateTileSprite;
      }
   }
}
