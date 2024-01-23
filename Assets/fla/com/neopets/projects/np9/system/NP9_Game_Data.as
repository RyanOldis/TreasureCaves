package com.neopets.projects.np9.system
{
   public class NP9_Game_Data
   {
       
      
      public var FG_GAME_BASE:String;
      
      public var sLang:String;
      
      public var sPSurl:String;
      
      public var sSK:String;
      
      public var sQuality:String;
      
      public var iGameMaxW:Number;
      
      public var bDebug:Boolean;
      
      public var objTransLevel:Object;
      
      public var sSpClickUrl:String;
      
      public var iDictVersion:Number;
      
      public var iNsm:Number;
      
      public var iSpTrackID:Number;
      
      public var bOffline:Boolean;
      
      public var iIsSponsor:Number;
      
      public var sHash:String;
      
      public var iChallengeCard:Number;
      
      public var bMeterVisible:Boolean;
      
      public var iVersion:Number;
      
      public var iAvgFramerate:Number;
      
      public var iDailyChallenge:Number;
      
      public var iItemID:Number;
      
      public var iGameHeight:Number;
      
      public var iTracking:Number;
      
      public var sPreloader:String;
      
      public var iIE:Number;
      
      public var FG_SCRIPT_BASE:String;
      
      public var iGameID:Number;
      
      public var iFramerate:Number;
      
      public var sUsername:String;
      
      public var sImageHost:String;
      
      public var sSpLogoURL:String;
      
      public var objAddVars:Object;
      
      public var iAge13:Number;
      
      public var sIncludeMovie:String;
      
      public var iVerifiedAct:Number;
      
      public var sNcReferer:String;
      
      public var iHiscore:Number;
      
      public var iGameWidth:Number;
      
      public var bTransDebug:Boolean;
      
      public var iUseCustomMsg:Number;
      
      public var bDictionary:Boolean;
      
      public var iMultiple:Number;
      
      public var sFilename:String;
      
      public var sDestination:String;
      
      public var iIsAdmin:Number;
      
      public var sName:String;
      
      public var tLoaded:Number;
      
      public var iBIOSHeight:Number;
      
      public var iTypeID:Number;
      
      public var iNsid:Number;
      
      public var iScorePosts:Number;
      
      public var bEmbedFonts:Boolean;
      
      public var iForceScore:Number;
      
      public var iDdNcChallenge:Number;
      
      public var iMeterX:Number;
      
      public var iMeterY:Number;
      
      public var iCalibration:Number;
      
      public var iBIOSWidth:Number;
      
      public var iNPRatio:Number;
      
      public var iNPCap:Number;
      
      public var sBaseURL:String;
      
      public var iIsMember:Number;
      
      public var iPlaysAllowed:Number;
      
      public var iSpLogoTrackID:Number;
      
      public var iChallenge:Number;
      
      public var sSpAdURL:String;
      
      public var iGameMaxH:Number;
      
      public function NP9_Game_Data()
      {
         super();
         this.FG_GAME_BASE = "";
         this.FG_SCRIPT_BASE = "";
         this.bDebug = false;
         this.bTransDebug = false;
         this.bOffline = false;
         this.bDictionary = false;
         this.bMeterVisible = true;
         this.objTransLevel = undefined;
         this.sFilename = "g915_v1_77768";
         this.sPreloader = "np9_preloader_hauntedwoods_v1";
         this.sQuality = "high";
         this.iFramerate = 24;
         this.iVersion = 15;
         this.iGameID = 915;
         this.iNPRatio = 0;
         this.iNPCap = 1000;
         this.sUsername = "guest_user_account";
         this.sName = "";
         this.iAge13 = 1;
         this.iNsm = 0;
         this.iNsid = 0;
         this.sNcReferer = "";
         this.sLang = "en";
         this.sHash = "35ba379a5d920acb6f18";
         this.sSK = "35ba379a5d920acb6f18";
         this.iCalibration = 256;
         this.sBaseURL = "www.neopets.com";
         this.iTypeID = 4;
         this.iItemID = 46;
         this.iScorePosts = 0;
         this.iVerifiedAct = 1;
         this.iHiscore = 0;
         this.sDestination = "games/";
         this.iChallenge = 0;
         this.sPSurl = "";
         this.iTracking = 0;
         this.iMultiple = 0;
         this.iIsMember = 0;
         this.iIsAdmin = 0;
         this.iIsSponsor = 0;
         this.iPlaysAllowed = 3;
         this.iDailyChallenge = 0;
         this.iDictVersion = 19;
         this.sImageHost = "http://images50.neopets.com";
         this.sIncludeMovie = "games/gaming_system/np9_gaming_system_v15.swf";
         this.iIE = 0;
         this.iChallengeCard = 1;
         this.iUseCustomMsg = 0;
         this.iForceScore = -1;
         this.iBIOSWidth = 640;
         this.iBIOSHeight = 480;
         this.iGameWidth = 640;
         this.iGameHeight = 480;
         this.iGameMaxW = 640;
         this.iGameMaxH = 480;
         this.sSpLogoURL = "";
         this.iSpTrackID = -1;
         this.sSpAdURL = "";
         this.sSpClickUrl = "";
         this.iSpLogoTrackID = -1;
         this.iMeterX = 0;
         this.iMeterY = 0;
         this.tLoaded = 0;
         this.bEmbedFonts = true;
         this.iAvgFramerate = 24;
         this.objAddVars = {};
      }
      
      public function setVar(param1:String, param2:*) : void
      {
         if(this[param1] != undefined)
         {
            if(param2 != undefined)
            {
               this[param1] = param2;
            }
         }
      }
      
      public function setAddVar(param1:String, param2:*) : void
      {
         if(param2 != undefined)
         {
            this.objAddVars[param1] = param2;
         }
      }
   }
}
