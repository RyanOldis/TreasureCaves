package com.neopets.util.button
{
   public interface INeopetButton
   {
       
      
      function getText() : String;
      
      function set lockOut(param1:Boolean) : void;
      
      function get dataObject() : Object;
      
      function get lockOut() : Boolean;
      
      function get displayFlag() : Boolean;
      
      function reset() : void;
      
      function init(param1:Object = null, param2:String = "button", param3:Object = null) : void;
      
      function set ID(param1:String) : void;
      
      function get ID() : String;
      
      function set displayFlag(param1:Boolean) : void;
      
      function setText(param1:String) : void;
   }
}
