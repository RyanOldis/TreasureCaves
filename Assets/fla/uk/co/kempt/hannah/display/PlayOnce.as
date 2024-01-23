package uk.co.kempt.hannah.display
{
   import flash.display.MovieClip;
   import uk.co.kempt.utils.GarbageUtil;
   
   public class PlayOnce extends MovieClip
   {
       
      
      public function PlayOnce()
      {
         super();
      }
      
      public function die() : void
      {
         GarbageUtil.kill(this);
      }
   }
}
