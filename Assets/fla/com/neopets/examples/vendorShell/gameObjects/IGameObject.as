package com.neopets.examples.vendorShell.gameObjects
{
   import flash.geom.Rectangle;
   
   public interface IGameObject
   {
       
      
      function init(param1:String, param2:Rectangle, param3:Number = 1) : void;
      
      function doCleanUp() : void;
      
      function doEffect() : void;
      
      function setStartLocation() : void;
   }
}
