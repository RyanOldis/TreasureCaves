package com.neopets.projects.gameEngine.gui.buttons
{
   import com.neopets.util.button.NeopetsButton;
   import flash.events.MouseEvent;
   
   public class SelectedButton extends NeopetsButton
   {
       
      
      protected var mState:String;
      
      public function SelectedButton()
      {
         super();
         addEventListener(MouseEvent.MOUSE_UP,this.onUp,false,0,true);
         this.mState = "";
      }
      
      override protected function onRollOver(param1:MouseEvent) : void
      {
         if(!mLockout)
         {
            if(this.mState != "selected")
            {
               gotoAndStop("on");
            }
            else
            {
               gotoAndStop("selected");
            }
         }
      }
      
      public function get state() : String
      {
         return this.mState;
      }
      
      override protected function onRollOut(param1:MouseEvent) : void
      {
         if(!mLockout)
         {
            if(this.mState != "selected")
            {
               gotoAndStop("off");
            }
            else
            {
               gotoAndStop("selected");
            }
         }
      }
      
      override protected function onDown(param1:MouseEvent) : void
      {
         if(!mLockout)
         {
            if(this.mState != "selected")
            {
               this.mState = "selected";
               gotoAndStop("selected");
            }
            else
            {
               this.mState = "notSelected";
               gotoAndStop("down");
            }
         }
      }
      
      protected function onUp(param1:MouseEvent) : void
      {
         if(!mLockout)
         {
            if(this.mState != "selected")
            {
               gotoAndStop("off");
            }
            else
            {
               gotoAndStop("selected");
            }
         }
      }
   }
}
