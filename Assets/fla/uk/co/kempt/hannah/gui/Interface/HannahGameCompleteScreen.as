package uk.co.kempt.hannah.gui.Interface
{
   import com.neopets.projects.gameEngine.gui.AbsMenu;
   import com.neopets.util.events.CustomEvent;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.Game;
   
   public class HannahGameCompleteScreen extends AbsMenu
   {
       
      
      public var playAgainBtn2:SimpleButton;
      
      public var score_txt:TextField;
      
      public var reportScoreBtn2:SimpleButton;
      
      public function HannahGameCompleteScreen()
      {
         super();
         this.playAgainBtn2.addEventListener(MouseEvent.MOUSE_UP,this.MouseClicked2,false,0,true);
      }
      
      protected function MouseClicked2(param1:Event) : void
      {
         this.dispatchEvent(new CustomEvent({"TARGETID":String(param1.currentTarget.name).substr(0,param1.currentTarget.name.length - 1)},BUTTON_PRESSED));
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(param1 == true)
         {
            this.onScreenDisplayed();
         }
      }
      
      protected function onScreenDisplayed() : void
      {
         if(Engine.currentLevelNum > 0)
         {
            trace("A. Engine.currentLevelNum = " + Engine.currentLevelNum);
            this.reportScoreBtn2.addEventListener(MouseEvent.MOUSE_UP,this.MouseClicked2,false,0,true);
         }
         else
         {
            trace("B. Engine.currentLevelNum = " + Engine.currentLevelNum);
            this.reportScoreBtn2.visible = false;
         }
         this.score_txt.text = Game.instance.endScore.toString();
      }
   }
}
