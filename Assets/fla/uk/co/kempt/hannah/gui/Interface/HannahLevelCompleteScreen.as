package uk.co.kempt.hannah.gui.Interface
{
   import com.neopets.projects.gameEngine.gui.AbsMenu;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import uk.co.kempt.hannah.display.LevelCompletePage;
   
   public class HannahLevelCompleteScreen extends AbsMenu
   {
       
      
      public var completePage:LevelCompletePage;
      
      public var nextLevelBtn:SimpleButton;
      
      public function HannahLevelCompleteScreen()
      {
         super();
         this.nextLevelBtn.addEventListener(MouseEvent.MOUSE_UP,MouseClicked,false,0,true);
      }
      
      public function activate() : void
      {
         this.completePage.activate();
      }
   }
}
