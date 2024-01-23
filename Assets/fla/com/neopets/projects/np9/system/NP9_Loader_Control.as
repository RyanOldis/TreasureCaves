package com.neopets.projects.np9.system
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.events.TextEvent;
   import flash.net.URLRequest;
   import flash.system.Capabilities;
   import flash.utils.getTimer;
   
   public class NP9_Loader_Control
   {
      
      private static var _WAITFORPRELOADER:uint = 7;
      
      private static var _LOAD_GS:uint = 2;
      
      private static var _WAIT_FOR_TRANS:uint = 5;
      
      private static var _DONE:uint = 0;
      
      private static var _WAIT_FOR_GS:uint = 3;
      
      private static var _INIT:uint = 1;
      
      private static var _LOADPRELOADER:uint = 6;
      
      private static var _LOAD_TRANS:uint = 4;
      
      private static var _WAITFORGAME:uint = 9;
      
      private static var _LOADGAME:uint = 8;
      
      private static var _STARTGAME:uint = 10;
       
      
      private var mcPreloader:Object;
      
      private var bLoadInProgress:Boolean;
      
      private var mcGS:MovieClip;
      
      private var bTRACE:Boolean;
      
      private var uiLoadState:uint;
      
      private var bGameLoaded:Boolean;
      
      private var bDEBUG_LOAD_LOCAL:Boolean;
      
      private var bOffline:Boolean;
      
      private var mcGame:Object;
      
      private var objTracer:com.neopets.projects.np9.system.NP9_Tracer;
      
      private var nStartGameLoad:Number;
      
      private var objStage:Stage;
      
      private var aParams:Array;
      
      private var _NP9_GAME_DATA:com.neopets.projects.np9.system.NP9_Game_Data;
      
      private var _NP9_bGameLoaded:Boolean;
      
      private var objLoaderGS:Loader;
      
      private var mLoaderVersion:String = "v9";
      
      private var objLoaderPre:Loader;
      
      private var bPreloaderLoaded:Boolean;
      
      private var aPreloaderText:Object;
      
      private var bGSLoaded:Boolean;
      
      private var objRoot:Object;
      
      private var objLoaderGame:Loader;
      
      private var sLocalPath:String;
      
      public function NP9_Loader_Control(param1:Object)
      {
         super();
         this.bTRACE = true;
         this.objTracer = new com.neopets.projects.np9.system.NP9_Tracer(this,this.bTRACE);
         this.objTracer.out("Instance NP9_LoaderControl GameEngine is Created>!" + this.mLoaderVersion,true);
         this.objTracer.out("Instance created!",true);
         this.objRoot = param1;
         this.objStage = this.objRoot.stage;
         this.bDEBUG_LOAD_LOCAL = false;
         this.uiLoadState = _INIT;
         this.bLoadInProgress = true;
         this.bOffline = false;
         this._NP9_bGameLoaded = false;
         this.bGSLoaded = false;
         this.bPreloaderLoaded = false;
         this.bGameLoaded = false;
         this.aPreloaderText = new Object();
         this.nStartGameLoad = 0;
         this._NP9_GAME_DATA = new com.neopets.projects.np9.system.NP9_Game_Data();
         this.sLocalPath = "G:\\Multimedia\\projects\\internal\\com\\neopets\\applications\\large_applications\\multimedia_gaming_system\\mgs1\\FLASH9";
         this.aParams = new Array();
         this.aParams.push(["sFilename","g"]);
         this.aParams.push(["sPreloader","p"]);
         this.aParams.push(["sQuality","q"]);
         this.aParams.push(["iFramerate","f"]);
         this.aParams.push(["iVersion","v"]);
         this.aParams.push(["iGameID","id"]);
         this.aParams.push(["iNPRatio","n"]);
         this.aParams.push(["iNPCap","c"]);
         this.aParams.push(["sUsername","username"]);
         this.aParams.push(["sName","name"]);
         this.aParams.push(["iAge13","age"]);
         this.aParams.push(["iNsm","nsm"]);
         this.aParams.push(["iNsid","nsid"]);
         this.aParams.push(["sNcReferer","nc_referer"]);
         this.aParams.push(["sLang","lang"]);
         this.aParams.push(["sHash","sh"]);
         this.aParams.push(["sSK","sk"]);
         this.aParams.push(["iCalibration","calibration"]);
         this.aParams.push(["sBaseURL","baseurl"]);
         this.aParams.push(["iTypeID","typeID"]);
         this.aParams.push(["iItemID","itemID"]);
         this.aParams.push(["iScorePosts","sp"]);
         this.aParams.push(["iVerifiedAct","va"]);
         this.aParams.push(["iHiscore","hiscore"]);
         this.aParams.push(["sDestination","destination"]);
         this.aParams.push(["iChallenge","chall"]);
         this.aParams.push(["sPSurl","psurl"]);
         this.aParams.push(["iTracking","t"]);
         this.aParams.push(["iMultiple","multiple"]);
         this.aParams.push(["iIsMember","member"]);
         this.aParams.push(["iIsAdmin","isAdmin"]);
         this.aParams.push(["iIsSponsor","isSponsor"]);
         this.aParams.push(["iPlaysAllowed","ms"]);
         this.aParams.push(["iDailyChallenge","dc"]);
         this.aParams.push(["iDictVersion","dict_ver"]);
         this.aParams.push(["sImageHost","image_host"]);
         this.aParams.push(["sIncludeMovie","include_movie"]);
         this.aParams.push(["iIE","internetexplorer"]);
         this.aParams.push(["iChallengeCard","ccard"]);
         this.aParams.push(["iGameWidth","gamew"]);
         this.aParams.push(["iGameHeight","gameh"]);
         this.aParams.push(["sSpLogoURL","sp_logo_url"]);
         this.aParams.push(["iSpTrackID","sp_track_id"]);
         this.aParams.push(["sSpAdURL","sp_ad_url"]);
         this.aParams.push(["sSpClickUrl","sp_logo_click_url"]);
         this.aParams.push(["iSpLogoTrackID","sp_logo_track_id"]);
         this.aParams.push(["iDdNcChallenge","ddNcChallenge"]);
         this.aParams.push(["iUseCustomMsg","useCustomMsg"]);
         this.aParams.push(["iForceScore","forceScore"]);
      }
      
      private function setPreloaderText() : void
      {
         var _loc1_:Date = new Date();
         var _loc2_:* = "<p align=\'center\'>® & © " + String(_loc1_.getFullYear()) + " Neopets, Inc.<br>All Rights Reserved</p>";
         this.mcPreloader.setLegalText(_loc2_);
         var _loc3_:String = String(this.mcGS.getTranslation("IDS_PRELOADER_LOADING_GAME"));
         var _loc4_:String = _loc3_.replace("face = \'jokerman_fnt\' ","");
         this.mcPreloader.setHeaderText(_loc4_);
         this.aPreloaderText.playgame = this.formatPreloaderTextStrings(this.mcGS.getTranslation("IDS_PRELOADER_PLAYGAME"));
         this.aPreloaderText.login = this.formatPreloaderTextStrings(this.mcGS.getTranslation("IDS_PRELOADER_LOGIN"));
         this.aPreloaderText.signup = this.formatPreloaderTextStrings(this.mcGS.getTranslation("IDS_PRELOADER_SIGNUP"));
         this.aPreloaderText.plugin = this.formatPreloaderTextStrings(this.mcGS.getTranslation("IDS_PRELOADER_PLUGIN"));
         this.aPreloaderText.loaded = this.formatPreloaderTextStrings(this.mcGS.getTranslation("IDS_PRELOADER_LOADED"));
         this.aPreloaderText.percent = this.formatPreloaderTextStrings(this.mcGS.getTranslation("IDS_PRELOADER_PERCENT"));
         this.aPreloaderText.elapsed = this.formatPreloaderTextStrings(this.mcGS.getTranslation("IDS_PRELOADER_ELAPSED"));
         this.aPreloaderText.secs = this.formatPreloaderTextStrings(this.mcGS.getTranslation("IDS_PRELOADER_SEC"));
         this.aPreloaderText.estimate = this.formatPreloaderTextStrings(this.mcGS.getTranslation("IDS_PRELOADER_ESTIMATED"));
         this.aPreloaderText.rate = this.formatPreloaderTextStrings(this.mcGS.getTranslation("IDS_PRELOADER_RATE"));
         this.aPreloaderText.kps = this.formatPreloaderTextStrings(this.mcGS.getTranslation("IDS_PRELOADER_KPS"));
         this.aPreloaderText.notloggedin = this.formatPreloaderTextStrings(this.mcGS.getTranslation("IDS_PRELOADER_NOTLOGGEDIN"));
         if(this._NP9_GAME_DATA.sUsername.toUpperCase() == "GUEST_USER_ACCOUNT")
         {
            this.mcPreloader.setData(false,false);
         }
      }
      
      private function GSLoaded(param1:Event) : void
      {
         this.bGSLoaded = true;
         this.objLoaderGS.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.GSLoaded);
      }
      
      private function preloaderLoaded(param1:Event) : void
      {
         this.bPreloaderLoaded = true;
         this.objLoaderPre.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.preloaderLoaded);
      }
      
      private function gameLoaded(param1:Event) : void
      {
         this.bGameLoaded = true;
         this.objLoaderGame.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.gameLoaded);
      }
      
      private function swapGSAndGame() : void
      {
         this.objRoot.swapChildren(this.objLoaderGame,this.objLoaderGS);
      }
      
      private function setPreloader() : void
      {
         this.mcPreloader = MovieClip(this.objLoaderPre.contentLoaderInfo.content);
         this.mcPreloader.initTextFields(this.mcGS.isWesternLang());
         if("sLang" in this.mcPreloader)
         {
            this.mcPreloader.sLang = this._NP9_GAME_DATA.sLang;
         }
         if("initLogoTracking" in this.mcPreloader)
         {
            if("setSpLogoClickUrl" in this.mcPreloader)
            {
               this.mcPreloader.initLogoTracking(this._NP9_GAME_DATA.iGameWidth,this._NP9_GAME_DATA.iGameHeight,this._NP9_GAME_DATA.sSpLogoURL,this._NP9_GAME_DATA.iSpTrackID,this._NP9_GAME_DATA.sSpAdURL,this._NP9_GAME_DATA.sSpClickUrl,this._NP9_GAME_DATA.iSpLogoTrackID);
            }
            else
            {
               this.mcPreloader.initLogoTracking(this._NP9_GAME_DATA.iGameWidth,this._NP9_GAME_DATA.iGameHeight,this._NP9_GAME_DATA.sSpLogoURL,this._NP9_GAME_DATA.iSpTrackID,this._NP9_GAME_DATA.sSpAdURL);
            }
         }
         this.objTracer.out("mcPreloader.width: " + this._NP9_GAME_DATA.iGameWidth,false);
         this.objTracer.out("mcPreloader.height: " + this._NP9_GAME_DATA.iGameHeight,false);
         this.mcPreloader.width = this._NP9_GAME_DATA.iGameWidth;
         this.mcPreloader.height = this._NP9_GAME_DATA.iGameHeight;
         this.mcPreloader.x = 0;
         this.mcPreloader.y = 0;
         this.mcPreloader.gotoAndStop(2);
         if("setLang" in this.mcPreloader)
         {
            this.mcPreloader.setLang(this.mcGS.getFlashParam("sLang"));
         }
         this.mcPreloader.addAnimation();
         this.objRoot.addChild(this.objLoaderPre);
      }
      
      private function loadPreloader() : void
      {
         var _loc1_:* = "";
         if(this.bDEBUG_LOAD_LOCAL)
         {
            _loc1_ = this.sLocalPath + "\\Preloader\\Older\\np9_preloader_hauntedwoods_v2.swf";
         }
         else
         {
            _loc1_ = this._NP9_GAME_DATA.FG_GAME_BASE;
            _loc1_ += "games/preloaders/" + this._NP9_GAME_DATA.sPreloader + ".swf";
         }
         this.objTracer.out("loading: " + _loc1_,false);
         this.objLoaderPre = new Loader();
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         this.objLoaderPre.load(_loc2_);
         this.objLoaderPre.contentLoaderInfo.addEventListener(Event.COMPLETE,this.preloaderLoaded,false,0,true);
      }
      
      private function setLoaderFramerate(param1:int = 18) : void
      {
         if(!this._NP9_GAME_DATA.bOffline)
         {
            this.objStage.frameRate = param1;
         }
      }
      
      private function gameLoadingProgress(param1:ProgressEvent) : void
      {
         var _loc2_:* = "<p align=\'center\'><br><br>";
         var _loc3_:Number = 0;
         if(param1.bytesLoaded > 0 && param1.bytesTotal > 0)
         {
            if(param1.bytesLoaded >= param1.bytesTotal)
            {
               _loc3_ = 100;
            }
            else
            {
               _loc3_ = int(param1.bytesLoaded * 100 / param1.bytesTotal);
            }
         }
         var _loc4_:Number = getTimer() - this.nStartGameLoad;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         if(_loc4_ > 0)
         {
            if((_loc5_ = param1.bytesLoaded / 1000 / (_loc4_ / 1000)) > 0)
            {
               _loc6_ = param1.bytesTotal / _loc5_;
            }
         }
         var _loc7_:RegExp;
         var _loc8_:Object = (_loc7_ = /^(\w*) (\d*),(\d*),(\d*),(\d*)$/).exec(Capabilities.version);
         var _loc9_:String = "";
         if(_loc8_ != null)
         {
            _loc9_ = String(_loc8_[2]);
         }
         _loc2_ += this.aPreloaderText.plugin + " " + _loc9_;
         _loc2_ += "<br>" + this.aPreloaderText.loaded + " " + String(_loc3_) + this.aPreloaderText.percent;
         if(this.mcPreloader.isLoggedIn())
         {
            _loc2_ += "<br>" + this.aPreloaderText.elapsed + " " + String(Math.round(_loc4_ / 1000)) + " " + this.aPreloaderText.secs;
            _loc2_ += "<br>" + this.aPreloaderText.estimate + " " + String(Math.round(_loc6_ / 1000)) + " " + this.aPreloaderText.secs;
            _loc2_ += "<br>" + this.aPreloaderText.rate + " " + String(int(_loc5_)) + " " + this.aPreloaderText.kps;
         }
         else
         {
            _loc2_ += "<br><br>" + this.aPreloaderText.notloggedin;
            _loc2_ += "<br><font color=\'#FF0000\'>" + this.aPreloaderText.playgame + "</font>";
            _loc2_ += "<br><font color=\'#FF0000\'>" + this.aPreloaderText.login + "</font>";
            _loc2_ += "<br><font color=\'#FF0000\'>" + this.aPreloaderText.signup + "</font>";
         }
         _loc2_ += "</p>";
         this.mcPreloader.showLoadingProcess(_loc2_,int(_loc3_));
      }
      
      private function loadGamingSystem() : void
      {
         var _loc1_:* = null;
         if(this.bDEBUG_LOAD_LOCAL)
         {
            _loc1_ = this.sLocalPath + "\\Gaming_System\\np9_gaming_system_v15.swf";
            trace("loading: " + _loc1_);
         }
         else
         {
            _loc1_ = this._NP9_GAME_DATA.FG_GAME_BASE + this._NP9_GAME_DATA.sIncludeMovie;
         }
         this.objTracer.out("loading: " + _loc1_,false);
         this.objLoaderGS = new Loader();
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         this.objLoaderGS.load(_loc2_);
         this.objLoaderGS.contentLoaderInfo.addEventListener(Event.COMPLETE,this.GSLoaded,false,0,true);
      }
      
      private function setGamingSystem() : void
      {
         this.mcGS = MovieClip(this.objLoaderGS.contentLoaderInfo.content);
         this.objRoot.addChild(this.objLoaderGS);
         this.mcGS.init(this._NP9_GAME_DATA,this.bTRACE);
         trace("GAMINGSYSTEM WIDTH = " + this.mcGS.width);
      }
      
      public function setEnvironment(param1:String) : void
      {
         if(param1.toUpperCase() == "OFFLINE")
         {
            this.objTracer.out("Offline Mode Detected!",true);
            this.bOffline = true;
         }
      }
      
      private function setBiosParams(param1:Object) : void
      {
         if(param1 == null)
         {
            trace("mcBIOS is NULL . CAUSE AND ERROR IN LOADER_CONTROLL!!!");
            return;
         }
         this._NP9_GAME_DATA.bMeterVisible = param1.metervisible;
         this._NP9_GAME_DATA.iMeterX = param1.meterX;
         this._NP9_GAME_DATA.iMeterY = param1.meterY;
         var _loc2_:int = param1.width != 0 ? int(param1.width) : int(param1.iBIOSWidth);
         var _loc3_:int = param1.height != 0 ? int(param1.height) : int(param1.iBIOSHeight);
         this._NP9_GAME_DATA.iBIOSWidth = _loc2_;
         this._NP9_GAME_DATA.iBIOSHeight = _loc3_;
      }
      
      public function main() : Boolean
      {
         trace("uiLoadState: " + this.uiLoadState);
         switch(this.uiLoadState)
         {
            case _INIT:
               this.initGameData();
               this.setLoaderFramerate(18);
               this.uiLoadState = _LOAD_GS;
               break;
            case _LOAD_GS:
               this.loadGamingSystem();
               this.uiLoadState = _WAIT_FOR_GS;
               break;
            case _WAIT_FOR_GS:
               if(this.bGSLoaded)
               {
                  this.setGamingSystem();
                  this.uiLoadState = _LOAD_TRANS;
               }
               break;
            case _LOAD_TRANS:
               this.mcGS.callTranslation();
               this.uiLoadState = _WAIT_FOR_TRANS;
               break;
            case _WAIT_FOR_TRANS:
               if(this.mcGS.translationComplete())
               {
                  if(this.bOffline)
                  {
                     this.objRoot.setGamingSystem(this.mcGS);
                     this.uiLoadState = _STARTGAME;
                  }
                  else
                  {
                     this.uiLoadState = _LOADPRELOADER;
                  }
               }
               break;
            case _LOADPRELOADER:
               this.loadPreloader();
               this.uiLoadState = _WAITFORPRELOADER;
               break;
            case _WAITFORPRELOADER:
               if(this.bPreloaderLoaded)
               {
                  this.setPreloader();
                  this.setPreloaderText();
                  this.mcPreloader.addEventListener(TextEvent.LINK,this.TextLinkHandler,false,0,true);
                  this.uiLoadState = _LOADGAME;
               }
               break;
            case _LOADGAME:
               this.loadGame();
               this.nStartGameLoad = getTimer();
               this.uiLoadState = _WAITFORGAME;
               break;
            case _WAITFORGAME:
               if(this.bGameLoaded)
               {
                  if(this.mcPreloader.startGame())
                  {
                     this.setGame();
                     this.swapGSAndGame();
                     this.uiLoadState = _STARTGAME;
                  }
               }
               break;
            case _STARTGAME:
               this.setLoaderFramerate(this._NP9_GAME_DATA.iFramerate);
               if(this.bOffline)
               {
                  this.objRoot.play();
                  this.objRoot.dispatchEvent(new Event("NP9_PRELOADER_tellingGametoStart"));
               }
               else
               {
                  this.mcPreloader.removeEventListener(TextEvent.LINK,this.TextLinkHandler);
                  this.mcGame.play();
                  this.mcGame.dispatchEvent(new Event("NP9_PRELOADER_tellingGametoStart"));
               }
               this.uiLoadState = _DONE;
               break;
            case _DONE:
               this.bLoadInProgress = false;
         }
         return this.bLoadInProgress;
      }
      
      private function formatPreloaderTextStrings(param1:String) : String
      {
         param1 = param1.replace("face = \'customFSS_fnt\' ","");
         param1 = param1.replace("_root.","");
         param1 = param1.replace("asfunction","event");
         param1 = param1.replace("HTMLClick,1","playGame");
         param1 = param1.replace("HTMLClick,2","signUp");
         return param1.replace("HTMLClick,3","login");
      }
      
      public function setOfflineBiosParams(param1:Object) : void
      {
         trace("setOfflineBiosParams > ",param1);
         this._NP9_GAME_DATA.bOffline = true;
         this._NP9_GAME_DATA.iGameID = param1.game_id;
         this._NP9_GAME_DATA.sLang = param1.game_lang;
         this._NP9_GAME_DATA.sImageHost = "http://" + param1.game_server;
         this._NP9_GAME_DATA.sBaseURL = param1.script_server;
         var _loc2_:int = param1.width != 0 ? int(param1.width) : int(param1.iBIOSWidth);
         var _loc3_:int = param1.height != 0 ? int(param1.height) : int(param1.iBIOSHeight);
         this._NP9_GAME_DATA.iBIOSWidth = _loc2_;
         this._NP9_GAME_DATA.iBIOSHeight = _loc3_;
         this.setBiosParams(param1);
         this.bTRACE = param1.debug;
         this.objTracer.setDebug(this.bTRACE);
      }
      
      private function TextLinkHandler(param1:TextEvent) : void
      {
         var _loc2_:String = param1.text.toUpperCase();
         switch(_loc2_)
         {
            case "LOGIN":
               trace("login clicked");
               this.mcGS.showLogin();
               break;
            case "SIGNUP":
               trace("signup clicked");
               this.mcGS.showSignup();
               break;
            case "PLAYGAME":
               trace("playgame clicked");
               this.mcPreloader.setStart(true);
         }
      }
      
      private function initGameData() : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:Boolean = false;
         var _loc6_:uint = 0;
         var _loc1_:String = "";
         var _loc2_:Object = this.objRoot.loaderInfo.parameters;
         for(_loc3_ in _loc2_)
         {
            _loc4_ = String(_loc2_[_loc3_]);
            _loc1_ += _loc3_ + ": ";
            _loc5_ = false;
            _loc6_ = 0;
            while(_loc6_ < this.aParams.length)
            {
               if(this.aParams[_loc6_][1] == _loc3_)
               {
                  _loc5_ = true;
                  this._NP9_GAME_DATA.setVar(this.aParams[_loc6_][0],_loc4_);
                  _loc1_ += this._NP9_GAME_DATA[this.aParams[_loc6_][0]] + "\n";
                  break;
               }
               _loc6_++;
            }
            if(!_loc5_)
            {
               this._NP9_GAME_DATA.setAddVar(_loc3_,_loc4_);
               _loc1_ += this._NP9_GAME_DATA.objAddVars[_loc3_] + " (NEW VAR)\n";
            }
         }
         this._NP9_GAME_DATA.FG_GAME_BASE = this._NP9_GAME_DATA.sImageHost + String.fromCharCode(47);
         this._NP9_GAME_DATA.FG_SCRIPT_BASE = "http://" + this._NP9_GAME_DATA.sBaseURL + String.fromCharCode(47);
         this.objTracer.out("_NP9_GAME_DATA.FG_GAME_BASE: " + this._NP9_GAME_DATA.FG_GAME_BASE,false);
         this.objTracer.out("_NP9_GAME_DATA.FG_SCRIPT_BASE: " + this._NP9_GAME_DATA.FG_SCRIPT_BASE,false);
         this._NP9_GAME_DATA.objTransLevel = this.objRoot;
         this._NP9_GAME_DATA.tLoaded = getTimer();
         this._NP9_GAME_DATA.iAvgFramerate = this._NP9_GAME_DATA.iFramerate;
         this._NP9_GAME_DATA.iGameMaxW = Capabilities.screenResolutionX;
         this._NP9_GAME_DATA.iGameMaxH = Capabilities.screenResolutionY;
      }
      
      private function setGame() : void
      {
         this.mcGame = MovieClip(this.objLoaderGame.contentLoaderInfo.content);
         this.objTracer.out("mcGame.width: " + this._NP9_GAME_DATA.iGameWidth,false);
         this.objTracer.out("mcGame.height: " + this._NP9_GAME_DATA.iGameHeight,false);
         this.mcGame.width = this._NP9_GAME_DATA.iGameWidth;
         this.mcGame.height = this._NP9_GAME_DATA.iGameHeight;
         this.mcGame.x = 0;
         this.mcGame.y = 0;
         this.mcGame.setGamingSystem(this.mcGS);
         this.setBiosParams(this.mcGame.getBIOS());
         this.objRoot.removeChild(this.objLoaderPre);
         this.objRoot.addChild(this.objLoaderGame);
      }
      
      private function loadGame() : void
      {
         var _loc1_:* = "";
         if(this.bDEBUG_LOAD_LOCAL)
         {
            _loc1_ = this.sLocalPath + "\\Gaming_System\\g928_v1_13743.swf";
         }
         else
         {
            _loc1_ = this._NP9_GAME_DATA.FG_GAME_BASE;
            _loc1_ += "games/" + this._NP9_GAME_DATA.sFilename + ".swf";
         }
         this.objTracer.out("loading: " + _loc1_,false);
         this.objLoaderGame = new Loader();
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         trace("NP9_LoaderControl is Loading>",_loc1_);
         this.objLoaderGame.load(_loc2_);
         this.objLoaderGame.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.gameLoadingProgress,false,0,true);
         this.objLoaderGame.contentLoaderInfo.addEventListener(Event.COMPLETE,this.gameLoaded,false,0,true);
      }
   }
}
