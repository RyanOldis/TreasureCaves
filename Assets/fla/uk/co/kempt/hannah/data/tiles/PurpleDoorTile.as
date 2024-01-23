package uk.co.kempt.hannah.data.tiles
{
   import uk.co.kempt.hannah.world.triggerables.PurpleBlastDoor;
   
   public class PurpleDoorTile extends AbstractTile
   {
       
      
      public function PurpleDoorTile()
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
         return PurpleDoorSprite;
      }
      
      override public function get gameClass() : Class
      {
         return PurpleBlastDoor;
      }
   }
}
