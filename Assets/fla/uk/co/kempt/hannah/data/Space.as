package uk.co.kempt.hannah.data
{
   import uk.co.kempt.hannah.world.ICollidable;
   
   public class Space
   {
       
      
      private var _collection:Vector.<ICollidable>;
      
      public function Space()
      {
         super();
         this._collection = new Vector.<ICollidable>();
      }
      
      public function add(param1:ICollidable) : void
      {
         if(this._collection.indexOf(param1) == -1)
         {
            this._collection.push(param1);
         }
      }
      
      public function get collection() : Vector.<ICollidable>
      {
         return this._collection;
      }
   }
}
