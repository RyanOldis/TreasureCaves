package uk.co.kempt.hannah.data.tiles
{
   import uk.co.kempt.hannah.world.NonSolidBlock;
   
   public class HiddenLevelTile extends AbstractTile
   {
       
      
      public function HiddenLevelTile()
      {
         super();
         variant = Math.floor(Math.random() * 3);
      }
      
      override public function get renderable() : Boolean
      {
         return false;
      }
      
      override public function get solid() : Boolean
      {
         return true;
      }
      
      override public function get spriteClass() : Class
      {
         return HiddenLevelTileSprite;
      }
      
      override public function get crustingGroup() : int
      {
         return 1;
      }
      
      override public function get gameClass() : Class
      {
         return NonSolidBlock;
      }
      
      override public function get crusting() : Boolean
      {
         return true;
      }
      
      override public function get mask() : Boolean
      {
         return true;
      }
   }
}
