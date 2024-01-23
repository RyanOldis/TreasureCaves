package uk.co.kempt.hannah.display
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.Game;
   import uk.co.kempt.hannah.sounds.HannahSounds;
   import uk.co.kempt.hannah.world.WorldObject;
   
   public class HannahHUD extends Sprite
   {
       
      
      public var chests_txt:TextField;
      
      public var fuel:uk.co.kempt.hannah.display.AbstractBar;
      
      public var fuelWarning:MovieClip;
      
      public var life3:MovieClip;
      
      public var points_txt:TextField;
      
      private var _chestsCollected:int;
      
      public var oxygenWarning:MovieClip;
      
      public var oxygen:uk.co.kempt.hannah.display.AbstractBar;
      
      public var life2:MovieClip;
      
      private var _totalChests:int;
      
      public var lives_txt:TextField;
      
      public var exit_btn:SimpleButton;
      
      public var life1:MovieClip;
      
      public var pickups:MovieClip;
      
      public function HannahHUD()
      {
         super();
         this._totalChests = 0;
         this._chestsCollected = 0;
         this.fuelWarning.visible = false;
         this.oxygenWarning.visible = false;
         this.exit_btn.addEventListener(MouseEvent.CLICK,this.onExitClicked,false,0,true);
      }
      
      public function set totalChests(param1:int) : void
      {
         this._totalChests = param1;
         this.updateChestsTxt();
      }
      
      public function update() : void
      {
         this.fuel.value = Engine.instance.player.fuel;
         this.oxygen.value = Engine.instance.player.oxygen;
         this.fuel.update();
         this.oxygen.update();
         this.lives_txt.text = "x" + Engine.instance.lives.toString();
         var _loc1_:Boolean = this.fuelWarning.visible;
         var _loc2_:Boolean = this.oxygenWarning.visible;
         this.fuelWarning.visible = this.fuel.value <= 0.2;
         this.oxygenWarning.visible = this.oxygen.value <= 0.2;
         if(!_loc1_ && this.fuelWarning.visible)
         {
            Engine.instance.soundEngine.playSound(HannahSounds.FUEL_WARNING);
         }
         if(!_loc2_ && this.oxygenWarning.visible)
         {
            Engine.instance.soundEngine.playSound(HannahSounds.OXYGEN_WARNING);
         }
         this.clearPickups();
         this.populatePickups();
      }
      
      private function onExitClicked(param1:MouseEvent) : void
      {
         Engine.instance.exitToMenu();
      }
      
      private function updatePointsTxt() : void
      {
         var _loc1_:int = Game.instance.endScore + this.points;
         this.points_txt.text = _loc1_.toString();
      }
      
      public function get totalChests() : int
      {
         return this._totalChests;
      }
      
      public function set points(param1:int) : void
      {
         Game.instance.score = param1;
         this.updatePointsTxt();
      }
      
      public function reset() : void
      {
         this.clearPickups();
         this.points = 0;
         this.totalChests = 0;
         this.chestsCollected = 0;
      }
      
      public function get chestsCollected() : int
      {
         return this._chestsCollected;
      }
      
      public function set chestsCollected(param1:int) : void
      {
         this._chestsCollected = param1;
         this.updateChestsTxt();
      }
      
      private function updateChestsTxt() : void
      {
         this.chests_txt.text = this.chestsCollected.toString() + "/" + this.totalChests.toString();
      }
      
      public function get points() : int
      {
         return Game.instance.score;
      }
      
      private function populatePickups() : void
      {
         var _loc2_:WorldObject = null;
         var _loc1_:Vector.<WorldObject> = Engine.instance.player.collection;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_];
            _loc2_.y = 0;
            _loc2_.x = _loc3_ * Engine.TILE_SIZE;
            this.pickups.addChild(_loc2_);
            _loc3_++;
         }
      }
      
      private function clearPickups() : void
      {
         var _loc1_:int = this.pickups.numChildren;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.pickups.removeChildAt(0);
            _loc2_++;
         }
      }
   }
}
