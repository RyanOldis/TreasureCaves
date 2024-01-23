package uk.co.kempt.hannah.display
{
   import flash.display.MovieClip;
   
   public class HannahAnimations extends MovieClip
   {
      
      public static const JET_SIDEWAYS:String = "jetSideways";
      
      public static const JET_TWEEN:String = "jetTween";
      
      public static const FALL_TOO_FAST:String = "fallTooFast";
      
      public static const HURT:String = "hurt";
      
      public static const JET_OFF:String = "jetOff";
      
      public static const IDLE:String = "idle";
      
      public static const JET_UP:String = "jetUp";
      
      public static const DEAD:String = "dead";
      
      public static const CROUCH_RUN:String = "crouchRun";
      
      public static const CROUCH_OUT:String = "crouchOut";
      
      public static const JET_IN:String = "jetIn";
      
      public static const JUMP:String = "jump";
      
      public static const RUN:String = "run";
      
      public static const CROUCH:String = "crouch";
       
      
      private var _state:String;
      
      public function HannahAnimations()
      {
         super();
         this.state = IDLE;
      }
      
      public function update() : void
      {
         switch(this.state)
         {
            case CROUCH_OUT:
               if(this.anim.currentFrame == this.anim.totalFrames)
               {
                  this.state = IDLE;
               }
               break;
            case JET_IN:
               if(this.anim.currentFrame == this.anim.totalFrames)
               {
                  this.state = JET_SIDEWAYS;
               }
         }
      }
      
      public function get anim() : MovieClip
      {
         return Boolean(getChildAt(0)) && getChildAt(0) is MovieClip ? MovieClip(getChildAt(0)) : null;
      }
      
      private function onStateSet() : void
      {
         gotoAndStop(this.state);
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      public function set state(param1:String) : void
      {
         if(this._state != param1)
         {
            this._state = param1;
            this.onStateSet();
         }
      }
      
      public function fforward() : void
      {
         this.anim.gotoAndStop(this.anim.totalFrames);
      }
   }
}
