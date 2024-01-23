package uk.co.kempt.hannah.world.triggerables
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.data.Boundaries;
   import uk.co.kempt.hannah.sounds.HannahSounds;
   import uk.co.kempt.hannah.world.Triggerable;
   
   public class AbstractBlastDoor extends Triggerable
   {
       
      
      public var anim:MovieClip;
      
      public function AbstractBlastDoor()
      {
         super();
      }
      
      override protected function onTriggered() : void
      {
         triggered = true;
         dead = true;
         if(this.anim.currentFrame == 1)
         {
            Engine.instance.soundEngine.playSound(HannahSounds.DOOR);
            this.anim.play();
         }
      }
      
      override protected function createBounds() : Boundaries
      {
         return new Boundaries(new Rectangle(x,y - Engine.TILE_SIZE,Engine.TILE_SIZE,Engine.TILE_SIZE * 2));
      }
   }
}
