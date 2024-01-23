package uk.co.kempt.hannah.world
{
   public class NonSolidBlock extends SolidBlock
   {
       
      
      public function NonSolidBlock()
      {
         super();
      }
      
      override public function get solid() : Boolean
      {
         return false;
      }
   }
}
