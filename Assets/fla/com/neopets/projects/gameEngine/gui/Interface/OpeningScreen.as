package com.neopets.projects.gameEngine.gui.Interface
{
   import com.neopets.projects.gameEngine.gui.AbsMenu;
   import com.neopets.projects.gameEngine.gui.buttons.SelectedButton;
   import com.neopets.util.button.NeopetsButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class OpeningScreen extends AbsMenu
   {
       
      
      public var musicToggleBtn:SelectedButton;
      
      public var startGameButton:NeopetsButton;
      
      public var txtFld_title:TextField;
      
      public var txtFld_copyright:TextField;
      
      public var instructionsButton:NeopetsButton;
      
      public var soundToggleBtn:SelectedButton;
      
      public var mcTransLogo:MovieClip;
      
      public function OpeningScreen()
      {
         super();
         this.setupVars();
      }
      
      private function setupVars() : void
      {
         this.soundToggleBtn.addEventListener(MouseEvent.MOUSE_UP,MouseClicked,false,0,true);
         this.musicToggleBtn.addEventListener(MouseEvent.MOUSE_UP,MouseClicked,false,0,true);
         this.startGameButton.addEventListener(MouseEvent.MOUSE_UP,MouseClicked,false,0,true);
         this.instructionsButton.addEventListener(MouseEvent.MOUSE_UP,MouseClicked,false,0,true);
         mID = "IntroScene";
      }
   }
}
