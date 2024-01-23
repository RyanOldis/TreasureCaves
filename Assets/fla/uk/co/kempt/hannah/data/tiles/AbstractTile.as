package uk.co.kempt.hannah.data.tiles
{
   import com.asliceofcrazypie.geom2d.IGridSquare;
   import com.asliceofcrazypie.tilerenderer.ITile;
   import flash.display.Sprite;
   import uk.co.kempt.hannah.Engine;
   import uk.co.kempt.hannah.world.SolidBlock;
   import uk.co.kempt.hannah.world.WorldObject;
   
   public class AbstractTile implements ITile, IGridSquare
   {
       
      
      public var variant:int = 0;
      
      public var crustTop:Boolean = true;
      
      public var crustBottom:Boolean;
      
      public var crustRight:Boolean;
      
      public var crustLeft:Boolean;
      
      private var _gameObject:Object;
      
      private var _associates:Vector.<uk.co.kempt.hannah.data.tiles.AbstractTile>;
      
      public function AbstractTile()
      {
         super();
      }
      
      public function get fillWidth() : int
      {
         return 1;
      }
      
      public function get crustingGroup() : int
      {
         return -1;
      }
      
      public function getTileDisplayObj(param1:Number, param2:Number) : *
      {
         if(this.renderable && !Engine.EDIT)
         {
            return Sprite;
         }
         return this.crusting ? Engine.instance.tileDictionary.getSpriteVariant(this) : this.spriteClass;
      }
      
      public function get gameObject() : Object
      {
         return this._gameObject = this._gameObject || (!!this.gameClass ? this.createGameObject() : null);
      }
      
      public function get unique() : Boolean
      {
         return false;
      }
      
      public function get fillHeight() : int
      {
         return 1;
      }
      
      public function get needsAssociates() : Boolean
      {
         return this.fillHeight > 1 || this.fillWidth > 1;
      }
      
      public function get gameClass() : Class
      {
         return this.solid ? SolidBlock : null;
      }
      
      public function get solid() : Boolean
      {
         return false;
      }
      
      public function get mask() : Boolean
      {
         return false;
      }
      
      public function get associates() : Vector.<uk.co.kempt.hannah.data.tiles.AbstractTile>
      {
         return this._associates;
      }
      
      public function set associates(param1:Vector.<uk.co.kempt.hannah.data.tiles.AbstractTile>) : void
      {
         this._associates = param1;
      }
      
      public function get renderable() : Boolean
      {
         return false;
      }
      
      public function get spriteClass() : Class
      {
         return Sprite;
      }
      
      public function get crusting() : Boolean
      {
         return false;
      }
      
      protected function createGameObject() : Object
      {
         var _loc2_:WorldObject = null;
         var _loc1_:Object = new this.gameClass();
         if(_loc1_ is WorldObject)
         {
            _loc2_ = _loc1_ as WorldObject;
            _loc2_.tile = this;
         }
         return _loc1_;
      }
   }
}
