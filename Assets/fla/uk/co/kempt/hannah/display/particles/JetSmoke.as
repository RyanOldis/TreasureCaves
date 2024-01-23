package uk.co.kempt.hannah.display.particles
{
   import flash.events.Event;
   import uk.co.kempt.hannah.display.PlayOnce;
   
   public class JetSmoke extends PlayOnce
   {
       
      
      protected var _yVel:Number;
      
      protected var _xVel:Number;
      
      protected var _yVelRnd:Number;
      
      protected var _xVelRnd:Number;
      
      protected var _power:Number;
      
      protected var _initVelX:Number;
      
      protected var _decay:Number;
      
      public function JetSmoke()
      {
         super();
         this.init();
         this._xVel += (Math.random() - 0.5) * this._xVelRnd;
         this._yVel += (Math.random() - 0.5) * this._yVelRnd;
         this._xVel *= this._power;
         this._yVel *= this._power;
         rotation = Math.random() * 360;
         addEventListener(Event.ENTER_FRAME,this.onEnterFrameEvent,false,0,true);
      }
      
      protected function init() : void
      {
         this._initVelX = 1.2;
         this._xVel = 0;
         this._yVel = 2;
         this._xVelRnd = 1;
         this._yVelRnd = 1.5;
         this._decay = 0.98;
         this._power = 3;
      }
      
      private function onEnterFrameEvent(param1:Event) : void
      {
         x += this._xVel;
         y += this._yVel;
         this._xVel *= this._decay;
         this._yVel *= this._decay;
      }
      
      public function setInitialVelocityX(param1:Number) : void
      {
         this._xVel += this._initVelX * param1;
      }
   }
}
