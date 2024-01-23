package com.neopets.examples.vendorShell.gameObjects
{
   import caurina.transitions.Tweener;
   import caurina.transitions.properties.FilterShortcuts;
   import flash.events.TimerEvent;
   import flash.filters.BlurFilter;
   import flash.utils.Timer;
   
   public class SquareObject extends GameObject
   {
       
      
      protected var mMoveTimer:Timer;
      
      protected var mMovementTime:Number;
      
      protected var mResetTime:int;
      
      protected var mEffectFilter:BlurFilter;
      
      protected var mTimer:Timer;
      
      protected var mDefaultEffectTime:int;
      
      public function SquareObject()
      {
         super();
         this.setupVars();
      }
      
      private function setupVars() : void
      {
         this.mDefaultEffectTime = 2;
         this.mResetTime = 500;
         this.mTimer = new Timer(this.mResetTime);
         this.mTimer.addEventListener(TimerEvent.TIMER,this.onResetObject,false,0,true);
         this.mMovementTime = Math.round(Math.random() * 3000) + 2000;
         this.mMoveTimer = new Timer(this.mMovementTime);
         this.mMoveTimer.addEventListener(TimerEvent.TIMER,this.onNewMovement,false,0,true);
         FilterShortcuts.init();
      }
      
      private function onResetObject(param1:TimerEvent) : void
      {
         this.filters = [];
         mLockTransition = false;
      }
      
      override protected function doLocalSetup() : void
      {
         mScoreValue += 100;
         this.onNewMovement();
      }
      
      private function onNewMovement(param1:TimerEvent = null) : void
      {
         var _loc2_:Number = Math.round(Math.random() * mStartingBox.height);
         var _loc3_:Number = Math.round(Math.random() * mStartingBox.width);
         var _loc4_:Number = this.mMovementTime / 1000;
         Tweener.addTween(this,{
            "x":_loc2_,
            "y":_loc3_,
            "time":_loc4_,
            "onComplete":this.MoveResetObject
         });
      }
      
      private function startResetObject() : void
      {
         this.mTimer.reset();
         this.mTimer.start();
      }
      
      override public function doEffect() : void
      {
         if(!mLockTransition)
         {
            mLockTransition = true;
            Tweener.addTween(this,{
               "_Blur_blurY":8,
               "_Blur_blurX":8,
               "time":this.mDefaultEffectTime,
               "onComplete":this.startResetObject
            });
         }
      }
      
      private function MoveResetObject() : void
      {
         this.mMoveTimer.reset();
         this.mMoveTimer.start();
         var _loc1_:Number = Math.random() * 1;
         var _loc2_:Boolean = _loc1_ > 0.5 ? true : false;
         if(_loc2_)
         {
            gotoAndPlay(1);
         }
         else
         {
            gotoAndStop(1);
         }
      }
   }
}
