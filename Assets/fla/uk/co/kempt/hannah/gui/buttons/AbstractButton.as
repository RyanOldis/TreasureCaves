package uk.co.kempt.hannah.gui.buttons
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class AbstractButton extends MovieClip
   {
       
      
      public function AbstractButton()
      {
         super();
         buttonMode = true;
         mouseChildren = false;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverEvent,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutEvent,false,0,true);
      }
      
      protected function onRollOutEvent(param1:MouseEvent) : void
      {
      }
      
      protected function onRollOverEvent(param1:MouseEvent) : void
      {
      }
   }
}
