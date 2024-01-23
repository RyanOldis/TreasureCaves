package uk.co.kempt.hannah.data.tiles
{
   import uk.co.kempt.hannah.world.ExitDoor;
   
   public class ExitTile extends AbstractTile
   {
       
      
      public function ExitTile()
      {
         super();
      }
      
      override public function get renderable() : Boolean
      {
         return true;
      }
      
      override public function get unique() : Boolean
      {
         return true;
      }
      
      override public function get spriteClass() : Class
      {
         return ExitDoorSprite;
      }
      
      override public function get gameClass() : Class
      {
         return ExitDoor;
      }
      
      override public function get fillHeight() : int
      {
         return 3;
      }
      
      override public function get fillWidth() : int
      {
         return 2;
      }
   }
}
