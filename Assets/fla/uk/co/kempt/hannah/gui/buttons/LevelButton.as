package uk.co.kempt.hannah.gui.buttons
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import virtualworlds.lang.TranslationManager;
   
   public class LevelButton extends AbstractButton
   {
       
      
      public var label_txt:TextField;
      
      private var _label:String;
      
      private var _disabled:Boolean;
      
      public function LevelButton()
      {
         super();
         stop();
         gotoAndStop(2);
      }
      
      public function set label(param1:String) : void
      {
         this._label = param1;
         TranslationManager.instance.setTextField(this.label_txt,param1);
      }
      
      public function disable() : void
      {
         this._disabled = true;
         gotoAndStop(1);
         this.label = this.label;
         mouseChildren = mouseEnabled = false;
      }
      
      override protected function onRollOverEvent(param1:MouseEvent) : void
      {
         if(this._disabled)
         {
            return;
         }
         super.onRollOverEvent(param1);
         gotoAndStop(3);
         this.label = this.label;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      override protected function onRollOutEvent(param1:MouseEvent) : void
      {
         if(this._disabled)
         {
            return;
         }
         super.onRollOutEvent(param1);
         gotoAndStop(2);
         this.label = this.label;
      }
      
      public function get disabled() : Boolean
      {
         return this._disabled;
      }
   }
}
