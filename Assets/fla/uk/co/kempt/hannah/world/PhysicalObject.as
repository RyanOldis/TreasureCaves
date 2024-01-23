package uk.co.kempt.hannah.world
{
   public class PhysicalObject extends WorldObject
   {
       
      
      public function PhysicalObject()
      {
         super();
      }
      
      override public function update() : void
      {
         velocity.y += GRAVITY;
         if(velocity.y > TERMINAL_VELOCITY_Y)
         {
            velocity.y = TERMINAL_VELOCITY_Y;
         }
         super.update();
         var _loc1_:Number = 1;
         if(Math.abs(velocity.x) <= _loc1_)
         {
            velocity.x = 0;
         }
         else if(velocity.x > 0)
         {
            velocity.x -= _loc1_;
         }
         else
         {
            velocity.x += _loc1_;
         }
      }
      
      override public function get updateable() : Boolean
      {
         return true;
      }
   }
}
