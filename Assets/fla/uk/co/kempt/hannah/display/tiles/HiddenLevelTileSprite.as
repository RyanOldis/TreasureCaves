package uk.co.kempt.hannah.display.tiles
{
   import flash.display.MovieClip;
   import uk.co.kempt.hannah.Engine;
   
   public class HiddenLevelTileSprite extends LevelTileSprite
   {
       
      
      public var qmark:MovieClip;
      
      public function HiddenLevelTileSprite()
      {
         super();
         this.qmark.visible = Engine.EDIT;
      }
   }
}
