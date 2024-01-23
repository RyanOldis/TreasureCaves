package uk.co.kempt.hannah.world
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.data.Boundaries;
   import uk.co.kempt.hannah.data.CollisionData;
   import uk.co.kempt.hannah.sounds.HannahSounds;
   import uk.co.kempt.sounds.Snd;
   
   public class ExitDoor extends WorldObject
   {
       
      
      public var doors:MovieClip;
      
      public var light:MovieClip;
      
      public function ExitDoor()
      {
         super();
      }
      
      override public function get updateable() : Boolean
      {
         return true;
      }
      
      override public function update() : void
      {
         var _loc2_:Snd = null;
         var _loc1_:int = Engine.instance.goalAchieved ? 2 : 1;
         if(this.light.currentFrame != _loc1_)
         {
            this.light.gotoAndStop(_loc1_);
         }
         if(!Engine.instance.goalAchieved)
         {
            if(this.doors.currentFrame != 1)
            {
               this.doors.gotoAndStop(1);
            }
         }
         else if(this.doors.currentFrame == 1)
         {
            if(Engine.instance.getWorldObjectPlayerRatio(this) > 0.3)
            {
               _loc2_ = Engine.instance.soundEngine.playSound(HannahSounds.EXIT_DOOR);
               _loc2_.pan = Engine.instance.getWorldObjectScreenRatio(this);
               this.doors.play();
            }
         }
      }
      
      override protected function createBounds() : Boundaries
      {
         return new Boundaries(new Rectangle(x + Engine.TILE_SIZE,y - Engine.TILE_SIZE,Engine.TILE_SIZE,Engine.TILE_SIZE * 2));
      }
      
      override public function get solid() : Boolean
      {
         return false;
      }
      
      override public function onCollision(param1:CollisionData) : void
      {
         super.onCollision(param1);
         if(Engine.instance.goalAchieved)
         {
            if(param1.source is Player)
            {
               Engine.instance.levelComplete();
            }
         }
      }
      
      override public function get fixed() : Boolean
      {
         return true;
      }
   }
}
