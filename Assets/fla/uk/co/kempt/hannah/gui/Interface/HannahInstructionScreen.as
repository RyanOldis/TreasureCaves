package uk.co.kempt.hannah.gui.Interface
{
   import com.neopets.projects.gameEngine.gui.Interface.InstructionScreen;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class HannahInstructionScreen extends InstructionScreen
   {
       
      
      public var backBtn:SimpleButton;
      
      public function HannahInstructionScreen()
      {
         super();
         this.backBtn.addEventListener(MouseEvent.MOUSE_UP,MouseClicked,false,0,true);
      }
   }
}
