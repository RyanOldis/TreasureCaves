package uk.co.kempt.hannah.display
{
   import com.neopets.projects.gameEngine.gui.buttons.SelectedButton;
   import fl.events.*;
   import fl.transitions.Tween;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.net.NetConnection;
   import flash.net.Responder;
   import flash.system.System;
   import flash.text.TextField;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.LevelEditor;
   import uk.co.kempt.hannah.data.LevelData;
   import uk.co.kempt.hannah.gui.buttons.LevelButton;
   import uk.co.kempt.hannah.utils.ExportUtil;
   import virtualworlds.lang.TranslationData;
   import virtualworlds.lang.TranslationManager;
   
   public class EditorPages extends MovieClip
   {
      
      public static const HOME:String = "home";
      
      public static const EXIT:String = "exit";
      
      public static const LOAD_SAVED:String = "loadSaved";
      
      public static const LOAD_PREVIEW:String = "loadPreview";
      
      public static const TOP_ROW_Y:int = 220;
      
      public static const SAVE_SLOTS:String = "saveslots";
      
      public static const PREVIEW:String = "preview";
      
      public static const ROW_SPACE_Y:int = 24;
      
      public static const PASTE2:String = "paste2";
      
      public static const SAVE_FAIL:String = "savefail";
      
      public static const SAVE_MENU:String = "savemenu";
      
      public static const INSTRUCTIONS:String = "instructions";
      
      public static const LOAD:String = "load";
      
      public static const INSTRUCTIONS3:String = "instructions3";
      
      public static const INSTRUCTIONS4:String = "instructions4";
      
      public static const SAVE_SUCCESS:String = "savesuccess";
      
      public static const PASTE:String = "paste";
      
      public static const INSTRUCTIONS2:String = "instructions2";
      
      public static const COPY_CODE:String = "copycode";
      
      public static const BLANK:String = "blank";
       
      
      public var r_btn_0:SimpleButton;
      
      public var r_btn_1:SimpleButton;
      
      public var back_btn:SimpleButton;
      
      public var loadInProgressLevel_btn:SimpleButton;
      
      public var next_btn:SimpleButton;
      
      public var r_btn_2:SimpleButton;
      
      public var invalidMessage:Sprite;
      
      public var soundToggleBtn:SelectedButton;
      
      private var responder:Responder;
      
      public var r_hi_0:MovieClip;
      
      public var r_hi_2:MovieClip;
      
      public var r_hi_1:MovieClip;
      
      public var loadPastedLevel_btn:SimpleButton;
      
      private var gateway:String = "/amfphp/gateway.php";
      
      private var _currentValidatedButton:SimpleButton;
      
      public var mc_xmark1:MovieClip;
      
      public var data_txt:TextField;
      
      public var mc_xmark2:MovieClip;
      
      public var newLevel_btn:SimpleButton;
      
      public var preview_btn:SimpleButton;
      
      public var mc_xmark0:MovieClip;
      
      public var input_txt_1:TextField;
      
      public var input_txt_0:TextField;
      
      public var input_txt_2:TextField;
      
      public var title_txt_0:TextField;
      
      public var title_txt_1:TextField;
      
      public var mc_lock0:MovieClip;
      
      public var mc_lock1:MovieClip;
      
      public var mc_lock2:MovieClip;
      
      public var load_btn:SimpleButton;
      
      public var title_txt_2:TextField;
      
      private var _editor:LevelEditor;
      
      public var close_btn:SimpleButton;
      
      public var save_btn:SimpleButton;
      
      private var _messageAlphaTween:Tween;
      
      public var copyCode_btn:SimpleButton;
      
      private var _udata:Array;
      
      public var copiedMessage:Sprite;
      
      public var btn_checkbox1:SimpleButton;
      
      public var btn_checkbox2:SimpleButton;
      
      public var btn_checkbox0:SimpleButton;
      
      private var _host_url:String = "http://www.neopets.com";
      
      public var exit_btn:SimpleButton;
      
      public var slot_selected:int;
      
      public var musicToggleBtn:SelectedButton;
      
      public var back3_btn:SimpleButton;
      
      private var _ubuttons:Vector.<LevelButton>;
      
      public var loadLevel_btn:SimpleButton;
      
      private var connection:NetConnection;
      
      public var loadSavedLevel_btn:SimpleButton;
      
      public var mc_noLevelsFound:MovieClip;
      
      private var _currentPage:String;
      
      public function EditorPages()
      {
         super();
         this.show(HOME);
      }
      
      private function onSaveToServerClicked(param1:MouseEvent) : void
      {
         trace("SAVE TO SERVER MENU");
         this.show(SAVE_SLOTS);
      }
      
      private function onLoadLevelClicked(param1:MouseEvent) : void
      {
         this.show(LOAD);
      }
      
      private function onSaveSlotsResult(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:TranslationData = null;
         trace("onSaveSlotsResult RESULT = " + param1);
         trace("timestamp 2010.10.18 2:38");
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               trace("RESULT Slot" + _loc2_ + " = " + param1[_loc2_]);
               if(param1[_loc2_])
               {
                  trace("   - true");
                  if(param1[_loc2_].name)
                  {
                     trace("TXT:" + _loc2_);
                     this["input_txt_" + _loc2_].text = param1[_loc2_].name;
                     this["title_txt_" + _loc2_].text = param1[_loc2_].name;
                  }
               }
               else
               {
                  trace("   - false");
                  this["input_txt_" + _loc2_].text = "";
                  _loc3_ = new TranslationData();
                  _loc3_ = TranslationManager.instance.translationData;
                  TranslationManager.instance.setTextField(this["title_txt_" + _loc2_],_loc3_.IDS_EMPTY_SLOT);
                  trace("TRANSLATION SYSTEM: IDS_EMPTY_SLOT = " + _loc3_.IDS_EMPTY_SLOT);
                  trace("TEXTBOX: title_txt_" + _loc2_ + " = " + this["title_txt_" + _loc2_].text);
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               trace("   - false2");
               this["input_txt_" + _loc2_].text = "";
               _loc3_ = new TranslationData();
               _loc3_ = TranslationManager.instance.translationData;
               TranslationManager.instance.setTextField(this["title_txt_" + _loc2_],_loc3_.IDS_EMPTY_SLOT);
               trace("TRANSLATION SYSTEM: IDS_EMPTY_SLOT = " + _loc3_.IDS_EMPTY_SLOT);
               trace("TEXTBOX: title_txt_" + _loc2_ + " = " + this["title_txt_" + _loc2_].text);
               _loc2_++;
            }
         }
      }
      
      private function onLoadClicked(param1:MouseEvent) : void
      {
         switch(this._currentPage)
         {
            case PASTE:
               Engine.setCurrentLevelData(this.data_txt.text);
               this.show(INSTRUCTIONS);
               this.editor.loadCurrentLevel();
               break;
            case LOAD_PREVIEW:
               this.show(BLANK);
               this.editor.loadCurrentLevel();
               break;
            case PASTE2:
               Engine.setCurrentLevelData(this.data_txt.text);
               this.show(BLANK);
               this.editor.loadCurrentLevel();
         }
      }
      
      private function onLoadPastedLevelClicked(param1:MouseEvent) : void
      {
         this.show(PASTE);
      }
      
      private function onResult_saveLevelData(param1:Object) : *
      {
         if(param1)
         {
            trace("SAVE SUCCESSFUL!");
            this.show(SAVE_SUCCESS);
         }
         else
         {
            trace("SAVE FAILED!");
            this.show(SAVE_FAIL);
         }
      }
      
      private function onReturnClicked(param1:MouseEvent) : void
      {
         this.show(HOME);
      }
      
      private function setupLoadSaved() : void
      {
         this.hideLocks();
         this.mc_noLevelsFound.visible = false;
         this.responder = new Responder(this.onLoadLevelsResult,this.onLoadLevelsFault);
         this.connection = new NetConnection();
         this.connection.connect(this._host_url + this.gateway);
         this.connection.call("HannahKreludorService.loadUser",this.responder);
      }
      
      private function onLoadSavedLevelClicked(param1:MouseEvent) : void
      {
         this.show(LOAD_SAVED);
      }
      
      private function onLoadLevelsFault(param1:Object) : *
      {
         trace("LOADLEVELS FAULT!");
      }
      
      private function onUsernameResult(param1:Object) : void
      {
         trace("onUsernameResult RESULT = " + param1.username);
         if(param1.username != null)
         {
            this.save_btn.enabled = true;
            this.save_btn.alpha = 1;
            this.save_btn.addEventListener(MouseEvent.CLICK,this.onSaveToServerClicked,false,0,true);
         }
         else
         {
            trace("USERNAME = NULL");
         }
      }
      
      private function checkBtnClicked(param1:MouseEvent) : *
      {
         trace("CHECK BTN CLICKED: ");
         this.mc_xmark2.visible = !this.mc_xmark2.visible;
      }
      
      private function onLoadInProgressLevelClicked(param1:MouseEvent) : void
      {
         Engine.setCurrentLevelData(this.editor.getLocalData());
         this.show(LOAD_PREVIEW);
      }
      
      private function onNextClicked(param1:MouseEvent) : void
      {
         switch(this._currentPage)
         {
            case INSTRUCTIONS:
               this.show(INSTRUCTIONS2);
               break;
            case INSTRUCTIONS2:
               this.show(INSTRUCTIONS3);
               break;
            case INSTRUCTIONS3:
               this.show(INSTRUCTIONS4);
               break;
            default:
               this.show(BLANK);
         }
      }
      
      private function onPageChange() : void
      {
         switch(this._currentPage)
         {
            case HOME:
               this.newLevel_btn.addEventListener(MouseEvent.CLICK,this.onNewLevelClicked,false,0,true);
               this.loadLevel_btn.addEventListener(MouseEvent.CLICK,this.onLoadLevelClicked,false,0,true);
               this.back_btn.addEventListener(MouseEvent.CLICK,this.onExitClicked,false,0,true);
               break;
            case LOAD:
               this.enableButton(this.loadInProgressLevel_btn,this.onLoadInProgressLevelClicked,!!this.editor.getLocalData() ? true : false);
               this.enableButton(this.loadSavedLevel_btn,this.onLoadSavedLevelClicked,true);
               this.loadPastedLevel_btn.addEventListener(MouseEvent.CLICK,this.onLoadPastedLevelClicked,false,0,true);
               this.back_btn.addEventListener(MouseEvent.CLICK,this.onExitClicked,false,0,true);
               break;
            case LOAD_PREVIEW:
               this.back_btn.addEventListener(MouseEvent.CLICK,this.onBackClicked,false,0,true);
               this.load_btn.addEventListener(MouseEvent.CLICK,this.onLoadClicked,false,0,true);
               break;
            case PASTE:
               this.data_txt.text = "";
               this.invalidMessage.visible = false;
               this.enableDataChecking(this.data_txt,this.load_btn);
               this.back_btn.addEventListener(MouseEvent.CLICK,this.onReturnClicked,false,0,true);
               this.load_btn.addEventListener(MouseEvent.CLICK,this.onLoadClicked,false,0,true);
               break;
            case INSTRUCTIONS:
            case INSTRUCTIONS2:
            case INSTRUCTIONS3:
            case INSTRUCTIONS4:
               this.close_btn.addEventListener(MouseEvent.CLICK,this.onCloseClicked,false,0,true);
               this.next_btn.addEventListener(MouseEvent.CLICK,this.onNextClicked,false,0,true);
               this.back_btn.addEventListener(MouseEvent.CLICK,this.onBackClicked,false,0,true);
               break;
            case PASTE2:
               this.data_txt.text = "";
               this.invalidMessage.visible = false;
               this.enableDataChecking(this.data_txt,this.load_btn);
               this.close_btn.addEventListener(MouseEvent.CLICK,this.onCloseClicked,false,0,true);
               this.load_btn.addEventListener(MouseEvent.CLICK,this.onLoadClicked,false,0,true);
               break;
            case COPY_CODE:
               this.close_btn.addEventListener(MouseEvent.CLICK,this.onCloseClicked,false,0,true);
               this.copyCode_btn.addEventListener(MouseEvent.CLICK,this.onCopyCodeClicked,false,0,true);
               this.data_txt.text = "";
               this.data_txt.text = ExportUtil.export(Engine.instance.grid,Engine.instance.currentLevelData);
               this.data_txt.addEventListener(MouseEvent.CLICK,this.onTextFocusSelectAll,false,0,true);
               this.copiedMessage.alpha = 0;
               break;
            case PREVIEW:
               this.close_btn.addEventListener(MouseEvent.CLICK,this.onCloseClicked,false,0,true);
               this.preview_btn.addEventListener(MouseEvent.CLICK,this.onPreviewClicked,false,0,true);
               break;
            case EXIT:
               this.close_btn.addEventListener(MouseEvent.CLICK,this.onCloseClicked,false,0,true);
               this.exit_btn.addEventListener(MouseEvent.CLICK,this.onExitClicked,false,0,true);
               break;
            case SAVE_MENU:
               trace("SAVE MENU::a");
               this.copyCode_btn.addEventListener(MouseEvent.CLICK,this.onCopyCodeScreenClicked,false,0,true);
               trace("SAVE MENU::b");
               this.back_btn.addEventListener(MouseEvent.CLICK,this.onCloseClicked,false,0,true);
               trace("SAVE MENU::c");
               this.save_btn.enabled = false;
               trace("SAVE MENU::d");
               this.save_btn.alpha = 0.5;
               trace("SAVE MENU::e");
               this.saveMenuInit();
               break;
            case SAVE_SLOTS:
               this.saveSlotsInit();
               this.r_btn_0.addEventListener(MouseEvent.CLICK,function(param1:*):*
               {
                  radioBtnClicked(0);
               },false,0,true);
               this.r_btn_1.addEventListener(MouseEvent.CLICK,function(param1:*):*
               {
                  radioBtnClicked(1);
               },false,0,true);
               this.r_btn_2.addEventListener(MouseEvent.CLICK,function(param1:*):*
               {
                  radioBtnClicked(2);
               },false,0,true);
               this.btn_checkbox2.addEventListener(MouseEvent.CLICK,this.checkBtnClicked,false,0,true);
               this.radioBtnClicked(0);
               this.mc_xmark2.visible = false;
               this.save_btn.addEventListener(MouseEvent.CLICK,this.onSaveLevelDataToServerClicked,false,0,true);
               this.back_btn.addEventListener(MouseEvent.CLICK,this.onBackToMenuClicked,false,0,true);
               break;
            case SAVE_FAIL:
            case SAVE_SUCCESS:
               this.copyCode_btn.addEventListener(MouseEvent.CLICK,this.onCopyCodeScreenClicked,false,0,true);
               this.back3_btn.addEventListener(MouseEvent.CLICK,this.onExitClicked,false,0,true);
               break;
            case LOAD_SAVED:
               this.back_btn.addEventListener(MouseEvent.CLICK,this.onBackClicked,false,0,true);
               this.setupLoadSaved();
         }
         Engine.instance.inputManager.inputEnabled = this._currentPage == BLANK;
      }
      
      private function onUserButtonClicked(param1:MouseEvent) : void
      {
         var _loc2_:LevelButton = param1.currentTarget as LevelButton;
         var _loc3_:int = this._ubuttons.indexOf(_loc2_);
         trace("LEVEL DATA = " + this._udata[_loc3_]);
         Engine.setCurrentLevelData(this._udata[_loc3_]);
         this.show(BLANK);
         this.editor.loadCurrentLevel();
         var _loc4_:int = int(this._ubuttons.length);
         var _loc5_:* = 0;
         while(_loc5_ < _loc4_)
         {
            removeChild(this._ubuttons.pop());
            _loc5_++;
         }
      }
      
      private function onDataTextFieldChanged(param1:Event) : void
      {
         var _loc2_:TextField = param1.currentTarget as TextField;
         var _loc3_:Boolean = ExportUtil.validate(_loc2_.text);
         if(this._currentValidatedButton)
         {
            this.enableButton(this._currentValidatedButton,null,_loc3_);
         }
         if(this.invalidMessage)
         {
            this.invalidMessage.visible = !_loc3_;
         }
      }
      
      private function onLoadLevelsResult(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:LevelButton = null;
         trace("onLoadLevelsResult RESULT = " + param1);
         this._ubuttons = new Vector.<LevelButton>();
         this._udata = new Array();
         if(!param1)
         {
            this.mc_noLevelsFound.visible = true;
         }
         else
         {
            for(_loc2_ in param1)
            {
               trace(_loc2_ + ".LEVEL NAME = " + param1[_loc2_].name);
               _loc3_ = new LevelButton();
               trace("B");
               _loc3_.x = 120;
               trace("C");
               _loc3_.y = TOP_ROW_Y + (_loc2_ - 1) * ROW_SPACE_Y;
               trace("D");
               _loc3_.label = param1[_loc2_].name;
               trace("E");
               _loc3_.addEventListener(MouseEvent.CLICK,this.onUserButtonClicked,false,0,true);
               trace("F");
               this._ubuttons.push(_loc3_);
               trace("G");
               this._udata.push(param1[_loc2_].data);
               trace("H");
               addChild(_loc3_);
               if(param1[_loc2_].visible == 0)
               {
                  this["mc_lock" + _loc2_].visible = true;
               }
               else
               {
                  this["mc_lock" + _loc2_].visible = false;
               }
            }
         }
      }
      
      public function get editor() : LevelEditor
      {
         return this._editor;
      }
      
      private function onBackToMenuClicked(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         this.r_btn_0.removeEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            radioBtnClicked(0);
         });
         this.r_btn_1.removeEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            radioBtnClicked(1);
         });
         this.r_btn_2.removeEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            radioBtnClicked(2);
         });
         this.back_btn.removeEventListener(MouseEvent.CLICK,this.onBackToMenuClicked);
         this.save_btn.removeEventListener(MouseEvent.CLICK,this.onSaveLevelDataToServerClicked);
         this.show(SAVE_MENU);
      }
      
      private function onFault(param1:Object) : void
      {
         trace("onSaveSlotsResult Fault = " + param1);
      }
      
      private function hideLocks() : *
      {
         this.mc_lock1.visible = false;
         this.mc_lock2.visible = false;
         this.mc_lock0.visible = false;
      }
      
      private function onCloseClicked(param1:MouseEvent) : void
      {
         this.show(BLANK);
      }
      
      private function onSaveLevelDataToServerClicked(param1:MouseEvent) : *
      {
         var _levelName:String;
         var _levelIsVisible:Boolean;
         var _levelString:String;
         var e:MouseEvent = param1;
         this.r_btn_0.removeEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            radioBtnClicked(0);
         });
         this.r_btn_1.removeEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            radioBtnClicked(1);
         });
         this.r_btn_2.removeEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            radioBtnClicked(2);
         });
         _levelString = ExportUtil.export(Engine.instance.grid,Engine.instance.currentLevelData);
         _levelName = String(this["input_txt_" + this.slot_selected].text);
         _levelIsVisible = this.mc_xmark2.visible;
         this.responder = new Responder(this.onResult_saveLevelData,this.onFault_saveLevelData);
         this.connection = new NetConnection();
         this.connection.connect(this._host_url + this.gateway);
         trace("SENDING DATA: " + _levelString + " , " + this.slot_selected + " , " + _levelName + " , " + _levelIsVisible);
         this.connection.call("HannahKreludorService.saveLevel",this.responder,_levelString,this.slot_selected,_levelName,_levelIsVisible);
      }
      
      private function radioBtnClicked(param1:int) : *
      {
         trace("RADIO BTN CLICKED: " + param1);
         var _loc2_:int = 0;
         while(_loc2_ <= 2)
         {
            if(param1 == _loc2_)
            {
               this["r_hi_" + _loc2_].visible = true;
               this["r_btn_" + _loc2_].enabled = false;
               this["input_txt_" + _loc2_].visible = true;
               this.slot_selected = _loc2_;
            }
            else
            {
               this["r_hi_" + _loc2_].visible = false;
               this["r_btn_" + _loc2_].enabled = true;
               this["input_txt_" + _loc2_].visible = false;
            }
            _loc2_++;
         }
         trace("    - Slot selected:" + this.slot_selected);
      }
      
      private function onCopyCodeScreenClicked(param1:MouseEvent) : void
      {
         this.show(COPY_CODE);
      }
      
      private function enableButton(param1:SimpleButton, param2:Function, param3:Boolean) : void
      {
         if(param3 && Boolean(param2))
         {
            param1.addEventListener(MouseEvent.CLICK,param2,false,0,true);
         }
         param1.alpha = param3 ? 1 : 0.5;
         param1.enabled = param1.mouseEnabled = param3;
      }
      
      private function onFault_saveLevelData(param1:Object) : *
      {
         trace("SAVE FAULT!");
      }
      
      public function get currentPage() : String
      {
         return this._currentPage;
      }
      
      private function saveMenuInit() : *
      {
         this.responder = new Responder(this.onUsernameResult,this.onFault);
         this.connection = new NetConnection();
         this.connection.connect(this._host_url + this.gateway);
         this.connection.call("UserService.getUser",this.responder);
      }
      
      private function enableDataChecking(param1:TextField, param2:SimpleButton) : void
      {
         this._currentValidatedButton = param2;
         if(param2)
         {
            this.enableButton(param2,null,false);
         }
         param1.addEventListener(Event.CHANGE,this.onDataTextFieldChanged,false,0,true);
      }
      
      private function onExitClicked(param1:MouseEvent) : void
      {
         Engine.PREVIEW = false;
         Engine.instance.exitToMenu();
      }
      
      private function onNewLevelClicked(param1:MouseEvent) : void
      {
         Engine.setCurrentLevelData(LevelData.LEVEL_NEW);
         this.show(INSTRUCTIONS);
         this.editor.loadCurrentLevel();
      }
      
      private function onCopyCodeClicked(param1:MouseEvent) : void
      {
         if(this._messageAlphaTween)
         {
            this._messageAlphaTween.stop();
         }
         System.setClipboard(this.data_txt.text);
         this.copiedMessage.alpha = 1;
         this._messageAlphaTween = new Tween(this.copiedMessage,"alpha",null,1,0,Engine.GAME_FRAMERATE * 2);
      }
      
      private function saveSlotsInit() : *
      {
         this.responder = new Responder(this.onSaveSlotsResult,this.onFault);
         this.connection = new NetConnection();
         this.connection.connect(this._host_url + this.gateway);
         this.connection.call("HannahKreludorService.loadUser",this.responder);
      }
      
      private function onTextFocusSelectAll(param1:Event) : void
      {
         var _loc2_:TextField = param1.currentTarget as TextField;
         _loc2_.setSelection(0,int.MAX_VALUE);
      }
      
      public function set editor(param1:LevelEditor) : void
      {
         this._editor = param1;
      }
      
      private function onBackClicked(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         switch(this._currentPage)
         {
            case LOAD_PREVIEW:
               this.show(LOAD);
               break;
            case LOAD_SAVED:
               _loc2_ = int(this._ubuttons.length);
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  removeChild(this._ubuttons.pop());
                  _loc3_++;
               }
               this.show(LOAD);
               break;
            case INSTRUCTIONS:
               break;
            case INSTRUCTIONS2:
               this.show(INSTRUCTIONS);
               break;
            case INSTRUCTIONS3:
               this.show(INSTRUCTIONS2);
               break;
            case INSTRUCTIONS4:
               this.show(INSTRUCTIONS3);
         }
      }
      
      public function show(param1:String) : void
      {
         this._currentPage = param1;
         gotoAndStop(this._currentPage);
         this.onPageChange();
      }
      
      private function onPreviewClicked(param1:MouseEvent) : void
      {
         this.show(BLANK);
         this.editor.preview();
      }
   }
}
