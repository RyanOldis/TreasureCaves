package uk.co.kempt.hannah.world
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.data.Boundaries;
   import uk.co.kempt.hannah.data.CollisionCollection;
   import uk.co.kempt.hannah.data.CollisionData;
   import uk.co.kempt.hannah.display.HannahAnimations;
   import uk.co.kempt.hannah.sounds.HannahSounds;
   import uk.co.kempt.hannah.utils.CollisionResolver;
   import uk.co.kempt.sounds.Snd;
   
   public class Player extends PhysicalObject
   {
      
      private static const GIVE:Number = 3.5;
      
      private static const OFFSET:Number = GIVE * 2 - 1;
      
      private static const ROCKET_SOUND_TIME:int = 20;
       
      
      private var _transparentTime:int;
      
      private var _onTopPrivate:Boolean;
      
      public var anim:HannahAnimations;
      
      private var _fallingTooFastWarning:Boolean;
      
      private var _fuel:Number;
      
      private var _fallingSound:Snd;
      
      private var _oxygen:Number;
      
      private var _rocketSoundTime:int;
      
      public var speedWarning:MovieClip;
      
      private var _rocketSound:Snd;
      
      private var _crouching:Boolean;
      
      private var _rotationSpeed:Number;
      
      private var _onTop:Boolean;
      
      private var _airTime:int;
      
      public function Player()
      {
         super();
         this._oxygen = 1 + Engine.OXYGEN_DECAY * Engine.GAME_FRAMERATE;
         this._fuel = 0.25;
         this._transparentTime = 0;
         this._onTopPrivate = true;
         this._onTop = true;
         this._rocketSound = Engine.instance.soundEngine.loopSound(HannahSounds.FLY,0);
         this._fallingSound = Engine.instance.soundEngine.loopSound(HannahSounds.FALLING,0);
         this.speedWarning.visible = false;
      }
      
      public function addFuel(param1:Number) : void
      {
         if(this.fuel < 1)
         {
            this.fuel = Math.min(1,this.fuel + param1);
         }
      }
      
      override public function die() : void
      {
         this._rocketSound.die();
         this._fallingSound.die();
         super.die();
      }
      
      override public function onCollision(param1:CollisionData) : void
      {
         super.onCollision(param1);
         if(param1.source is NonSolidBlock)
         {
            this._onTopPrivate = false;
            this._transparentTime = 10;
         }
      }
      
      public function canJump() : Boolean
      {
         if(this._crouching)
         {
            return false;
         }
         var _loc1_:Point = velocity.clone();
         velocity = new Point(0,1);
         var _loc2_:CollisionCollection = CollisionResolver.testObjects(this,Engine.SPACES.getPossibleCollidables(this));
         var _loc3_:CollisionData = _loc2_.getNearestSolid();
         velocity = _loc1_;
         return !!_loc3_ ? true : false;
      }
      
      public function get oxygen() : Number
      {
         return this._oxygen;
      }
      
      private function get standingBounds() : Boundaries
      {
         return new Boundaries(new Rectangle(x + GIVE,y - Engine.TILE_SIZE + OFFSET,Engine.TILE_SIZE - GIVE * 2,Engine.TILE_SIZE * 2 - GIVE * 2));
      }
      
      override public function get updateable() : Boolean
      {
         return true;
      }
      
      override public function get solid() : Boolean
      {
         return false;
      }
      
      public function dying() : void
      {
         if(this.anim.state != HannahAnimations.DEAD)
         {
            velocity.y = -6;
            this._rotationSpeed = -25;
            this.anim.state = HannahAnimations.DEAD;
            this._rocketSound.volume = 0;
            this._fallingSound.volume = 0;
            this._rocketSoundTime = 0;
            Engine.instance.soundEngine.playSound(HannahSounds.DEAD);
         }
         this.anim.anim.rotation += this._rotationSpeed;
         x -= this.anim.scaleX * 1.2;
         this._rotationSpeed *= 0.94;
         if(this.speedWarning.visible)
         {
            this.speedWarning.visible = false;
         }
      }
      
      public function jump() : void
      {
         velocity.y = -8;
         this.anim.state = HannahAnimations.JUMP;
         Engine.instance.soundEngine.playSound(HannahSounds.JUMP);
      }
      
      public function addOxygen(param1:Number) : void
      {
         if(this.oxygen < 1)
         {
            this.oxygen = Math.min(1,this.oxygen + param1);
         }
      }
      
      public function get fuel() : Number
      {
         return this._fuel;
      }
      
      private function get deathSpeed() : Number
      {
         return TERMINAL_VELOCITY_Y * 0.75;
      }
      
      private function get crouchingBounds() : Boundaries
      {
         return new Boundaries(new Rectangle(x + GIVE,y + OFFSET,Engine.TILE_SIZE - GIVE * 2,Engine.TILE_SIZE - GIVE * 2));
      }
      
      public function set oxygen(param1:Number) : void
      {
         this._oxygen = param1;
      }
      
      public function crouch(param1:Boolean) : void
      {
         var _loc2_:Point = null;
         var _loc3_:CollisionCollection = null;
         var _loc4_:CollisionData = null;
         if(param1 != this._crouching)
         {
            if(!param1)
            {
               _loc2_ = velocity.clone();
               velocity = new Point(0,this.standingBounds.top - bounds.top);
               _loc3_ = CollisionResolver.testObjects(this,Engine.SPACES.getPossibleCollidables(this));
               _loc4_ = _loc3_.getNearestSolid();
               velocity = _loc2_;
               if(_loc4_)
               {
                  return;
               }
               _loc3_.dispatchToTargets();
            }
            else if(!this.canJump())
            {
               return;
            }
            onPositionChanged();
            this._crouching = param1;
            if(this._crouching)
            {
               this.anim.state = HannahAnimations.CROUCH;
            }
            else
            {
               this.anim.state = HannahAnimations.CROUCH_OUT;
            }
         }
      }
      
      override protected function onCollideWithFloor(param1:CollisionData) : void
      {
         switch(this.anim.state)
         {
            case HannahAnimations.JUMP:
            case HannahAnimations.JET_IN:
            case HannahAnimations.JET_SIDEWAYS:
            case HannahAnimations.JET_UP:
            case HannahAnimations.JET_OFF:
            case HannahAnimations.FALL_TOO_FAST:
               this.anim.state = HannahAnimations.IDLE;
         }
         if(param1.trajectory.displacementY > this.deathSpeed)
         {
            Engine.instance.killPlayer();
         }
         if(param1.trajectory.displacementY > 2)
         {
            Engine.instance.soundEngine.playSound(HannahSounds.LAND);
         }
      }
      
      public function moveRight() : void
      {
         velocity.x = this.movementSpeed;
         this.anim.scaleX = 1;
         this.onMoveLeftRight();
      }
      
      override public function update() : void
      {
         super.update();
         this._fallingTooFastWarning = velocity.y > this.deathSpeed * 0.9;
         this.anim.update();
         if(collidingWithFloor)
         {
            this._airTime = 0;
            if(velocity.x == 0)
            {
               switch(this.anim.state)
               {
                  case HannahAnimations.RUN:
                     this.anim.state = HannahAnimations.IDLE;
                     break;
                  case HannahAnimations.CROUCH_RUN:
                     this.anim.state = HannahAnimations.CROUCH;
                     this.anim.fforward();
               }
            }
         }
         else
         {
            ++this._airTime;
            if(this._airTime > Engine.GAME_FRAMERATE / 6)
            {
               if(this.crouching)
               {
                  this.crouch(false);
               }
               switch(this.anim.state)
               {
                  case HannahAnimations.JUMP:
                  case HannahAnimations.JET_OFF:
                     if(this._fallingTooFastWarning)
                     {
                        this.anim.state = HannahAnimations.FALL_TOO_FAST;
                     }
                     break;
                  case HannahAnimations.FALL_TOO_FAST:
                     if(!this._fallingTooFastWarning)
                     {
                        this.anim.state = HannahAnimations.JET_OFF;
                     }
                     break;
                  case HannahAnimations.CROUCH:
                  case HannahAnimations.CROUCH_OUT:
                  case HannahAnimations.CROUCH_RUN:
                  case HannahAnimations.RUN:
                  case HannahAnimations.IDLE:
                     this.anim.state = HannahAnimations.JET_OFF;
               }
            }
         }
         if(this._transparentTime > 0 && Math.abs(velocity.x) >= 1)
         {
            --this._transparentTime;
            if(this._transparentTime <= 0)
            {
               this._onTopPrivate = true;
            }
         }
         this.onTop = this._onTopPrivate;
         this.speedWarning.visible = this._fallingTooFastWarning;
         var _loc1_:Number = this._rocketSoundTime / ROCKET_SOUND_TIME * Engine.instance.targetSFXVolume;
         this._rocketSound.volume += (_loc1_ - this._rocketSound.volume) / 4;
         if(this._rocketSound.volume < 1 / 20)
         {
            this._rocketSound.volume = 0;
         }
         if(this._rocketSoundTime > 0)
         {
            --this._rocketSoundTime;
         }
         var _loc2_:Number = Math.max(0,Math.min(1,(velocity.y - TERMINAL_VELOCITY_Y * 1 / 3) / (TERMINAL_VELOCITY_Y * 2 / 3))) * Engine.instance.targetSFXVolume;
         this._fallingSound.volume += (_loc2_ - this._fallingSound.volume) / 4;
         if(this._fallingSound.volume < 1 / 20)
         {
            this._fallingSound.volume = 0;
         }
      }
      
      override protected function createBounds() : Boundaries
      {
         return this._crouching ? this.crouchingBounds : this.standingBounds;
      }
      
      private function get movementSpeed() : Number
      {
         return Engine.instance.inputManager.keyIsDown(Keyboard.SHIFT) ? 7 : 6;
      }
      
      private function onMoveLeftRight() : void
      {
         switch(this.anim.state)
         {
            case HannahAnimations.IDLE:
               this.anim.state = HannahAnimations.RUN;
               break;
            case HannahAnimations.CROUCH:
               this.anim.state = HannahAnimations.CROUCH_RUN;
         }
      }
      
      public function get crouching() : Boolean
      {
         return this._crouching;
      }
      
      public function set fuel(param1:Number) : void
      {
         this._fuel = param1;
      }
      
      public function flyUp() : void
      {
         var _loc1_:Number = NaN;
         if(this._crouching)
         {
            return;
         }
         if(this.fuel > 0)
         {
            this.fuel -= Engine.FUEL_DECAY;
            velocity.y -= velocity.y > 0 ? Math.min(2,Math.max(0.4,(velocity.y - 0) / 12)) : 0.4;
            this._rocketSoundTime = ROCKET_SOUND_TIME;
            switch(this.anim.state)
            {
               case HannahAnimations.JET_IN:
                  break;
               case HannahAnimations.JET_SIDEWAYS:
               case HannahAnimations.JET_UP:
               case HannahAnimations.JET_OFF:
                  this.anim.state = velocity.x == 0 ? HannahAnimations.JET_UP : HannahAnimations.JET_SIDEWAYS;
                  break;
               default:
                  this.anim.state = HannahAnimations.JET_IN;
            }
            _loc1_ = Math.max(-4,Math.min(4,-velocity.x / 4));
            Engine.instance.particleEngine.spawnJetSmoke(new Point(x + this.anim.x,y + this.anim.y),_loc1_);
         }
         else
         {
            this.noFly();
         }
      }
      
      public function noFly() : void
      {
         switch(this.anim.state)
         {
            case HannahAnimations.JET_IN:
            case HannahAnimations.JET_SIDEWAYS:
            case HannahAnimations.JET_UP:
               this.anim.state = HannahAnimations.JET_OFF;
         }
      }
      
      public function set onTop(param1:Boolean) : void
      {
         if(this._onTop == param1)
         {
            return;
         }
         this._onTop = param1;
         Engine.instance.updatePlayerDepth();
      }
      
      public function get onTop() : Boolean
      {
         return this._onTop;
      }
      
      public function moveLeft() : void
      {
         velocity.x = -this.movementSpeed;
         this.anim.scaleX = -1;
         this.onMoveLeftRight();
      }
   }
}
