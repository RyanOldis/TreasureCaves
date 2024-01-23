package com.neopets.projects.gameEngine.gui
{
   import com.neopets.util.events.CustomEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class AbsMenu extends MovieClip
   {
       
      
      public var mID:String;
      
      public const BUTTON_PRESSED:String = "MenuButtonPressed";
      
      public function AbsMenu()
      {
         super();
      }
      
      protected function MouseClicked(param1:Event) : void
      {
         this.dispatchEvent(new CustomEvent({"TARGETID":param1.currentTarget.name},this.BUTTON_PRESSED));
      }
   }
}
