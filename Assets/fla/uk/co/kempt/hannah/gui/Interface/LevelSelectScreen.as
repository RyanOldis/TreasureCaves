package uk.co.kempt.hannah.gui.Interface
{
   import com.neopets.projects.gameEngine.gui.AbsMenu;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import uk.co.kempt.hannah.display.LevelChooser;
   
   public class LevelSelectScreen extends AbsMenu
   {
       
      
      public var backBtn:SimpleButton;
      
      public var txtFld_title:TextField;
      
      public function LevelSelectScreen()
      {
         super();
         mID = "LevelSelect";
         this.backBtn.addEventListener(MouseEvent.MOUSE_UP,MouseClicked,false,0,true);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(param1 == true)
         {
            this.onScreenDisplayed();
         }
      }
      
      private function onScreenDisplayed() : void
      {
         LevelChooser.instance.refresh();
      }
   }
}
