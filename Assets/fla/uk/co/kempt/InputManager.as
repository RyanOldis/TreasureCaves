package uk.co.kempt
{
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class InputManager
   {
      
      private static var KEYS:Object;
      
      private static var KEY_TIMES:Object;
      
      private static var LISTENERS:Dictionary;
       
      
      private var _cheat:Boolean;
      
      private var _inputEnabled:Boolean;
      
      private var _stage:Stage;
      
      public function InputManager(param1:Stage)
      {
         super();
         this._stage = param1;
         this.init();
      }
      
      public function die() : void
      {
         if(this._stage)
         {
            this._stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownEvent);
            this._stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUpEvent);
         }
         KEYS = null;
         KEY_TIMES = null;
         LISTENERS = null;
         this._stage = null;
      }
      
      public function get stage() : Stage
      {
         return this._stage;
      }
      
      private function getListenersForKey(param1:uint) : Array
      {
         return LISTENERS[param1] = LISTENERS[param1] || [];
      }
      
      public function keyIsDown(param1:uint) : Boolean
      {
         return this.inputEnabled ? Boolean(KEYS[param1]) : false;
      }
      
      public function set cheat(param1:Boolean) : void
      {
         this._cheat = param1;
      }
      
      private function onKeyUpEvent(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case 19:
               if(this.keyIsDown(16) && this.keyIsDown(107))
               {
                  this._cheat = !this._cheat;
               }
         }
         KEYS[param1.keyCode] = false;
      }
      
      public function get inputEnabled() : Boolean
      {
         return this._inputEnabled;
      }
      
      public function unregisterListener(param1:uint, param2:Function) : void
      {
         var _loc3_:Array = this.getListenersForKey(param1);
         var _loc4_:int;
         if((_loc4_ = _loc3_.indexOf(param2)) != -1)
         {
            _loc3_.splice(_loc4_,1);
         }
      }
      
      private function init() : void
      {
         KEYS = {};
         KEY_TIMES = {};
         LISTENERS = new Dictionary();
         this.inputEnabled = true;
         this.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownEvent,false,0,true);
         this.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUpEvent,false,0,true);
      }
      
      public function set inputEnabled(param1:Boolean) : void
      {
         this._inputEnabled = param1;
      }
      
      public function registerListener(param1:uint, param2:Function) : void
      {
         var _loc3_:Array = this.getListenersForKey(param1);
         if(_loc3_.indexOf(param2) == -1)
         {
            _loc3_.push(param2);
         }
      }
      
      private function onKeyDownEvent(param1:KeyboardEvent) : void
      {
         var tListeners:Array = null;
         var e:KeyboardEvent = param1;
         if(KEYS[e.keyCode] == true)
         {
            return;
         }
         KEYS[e.keyCode] = true;
         KEY_TIMES[e.keyCode] = getTimer();
         if(this.inputEnabled)
         {
            tListeners = this.getListenersForKey(e.keyCode);
            tListeners.forEach(function(param1:Function, param2:int, param3:Array):void
            {
               param1(e);
            });
         }
      }
      
      public function get cheat() : Boolean
      {
         return this._cheat;
      }
      
      public function getKeyTime(param1:uint) : uint
      {
         var _loc2_:Number = Number(Number(KEY_TIMES[param1]) || 0);
         if(this._cheat)
         {
            return 1;
         }
         return getTimer() - _loc2_;
      }
   }
}
