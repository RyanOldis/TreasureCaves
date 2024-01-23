package uk.co.kempt.hannah.world
{
   import flash.geom.Point;
   import uk.co.kempt.hannah.data.Boundaries;
   import uk.co.kempt.hannah.data.CollisionData;
   
   public interface ICollidable
   {
       
      
      function get collidable() : Boolean;
      
      function get fixed() : Boolean;
      
      function get dead() : Boolean;
      
      function get bounds() : Boundaries;
      
      function set dead(param1:Boolean) : void;
      
      function onCollision(param1:CollisionData) : void;
      
      function get solid() : Boolean;
      
      function get velocity() : Point;
   }
}
