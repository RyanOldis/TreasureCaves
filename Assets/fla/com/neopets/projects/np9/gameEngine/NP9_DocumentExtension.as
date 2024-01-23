package com.neopets.projects.np9.gameEngine
{
   import com.neopets.projects.np9.system.NP9_BIOS;
   import com.neopets.projects.np9.system.NP9_Loader_Control;
   import com.neopets.util.events.CustomEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.getDefinitionByName;
   import virtualworlds.lang.TranslationData;
   import virtualworlds.lang.TranslationManager;
   
   public class NP9_DocumentExtension extends MovieClip
   {
       
      
      public const END_GAME_MSG:String = "Game Finished";
      
      public const START_LOADING:String = "NP9_PRELOADER_tellingGametoStart";
      
      private var mObjLoaderControl:NP9_Loader_Control;
      
      public var bOffline:Boolean;
      
      public const SETUP_LOADING_SIGN:String = "setupLoadingSign";
      
      public const TRANSLATION_COMPLETE:String = "TranslationSystemComplete";
      
      protected var LoadingSignOn:Boolean;
      
      protected var mGamingSystemIndex:Number;
      
      protected var mGamingSystem:MovieClip;
      
      protected var mBIOS:NP9_BIOS;
      
      protected var mNP9SystemLoadedToggle:Boolean;
      
      public const REMOVE_LOADING_SIGN:String = "removeLoadingSign";
      
      public const LOADING_PROGRESS:String = "loadingProgress";
      
      public const START_GAME_MSG:String = "Game Started";
      
      public function NP9_DocumentExtension()
      {
         super();
         trace("NP9_DocumentExtension says: NP9_DocumentExtension constructed");
         trace("NP9_DocumentExtension says: NP9_DocumentExtension: " + this.stage);
         this.setupVars();
         addEventListener(this.START_LOADING,this.NP9systemLoaded,false,0,true);
         addEventListener(this.SETUP_LOADING_SIGN,this.setupLoaderSign,false,0,true);
         addEventListener(this.LOADING_PROGRESS,this.onProgress,false,0,true);
      }
      
      protected function translationComplete(param1:Event) : void
      {
         dispatchEvent(new Event(this.TRANSLATION_COMPLETE));
         trace("translation complete event dispatched");
      }
      
      public function get _GS() : MovieClip
      {
         return this.mGamingSystem;
      }
      
      public function init(param1:NP9_BIOS = null) : void
      {
         this.mBIOS = param1;
         if(this.parent != null)
         {
            if(this.parent.toString().toUpperCase().indexOf("STAGE",0) >= 0)
            {
               this.triggerOfflineMode();
            }
         }
         trace(this.mBIOS.game_infostamp + " " + this.mBIOS.game_datestamp + " " + this.mBIOS.game_timestamp);
         this.mBIOS.visible = false;
         this.mGamingSystemIndex = 0;
      }
      
      public function NP9_GameBase() : void
      {
         this.mGamingSystem = this.getGamingSystem();
      }
      
      protected function removeLoaderSign(param1:Event = null) : void
      {
         if(hasEventListener(this.SETUP_LOADING_SIGN))
         {
            removeEventListener(this.SETUP_LOADING_SIGN,this.setupLoaderSign);
         }
         if(hasEventListener(this.REMOVE_LOADING_SIGN))
         {
            removeEventListener(this.REMOVE_LOADING_SIGN,this.removeLoaderSign);
         }
         if(hasEventListener(this.LOADING_PROGRESS))
         {
            removeEventListener(this.LOADING_PROGRESS,this.onProgress);
         }
         if(getChildByName("loadingSign") != null)
         {
            removeChild(getChildByName("loadingSign"));
         }
      }
      
      public function offlineMode() : void
      {
         this.mObjLoaderControl = new NP9_Loader_Control(this);
         this.mObjLoaderControl.setEnvironment("offline");
         this.mObjLoaderControl.setOfflineBiosParams(this.mBIOS);
         this.addEventListener(Event.ENTER_FRAME,this.main,false,0,true);
      }
      
      protected function onProgress(param1:CustomEvent) : void
      {
         var _loc2_:int = int(param1.oData.DATA.TOTAL_LOADED);
         var _loc3_:int = int(param1.oData.DATA.TOTAL_ITEMS);
         var _loc4_:Number = Number(param1.oData.DATA.BYTES_LOADED);
         var _loc5_:Number = Number(param1.oData.DATA.BYTES_TOTAL);
         var _loc6_:Number = Math.floor(_loc4_ / _loc5_ * 100);
         var _loc7_:MovieClip;
         if((_loc7_ = MovieClip(getChildByName("loadingSign"))).hasOwnProperty("percentCount"))
         {
            _loc7_.percentCount.text = _loc6_.toString();
         }
         if(_loc7_.hasOwnProperty("fileCount"))
         {
            _loc7_.fileCount.text = _loc2_.toString() + "/" + _loc3_.toString();
         }
      }
      
      public function getGamingSystem() : MovieClip
      {
         return this.mGamingSystem;
      }
      
      private function main(param1:Event) : void
      {
         if(!this.mObjLoaderControl.main())
         {
            this.removeEventListener(Event.ENTER_FRAME,this.main);
            this.removeEventListener(Event.ENTER_FRAME,this.main);
         }
      }
      
      public function get translationManager() : TranslationManager
      {
         return TranslationManager.instance;
      }
      
      protected function gameEngineUpdate() : void
      {
         trace("NP9_DocumentExtension says: Please override gameEngineUpdate( )");
      }
      
      public function get neopets_GS() : MovieClip
      {
         if(this.mGamingSystem == null)
         {
            throw new Error("NP9_DocumentExtension says: mGamingSystem is Null in the DocumentExtension");
         }
         return this.mGamingSystem;
      }
      
      public function getBIOS() : NP9_BIOS
      {
         return this.mBIOS;
      }
      
      private function setupVars() : void
      {
         trace("NP9_DocumentExtension says: setupVars called");
         this.mNP9SystemLoadedToggle = false;
         this.LoadingSignOn = false;
         this.bOffline = false;
      }
      
      protected function setupLoaderSign(param1:Event = null) : void
      {
         var _loc2_:Class = null;
         var _loc3_:MovieClip = null;
         if(!this.LoadingSignOn)
         {
            this.LoadingSignOn = true;
            _loc2_ = getDefinitionByName("loadingSign") as Class;
            _loc3_ = new _loc2_();
            _loc3_.name = "loadingSign";
            addChild(_loc3_);
            _loc3_.x = stage.stageWidth / 2;
            _loc3_.y = stage.stageHeight / 2;
            addEventListener(this.REMOVE_LOADING_SIGN,this.removeLoaderSign,false,0,true);
         }
      }
      
      public function setGamingSystem(param1:MovieClip) : void
      {
         this.mGamingSystem = param1;
      }
      
      protected function NP9systemLoaded(param1:Event = null) : void
      {
         if(!this.mNP9SystemLoadedToggle)
         {
            this.NP9_GameBase();
            this.addChildAt(this.mGamingSystem,this.mGamingSystemIndex);
            this.gameEngineUpdate();
         }
      }
      
      public function sendScoringMeterToBack() : void
      {
         if(this.bOffline)
         {
            if(this.mGamingSystemIndex != 0)
            {
               setChildIndex(getChildAt(this.mGamingSystemIndex),0);
               this.mGamingSystemIndex = 0;
            }
            trace("INFO sendScoringMeterToBack>  GSVIS>",this.mGamingSystem.visible);
         }
      }
      
      public function triggerOfflineMode() : void
      {
         this.bOffline = true;
         this.offlineMode();
         trace("Triggered offline Mode");
      }
      
      protected function getLanguageCode() : String
      {
         var _loc1_:String = String(this.mGamingSystem.getFlashParam("sLang"));
         if(_loc1_ == null)
         {
            _loc1_ = this.mBIOS.game_lang;
         }
         return _loc1_;
      }
      
      public function sendScoringMeterToFront() : void
      {
         trace(" NP9_GameDocument > sendScoringMeterToFront bOffline>",this.bOffline);
         var _loc1_:Number = numChildren - 1;
         this.mGamingSystem.visible = true;
         if(this.mGamingSystemIndex != _loc1_)
         {
            setChildIndex(getChildAt(this.mGamingSystemIndex),_loc1_);
            this.mGamingSystemIndex = _loc1_;
         }
         trace("INFO SendScoreingMeterToFront>",_loc1_," GSINDEX>",this.mGamingSystemIndex," GSVIS>",this.mGamingSystem.visible);
      }
      
      public function setupTranslation(param1:TranslationData, param2:String = null) : void
      {
         var _loc3_:TranslationManager = TranslationManager.instance;
         _loc3_.addEventListener(Event.COMPLETE,this.translationComplete,false,0,true);
         trace("LANGUAGE: " + this.mGamingSystem.getFlashParam("sLang").toUpperCase());
         _loc3_.init(this.mGamingSystem.getFlashParam("sLang").toUpperCase(),this.mBIOS.game_id,TranslationManager.TYPE_ID_GAME,param1);
      }
      
      public function get _GAMINGSYSTEM() : MovieClip
      {
         return this.mGamingSystem;
      }
   }
}
