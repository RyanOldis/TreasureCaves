package com.neopets.projects.np9.vendorInterface
{
   import com.neopets.util.button.NeopetsButton;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class NP9_SimpleScoreMeter extends MovieClip
   {
       
      
      public var mMessageTextField:TextField;
      
      public const RESTARTBTN_CLICKED:String = "TheRestartGameBtnClicked";
      
      public var mReturnButton:NeopetsButton;
      
      public function NP9_SimpleScoreMeter()
      {
         super();
         this.mReturnButton.addEventListener(MouseEvent.MOUSE_UP,this.dispatchRestart);
      }
      
      public function showMsg(param1:Number, param2:Number) : void
      {
         this.mReturnButton.label_txt.htmlText = "Restart Game";
         this.mMessageTextField.text = "Dummy Score Result: " + param2 + " USERID:" + param1;
      }
      
      private function dispatchRestart(param1:Event) : void
      {
         this.dispatchEvent(new Event(this.RESTARTBTN_CLICKED));
      }
   }
}
