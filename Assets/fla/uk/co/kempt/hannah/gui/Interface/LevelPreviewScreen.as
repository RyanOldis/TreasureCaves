package uk.co.kempt.hannah.gui.Interface
{
   import com.neopets.projects.gameEngine.gui.AbsMenu;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.data.LevelData;
   import uk.co.kempt.hannah.display.LevelPreview;
   import virtualworlds.lang.TranslationManager;
   
   public class LevelPreviewScreen extends AbsMenu
   {
       
      
      private var _preview:LevelPreview;
      
      public var startLevelButton:SimpleButton;
      
      public var backToLevelSelectButton:SimpleButton;
      
      public var title_txt:TextField;
      
      public var description_txt:TextField;
      
      public function LevelPreviewScreen()
      {
         super();
         mID = "LevelPreview";
         this.startLevelButton.addEventListener(MouseEvent.MOUSE_UP,MouseClicked,false,0,true);
         this.backToLevelSelectButton.addEventListener(MouseEvent.MOUSE_UP,MouseClicked,false,0,true);
      }
      
      public function createPreview(param1:int = 1, param2:String = "") : void
      {
         if(this._preview)
         {
            this._preview.die();
            this._preview = null;
         }
         this._preview = new LevelPreview(Engine.currentLevelData);
         addChild(this._preview);
         this._preview.x = (Engine.GAME_WIDTH - this._preview.width) / 2;
         this._preview.y = 126 + (300 - this._preview.height) / 2;
         if(param1 < 9999)
         {
            TranslationManager.instance.setTextField(this.description_txt,LevelData.getName(param1));
         }
         else
         {
            TranslationManager.instance.setTextField(this.description_txt,param2);
         }
         if(param2 != "")
         {
            TranslationManager.instance.setTextField(this.title_txt,TranslationManager.instance.translationData.TITLE_CUSTOM_LEVEL);
            trace("setting text: TITLE_CUSTOM_LEVEL");
         }
         else
         {
            TranslationManager.instance.setTextField(this.title_txt,TranslationManager.instance.translationData.TITLE_LEVEL_NUMBER.split("[LVL]").join(Engine.currentLevelNum.toString()));
         }
      }
   }
}
