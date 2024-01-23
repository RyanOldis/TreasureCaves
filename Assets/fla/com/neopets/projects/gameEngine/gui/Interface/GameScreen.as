package com.neopets.projects.gameEngine.gui.Interface
{
   import com.neopets.projects.gameEngine.gui.AbsMenu;
   import com.neopets.util.button.NeopetsButton;
   import flash.events.MouseEvent;
   
   public class GameScreen extends AbsMenu
   {
       
      
      public var quitGameButton:NeopetsButton;
      
      public function GameScreen()
      {
         super();
         this.setupVars();
      }
      
      private function setupVars() : void
      {
         this.quitGameButton.addEventListener(MouseEvent.MOUSE_UP,MouseClicked,false,0,true);
         mID = "GameScene";
      }
   }
}
