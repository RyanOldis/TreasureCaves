package com.neopets.projects.np9.system
{
   public class NP9_Evar
   {
       
      
      private var aEvar:Array;
      
      public function NP9_Evar(param1:*)
      {
         super();
         this.aEvar = [];
         this.create(param1);
      }
      
      public function changeBy(param1:*) : void
      {
         var _loc2_:* = undefined;
         if(this.aEvar[0][0] > 0)
         {
            this.aEvar[0][1] += this.aEvar[0][0] * param1;
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               this.aEvar[0][1].push(param1.charCodeAt(_loc2_));
               _loc2_++;
            }
         }
      }
      
      public function changeTo(param1:*) : void
      {
         this.create(param1);
      }
      
      private function create(param1:*) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         this.aEvar = [];
         var _loc2_:* = [];
         var _loc3_:* = typeof param1;
         if(_loc3_.toLowerCase() == "string")
         {
            _loc2_.push(0);
            _loc4_ = [];
            _loc5_ = 0;
            while(_loc5_ < param1.length)
            {
               _loc4_.push(param1.charCodeAt(_loc5_));
               _loc5_++;
            }
            _loc2_.push(_loc4_);
         }
         else if(_loc3_.toLowerCase() == "number")
         {
            _loc2_.push(11 + int(Math.random() * 100));
            _loc2_.push(param1 * _loc2_[0]);
         }
         this.aEvar.push(_loc2_);
      }
      
      public function show() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         if(this.aEvar[0][0] > 0)
         {
            return this.aEvar[0][1] / this.aEvar[0][0];
         }
         _loc1_ = "";
         _loc2_ = 0;
         while(_loc2_ < this.aEvar[0][1].length)
         {
            _loc1_ += String.fromCharCode(this.aEvar[0][1][_loc2_]);
            _loc2_++;
         }
         return _loc1_;
      }
   }
}
