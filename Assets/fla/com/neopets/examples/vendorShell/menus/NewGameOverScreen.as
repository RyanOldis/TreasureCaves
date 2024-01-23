package com.neopets.examples.vendorShell.menus
{
   import com.neopets.projects.gameEngine.gui.AbsMenu;
   import com.neopets.util.button.NeopetsButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public dynamic class NewGameOverScreen extends AbsMenu
   {
       
      
      public var playAgainBtn:NeopetsButton;
      
      public var reportScoreBtn:NeopetsButton;
      
      public var txtField_finalTime:TextField;
      
      public function NewGameOverScreen()
      {
         super();
         this.setupExtendedVars();
      }
      
      public function setFinalTime(param1:Number) : void
      {
         this.txtField_finalTime.text = String(param1);
      }
      
      private function setupExtendedVars() : void
      {
         this.reportScoreBtn.addEventListener(MouseEvent.MOUSE_UP,MouseClicked,false,0,true);
         this.playAgainBtn.addEventListener(MouseEvent.MOUSE_UP,MouseClicked,false,0,true);
         mID = "NewGameOverScreen";
      }
      
      public function toggleInterfaceButtons(param1:Boolean) : void
      {
         this.playAgainBtn.visible = param1;
         this.reportScoreBtn.visible = param1;
      }
   }
}
