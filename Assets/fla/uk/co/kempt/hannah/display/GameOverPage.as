package uk.co.kempt.hannah.display
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import uk.co.kempt.hannah.Game;
   
   public class GameOverPage extends Sprite
   {
       
      
      public var score_txt:TextField;
      
      public function GameOverPage()
      {
         super();
      }
      
      public function activate() : void
      {
         this.score_txt.text = Game.instance.endScore.toString();
      }
   }
}
