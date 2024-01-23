package uk.co.kempt.hannah
{
   import com.asliceofcrazypie.geom2d.Grid;
   import com.asliceofcrazypie.geom2d.IGridSquare;
   import com.neopets.projects.gameEngine.gui.buttons.SelectedButton;
   import fl.transitions.Tween;
   import flash.display.DisplayObject;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import flash.ui.Mouse;
   import flash.utils.getTimer;
   import uk.co.kempt.hannah.data.DraggingData;
   import uk.co.kempt.hannah.data.tiles.AbstractTile;
   import uk.co.kempt.hannah.data.tiles.BlankTile;
   import uk.co.kempt.hannah.display.EditorPages;
   import uk.co.kempt.hannah.display.TileSelection;
   import uk.co.kempt.hannah.display.tiles.TileSprite;
   import uk.co.kempt.hannah.gui.buttons.HannahSelectedButton;
   import uk.co.kempt.hannah.utils.ClassUtil;
   import uk.co.kempt.hannah.utils.ExportUtil;
   import uk.co.kempt.hannah.utils.SharedObjectUtil;
   import uk.co.kempt.utils.GarbageUtil;
   import virtualworlds.lang.TranslationManager;
   
   public class LevelEditor extends Sprite
   {
      
      private static const KEY_DOWN:Number = Keyboard.DOWN;
      
      private static const WORKING_COPY_NAME:String = "levelwc";
      
      private static const KEY_UP:Number = Keyboard.UP;
      
      private static const KEY_RIGHT:Number = Keyboard.RIGHT;
      
      private static const KEY_LEFT:Number = Keyboard.LEFT;
       
      
      public var load_btn:SimpleButton;
      
      public var zoom_txt:TextField;
      
      public var currentOutline:Sprite;
      
      public var tooltip:Sprite;
      
      private var _currentTile:Sprite;
      
      private var _tooltipAlphaTween:Tween;
      
      private var _selection:TileSelection;
      
      public var soundToggleBtn:SelectedButton;
      
      public var save_btn:SimpleButton;
      
      public var tileDescription_txt:TextField;
      
      private var _dataHasChanged:Boolean;
      
      public var level_txt:TextField;
      
      private var _idleFramesUntilSave:int;
      
      public var musicToggleBtn:SelectedButton;
      
      private var _inited:Boolean;
      
      public var mouseArea:Sprite;
      
      public var exit_btn:SimpleButton;
      
      public var editorPages:EditorPages;
      
      public var help_btn:SimpleButton;
      
      public var panningHand:Sprite;
      
      public var preview_btn:SimpleButton;
      
      private var _draggingData:DraggingData;
      
      private var _follower:Sprite;
      
      public function LevelEditor()
      {
         super();
         this.editorPages.editor = this;
      }
      
      public function die() : void
      {
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownEvent);
         removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpEvent);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpEvent);
         Engine.instance.inputManager.unregisterListener(107,this.onZoomIn);
         Engine.instance.inputManager.unregisterListener(187,this.onZoomIn);
         Engine.instance.inputManager.unregisterListener(109,this.onZoomOut);
         Engine.instance.inputManager.unregisterListener(189,this.onZoomOut);
         Engine.instance.inputManager.unregisterListener(13,this.onZoomRestore);
         Engine.instance.inputManager.unregisterListener(106,this.onZoomRestore);
         Engine.instance.inputManager.unregisterListener(27,this.onCancel);
         stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelEvent);
         Engine.instance.inputManager.unregisterListener(KEY_LEFT,this.onPanLeft);
         Engine.instance.inputManager.unregisterListener(KEY_RIGHT,this.onPanRight);
         Engine.instance.inputManager.unregisterListener(KEY_UP,this.onPanUp);
         Engine.instance.inputManager.unregisterListener(KEY_DOWN,this.onPanDown);
         this.save_btn.removeEventListener(MouseEvent.CLICK,this.onSaveClicked);
         this.load_btn.removeEventListener(MouseEvent.CLICK,this.onLoadClicked);
         this.preview_btn.removeEventListener(MouseEvent.CLICK,this.onPreviewClicked);
         this.help_btn.removeEventListener(MouseEvent.CLICK,this.onHelpClicked);
         this.exit_btn.removeEventListener(MouseEvent.CLICK,this.onExitClicked);
         this.level_txt.removeEventListener(MouseEvent.CLICK,this.onTextFocus);
         this.musicToggleBtn.removeEventListener(MouseEvent.MOUSE_UP,this.onMusicToggleButtonClicked);
         this.soundToggleBtn.removeEventListener(MouseEvent.MOUSE_UP,this.onSoundToggleButtonClicked);
         this.removeCurrentSelection();
         this._draggingData = null;
         this._currentTile = null;
         GarbageUtil.kill(this);
      }
      
      private function onLoadClicked(param1:MouseEvent) : void
      {
         this.removeCurrentTile();
         this.removeCurrentSelection();
         this.editorPages.show(EditorPages.PASTE2);
      }
      
      private function onPanRight(param1:Event) : void
      {
         this.follower.x += this.panSpeed;
      }
      
      private function onPanDown(param1:Event) : void
      {
         this.follower.y += this.panSpeed;
      }
      
      private function onTextFocus(param1:Event) : void
      {
         this.level_txt.setSelection(0,int.MAX_VALUE);
      }
      
      private function onRollOutEvent(param1:MouseEvent) : void
      {
         if(param1.target is TileSprite)
         {
            if(this._tooltipAlphaTween.finish != 0)
            {
               this._tooltipAlphaTween.continueTo(0,0.4);
            }
         }
      }
      
      public function loadCurrentLevel() : void
      {
         Engine.instance.executeAfterWait(this.doLoadCurrentLevel);
      }
      
      private function saveLocalCopy() : void
      {
         var _loc1_:int = 0;
         if(this.editorPages.currentPage != EditorPages.BLANK)
         {
            return;
         }
         if(this._dataHasChanged)
         {
            _loc1_ = getTimer();
            SharedObjectUtil.writeToSharedObject(Engine.SHARED_OBJECT_NAME,WORKING_COPY_NAME,ExportUtil.export(Engine.instance.grid,Engine.instance.currentLevelData));
            this._dataHasChanged = false;
            _loc1_ = getTimer() - _loc1_;
            trace("autosaving: " + _loc1_ + "ms");
         }
      }
      
      public function get follower() : Sprite
      {
         return this._follower = this._follower || new Sprite();
      }
      
      private function onSoundToggleButtonClicked(param1:MouseEvent) : void
      {
         Game.instance.doToggleSound();
      }
      
      private function onMouseWheelEvent(param1:MouseEvent) : void
      {
         if(param1.delta > 0)
         {
            this.onZoomIn(null);
         }
         else if(param1.delta < 0)
         {
            this.onZoomOut(null);
         }
      }
      
      private function onZoomIn(param1:Event) : void
      {
         this.zoomByAmount(4 / Engine.TILE_SIZE);
      }
      
      public function init() : void
      {
         Engine.instance.zoom = 1;
         this.follower.x = Engine.instance.startPosition.x;
         this.follower.y = Engine.instance.startPosition.y;
         Engine.instance.gameCamera.update(true);
         if(this._inited)
         {
            return;
         }
         this.panningHand.visible = false;
         this.panningHand.mouseEnabled = this.panningHand.mouseChildren = false;
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownEvent,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpEvent,false,0,true);
         addEventListener(MouseEvent.MOUSE_OVER,this.onRollOverEvent,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.onRollOutEvent,false,0,true);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpEvent);
         Engine.instance.inputManager.registerListener(107,this.onZoomIn);
         Engine.instance.inputManager.registerListener(187,this.onZoomIn);
         Engine.instance.inputManager.registerListener(109,this.onZoomOut);
         Engine.instance.inputManager.registerListener(189,this.onZoomOut);
         Engine.instance.inputManager.registerListener(48,this.onZoomRestore);
         Engine.instance.inputManager.registerListener(106,this.onZoomRestore);
         Engine.instance.inputManager.registerListener(27,this.onCancel);
         stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelEvent);
         Engine.instance.inputManager.registerListener(KEY_LEFT,this.onPanLeft);
         Engine.instance.inputManager.registerListener(KEY_RIGHT,this.onPanRight);
         Engine.instance.inputManager.registerListener(KEY_UP,this.onPanUp);
         Engine.instance.inputManager.registerListener(KEY_DOWN,this.onPanDown);
         this.save_btn.addEventListener(MouseEvent.CLICK,this.onSaveClicked,false,0,true);
         this.load_btn.addEventListener(MouseEvent.CLICK,this.onLoadClicked,false,0,true);
         this.exit_btn.addEventListener(MouseEvent.CLICK,this.onExitClicked,false,0,true);
         this.preview_btn.addEventListener(MouseEvent.CLICK,this.onPreviewClicked,false,0,true);
         this.help_btn.addEventListener(MouseEvent.CLICK,this.onHelpClicked,false,0,true);
         this.level_txt.addEventListener(MouseEvent.CLICK,this.onTextFocus,false,0,true);
         this.musicToggleBtn.addEventListener(MouseEvent.MOUSE_UP,this.onMusicToggleButtonClicked,false,0,true);
         this.soundToggleBtn.addEventListener(MouseEvent.MOUSE_UP,this.onSoundToggleButtonClicked,false,0,true);
         this._tooltipAlphaTween = new Tween(this.tooltip,"alpha",null,0,0,0.4,true);
         this._tooltipAlphaTween.fforward();
         HannahSelectedButton(this.soundToggleBtn).state = Engine.instance.soundDisabled ? "selected" : "off";
         HannahSelectedButton(this.musicToggleBtn).state = Engine.instance.musicDisabled ? "selected" : "off";
         this._inited = true;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.init();
      }
      
      private function get panSpeed() : Number
      {
         return (Engine.instance.inputManager.keyIsDown(16) ? 300 : 100) * Engine.instance.zoom;
      }
      
      private function onZoomOut(param1:Event) : void
      {
         this.zoomByAmount(-4 / Engine.TILE_SIZE);
      }
      
      private function onRollOverEvent(param1:MouseEvent) : void
      {
         var _loc2_:TileSprite = null;
         if(Engine.instance.inputManager.keyIsDown(Keyboard.SPACE))
         {
            return;
         }
         if(param1.target is TileSprite)
         {
            if(this._tooltipAlphaTween.finish != 1)
            {
               this._tooltipAlphaTween.continueTo(1,0.15);
            }
            _loc2_ = param1.target as TileSprite;
            TranslationManager.instance.setTextField(this.tileDescription_txt,_loc2_.tileName.toUpperCase() + ": " + _loc2_.description);
            TranslationManager.instance.setTextField(TextField(this.tooltip["label_txt"]),_loc2_.tileName.toUpperCase());
         }
      }
      
      private function onSaveClicked(param1:MouseEvent) : void
      {
         this.removeCurrentTile();
         this.removeCurrentSelection();
         this.editorPages.show(EditorPages.SAVE_MENU);
      }
      
      private function zoomByAmount(param1:Number) : void
      {
         var _loc2_:Point = this.relativeMousePoint2;
         Engine.instance.zoom = Math.min(2,Math.max(3 / 32,Engine.instance.zoom + param1));
         _loc2_ = this.relativeMousePoint2.subtract(_loc2_);
         this.follower.x -= _loc2_.x * Engine.instance.zoom;
         this.follower.y -= _loc2_.y * Engine.instance.zoom;
         Engine.instance.gameCamera.update(true);
      }
      
      private function removeCurrentSelection() : void
      {
         if(this._selection)
         {
            this._selection.die();
            this._selection = null;
         }
      }
      
      public function clearTiles(param1:Rectangle) : void
      {
         Engine.instance.clearTiles(param1);
      }
      
      private function onMouseDownEvent(param1:MouseEvent) : void
      {
         if(param1.target == this.mouseArea)
         {
            stage.focus = stage;
            if(Engine.instance.inputManager.keyIsDown(Keyboard.SPACE))
            {
               this._draggingData = new DraggingData(new Point(this.follower.x,this.follower.y),this.mousePoint);
            }
            else if(this._currentTile)
            {
               this.removeCurrentSelection();
               this._selection = new TileSelection(this.mouseCoord,Engine.instance.tileDictionary.getTileClass(ClassUtil.getClass(this._currentTile)));
               Engine.instance.display.addChild(this._selection);
               this.hideTile(true);
            }
         }
      }
      
      public function get relativeMousePoint2() : Point
      {
         return new Point(Engine.instance.display.mouseX,Engine.instance.display.mouseY);
      }
      
      private function hideTile(param1:Boolean = true) : void
      {
         if(this._currentTile)
         {
            this._currentTile.visible = !param1;
         }
      }
      
      private function clearUniques(param1:Class) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Vector.<int> = null;
         var _loc2_:Grid = Engine.instance.grid;
         var _loc3_:Vector.<IGridSquare> = _loc2_.getSlice(0,0,_loc2_.width,_loc2_.height);
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_[_loc4_] is param1)
            {
               _loc5_ = _loc2_.getSquareCoords(_loc3_[_loc4_]);
               this.clearTiles(new Rectangle(_loc5_[0],_loc5_[1],1,1));
               _loc2_.setSquareAt(_loc5_[0],_loc5_[1],new BlankTile());
            }
            _loc4_++;
         }
      }
      
      private function removeCurrentTile() : void
      {
         if(this._currentTile)
         {
            if(this._currentTile.parent)
            {
               this._currentTile.parent.removeChild(this._currentTile);
            }
            this._currentTile = null;
            this.currentOutline.x = -1000;
         }
      }
      
      private function onHelpClicked(param1:MouseEvent) : void
      {
         this.removeCurrentTile();
         this.removeCurrentSelection();
         this.editorPages.show(EditorPages.INSTRUCTIONS);
      }
      
      public function preview() : void
      {
         var _loc1_:String = ExportUtil.export(Engine.instance.grid,Engine.instance.currentLevelData);
         this.saveLocalCopy();
         Engine.setCurrentLevelData(_loc1_);
         if(_loc1_)
         {
            Engine.instance.previewLevel();
         }
         else
         {
            trace("no data");
         }
      }
      
      public function update() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Point = null;
         var _loc3_:Boolean = false;
         if(this.editorPages.currentPage == EditorPages.BLANK)
         {
            if(Boolean(stage) && Boolean(stage.focus))
            {
               stage.focus = null;
            }
         }
         if(this._currentTile)
         {
            _loc1_ = this.mouseCoord;
            this._currentTile.x = Engine.TILE_SIZE * _loc1_.x;
            this._currentTile.y = Engine.TILE_SIZE * _loc1_.y;
         }
         if(this._selection)
         {
            this._selection.update(this.mouseCoord);
         }
         if(this._draggingData)
         {
            _loc2_ = this._draggingData.objectStart.subtract(this.mousePoint.subtract(this._draggingData.mouseStart));
            this.follower.x = _loc2_.x;
            this.follower.y = _loc2_.y;
         }
         if(this.follower)
         {
            this.follower.x = Math.max(0,Math.min(Engine.instance.grid.width * Engine.TILE_SIZE * Engine.instance.zoom,this.follower.x));
            this.follower.y = Math.max(0,Math.min(Engine.instance.grid.height * Engine.TILE_SIZE * Engine.instance.zoom,this.follower.y));
         }
         if(this.zoom_txt)
         {
            this.zoom_txt.text = "" + Math.floor(Engine.instance.zoom * 100).toString() + "%";
         }
         if(this.tooltip)
         {
            this.tooltip.x += (mouseX - this.tooltip.x) / 2;
            this.tooltip.y += (mouseY - this.tooltip.y) / 2;
         }
         if(this.panningHand)
         {
            this.panningHand.x += (mouseX - this.panningHand.x) * 0.8;
            this.panningHand.y += (mouseY - this.panningHand.y) * 0.8;
            _loc3_ = this.panningHand.visible;
            this.panningHand.visible = Engine.instance.inputManager.keyIsDown(Keyboard.SPACE);
            if(!_loc3_ && this.panningHand.visible)
            {
               Mouse.hide();
            }
            else if(_loc3_ && !this.panningHand.visible)
            {
               Mouse.show();
            }
         }
         if(this._idleFramesUntilSave > 0)
         {
            --this._idleFramesUntilSave;
            if(this._idleFramesUntilSave <= 0)
            {
               this.saveLocalCopy();
            }
         }
      }
      
      private function doLoadCurrentLevel() : void
      {
         Engine.instance.loadLevel(Engine.currentLevelData);
         Engine.instance.beginEditing();
      }
      
      public function get dragging() : Boolean
      {
         return !!this._draggingData ? true : false;
      }
      
      public function get mouseCoord() : Point
      {
         return this.convertPointToCoord(this.relativeMousePoint);
      }
      
      private function onExitClicked(param1:MouseEvent) : void
      {
         this.removeCurrentTile();
         this.removeCurrentSelection();
         this.editorPages.show(EditorPages.EXIT);
      }
      
      private function onMouseUpEvent(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:Class = null;
         var _loc4_:AbstractTile = null;
         if(param1.target == this.mouseArea)
         {
            this.setSelection();
            this.removeCurrentSelection();
         }
         else if(param1.target is TileSprite)
         {
            this.removeCurrentTile();
            this.currentOutline.x = DisplayObject(param1.target).x + 16;
            this.currentOutline.y = DisplayObject(param1.target).y + 16;
            _loc2_ = ClassUtil.duplicateDisplayObject(param1.target as DisplayObject);
            this._currentTile = !!_loc2_ ? _loc2_ as Sprite : null;
            if(this._currentTile)
            {
               _loc3_ = Engine.instance.tileDictionary.getTileClass(ClassUtil.getClass(this._currentTile));
               _loc4_ = new _loc3_() as AbstractTile;
               this._currentTile.filters = [new GlowFilter(16777215,1,5,5,1,2)];
               this._currentTile.graphics.lineStyle(2,16777215,1);
               this._currentTile.graphics.beginFill(65535,0.1);
               this._currentTile.graphics.drawRect(0,-Engine.TILE_SIZE * (_loc4_.fillHeight - 1),Engine.TILE_SIZE * _loc4_.fillWidth,Engine.TILE_SIZE * _loc4_.fillHeight);
               this._currentTile.graphics.endFill();
               this._currentTile.mouseEnabled = false;
               Engine.instance.display.addChild(this._currentTile);
            }
         }
         this.clearOnMouseUp();
      }
      
      private function onCancel(param1:Event) : void
      {
         if(this._selection)
         {
            this.removeCurrentSelection();
         }
      }
      
      private function onZoomRestore(param1:Event) : void
      {
         this.zoomByAmount(1 - Engine.instance.zoom);
      }
      
      private function onMusicToggleButtonClicked(param1:MouseEvent) : void
      {
         Game.instance.doToggleMusic();
      }
      
      private function translatePoint(param1:Point) : Point
      {
         var _loc2_:Point = Engine.instance.gameCamera.position;
         param1.x *= 1 / Engine.instance.zoom;
         param1.y *= 1 / Engine.instance.zoom;
         _loc2_.x *= 1 / Engine.instance.zoom;
         _loc2_.y *= 1 / Engine.instance.zoom;
         return param1.add(_loc2_);
      }
      
      private function convertPointToCoord(param1:Point) : Point
      {
         return new Point(Math.floor(param1.x / Engine.TILE_SIZE),Math.floor(param1.y / Engine.TILE_SIZE));
      }
      
      public function get relativeMousePoint() : Point
      {
         return this.translatePoint(this.mousePoint);
      }
      
      private function onStageMouseUpEvent(param1:MouseEvent) : void
      {
         this.clearOnMouseUp();
      }
      
      public function get mousePoint() : Point
      {
         return new Point(mouseX,mouseY);
      }
      
      private function onPanLeft(param1:Event) : void
      {
         this.follower.x += -this.panSpeed;
      }
      
      private function clearOnMouseUp() : void
      {
         this.removeCurrentSelection();
         this._draggingData = null;
         this.hideTile(false);
      }
      
      private function setSelection() : void
      {
         var _loc1_:Vector.<IGridSquare> = null;
         var _loc2_:Rectangle = null;
         var _loc3_:int = 0;
         var _loc4_:Class = null;
         var _loc5_:AbstractTile = null;
         var _loc6_:int = 0;
         if(Boolean(this._selection) && Boolean(this._currentTile))
         {
            _loc1_ = new Vector.<IGridSquare>();
            _loc2_ = this._selection.getSelection();
            _loc3_ = _loc2_.width * _loc2_.height;
            _loc5_ = new (_loc4_ = Engine.instance.tileDictionary.getTileClass(ClassUtil.getClass(this._currentTile)))() as AbstractTile;
            if(_loc2_.y - (_loc5_.fillHeight - 1) < 0)
            {
               return;
            }
            if(_loc2_.x + (_loc5_.fillWidth - 1) + _loc2_.width > Engine.instance.grid.width)
            {
               return;
            }
            if(_loc2_.x < 0)
            {
               return;
            }
            if(_loc2_.y + _loc2_.height > Engine.instance.grid.height)
            {
               return;
            }
            if(_loc4_)
            {
               if(_loc5_.unique)
               {
                  this.clearUniques(_loc4_);
               }
               _loc6_ = 0;
               while(_loc6_ < _loc3_)
               {
                  _loc1_.push(new _loc4_());
                  _loc6_++;
               }
               this.clearTiles(_loc2_);
               Engine.instance.grid.setSubGrid(_loc2_.x,_loc2_.y,_loc2_.width,_loc2_.height,_loc1_);
               this._dataHasChanged = true;
               this._idleFramesUntilSave = Engine.GAME_FRAMERATE * 4;
               Engine.instance.invalidate(_loc2_);
            }
         }
      }
      
      private function onPanUp(param1:Event) : void
      {
         this.follower.y += -this.panSpeed;
      }
      
      private function onPreviewClicked(param1:MouseEvent) : void
      {
         this.removeCurrentTile();
         this.removeCurrentSelection();
         this.editorPages.show(EditorPages.PREVIEW);
      }
      
      public function getLocalData() : String
      {
         var _loc2_:String = null;
         var _loc1_:* = SharedObjectUtil.retrieveFromSharedObject(Engine.SHARED_OBJECT_NAME,WORKING_COPY_NAME);
         if(_loc1_ && _loc1_ is String)
         {
            _loc2_ = _loc1_ as String;
         }
         return _loc2_;
      }
   }
}
