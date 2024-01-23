package com.neopets.projects.gameEngine.gui
{
   import com.neopets.examples.vendorShell.translation.TranslationInfo;
   import com.neopets.util.events.CustomEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.system.ApplicationDomain;
   import virtualworlds.lang.TranslationData;
   
   public class MenuManager extends EventDispatcher
   {
      
      private static const mInstance:com.neopets.projects.gameEngine.gui.MenuManager = new com.neopets.projects.gameEngine.gui.MenuManager(SingletonEnforcer);
      
      public static const MENU_INTRO_SCR:String = "mIntroScreen";
      
      public static const MENU_GAMEOVER_SCR:String = "mGameOverScreen";
      
      public static const MENU_GAME_SCR:String = "mGameScreen";
      
      public static const MENU_INSTRUCT_SCR:String = "mInstructionScreen";
       
      
      public const MENU_EVENT:String = "MenuManagerhasEvent";
      
      protected var mMenuArray:Array;
      
      public const MENU_NAVIGATION_EVENT:String = "MenuSpecialEvent";
      
      protected var mDocumentClass:MovieClip;
      
      protected var mTranslationInfo:TranslationData;
      
      protected var mMenuHolder:Sprite;
      
      public const MENU_BUTTON_EVENT:String = "MenuhasButtonEvent";
      
      public function MenuManager(param1:Class = null)
      {
         super();
         if(param1 != SingletonEnforcer)
         {
            throw new Error("Invalid Singleton access.  Use MenuManager.instance.");
         }
         this.setupVars();
      }
      
      public static function get instance() : com.neopets.projects.gameEngine.gui.MenuManager
      {
         return mInstance;
      }
      
      public function menuNavigation(param1:String) : void
      {
         var _loc2_:int = int(this.mMenuArray.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.mMenuArray[_loc3_].mID == param1)
            {
               this.mMenuArray[_loc3_].visible = true;
               dispatchEvent(new CustomEvent({"MENU":param1},this.MENU_NAVIGATION_EVENT));
            }
            else
            {
               this.mMenuArray[_loc3_].visible = false;
            }
            _loc3_++;
         }
      }
      
      public function getMenuScreen(param1:String) : *
      {
         var _loc2_:int = int(this.mMenuArray.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.mMenuArray[_loc3_].mID == param1)
            {
               return this.mMenuArray[_loc3_];
            }
            _loc3_++;
         }
         return false;
      }
      
      public function get menusDisplayObj() : Sprite
      {
         return this.mMenuHolder;
      }
      
      protected function restartBtnPressed(param1:Event = null) : void
      {
         if(this.mDocumentClass.neopets_GS.hasEventListener(this.mDocumentClass.neopets_GS.RESTART_CLICKED))
         {
            this.mDocumentClass.neopets_GS.removeEventListener(this.mDocumentClass.neopets_GS.RESTART_CLICKED,this.restartBtnPressed);
         }
         this.mDocumentClass.sendScoringMeterToBack();
         dispatchEvent(new CustomEvent({"EVENT":"restartGame"},this.MENU_EVENT));
      }
      
      protected function onInterfaceButtonPressed(param1:CustomEvent) : void
      {
         switch(param1.oData.TARGETID)
         {
            case "startGameButton":
               this.mDocumentClass.neopets_GS.sendTag(this.mDocumentClass.START_GAME_MSG);
               break;
            case "instructionsButton":
               this.menuNavigation(com.neopets.projects.gameEngine.gui.MenuManager.MENU_INSTRUCT_SCR);
               break;
            case "quitGameButton":
               this.menuNavigation(com.neopets.projects.gameEngine.gui.MenuManager.MENU_GAMEOVER_SCR);
               break;
            case "playAgainBtn":
               this.mDocumentClass.sendScoringMeterToBack();
               break;
            case "reportScoreBtn":
               this.getMenuScreen(com.neopets.projects.gameEngine.gui.MenuManager.MENU_GAMEOVER_SCR).toggleInterfaceButtons(false);
               this.mDocumentClass.sendScoringMeterToFront();
               this.mDocumentClass.neopets_GS.addEventListener(this.mDocumentClass.neopets_GS.RESTART_CLICKED,this.restartBtnPressed);
               break;
            case "returnBtn":
               this.menuNavigation(com.neopets.projects.gameEngine.gui.MenuManager.MENU_INTRO_SCR);
               break;
            case "soundToggleBtn":
            case "musicToggleBtn":
         }
         dispatchEvent(new CustomEvent({"EVENT":param1.oData.TARGETID},this.MENU_BUTTON_EVENT));
      }
      
      public function createMenu(param1:String, param2:String) : AbsMenu
      {
         var _loc3_:Class = ApplicationDomain.currentDomain.getDefinition(param1) as Class;
         var _loc4_:AbsMenu;
         (_loc4_ = new _loc3_()).mID = param2;
         _loc4_.addEventListener(_loc4_.BUTTON_PRESSED,this.onInterfaceButtonPressed,false,0,true);
         this.mMenuArray.push(_loc4_);
         _loc4_.visible = false;
         this.mMenuHolder.addChild(_loc4_);
         return _loc4_;
      }
      
      protected function setupVars() : void
      {
         this.mMenuArray = [];
         this.mMenuHolder = new Sprite();
         this.mTranslationInfo = new TranslationInfo();
      }
      
      public function init(param1:MovieClip, param2:TranslationData) : void
      {
         this.mDocumentClass = param1;
         this.mTranslationInfo = param2;
      }
   }
}

class SingletonEnforcer
{
    
   
   public function SingletonEnforcer()
   {
      super();
   }
}
