package uk.co.kempt.hannah.display
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.NetConnection;
   import flash.net.Responder;
   import flash.text.TextField;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.Game;
   import uk.co.kempt.hannah.data.LevelData;
   import uk.co.kempt.hannah.gui.Interface.LevelPreviewScreen;
   import uk.co.kempt.hannah.gui.buttons.LevelButton;
   import uk.co.kempt.utils.GarbageUtil;
   
   public class LevelChooser extends Sprite
   {
      
      public static const TOP_ROW_Y:int = 45;
      
      private static var INSTANCE:uk.co.kempt.hannah.display.LevelChooser;
      
      public static const ROW_SPACE_Y:int = 24;
      
      public static const MENU_LEVEL_PREVIEW:String = "mLevelPreviewScreen";
       
      
      public var mc_nolevels:MovieClip;
      
      private var responder:Responder;
      
      public var load_btn:SimpleButton;
      
      public var tf_username:TextField;
      
      public var mc_lock0:MovieClip;
      
      private var _udata:Array;
      
      private var _host_url:String = "http://www.neopets.com";
      
      public var btn_dnArrow:SimpleButton;
      
      public var mc_txt_enterusername:MovieClip;
      
      private var _buttons:Vector.<LevelButton>;
      
      private var gateway:String = "/amfphp/gateway.php";
      
      public var btn_upArrow:SimpleButton;
      
      public var mc_txt_username:MovieClip;
      
      private var _ubuttons:Vector.<LevelButton>;
      
      public var mc_txt_or:MovieClip;
      
      private var connection:NetConnection;
      
      public var mc_username_box:MovieClip;
      
      public var mc_lock1:MovieClip;
      
      public var mc_lock2:MovieClip;
      
      public function LevelChooser()
      {
         super();
         INSTANCE = this;
         mouseEnabled = false;
         this._buttons = new Vector.<LevelButton>();
         this._ubuttons = new Vector.<LevelButton>();
         this._udata = new Array();
         this.tf_username.text = "";
         this.btn_upArrow.addEventListener(MouseEvent.CLICK,this.onBtnUp,false);
         this.btn_dnArrow.addEventListener(MouseEvent.CLICK,this.onBtnDn,false);
         this.load_btn.addEventListener(MouseEvent.CLICK,this.onUserLoadClick,false);
      }
      
      public static function get instance() : uk.co.kempt.hannah.display.LevelChooser
      {
         return INSTANCE;
      }
      
      private function onLoadUserResult(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:LevelButton = null;
         this._ubuttons = new Vector.<LevelButton>();
         this._udata = new Array();
         trace("onLoadUserResult RESULT = " + param1);
         if(!param1)
         {
            this.mc_nolevels.visible = true;
         }
         else
         {
            for(_loc2_ in param1)
            {
               trace(_loc2_ + ".LEVEL NAME = " + param1[_loc2_].name);
               _loc3_ = new LevelButton();
               _loc3_.x = 84;
               _loc3_.y = TOP_ROW_Y + _loc2_ * ROW_SPACE_Y;
               _loc3_.label = param1[_loc2_].name;
               _loc3_.addEventListener(MouseEvent.CLICK,this.onUserButtonClicked,false,0,true);
               this._ubuttons.push(_loc3_);
               this._udata.push(param1[_loc2_].data);
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
      
      private function hideLocks() : *
      {
         this.mc_lock1.visible = false;
         this.mc_lock2.visible = false;
         this.mc_lock0.visible = false;
      }
      
      private function onUserLoadClick(param1:Object) : *
      {
         var _loc3_:* = undefined;
         var _loc2_:String = this.tf_username.text;
         this.btn_upArrow.visible = false;
         this.btn_dnArrow.visible = false;
         for(_loc3_ in this._buttons)
         {
            this._buttons[_loc3_].visible = false;
         }
         for(_loc3_ in this._ubuttons)
         {
            this._ubuttons[_loc3_].visible = false;
         }
         this.mc_nolevels.visible = false;
         this.responder = new Responder(this.onLoadUserResult,this.onLoadUserFault);
         this.connection = new NetConnection();
         this.connection.connect(this._host_url + this.gateway);
         this.connection.call("HannahKreludorService.loadUser",this.responder,_loc2_);
      }
      
      private function onLoadUserFault(param1:Object) : *
      {
         trace("LOADUSER FAULT!");
      }
      
      protected function addButton(param1:int, param2:String) : void
      {
         var _loc6_:* = undefined;
         var _loc3_:Number = 84;
         var _loc4_:Number = TOP_ROW_Y + (param1 - 1) * ROW_SPACE_Y;
         var _loc5_:LevelButton;
         (_loc5_ = new LevelButton()).x = _loc3_;
         _loc5_.y = _loc4_;
         if(_loc4_ > TOP_ROW_Y + ROW_SPACE_Y * 7 || _loc4_ < TOP_ROW_Y)
         {
            _loc5_.visible = false;
         }
         else
         {
            _loc5_.visible = true;
         }
         _loc5_.label = param2;
         _loc5_.addEventListener(MouseEvent.CLICK,this.onButtonClicked,false,0,true);
         this._buttons.push(_loc5_);
         if(Engine.instance.progressData)
         {
            if(Engine.instance.progressData.level < param1)
            {
               _loc5_.disable();
               _loc5_.removeEventListener(MouseEvent.CLICK,this.onButtonClicked);
            }
         }
         else
         {
            trace("no progress data");
         }
         addChild(_loc5_);
         for(_loc6_ in this._ubuttons)
         {
            removeChild(this._ubuttons.pop());
         }
      }
      
      private function onUsernameFault(param1:Object) : *
      {
         trace("USERNAME FAULT!");
      }
      
      private function onUsernameResult(param1:Object) : void
      {
         var _loc2_:* = undefined;
         trace("onUsernameResult RESULT = " + param1.username);
         for(_loc2_ in param1)
         {
            trace("      - " + _loc2_ + " :: " + param1[_loc2_]);
         }
         if(param1.username != null)
         {
            this.tf_username.text = param1.username;
         }
         else
         {
            trace("USERNAME = NULL");
         }
      }
      
      public function refresh() : void
      {
         var _loc2_:String = null;
         this.hideLocks();
         trace("REFRESH :: a");
         this.clearButtons();
         trace("REFRESH :: b");
         this.load_btn.visible = true;
         trace("REFRESH :: c");
         this.tf_username.visible = true;
         trace("REFRESH :: d");
         this.btn_upArrow.visible = true;
         trace("REFRESH :: e");
         this.btn_dnArrow.visible = true;
         trace("REFRESH :: f");
         this.tf_username.text = "";
         trace("REFRESH :: g");
         this.mc_nolevels.visible = false;
         trace("REFRESH :: h");
         var _loc1_:int = 1;
         while(_loc1_ <= LevelData.TOTAL_NUMBER_OF_LEVELS)
         {
            _loc2_ = _loc1_.toString() + ": " + LevelData.getName(_loc1_);
            this.addButton(_loc1_,_loc2_);
            _loc1_++;
         }
         trace("REFRESH :: i");
         this.responder = new Responder(this.onUsernameResult,this.onUsernameFault);
         this.connection = new NetConnection();
         this.connection.connect(this._host_url + this.gateway);
         trace("CALLING UserService.getUser");
         this.connection.call("UserService.getUser",this.responder);
      }
      
      private function onBtnDn(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         trace("BTN DNS!!");
         if(this._buttons[this._buttons.length - 1].y > TOP_ROW_Y + ROW_SPACE_Y * 7)
         {
            for(_loc2_ in this._buttons)
            {
               this._buttons[_loc2_].y -= ROW_SPACE_Y;
               if(this._buttons[_loc2_].y > TOP_ROW_Y + ROW_SPACE_Y * 7 || this._buttons[_loc2_].y < TOP_ROW_Y)
               {
                  this._buttons[_loc2_].visible = false;
               }
               else
               {
                  this._buttons[_loc2_].visible = true;
               }
            }
         }
      }
      
      private function onUserButtonClicked(param1:MouseEvent) : void
      {
         var _loc2_:LevelButton = param1.currentTarget as LevelButton;
         var _loc3_:int = this._ubuttons.indexOf(_loc2_);
         trace("LEVEL DATA = " + this._udata[_loc3_]);
         Engine.setCurrentLevel(9999);
         Engine.setCurrentLevelData(this._udata[_loc3_]);
         LevelPreviewScreen(Game.instance.menuManager.getMenuScreen(MENU_LEVEL_PREVIEW)).createPreview(9999,_loc2_.label);
         Game.instance.menuManager.menuNavigation(MENU_LEVEL_PREVIEW);
      }
      
      private function clearButtons() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._buttons.length)
         {
            GarbageUtil.kill(this._buttons[_loc1_]);
            _loc1_++;
         }
         this._buttons = new Vector.<LevelButton>();
      }
      
      private function onButtonClicked(param1:MouseEvent) : void
      {
         var _loc2_:LevelButton = param1.currentTarget as LevelButton;
         var _loc3_:int = this._buttons.indexOf(_loc2_);
         Game.instance.selectLevelByNumber(_loc3_ + 1);
      }
      
      private function onBtnUp(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         trace("BTN UP!");
         if(this._buttons[0].y < TOP_ROW_Y)
         {
            for(_loc2_ in this._buttons)
            {
               this._buttons[_loc2_].y += ROW_SPACE_Y;
               if(this._buttons[_loc2_].y > TOP_ROW_Y + ROW_SPACE_Y * 7 || this._buttons[_loc2_].y < TOP_ROW_Y)
               {
                  this._buttons[_loc2_].visible = false;
               }
               else
               {
                  this._buttons[_loc2_].visible = true;
               }
            }
         }
      }
   }
}
