package uk.co.kempt.hannah.gui.buttons
{
   import com.neopets.projects.gameEngine.gui.buttons.SelectedButton;
   
   public class HannahSelectedButton extends SelectedButton
   {
       
      
      public function HannahSelectedButton()
      {
         super();
      }
      
      public function set state(param1:String) : void
      {
         mState = param1;
         gotoAndStop(param1);
      }
   }
}
