package com.neopets.util.button
{
   import com.neopets.util.general.GeneralFunctions;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.Font;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class NeopetsButton extends MovieClip implements INeopetButton
   {
       
      
      protected var mID:String;
      
      protected var mLockout:Boolean;
      
      protected var mVisibility:Boolean;
      
      public var label_txt:TextField;
      
      protected var mDefaultFormat:TextFormat;
      
      protected var mDataObject:Object;
      
      public function NeopetsButton()
      {
         super();
         this.mDefaultFormat = new TextFormat();
         if(this.label_txt != null)
         {
            this.label_txt.htmlText = "";
         }
         addEventListener(MouseEvent.MOUSE_OVER,this.onRollOver,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.onRollOut,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onDown,false,0,true);
         buttonMode = true;
         this.mLockout = false;
      }
      
      public function set lockOut(param1:Boolean) : void
      {
         this.mLockout = param1;
      }
      
      public function get dataObject() : Object
      {
         return this.mDataObject;
      }
      
      public function get displayFlag() : Boolean
      {
         return this.mVisibility;
      }
      
      public function reset() : void
      {
         gotoAndStop(1);
      }
      
      public function init(param1:Object = null, param2:String = "button", param3:Object = null) : void
      {
         this.mID = param2;
         this.mDataObject = param1;
         if(this.mDataObject.hasOwnProperty("visible"))
         {
            this.displayFlag = GeneralFunctions.convertBoolean(this.mDataObject.visible.toString());
         }
         else
         {
            this.displayFlag = true;
         }
         if(this.mDataObject.hasOwnProperty("text"))
         {
            this.label_txt.htmlText = this.mDataObject.text;
            if(this.mDataObject.hasOwnProperty("FORMAT"))
            {
               GeneralFunctions.setParamatersList(this.mDefaultFormat,this.mDataObject.FORMAT);
               if(this.mDataObject.FORMAT.hasOwnProperty("font"))
               {
                  if(this.checkFont(this.mDataObject.FORMAT.font))
                  {
                     this.mDefaultFormat.font = this.mDataObject.FORMAT.font;
                     this.label_txt.embedFonts = true;
                  }
                  else
                  {
                     this.label_txt.embedFonts = false;
                  }
               }
            }
            this.label_txt.setTextFormat(this.mDefaultFormat);
         }
         if(this.mDataObject.hasOwnProperty("scaleX"))
         {
            scaleX = this.mDataObject.scaleX.toString();
         }
         if(this.mDataObject.hasOwnProperty("scaleY"))
         {
            scaleY = this.mDataObject.scaleY.toString();
         }
      }
      
      public function set displayFlag(param1:Boolean) : void
      {
         this.mVisibility = param1;
         if(param1)
         {
            visible = true;
         }
         else
         {
            visible = false;
         }
      }
      
      protected function onDown(param1:MouseEvent) : void
      {
         if(!this.mLockout)
         {
            gotoAndStop("down");
         }
      }
      
      public function get ID() : String
      {
         return this.mID;
      }
      
      public function getText() : String
      {
         if(this.label_txt != null)
         {
            return this.label_txt.htmlText;
         }
         return null;
      }
      
      public function get lockOut() : Boolean
      {
         return this.mLockout;
      }
      
      protected function onRollOver(param1:MouseEvent) : void
      {
         if(!this.mLockout)
         {
            gotoAndStop("on");
         }
      }
      
      protected function checkFont(param1:String) : Boolean
      {
         var _loc2_:Array = Font.enumerateFonts(false);
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
      
      protected function onRollOut(param1:MouseEvent) : void
      {
         gotoAndStop("off");
      }
      
      public function set ID(param1:String) : void
      {
         this.mID = param1;
      }
      
      public function setText(param1:String) : void
      {
         if(this.label_txt != null)
         {
            this.label_txt.htmlText = param1;
            this.label_txt.setTextFormat(this.mDefaultFormat);
         }
      }
   }
}
