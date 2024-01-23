package uk.co.kempt.hannah.display
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.sounds.HannahSounds;
   import virtualworlds.lang.TranslationManager;
   
   public class LevelCompletePage extends Sprite
   {
      
      private static const FILL_POINT:Point = new Point(42.7,222.7);
      
      private static const PAD_X:Number = 40;
      
      private static const PAD_Y:Number = 30;
       
      
      public var chests_txt:TextField;
      
      public var fuel_txt:TextField;
      
      public var title_txt:TextField;
      
      private var _gems:Vector.<uk.co.kempt.hannah.display.GemThing>;
      
      public var oxygen_txt:TextField;
      
      private var _waitCount:int;
      
      public var points_txt:TextField;
      
      private var _numOfChests:int;
      
      private var _currentIndex:int;
      
      public var chest_mc:MovieClip;
      
      public function LevelCompletePage()
      {
         super();
         addEventListener(Event.ENTER_FRAME,this.onEnterFrameEvent,false,0,true);
      }
      
      public function activate() : void
      {
         trace("activate level complete page");
         this.clearGems();
         var _loc1_:int = Engine.instance.hud.chestsCollected;
         TranslationManager.instance.setTextField(this.title_txt,TranslationManager.instance.translationData.LABEL_LEVEL_COMPLETE.split("[LVL]").join(Engine.currentLevelNum.toString()));
         this.points_txt.text = Engine.instance.hud.points.toString();
         this.chests_txt.text = _loc1_.toString();
         this._numOfChests = _loc1_;
         this._currentIndex = 0;
         this._waitCount = 20;
         this.oxygen_txt.text = Engine.instance.oxygenBonus.toString();
         this.fuel_txt.text = Engine.instance.fuelBonus.toString();
      }
      
      private function createGem(param1:int) : void
      {
         var _loc2_:uk.co.kempt.hannah.display.GemThing = new uk.co.kempt.hannah.display.GemThing();
         var _loc3_:Point = FILL_POINT.clone();
         _loc3_.x += param1 % 5 * PAD_X;
         _loc3_.y += Math.floor(param1 / 5) * PAD_Y;
         _loc2_.animate(new Point(this.chest_mc.x,this.chest_mc.y),_loc3_);
         this._gems.push(_loc2_);
         addChild(_loc2_);
         Engine.instance.soundEngine.playSound(HannahSounds.CHEST_PICKUP,0.8);
      }
      
      private function onEnterFrameEvent(param1:Event) : void
      {
         if(this._currentIndex < this._numOfChests)
         {
            if(this._waitCount <= 0)
            {
               this.createGem(this._currentIndex);
               ++this._currentIndex;
               this.chests_txt.text = int(this._numOfChests - this._currentIndex).toString();
               this._waitCount = 3;
            }
            else
            {
               --this._waitCount;
            }
         }
      }
      
      private function clearGems() : void
      {
         var _loc1_:int = 0;
         if(this._gems)
         {
            _loc1_ = 0;
            while(_loc1_ < this._gems.length)
            {
               if(this._gems[_loc1_].parent)
               {
                  this._gems[_loc1_].parent.removeChild(this._gems[_loc1_]);
               }
               _loc1_++;
            }
         }
         this._gems = new Vector.<uk.co.kempt.hannah.display.GemThing>();
      }
   }
}
