package com.neopets.projects.np9.vendorInterface
{
   import com.neopets.projects.gameEngine.gui.Interface.GameOverScreen;
   import com.neopets.projects.gameEngine.gui.Interface.GameScreen;
   import com.neopets.projects.gameEngine.gui.Interface.InstructionScreen;
   import com.neopets.projects.gameEngine.gui.Interface.OpeningScreen;
   import com.neopets.projects.gameEngine.gui.MenuManager;
   import com.neopets.projects.np9.system.NP9_Evar;
   import com.neopets.util.events.CustomEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import virtualworlds.lang.TranslationData;
   import virtualworlds.lang.TranslationManager;
   
   public class NP9_VendorGameExtension extends MovieClip
   {
       
      
      protected var mMenuManager:MenuManager;
      
      protected var mScore:NP9_Evar;
      
      protected var mDocumentClass:MovieClip;
      
      protected var mTranslationInfo:TranslationData;
      
      public function NP9_VendorGameExtension()
      {
         super();
         this.setVars();
      }
      
      protected function restartGame() : void
      {
      }
      
      protected function setupMenus() : void
      {
         var _loc1_:TranslationManager = TranslationManager.instance;
         var _loc2_:OpeningScreen = OpeningScreen(this.mMenuManager.createMenu("mcOpeningScreen",MenuManager.MENU_INTRO_SCR));
         var _loc3_:GameScreen = GameScreen(this.mMenuManager.createMenu("mcGameScreen",MenuManager.MENU_GAME_SCR));
         var _loc4_:GameOverScreen = GameOverScreen(this.mMenuManager.createMenu("mcGameOverScreen",MenuManager.MENU_GAMEOVER_SCR));
         var _loc5_:InstructionScreen = InstructionScreen(this.mMenuManager.createMenu("mcInstructionScreen",MenuManager.MENU_INSTRUCT_SCR));
         _loc1_.setTextField(_loc2_.instructionsButton.label_txt,this.mTranslationInfo.IDS_BTN_INSTRUCTION);
         _loc1_.setTextField(_loc2_.startGameButton.label_txt,this.mTranslationInfo.IDS_BTN_START);
         _loc1_.setTextField(_loc2_.txtFld_copyright,this.mTranslationInfo.IDS_COPYRIGHT_TXT);
         _loc1_.setTextField(_loc2_.txtFld_title,this.mTranslationInfo.IDS_TITLE_NAME);
         _loc1_.setTextField(_loc5_.returnBtn.label_txt,this.mTranslationInfo.IDS_BTN_BACK);
         _loc1_.setTextField(_loc5_.instructionTextField,this.mTranslationInfo.IDS_INSTRUCTION_TXT);
         _loc1_.setTextField(_loc3_.quitGameButton.label_txt,this.mTranslationInfo.IDS_BTN_QUIT);
         _loc1_.setTextField(_loc4_.playAgainBtn.label_txt,this.mTranslationInfo.IDS_BTN_PLAYAGAIN);
         _loc1_.setTextField(_loc4_.reportScoreBtn.label_txt,this.mTranslationInfo.IDS_BTN_SENDSCORE);
         this.extendMenus();
      }
      
      protected function quitGame() : void
      {
      }
      
      protected function onMenuNavigationEvent(param1:CustomEvent) : void
      {
         var _loc2_:GameOverScreen = null;
         switch(param1.oData.MENU)
         {
            case MenuManager.MENU_GAMEOVER_SCR:
               this.mDocumentClass.neopets_GS.sendTag(this.mDocumentClass.END_GAME_MSG);
               _loc2_ = this.mMenuManager.getMenuScreen(MenuManager.MENU_GAMEOVER_SCR) as GameOverScreen;
               _loc2_.toggleInterfaceButtons(true);
         }
      }
      
      protected function startGameSetup() : void
      {
      }
      
      protected function setupTranslationComplete(param1:Event) : void
      {
         trace("SETUPTRANSLATIONCOMPLETE");
         var _loc2_:TranslationManager = TranslationManager.instance;
         this.mDocumentClass.removeEventListener(this.mDocumentClass.TRANSLATION_COMPLETE,this.setupTranslationComplete);
         this.mTranslationInfo = TranslationData(_loc2_.translationData);
         this.mMenuManager.init(this.mDocumentClass,this.mTranslationInfo);
         this.setupMenus();
         addChild(this.mMenuManager.menusDisplayObj);
         this.startGameSetup();
      }
      
      protected function setVars() : void
      {
         this.mMenuManager = MenuManager.instance;
         this.mMenuManager.addEventListener(this.mMenuManager.MENU_EVENT,this.onMenuEvent,false,0,true);
         this.mMenuManager.addEventListener(this.mMenuManager.MENU_BUTTON_EVENT,this.onMenuButtonEvent,false,0,true);
         this.mMenuManager.addEventListener(this.mMenuManager.MENU_NAVIGATION_EVENT,this.onMenuNavigationEvent,false,0,true);
         this.mScore = new NP9_Evar(0);
      }
      
      protected function onMenuButtonEvent(param1:CustomEvent) : void
      {
         switch(param1.oData.EVENT)
         {
            case "startGameButton":
               this.startGame();
               break;
            case "quitGameButton":
               this.quitGame();
               break;
            case "playAgainBtn":
               this.restartGame();
               break;
            case "reportScoreBtn":
               this.reportScore();
               break;
            case "musicToggleBtn":
               this.toggleMusic();
               break;
            case "soundToggleBtn":
               this.toggleSound();
         }
         this.extraMenuButtons(param1.oData.EVENT);
      }
      
      protected function startGame() : void
      {
      }
      
      public function init(param1:MovieClip) : void
      {
         this.mDocumentClass = param1;
         this.mDocumentClass.addEventListener(this.mDocumentClass.TRANSLATION_COMPLETE,this.setupTranslationComplete);
         this.mDocumentClass.setupTranslation(this.mTranslationInfo);
      }
      
      protected function toggleMusic() : void
      {
      }
      
      protected function extraMenuButtons(param1:String) : void
      {
      }
      
      protected function extendMenus() : void
      {
      }
      
      protected function toggleSound() : void
      {
      }
      
      protected function onMenuEvent(param1:CustomEvent) : void
      {
         switch(param1.oData.EVENT)
         {
            case "restartGame":
               this.restartGame();
         }
      }
      
      protected function reportScore() : void
      {
         this.mDocumentClass.neopets_GS.sendScore(this.mScore.show());
      }
   }
}
