package uk.co.kempt.hannah
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import uk.co.kempt.hannah.display.PlayOnce;
   import uk.co.kempt.hannah.display.particles.CollectChestParticle;
   import uk.co.kempt.hannah.display.particles.CollectHeartParticle;
   import uk.co.kempt.hannah.display.particles.CollectParticle;
   import uk.co.kempt.hannah.display.particles.JetSmoke;
   import uk.co.kempt.hannah.display.particles.JetSmokeBright;
   
   public class ParticleEngine
   {
       
      
      private var _display:Sprite;
      
      public function ParticleEngine()
      {
         super();
      }
      
      public function spawnJetSmoke(param1:Point, param2:Number = 1) : void
      {
         var _loc3_:JetSmoke = new JetSmoke();
         var _loc4_:JetSmokeBright = new JetSmokeBright();
         _loc3_.setInitialVelocityX(param2);
         _loc4_.setInitialVelocityX(param2);
         _loc3_.x = _loc4_.x = param1.x;
         _loc3_.y = _loc4_.y = param1.y;
         this.display.addChild(_loc3_);
         this.display.addChild(_loc4_);
      }
      
      public function get display() : Sprite
      {
         return this._display = this._display || this.createDisplay();
      }
      
      public function spawnHeartPickup(param1:Point) : void
      {
         var _loc2_:PlayOnce = new CollectHeartParticle();
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         this.display.addChild(_loc2_);
      }
      
      public function spawnChestPickup(param1:Point) : void
      {
         var _loc2_:PlayOnce = null;
         _loc2_ = new CollectChestParticle();
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         this.display.addChild(_loc2_);
      }
      
      private function createDisplay() : Sprite
      {
         return new Sprite();
      }
      
      public function spawnPickup(param1:Point) : void
      {
         var _loc2_:PlayOnce = null;
         _loc2_ = new CollectParticle();
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         this.display.addChild(_loc2_);
      }
   }
}
