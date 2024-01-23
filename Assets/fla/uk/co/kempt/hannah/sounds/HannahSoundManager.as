package uk.co.kempt.hannah.sounds
{
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.sounds.Snd;
   import uk.co.kempt.sounds.SoundManager;
   
   public class HannahSoundManager extends SoundManager
   {
       
      
      public function HannahSoundManager()
      {
         super();
      }
      
      override public function playSound(param1:Object, param2:Number = 1) : Snd
      {
         return super.playSound(param1,Engine.instance.soundDisabled ? 0 : param2);
      }
   }
}
