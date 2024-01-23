package uk.co.kempt.hannah.gui.Interface
{
   import com.neopets.projects.gameEngine.gui.Interface.GameOverScreen;
   import com.neopets.util.events.CustomEvent;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.display.GameOverPage;
   
   public class HannahGameOverScreen extends GameOverScreen
   {
       
      
      public var playAgainBtn2:SimpleButton;
      
      public var reportScoreBtn2:SimpleButton;
      
      public var gameOverPage:GameOverPage;
      
      public function HannahGameOverScreen()
      {
         super();
         this.playAgainBtn2.visible = true;
         this.reportScoreBtn2.visible = true;
         this.playAgainBtn2.addEventListener(MouseEvent.MOUSE_UP,this.MouseClicked2,false,0,true);
         this.reportScoreBtn2.addEventListener(MouseEvent.MOUSE_UP,this.MouseClicked2,false,0,true);
      }
      
      protected function MouseClicked2(param1:Event) : void
      {
         this.playAgainBtn2.visible = false;
         this.reportScoreBtn2.visible = false;
         this.dispatchEvent(new CustomEvent({"TARGETID":String(param1.currentTarget.name).substr(0,param1.currentTarget.name.length - 1)},BUTTON_PRESSED));
      }
      
      protected function onScreenDisplayed() : void
      {
         this.playAgainBtn2.visible = true;
         trace("GAME OVER SCREEN: ONSCREENDISPLAYED()");
         if(Engine.currentLevelNum > 0)
         {
            trace("GAME OVER SCREEN: NORMAL LEVEL");
            this.reportScoreBtn2.visible = true;
         }
         else
         {
            trace("GAME OVER SCREEN: CUSTOM LEVEL");
            this.reportScoreBtn2.visible = false;
         }
         this.gameOverPage.activate();
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(param1 == true)
         {
            this.onScreenDisplayed();
         }
      }
   }
}
