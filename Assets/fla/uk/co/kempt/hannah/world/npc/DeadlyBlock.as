package uk.co.kempt.hannah.world.npc
{
   import flash.geom.Rectangle;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.data.Boundaries;
   import uk.co.kempt.hannah.data.CollisionData;
   import uk.co.kempt.hannah.world.Player;
   import uk.co.kempt.hannah.world.WorldObject;
   
   public class DeadlyBlock extends WorldObject
   {
      
      private static const PADDING:int = 4;
       
      
      public function DeadlyBlock()
      {
         super();
      }
      
      override protected function createBounds() : Boundaries
      {
         return new Boundaries(new Rectangle(x + PADDING,y + PADDING,Engine.TILE_SIZE - PADDING * 2,Engine.TILE_SIZE - PADDING * 2));
      }
      
      override public function onCollision(param1:CollisionData) : void
      {
         if(param1.source is Player)
         {
            Engine.instance.killPlayer();
         }
      }
      
      override public function get fixed() : Boolean
      {
         return true;
      }
      
      override public function get solid() : Boolean
      {
         return false;
      }
   }
}
