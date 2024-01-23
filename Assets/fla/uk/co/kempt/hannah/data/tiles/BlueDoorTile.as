package uk.co.kempt.hannah.data.tiles
{
   import uk.co.kempt.hannah.world.triggerables.BlueBlastDoor;
   
   public class BlueDoorTile extends AbstractTile
   {
       
      
      public function BlueDoorTile()
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
         return BlueDoorSprite;
      }
      
      override public function get gameClass() : Class
      {
         return BlueBlastDoor;
      }
   }
}
