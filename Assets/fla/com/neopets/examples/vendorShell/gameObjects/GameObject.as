package com.neopets.examples.vendorShell.gameObjects
{
   import com.neopets.util.events.CustomEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class GameObject extends MovieClip implements IGameObject
   {
       
      
      protected var mID:String;
      
      protected var mBaseScale:Number;
      
      protected var mLockTransition:Boolean;
      
      protected var mScoreValue:int;
      
      public const SEND_SCORE:String = "GameObjectSendingScore";
      
      protected var mStartingBox:Rectangle;
      
      public function GameObject()
      {
         super();
      }
      
      public function doEffect() : void
      {
      }
      
      protected function onClick(param1:Event) : void
      {
         if(!this.mLockTransition)
         {
            this.dispatchEvent(new CustomEvent({
               "ID":this.mID,
               "SCORE":this.mScoreValue
            },this.SEND_SCORE));
            this.doEffect();
         }
      }
      
      public function setStartLocation() : void
      {
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         _loc1_ = Math.round(Math.random() * this.mStartingBox.height);
         _loc2_ = Math.round(Math.random() * this.mStartingBox.width);
         x = _loc1_ + this.mStartingBox.x;
         y = _loc2_ + this.mStartingBox.y;
      }
      
      public function init(param1:String, param2:Rectangle, param3:Number = 1) : void
      {
         this.mLockTransition = false;
         this.mScoreValue = Math.random() * 100;
         this.mID = param1;
         this.mStartingBox = param2;
         this.mBaseScale = param3;
         scaleX = this.mBaseScale;
         scaleY = this.mBaseScale;
         this.setStartLocation();
         addEventListener(MouseEvent.MOUSE_DOWN,this.onClick,false,0,true);
         this.doLocalSetup();
      }
      
      public function doCleanUp() : void
      {
      }
      
      protected function doLocalSetup() : void
      {
      }
   }
}
