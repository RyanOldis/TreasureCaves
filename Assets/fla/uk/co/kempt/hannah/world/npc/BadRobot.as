package uk.co.kempt.hannah.world.npc
{
   import flash.events.Event;
   import flash.geom.Rectangle;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.data.Boundaries;
   import uk.co.kempt.hannah.data.CollisionCollection;
   import uk.co.kempt.hannah.data.CollisionData;
   import uk.co.kempt.hannah.display.BadRobotAnimations;
   import uk.co.kempt.hannah.sounds.HannahSounds;
   import uk.co.kempt.hannah.utils.CollisionResolver;
   import uk.co.kempt.hannah.world.Player;
   import uk.co.kempt.hannah.world.WorldObject;
   import uk.co.kempt.sounds.Snd;
   
   public class BadRobot extends WorldObject
   {
      
      private static const GIVE:Number = 1.5;
       
      
      private var _started:Boolean = false;
      
      private var _stomping:Boolean;
      
      private var _backwards:Boolean;
      
      public var anim:BadRobotAnimations;
      
      public function BadRobot()
      {
         super();
         this.anim.gotoAndStop("idle");
      }
      
      private function get standingBounds() : Boundaries
      {
         return new Boundaries(new Rectangle(x,y - 52 - GIVE,32,84));
      }
      
      override public function get updateable() : Boolean
      {
         return true;
      }
      
      public function set backwards(param1:Boolean) : void
      {
         this._backwards = param1;
         this.anim.scaleX = this.backwards ? -1 : 1;
      }
      
      private function onStomp(param1:Event) : void
      {
         this._stomping = true;
      }
      
      override public function get solid() : Boolean
      {
         return false;
      }
      
      override protected function onCollideWithFloor(param1:CollisionData) : void
      {
         super.onCollideWithFloor(param1);
         if(!this._started)
         {
            this._started = true;
            this.anim.gotoAndStop("walk");
            this.anim.anim.addEventListener("stomp",this.onStomp);
         }
      }
      
      override public function onCollision(param1:CollisionData) : void
      {
         if(param1.source is Player)
         {
            Engine.instance.killPlayer();
         }
      }
      
      override public function update() : void
      {
         var _loc1_:CollisionCollection = null;
         var _loc2_:CollisionData = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this._started)
         {
            _loc1_ = CollisionResolver.testReachedLedge(this,Engine.SPACES.getPossibleCollidables(this));
            _loc2_ = !!_loc1_ ? _loc1_.getNearestSolid() : null;
            if(!_loc2_)
            {
               this.backwards = !this.backwards;
            }
            _loc3_ = 1.5;
            if(this._backwards)
            {
               _loc3_ *= -1;
            }
            velocity.x = _loc3_;
            _loc4_ = x + velocity.x;
            super.update();
            if(x != _loc4_)
            {
               this.backwards = !this.backwards;
            }
            if(this._stomping)
            {
               this._stomping = false;
               this.playStompSound();
            }
         }
         else
         {
            velocity.y += GRAVITY;
            if(velocity.y > TERMINAL_VELOCITY_Y)
            {
               velocity.y = TERMINAL_VELOCITY_Y;
            }
            super.update();
         }
      }
      
      public function get backwards() : Boolean
      {
         return this._backwards;
      }
      
      private function playStompSound() : void
      {
         var _loc1_:Number = Engine.instance.getWorldObjectScreenRatio(this);
         var _loc2_:Number = Engine.instance.getWorldObjectPlayerRatio(this);
         var _loc3_:Snd = Engine.instance.soundEngine.playSound(HannahSounds.ROBOT_STEP,_loc2_);
         _loc3_.pan = _loc1_;
      }
      
      override public function stopAnimating() : void
      {
         super.stopAnimating();
         this.anim.anim.stop();
      }
      
      override protected function createBounds() : Boundaries
      {
         return this.standingBounds;
      }
   }
}
