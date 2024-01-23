package com.neopets.projects.gameEngine.gui.Interface
{
   import com.neopets.projects.gameEngine.gui.AbsMenu;
   import com.neopets.util.button.NeopetsButton;
   import flash.events.MouseEvent;
   
   public dynamic class GameOverScreen extends AbsMenu
   {
       
      
      public var playAgainBtn:NeopetsButton;
      
      public var reportScoreBtn:NeopetsButton;
      
      public function GameOverScreen()
      {
         super();
         this.setupVars();
      }
      
      private function setupVars() : void
      {
         this.playAgainBtn.addEventListener(MouseEvent.MOUSE_UP,MouseClicked,false,0,true);
         this.reportScoreBtn.addEventListener(MouseEvent.MOUSE_UP,MouseClicked,false,0,true);
         mID = "GameOverScreen";
      }
      
      public function toggleInterfaceButtons(param1:Boolean) : void
      {
         this.playAgainBtn.visible = param1;
         this.reportScoreBtn.visible = param1;
      }
   }
}
