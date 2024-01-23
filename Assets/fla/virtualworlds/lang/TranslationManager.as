package virtualworlds.lang
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.text.Font;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.unescapeMultiByte;
   
   public class TranslationManager extends EventDispatcher
   {
      
      public static const TYPE_ID_CONTENT:int = 14;
      
      public static const GERMAN:String = "DE";
      
      private static const _instance:virtualworlds.lang.TranslationManager = new virtualworlds.lang.TranslationManager(SingletonEnforcer);
      
      public static const DUTCH:String = "NL";
      
      public static const ENGLISH:String = "EN";
      
      public static const CHINESE_SIMPLIFIED:String = "CH";
      
      public static const PORTUGUESE:String = "PT";
      
      public static const TYPE_ID_GAME:int = 4;
      
      public static const FRENCH:String = "FR";
      
      public static const SPANISH:String = "ES";
      
      public static const CHINESE_TRADITIONAL:String = "ZH";
       
      
      private var _translationXMLData:XML;
      
      private var _langCode:String;
      
      private var _translationURL:String;
      
      public const LABEL_ID:String = "txtFld";
      
      private var _gameID:int = 0;
      
      private var _loader:URLLoader;
      
      private var _typeID:int = 0;
      
      private var _shouldEmbedFonts:Boolean;
      
      private var _translationData:virtualworlds.lang.TranslationData;
      
      public function TranslationManager(param1:Class = null)
      {
         super();
         if(param1 != SingletonEnforcer)
         {
            throw new Error("Invalid Singleton access.  Use TranslationManager.instance.");
         }
         this.setupVars();
      }
      
      public static function get instance() : virtualworlds.lang.TranslationManager
      {
         return _instance;
      }
      
      private function loadTranslationData() : void
      {
         this._loader = new URLLoader();
         this._loader.addEventListener(Event.COMPLETE,this.onCompleteHandler,false,0,true);
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.catchIO);
         this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityErrorHandler,false,0,true);
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.lang = this._langCode;
         _loc1_.type_id = this._typeID;
         _loc1_.item_id = this._gameID;
         _loc1_.r = Math.random() * this._gameID;
         var _loc2_:URLRequest = new URLRequest();
         _loc2_.url = this._translationURL;
         _loc2_.data = _loc1_;
         _loc2_.method = URLRequestMethod.POST;
         this._loader.load(_loc2_);
      }
      
      private function onSecurityErrorHandler(param1:SecurityErrorEvent) : void
      {
         trace("TextManager::onSecurityErrorHandler " + param1.text);
      }
      
      private function setupVars() : void
      {
         this._translationURL = "http://www.neopets.com/transcontent/gettranslationxml.phtml";
         this._shouldEmbedFonts = true;
      }
      
      private function onCompleteHandler(param1:Event = null) : void
      {
         var _loc2_:XMLList = null;
         var _loc5_:XML = null;
         var _loc6_:XMLList = null;
         var _loc7_:String = null;
         this._translationXMLData = new XML(this._loader.data);
         if(this._translationXMLData.hasOwnProperty("errors"))
         {
            trace(this._translationXMLData.errors);
         }
         _loc2_ = this._translationXMLData.file.body.child("trans-unit");
         var _loc3_:int = _loc2_.length();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = (_loc5_ = _loc2_[_loc4_]).attribute("resname");
            _loc7_ = unescapeMultiByte(_loc5_.source);
            this._translationData[_loc6_.toString()] = _loc7_;
            _loc4_++;
         }
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function setTextField(param1:TextField, param2:String, param3:String = null, param4:TextFormat = null) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(param3)
         {
            if(param4)
            {
               param4.font = param3;
            }
            else
            {
               (param4 = param1.getTextFormat()).font = param3;
               param4.size = null;
               param4.align = null;
               param4.bold = null;
               param4.italic = null;
            }
         }
         param1.multiline = true;
         param1.wordWrap = true;
         param1.htmlText = param2;
         param1.embedFonts = this._shouldEmbedFonts;
         if(param4)
         {
            param1.setTextFormat(param4);
         }
      }
      
      public function init(param1:String, param2:int, param3:int, param4:virtualworlds.lang.TranslationData) : void
      {
         this._langCode = param1;
         this._gameID = param2;
         this._typeID = param3;
         this._translationData = param4;
         if(param1 == virtualworlds.lang.TranslationManager.CHINESE_SIMPLIFIED || param1 == virtualworlds.lang.TranslationManager.CHINESE_TRADITIONAL)
         {
            this._shouldEmbedFonts = false;
         }
         this.loadTranslationData();
      }
      
      public function set externalURLforTranslation(param1:String) : void
      {
         this._translationURL = param1;
      }
      
      private function catchIO(param1:IOErrorEvent) : void
      {
         trace("IOError " + param1.text);
      }
      
      public function get translationXMLData() : XML
      {
         return this._translationXMLData;
      }
      
      public function set translationData(param1:virtualworlds.lang.TranslationData) : void
      {
         this._translationData = param1;
      }
      
      private function checkFont(param1:String) : Boolean
      {
         var _loc2_:Array = Font.enumerateFonts(true);
         var _loc3_:uint = _loc2_.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].fontName == param1)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function getTranslationOf(param1:String) : String
      {
         if(this.translationData[param1] == null)
         {
            return param1;
         }
         return this.translationData[param1];
      }
      
      public function get translationData() : virtualworlds.lang.TranslationData
      {
         return this._translationData;
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
