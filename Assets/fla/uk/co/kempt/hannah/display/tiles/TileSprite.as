package uk.co.kempt.hannah.display.tiles
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.getQualifiedClassName;
   import virtualworlds.lang.TranslationManager;
   
   public class TileSprite extends MovieClip
   {
      
      public static const DESC:String = "_desc";
      
      public static const NAME:String = "_name";
       
      
      public var top2:Sprite;
      
      public var left:Sprite;
      
      public var left2:Sprite;
      
      public var top:Sprite;
      
      public var right2:Sprite;
      
      public var right:Sprite;
      
      public var bottom2:Sprite;
      
      public var bottom:Sprite;
      
      protected var _tileName:String;
      
      protected var _description:String;
      
      public function TileSprite()
      {
         super();
         mouseChildren = false;
         this.setOutline(false,false,false,false);
         gotoAndStop(1);
         var _loc1_:Array = getQualifiedClassName(this).split("::");
         var _loc2_:String = _loc1_.length > 1 ? String(_loc1_[1]) : String(_loc1_[0]);
         if(TranslationManager.instance.translationData.hasOwnProperty(_loc2_ + NAME))
         {
            this._tileName = TranslationManager.instance.translationData[_loc2_ + NAME];
         }
         else
         {
            this._tileName = TranslationManager.instance.translationData.unknownTileSprite_name;
         }
         if(TranslationManager.instance.translationData.hasOwnProperty(_loc2_ + DESC))
         {
            this._description = TranslationManager.instance.translationData[_loc2_ + DESC];
         }
         else
         {
            this._tileName = TranslationManager.instance.translationData.unknownTileSprite_desc;
         }
      }
      
      public function setOutline(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         this.showCrust(this.top,param1);
         this.showCrust(this.top2,param1);
         this.showCrust(this.right,param2);
         this.showCrust(this.right2,param2);
         this.showCrust(this.bottom,param3);
         this.showCrust(this.bottom2,param3);
         this.showCrust(this.left,param4);
         this.showCrust(this.left2,param4);
      }
      
      public function setVariant(param1:int) : void
      {
         gotoAndStop(1 + param1);
      }
      
      private function showCrust(param1:Sprite, param2:Boolean = true) : void
      {
         if(param1)
         {
            param1.visible = param2;
         }
      }
      
      public function get tileName() : String
      {
         return this._tileName || "Unknown";
      }
      
      public function get description() : String
      {
         return this._description || "No description available.";
      }
   }
}
