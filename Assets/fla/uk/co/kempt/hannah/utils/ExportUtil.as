package uk.co.kempt.hannah.utils
{
   import com.adobe.crypto.MD5;
   import com.adobe.serialization.json.JSON;
   import com.asliceofcrazypie.geom2d.Grid;
   import com.asliceofcrazypie.geom2d.IGridSquare;
   import com.dynamicflash.util.Base64;
   import flash.utils.ByteArray;
   import uk.co.kempt.hannah.data.LevelData;
   import uk.co.kempt.hannah.data.TileDictionary;
   import uk.co.kempt.hannah.data.tiles.BlankTile;
   
   public class ExportUtil
   {
      
      private static var _keys:Array;
      
      public static const GRID_SIZE:int = 200;
      
      public static const GRID_ROWS:int = GRID_SIZE;
      
      public static const GRID_COLS:int = GRID_SIZE;
      
      private static const KEY:String = "£,$,%,^,&,#,@,!,*,?,~,z,k,x,v,t,r,n,o,1,2,3,4,5,6,7,8,9,0";
       
      
      public function ExportUtil()
      {
         super();
      }
      
      public static function export(param1:Grid, param2:LevelData) : String
      {
         var _loc6_:IGridSquare = null;
         var _loc8_:int = 0;
         var _loc3_:String = "";
         var _loc4_:Vector.<IGridSquare>;
         var _loc5_:int = int((_loc4_ = param1.getSlice(0,0,param1.width,param1.height)).length);
         var _loc7_:Vector.<String> = new Vector.<String>();
         var _loc9_:int = 0;
         while(_loc9_ < _loc5_)
         {
            _loc6_ = _loc4_[_loc9_];
            _loc8_ = TileDictionary.getTileID(_loc6_);
            _loc7_.push(keys[_loc8_]);
            _loc9_++;
         }
         _loc3_ = _loc7_.join("");
         var _loc10_:Object;
         (_loc10_ = {}).tiles = _loc3_;
         _loc10_.name = param2.name;
         _loc10_.bg = param2.background;
         _loc10_.hash = MD5.hash(_loc10_.tiles);
         var _loc11_:String = com.adobe.serialization.json.JSON.encode(_loc10_);
         var _loc12_:String = compress(_loc11_);
         var _loc13_:int = (1 - _loc12_.length / _loc11_.length) * 100;
         trace("level compression at: " + _loc13_ + "%");
         return _loc12_;
      }
      
      public static function importByString2(param1:String) : LevelData
      {
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(uncompress(param1));
         var _loc3_:String = MD5.hash(_loc2_.tiles);
         var _loc4_:LevelData = new LevelData();
         if(_loc3_ != _loc2_.hash)
         {
            trace("level checksum doesnt match");
         }
         _loc4_.grid = new Grid(GRID_COLS,GRID_ROWS,null);
         _loc4_.name = _loc2_.name;
         _loc4_.background = _loc2_.bg;
         _loc4_.grid.setSubGrid(0,0,GRID_COLS,GRID_ROWS,resizeToFit(importByString(_loc2_.tiles)));
         _loc4_.hash = _loc3_;
         return _loc4_;
      }
      
      private static function resizeToFit(param1:Vector.<IGridSquare>) : Vector.<IGridSquare>
      {
         var _loc5_:Vector.<IGridSquare> = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:int = Math.sqrt(param1.length);
         var _loc3_:int = GRID_COLS * GRID_ROWS;
         var _loc4_:int = GRID_COLS - _loc2_;
         if(param1.length > _loc3_)
         {
            param1.length = GRID_COLS * GRID_ROWS;
         }
         else if(param1.length < _loc3_)
         {
            _loc5_ = new Vector.<IGridSquare>();
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               trace(_loc6_ * _loc2_ + _loc7_);
               _loc7_ = 0;
               while(_loc7_ < _loc2_)
               {
                  _loc5_.push(param1[_loc6_ * _loc2_ + _loc7_]);
                  _loc7_++;
               }
               _loc8_ = 0;
               while(_loc8_ < _loc4_)
               {
                  _loc5_.push(new BlankTile());
                  _loc8_++;
               }
               _loc6_++;
            }
            while(_loc5_.length < _loc3_)
            {
               _loc5_.push(new BlankTile());
            }
            return _loc5_;
         }
         return param1;
      }
      
      public static function uncompress(param1:String) : String
      {
         var _loc2_:ByteArray = Base64.decodeToByteArray(param1);
         _loc2_.uncompress();
         return _loc2_.toString();
      }
      
      private static function importByString(param1:String) : Vector.<IGridSquare>
      {
         var _loc3_:Class = null;
         var _loc6_:int = 0;
         var _loc2_:Vector.<String> = Vector.<String>(param1.split(""));
         var _loc4_:Vector.<IGridSquare> = new Vector.<IGridSquare>();
         var _loc5_:int = int(_loc2_.length);
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_)
         {
            _loc6_ = keys.indexOf(_loc2_[_loc7_]);
            _loc3_ = TileDictionary.getTileClassByID(_loc6_);
            _loc4_.push(new _loc3_());
            _loc7_++;
         }
         return _loc4_;
      }
      
      public static function compress(param1:String) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         _loc2_.compress();
         return Base64.encodeByteArray(_loc2_);
      }
      
      public static function get keys() : Array
      {
         return _keys = _keys || KEY.split(",");
      }
      
      public static function validate(param1:String) : Boolean
      {
         var tJSONObject:Object = null;
         var tChecksum:String = null;
         var pString:String = param1;
         try
         {
            tJSONObject = com.adobe.serialization.json.JSON.decode(uncompress(pString));
            tChecksum = MD5.hash(tJSONObject.tiles);
            return tChecksum == tJSONObject.hash;
         }
         catch(e:Error)
         {
            return false;
         }
      }
   }
}
