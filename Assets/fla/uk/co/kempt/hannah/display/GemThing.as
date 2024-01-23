package uk.co.kempt.hannah.display
{
   import fl.transitions.Tween;
   import fl.transitions.easing.Regular;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class GemThing extends Sprite
   {
       
      
      private var _tweenX:Tween;
      
      private var _tweenY:Tween;
      
      public function GemThing()
      {
         super();
         this._tweenX = new Tween(this,"x",Regular.easeOut,x,x,1,true);
         this._tweenY = new Tween(this,"y",Regular.easeOut,y,y,1,true);
         this._tweenX.fforward();
         this._tweenY.fforward();
      }
      
      public function animate(param1:Point, param2:Point) : void
      {
         this._tweenX.continueTo(param1.x,1);
         this._tweenY.continueTo(param1.y,1);
         this._tweenX.fforward();
         this._tweenY.fforward();
         this._tweenX.continueTo(param2.x,0.2);
         this._tweenY.continueTo(param2.y,0.2);
      }
   }
}
