package uk.co.kempt.hannah
{
   import com.neopets.projects.gameEngine.gui.MenuManager;
   import com.neopets.projects.np9.system.NP9_Evar;
   import com.neopets.projects.np9.vendorInterface.NP9_VendorGameExtension;
   import com.neopets.util.events.CustomEvent;
   import com.neopets.util.flashvars.*;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.text.TextField;
   import uk.co.kempt.hannah.data.LevelData;
   import uk.co.kempt.hannah.gui.Interface.HannahGameCompleteScreen;
   import uk.co.kempt.hannah.gui.Interface.HannahLevelCompleteScreen;
   import uk.co.kempt.hannah.gui.Interface.LevelPreviewScreen;
   import uk.co.kempt.hannah.gui.Interface.LevelSelectScreen;
   import uk.co.kempt.hannah.translation.TranslationInfo;
   import virtualworlds.lang.TranslationData;
   import virtualworlds.lang.TranslationManager;
   
   public class Game extends NP9_VendorGameExtension
   {
      
      public static const MENU_GAME_COMPLETE:String = "mGameCompleteScreen";
      
      public static const MENU_LEVEL_PREVIEW:String = "mLevelPreviewScreen";
      
      public static const MENU_LEVEL_COMPLETE:String = "mLevelCompleteScreen";
      
      private static var INSTANCE:uk.co.kempt.hannah.Game;
      
      public static const MENU_LEVEL_SELECT:String = "mLevelSelectScreen";
       
      
      private var _levelScore:NP9_Evar;
      
      public function Game()
      {
         super();
         addEventListener(Event.ADDED,this.onChildAdded);
         INSTANCE = this;
         this.setGameVars();
      }
      
      public static function get instance() : uk.co.kempt.hannah.Game
      {
         return INSTANCE;
      }
      
      protected function setGameVars() : void
      {
         trace("setGameVars");
         mTranslationInfo = new TranslationInfo();
      }
      
      private function startLevel() : void
      {
         mMenuManager.menuNavigation(MenuManager.MENU_GAME_SCR);
         this._levelScore = new NP9_Evar(0);
         Engine.instance.start();
      }
      
      private function onChildAdded(param1:Event) : void
      {
         this.checkObj(DisplayObject(param1.target));
      }
      
      private function scanContainer(param1:DisplayObjectContainer) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:int = param1.numChildren - 1;
         while(_loc3_ > -1)
         {
            this.checkObj(param1.getChildAt(_loc3_));
            _loc3_--;
         }
      }
      
      override protected function setupMenus() : void
      {
         super.setupMenus();
         var _loc1_:TranslationManager = TranslationManager.instance;
         var _loc2_:LevelPreviewScreen = LevelPreviewScreen(mMenuManager.createMenu("mcLevelPreviewScreen",MENU_LEVEL_PREVIEW));
         var _loc3_:LevelSelectScreen = LevelSelectScreen(mMenuManager.createMenu("mcLevelSelectScreen",MENU_LEVEL_SELECT));
         var _loc4_:HannahLevelCompleteScreen = HannahLevelCompleteScreen(mMenuManager.createMenu("mcLevelCompleteScreen",MENU_LEVEL_COMPLETE));
         var _loc5_:HannahGameCompleteScreen = HannahGameCompleteScreen(mMenuManager.createMenu("mcGameCompleteScreen",MENU_GAME_COMPLETE));
      }
      
      public function doFailExit() : void
      {
         mMenuManager.menuNavigation(MENU_LEVEL_PREVIEW);
      }
      
      public function selectLevelByNumber(param1:int) : void
      {
         if(param1 <= LevelData.TOTAL_NUMBER_OF_LEVELS && Engine.currentLevelNum > 0)
         {
            Engine.setCurrentLevel(param1);
            LevelPreviewScreen(mMenuManager.getMenuScreen(MENU_LEVEL_PREVIEW)).createPreview(param1);
            mMenuManager.menuNavigation(MENU_LEVEL_PREVIEW);
         }
         else
         {
            trace("no more levels");
            mMenuManager.menuNavigation(MenuManager.MENU_GAME_SCR);
         }
      }
      
      public function doExit() : void
      {
         mScore.changeBy(this.score);
         if(Engine.currentLevelNum < LevelData.TOTAL_NUMBER_OF_LEVELS && Engine.currentLevelNum > 0)
         {
            mMenuManager.menuNavigation(MENU_LEVEL_COMPLETE);
            HannahLevelCompleteScreen(mMenuManager.getMenuScreen(MENU_LEVEL_COMPLETE)).activate();
         }
         else
         {
            Engine.clearExcludedObjects();
            mMenuManager.menuNavigation(MENU_GAME_COMPLETE);
         }
      }
      
      public function get menuManager() : MenuManager
      {
         return mMenuManager;
      }
      
      private function checkObj(param1:DisplayObject) : void
      {
         var _loc2_:SimpleButton = null;
         if(param1 is TextField)
         {
            this.translateTxt(TextField(param1));
         }
         else if(param1 is DisplayObjectContainer)
         {
            this.scanContainer(DisplayObjectContainer(param1));
         }
         else if(param1 is SimpleButton)
         {
            _loc2_ = SimpleButton(param1);
            this.checkObj(_loc2_.downState);
            this.checkObj(_loc2_.upState);
            this.checkObj(_loc2_.overState);
            this.checkObj(_loc2_.hitTestState);
         }
      }
      
      override public function init(param1:MovieClip) : void
      {
         super.init(param1);
         this.setGameVars();
      }
      
      private function translateTxt(param1:TextField) : void
      {
         if(TranslationManager.instance.translationData.hasOwnProperty(param1.name))
         {
            TranslationManager.instance.setTextField(param1,TranslationManager.instance.translationData[param1.name]);
         }
      }
      
      public function get score() : int
      {
         return int(this._levelScore.show());
      }
      
      public function doToggleSound() : void
      {
         this.toggleSound();
      }
      
      protected function updateScore(param1:CustomEvent) : void
      {
         mScore.changeBy(param1.oData.SCORE);
      }
      
      override protected function toggleSound() : void
      {
         trace("Toggle Sound Btn Pressed");
         Engine.instance.soundDisabled = !Engine.instance.soundDisabled;
      }
      
      override protected function restartGame() : void
      {
         mScore = new NP9_Evar(0);
         mMenuManager.menuNavigation(MenuManager.MENU_INTRO_SCR);
         Engine.instance.restartGame();
      }
      
      public function set score(param1:int) : void
      {
         this._levelScore.changeTo(param1);
      }
      
      public function doToggleMusic() : void
      {
         this.toggleMusic();
      }
      
      public function doFinalFailExit() : void
      {
         Engine.clearExcludedObjects();
         if(Engine.EDIT)
         {
            mMenuManager.menuNavigation(MenuManager.MENU_INTRO_SCR);
         }
         else
         {
            mMenuManager.menuNavigation(MenuManager.MENU_GAMEOVER_SCR);
         }
      }
      
      override protected function quitGame() : void
      {
         trace("quitGame");
      }
      
      override protected function startGameSetup() : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         trace("start game setup");
         mDocumentClass.addChildAt(this,mDocumentClass.numChildren);
         trace("***********************");
         trace("***********************");
         var _loc1_:Boolean = false;
         var _loc2_:* = false;
         var _loc3_:String = FlashVarsFinder.findVar(stage.root,"customUser");
         if(_loc3_ != null)
         {
            _loc1_ = true;
         }
         _loc2_ = FlashVarsFinder.findVar(stage.root,"jumpTo") == "editor";
         trace(_loc3_);
         trace("***********************");
         trace("***********************");
         if(_loc1_)
         {
            trace("THIS IS SPOTLIGHT");
            _loc5_ = FlashVarsFinder.findVar(stage.root,"customUser");
            _loc6_ = FlashVarsFinder.findVar(stage.root,"customLevel");
            _loc7_ = FlashVarsFinder.findVar(stage.root,"customName");
            while(_loc6_.indexOf(" ") > -1)
            {
               _loc6_ = _loc6_.replace(" ","+");
            }
            trace("NEW pCustomLevel = " + _loc6_);
            Engine.setCurrentLevel(9999);
            Engine.setCurrentLevelData(_loc6_);
            LevelPreviewScreen(mMenuManager.getMenuScreen(MENU_LEVEL_PREVIEW)).createPreview(9999,_loc7_);
            mMenuManager.menuNavigation(MENU_LEVEL_PREVIEW);
         }
         else if(_loc2_)
         {
            trace("THIS IS EDITOR");
            Engine.EDIT = true;
            this.startLevel();
         }
         else
         {
            trace("THIS IS REGULAR GAMEPLAY");
            mMenuManager.menuNavigation(MenuManager.MENU_INTRO_SCR);
         }
         var _loc4_:String;
         if((_loc4_ = String(mDocumentClass.neopets_GS.getFlashParam("sLang"))) == null)
         {
            _loc4_ = String(mDocumentClass.mcBIOS.game_lang);
         }
         mMenuManager.getMenuScreen(MenuManager.MENU_INTRO_SCR).mcTransLogo.gotoAndStop(_loc4_.toLowerCase());
      }
      
      override protected function toggleMusic() : void
      {
         trace("Toggle Music Btn Pressed");
         Engine.instance.musicDisabled = !Engine.instance.musicDisabled;
      }
      
      override protected function extraMenuButtons(param1:String) : void
      {
         switch(param1)
         {
            case "startEditingButton":
               Engine.EDIT = true;
               this.startLevel();
               break;
            case "backBtn":
               mMenuManager.menuNavigation(MenuManager.MENU_INTRO_SCR);
               break;
            case "backToLevelSelectButton":
               mMenuManager.menuNavigation(MENU_LEVEL_SELECT);
               break;
            case "nextLevelBtn":
               this.selectLevelByNumber(Engine.currentLevelNum + 1);
               break;
            case "startLevelButton":
               this.startLevel();
         }
      }
      
      override protected function startGame() : void
      {
         var _loc2_:* = undefined;
         trace("*************************START GAME****************************************");
         var _loc1_:TranslationData = new TranslationData();
         _loc1_ = TranslationManager.instance.translationData;
         for(_loc2_ in _loc1_)
         {
            trace(_loc2_ + " ::: " + _loc1_[_loc2_]);
         }
         Engine.EDIT = false;
         mMenuManager.menuNavigation(MENU_LEVEL_SELECT);
         mScore = new NP9_Evar(0);
         Engine.instance.restartGame();
      }
      
      public function get endScore() : int
      {
         return int(mScore.show());
      }
      
      override protected function reportScore() : void
      {
         mDocumentClass.neopets_GS.sendScore(mScore.show());
      }
   }
}
