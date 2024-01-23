package uk.co.kempt.hannah.data.tiles
{
   import uk.co.kempt.hannah.world.npc.BadRobot;
   
   public class RobotTile extends AbstractTile
   {
       
      
      public function RobotTile()
      {
         super();
      }
      
      override public function get renderable() : Boolean
      {
         return true;
      }
      
      override public function get spriteClass() : Class
      {
         return RobotSprite;
      }
      
      override public function get gameClass() : Class
      {
         return BadRobot;
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
