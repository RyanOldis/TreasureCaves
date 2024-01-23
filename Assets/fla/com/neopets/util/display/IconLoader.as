package com.neopets.util.display
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   
   public class IconLoader extends MovieClip
   {
       
      
      protected var _imgWidth:Number;
      
      protected var _loader:Loader;
      
      protected var _imgHeight:Number;
      
      protected var _req:URLRequest;
      
      public function IconLoader()
      {
         super();
         this._imgHeight = 32;
         this._imgWidth = 32;
      }
      
      public function get iconHeight() : Number
      {
         return this._imgHeight;
      }
      
      public function set iconWidth(param1:Number) : void
      {
         this._imgWidth = param1;
         this.updateIcon();
      }
      
      public function clearIcon() : void
      {
         this._req = null;
         if(this._loader != null)
         {
            removeChild(this._loader);
            this._loader = null;
         }
      }
      
      public function set iconHeight(param1:Number) : void
      {
         this._imgHeight = param1;
         this.updateIcon();
      }
      
      protected function onImgLoaded(param1:Event) : void
      {
         this.updateIcon();
      }
      
      public function get iconWidth() : Number
      {
         return this._imgWidth;
      }
      
      public function loadFrom(param1:String) : void
      {
         this.clearIcon();
         this._req = new URLRequest(param1);
         this._loader = new Loader();
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onImgLoaded);
         addChild(this._loader);
         this._loader.load(this._req);
      }
      
      public function updateIcon() : void
      {
         var _loc1_:Rectangle = null;
         if(this._loader != null)
         {
            this._loader.scaleX = Math.min(this._imgHeight / this._loader.height,this._imgWidth / this._loader.width);
            this._loader.scaleY = this._loader.scaleX;
            _loc1_ = this._loader.getBounds(this);
            this._loader.x = -(_loc1_.left + _loc1_.width / 2);
            this._loader.y = -(_loc1_.top + _loc1_.height / 2);
         }
      }
   }
}
