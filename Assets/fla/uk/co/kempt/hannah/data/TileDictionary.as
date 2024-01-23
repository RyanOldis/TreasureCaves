package uk.co.kempt.hannah.data
{
   import flash.utils.Dictionary;
   import uk.co.kempt.hannah.data.tiles.*;
   import uk.co.kempt.hannah.display.tiles.TileSprite;
   import uk.co.kempt.hannah.utils.ClassUtil;
   
   public class TileDictionary
   {
      
      public static const TILES:Vector.<Class> = Vector.<Class>([BlankTile,BlankTile,BlueKeyTile,CrateTile,BlueDoorTile,ExitTile,FuelTile,HeartTile,LevelTile,LevelTile2,OxygenTile,RobotTile,StartTile,TreasureTile,YellowKeyTile,PurpleKeyTile,YellowDoorTile,PurpleDoorTile,DownSpikeTile,HiddenLevelTile]);
      
      private static var TILE_SPRITES:Dictionary = new Dictionary();
       
      
      private var _tiles:Dictionary;
      
      private var _sprites:Dictionary;
      
      public function TileDictionary()
      {
         super();
         this.populate();
      }
      
      public static function getTileClassByID(param1:int) : Class
      {
         return TILES[param1];
      }
      
      public static function getTileID(param1:*) : int
      {
         var _loc2_:int = TILES.indexOf(ClassUtil.getClass(param1));
         if(_loc2_ == -1)
         {
            _loc2_ = TILES.indexOf(BlankTile);
         }
         return _loc2_;
      }
      
      private function getVariants(param1:Class) : Object
      {
         return TILE_SPRITES[param1] = TILE_SPRITES[param1] || {};
      }
      
      private function createVariant(param1:AbstractTile) : TileSprite
      {
         var _loc2_:Class = param1.spriteClass;
         var _loc3_:TileSprite = new _loc2_() as TileSprite;
         _loc3_.setOutline(param1.crustTop,param1.crustRight,param1.crustBottom,param1.crustLeft);
         _loc3_.setVariant(param1.variant);
         return _loc3_;
      }
      
      public function getSpriteVariant(param1:AbstractTile) : TileSprite
      {
         var _loc2_:Object = this.getVariants(param1.spriteClass);
         var _loc3_:String = this.getTileUID(param1);
         return _loc2_[_loc3_] = _loc2_[_loc3_] || this.createVariant(param1);
      }
      
      private function getTileUID(param1:AbstractTile) : String
      {
         var _loc2_:String = "uid";
         _loc2_ += param1.crustTop ? "1" : "0";
         _loc2_ += param1.crustRight ? "1" : "0";
         _loc2_ += param1.crustBottom ? "1" : "0";
         _loc2_ += param1.crustLeft ? "1" : "0";
         return _loc2_ + param1.variant.toString();
      }
      
      public function clear() : void
      {
         TILE_SPRITES = new Dictionary();
      }
      
      private function populate() : void
      {
         this._tiles = new Dictionary();
         this._sprites = new Dictionary();
         TILES.forEach(this.storeTileData);
      }
      
      public function getTileClass(param1:Class) : Class
      {
         return this._sprites[param1];
      }
      
      private function storeTileData(param1:Class, param2:int, param3:Vector.<Class>) : void
      {
         var _loc4_:AbstractTile = new param1() as AbstractTile;
         this._sprites[_loc4_.spriteClass] = param1;
         this._tiles[param1] = _loc4_.spriteClass;
      }
      
      public function getSpriteClass(param1:Class) : Class
      {
         return this._tiles[param1];
      }
   }
}
