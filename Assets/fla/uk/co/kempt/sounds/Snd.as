package uk.co.kempt.sounds
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.Timer;
   
   public class Snd extends EventDispatcher
   {
      
      public static const FADE_RATE:Number = 100;
      
      public static const MAX_LOOPS:int = 10000000;
       
      
      protected var channel:SoundChannel;
      
      protected var masterVol:Number;
      
      protected var _vol:Number = 1;
      
      protected var _tVol:Number;
      
      protected var masterMuted:Boolean;
      
      protected var manager:uk.co.kempt.sounds.SoundManager;
      
      protected var _dVol:Number;
      
      protected var isLooping:Boolean = false;
      
      protected var trans:SoundTransform;
      
      protected var timer:Timer;
      
      protected var onFadeComplete:Function;
      
      protected var _fading:Boolean;
      
      protected var pos:int = 0;
      
      protected var _pan:Number = 0;
      
      protected var snd:Sound;
      
      public var n:int;
      
      public function Snd(param1:uk.co.kempt.sounds.SoundManager, param2:Sound, param3:int = 0)
      {
         super();
         this.n = param3;
         this.manager = param1;
         this.manager.addEventListener(VolumeEvent.VOLUME_CHANGE,this.onManagerChangeVolume);
         this.manager.addEventListener(MuteEvent.MUTED,this.onManagerMuted);
         this.manager.addEventListener(uk.co.kempt.sounds.SoundManager.STOP,this.stop);
         this.manager.addEventListener(uk.co.kempt.sounds.SoundManager.PAUSE,this.pause);
         this.manager.addEventListener(uk.co.kempt.sounds.SoundManager.UNPAUSE,this.unpause);
         this.manager.addEventListener(uk.co.kempt.sounds.SoundManager.DIE,this.die);
         this.masterVol = this.manager.volume;
         this.masterMuted = this.manager.mute;
         this.snd = param2;
         this.trans = new SoundTransform();
         this.volume = 1;
      }
      
      public function die(param1:Event = null) : void
      {
         if(this.snd)
         {
            this.snd.removeEventListener(Event.COMPLETE,this.die);
            this.snd.removeEventListener(Event.COMPLETE,this.doLoop);
            this.snd = null;
         }
         if(this.manager)
         {
            this.manager.removeEventListener(VolumeEvent.VOLUME_CHANGE,this.onManagerChangeVolume);
            this.manager.removeEventListener(MuteEvent.MUTED,this.onManagerMuted);
            this.manager.removeEventListener(uk.co.kempt.sounds.SoundManager.STOP,this.stop);
            this.manager.removeEventListener(uk.co.kempt.sounds.SoundManager.PAUSE,this.pause);
            this.manager.removeEventListener(uk.co.kempt.sounds.SoundManager.UNPAUSE,this.unpause);
            this.manager = null;
         }
         if(this.channel)
         {
            this.channel.stop();
            this.channel = null;
         }
         if(this.timer)
         {
            this.timer.removeEventListener(TimerEvent.TIMER,this.changeVolTowards);
            this.timer.stop();
            this.timer = null;
         }
         this.trans = null;
      }
      
      public function stop(param1:Event = null) : void
      {
         if(this.channel)
         {
            this.channel.stop();
            this.pos = 0;
            this.channel = null;
         }
         this.die();
      }
      
      public function fadeTo(param1:Number, param2:Number, param3:Function = null) : void
      {
         var _loc4_:Number = NaN;
         this.onFadeComplete = param3;
         if(this.timer)
         {
            this.stopFade();
         }
         if(param2 > 0)
         {
            _loc4_ = (param1 - this._vol) / param2;
            this.setFade(_loc4_ * (FADE_RATE / 1000),param1,true);
         }
         else
         {
            this.changeVolume(param1);
         }
      }
      
      public function get volume() : Number
      {
         return this._vol;
      }
      
      public function get pan() : Number
      {
         return this._pan;
      }
      
      public function stopFade() : void
      {
         if(this.timer)
         {
            this.timer.stop();
            this.timer.removeEventListener(TimerEvent.TIMER,this.changeVolTowards);
            this.timer = null;
            if(this.onFadeComplete != null)
            {
               this.onFadeComplete();
               this.onFadeComplete = null;
            }
         }
      }
      
      public function play(param1:Number = 0, param2:int = 1, param3:SoundTransform = null) : void
      {
         if(param3)
         {
            this.trans = param3;
            this.volume = this.trans.volume;
         }
         this.channel = this.snd.play(param1,param2,this.trans);
         this.channel.addEventListener(Event.SOUND_COMPLETE,this.die);
      }
      
      public function set pan(param1:Number) : void
      {
         this._pan = param1;
         this.trans.pan = param1;
         if(this.channel)
         {
            this.channel.soundTransform = this.trans;
         }
      }
      
      protected function onManagerMuted(param1:MuteEvent) : void
      {
         this.masterMuted = param1.isMuted;
         this.volume = this._vol;
      }
      
      public function set volume(param1:Number) : void
      {
         this._vol = param1;
         if(this.masterMuted)
         {
            this.trans.volume = 0;
         }
         else
         {
            this.trans.volume = param1 * this.masterVol;
         }
         if(this.channel)
         {
            this.channel.soundTransform = this.trans;
         }
      }
      
      public function doLoop(param1:int = 0) : void
      {
         if(this.channel)
         {
            this.channel.removeEventListener(Event.SOUND_COMPLETE,this.doLoop);
            this.channel.removeEventListener(Event.SOUND_COMPLETE,this.die);
         }
         this.channel = this.snd.play(param1,99999999,this.trans);
         this.channel.addEventListener(Event.SOUND_COMPLETE,this.doLoop);
         this.isLooping = true;
      }
      
      protected function onManagerChangeVolume(param1:VolumeEvent) : void
      {
         this.masterVol = param1.newVol;
         this.volume = this._vol;
      }
      
      protected function changeVolTowards(param1:TimerEvent) : void
      {
         if(!this.trans)
         {
            this.stopFade();
            return;
         }
         var _loc2_:Number = this._vol;
         if(Math.abs(this._dVol) < Math.abs(this._tVol - _loc2_))
         {
            this.changeVolume(this._dVol);
         }
         else
         {
            this.volume = this._tVol;
            if(this._fading)
            {
               this.stopFade();
            }
         }
      }
      
      public function changeVolume(param1:Number) : void
      {
         this.volume = this._vol + param1;
      }
      
      override public function toString() : String
      {
         return "[sound=" + this.snd + ", n=" + this.n + ", vol=" + this.volume + "]";
      }
      
      public function fadeBy(param1:Number, param2:Number, param3:Function = null) : void
      {
         this.onFadeComplete = param3;
         if(this.timer)
         {
            this.stopFade();
         }
         if(param2 > 0)
         {
            this.setFade(param1 * (FADE_RATE / 1000),param1 * param2,true);
         }
      }
      
      public function pause(param1:Event = null) : void
      {
         if(this.channel)
         {
            this.pos = this.channel.position % this.snd.length;
            this.channel.removeEventListener(Event.SOUND_COMPLETE,this.die);
            this.channel.stop();
            this.channel = null;
         }
      }
      
      public function fade(param1:Number, param2:Number, param3:Function = null) : void
      {
         this.onFadeComplete = param3;
         if(this.timer)
         {
            this.stopFade();
         }
         this.setFade(param1 * (FADE_RATE / 1000),param2,true);
      }
      
      public function unpause(param1:Event = null) : void
      {
         if(!this.channel && Boolean(this.snd))
         {
            this.channel = this.snd.play(this.pos);
            if(this.channel)
            {
               this.channel.soundTransform = this.trans;
               if(this.isLooping)
               {
                  this.channel.addEventListener(Event.SOUND_COMPLETE,this.doLoop);
               }
            }
         }
      }
      
      protected function setFade(param1:Number, param2:Number, param3:Boolean) : void
      {
         this._dVol = param1;
         this._tVol = param2;
         this._fading = param3;
         this.timer = new Timer(FADE_RATE);
         this.timer.addEventListener(TimerEvent.TIMER,this.changeVolTowards);
         this.timer.start();
      }
   }
}
