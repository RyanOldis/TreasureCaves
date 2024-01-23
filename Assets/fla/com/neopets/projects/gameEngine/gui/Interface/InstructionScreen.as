package com.neopets.projects.gameEngine.gui.Interface
{
   import com.neopets.projects.gameEngine.gui.AbsMenu;
   import com.neopets.util.button.NeopetsButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class InstructionScreen extends AbsMenu
   {
       
      
      public var returnBtn:NeopetsButton;
      
      public var instructionTextField:TextField;
      
      public function InstructionScreen()
      {
         super();
         this.setupVars();
      }
      
      private function setupVars() : void
      {
         this.returnBtn.addEventListener(MouseEvent.MOUSE_UP,MouseClicked,false,0,true);
         mID = "GameScene";
      }
   }
}
