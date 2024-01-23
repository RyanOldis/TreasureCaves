package uk.co.kempt.hannah.gui.Interface
{
   import com.neopets.projects.gameEngine.gui.Interface.OpeningScreen;
   import com.neopets.util.events.CustomEvent;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.gui.buttons.HannahSelectedButton;
   
   public class HannahOpeningScreen extends OpeningScreen
   {
       
      
      public var startEditingButton2:SimpleButton;
      
      public var instructionsButton2:SimpleButton;
      
      public var startGameButton2:SimpleButton;
      
      public function HannahOpeningScreen()
      {
         super();
         this.startGameButton2.addEventListener(MouseEvent.MOUSE_UP,this.MouseClicked2,false,0,true);
         this.startEditingButton2.addEventListener(MouseEvent.MOUSE_UP,this.MouseClicked2,false,0,true);
         this.instructionsButton2.addEventListener(MouseEvent.MOUSE_UP,this.MouseClicked2,false,0,true);
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
         HannahSelectedButton(soundToggleBtn).state = Engine.instance.soundDisabled ? "selected" : "off";
         HannahSelectedButton(musicToggleBtn).state = Engine.instance.musicDisabled ? "selected" : "off";
      }
   }
}
