package uk.co.kempt.hannah.display
{
   import flash.display.Sprite;
   import flash.events.Event;
   import uk.co.kempt.hannah.Engine;
   
   public class Previewer extends Sprite
   {
       
      
      private var _preview:uk.co.kempt.hannah.display.LevelPreview;
      
      public function Previewer()
      {
         super();
         if(stage)
         {
            this.init();
         }
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,false,0,true);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage,false,0,true);
      }
      
      private function init() : void
      {
         this.dispose();
         this._preview = new uk.co.kempt.hannah.display.LevelPreview(Engine.currentLevelData);
         addChild(this._preview);
         this._preview.x = (546 - this._preview.width) / 2;
         this._preview.y = (302 - this._preview.height) / 2;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.init();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.dispose();
      }
      
      private function dispose() : void
      {
         if(this._preview)
         {
            this._preview.die();
            this._preview = null;
         }
      }
   }
}
