package uk.co.kempt.hannah.data.tiles
{
   import uk.co.kempt.hannah.world.triggerables.YellowBlastDoor;
   
   public class YellowDoorTile extends AbstractTile
   {
       
      
      public function YellowDoorTile()
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
         return YellowDoorSprite;
      }
      
      override public function get gameClass() : Class
      {
         return YellowBlastDoor;
      }
   }
}
