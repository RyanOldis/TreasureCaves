package uk.co.kempt.hannah.display
{
   import flash.display.MovieClip;
   
   public class BadRobotAnimations extends MovieClip
   {
       
      
      public function BadRobotAnimations()
      {
         super();
      }
      
      public function get anim() : MovieClip
      {
         return Boolean(getChildAt(0)) && getChildAt(0) is MovieClip ? MovieClip(getChildAt(0)) : null;
      }
   }
}
