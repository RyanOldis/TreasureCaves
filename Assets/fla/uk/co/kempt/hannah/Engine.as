package uk.co.kempt.hannah
{
   import com.asliceofcrazypie.geom2d.Grid;
   import com.asliceofcrazypie.geom2d.IGridSquare;
   import com.asliceofcrazypie.tilerenderer.Scroller;
   import com.neopets.projects.gameEngine.gui.Interface.GameScreen;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import uk.co.kempt.InputManager;
   import uk.co.kempt.hannah.data.LevelData;
   import uk.co.kempt.hannah.data.ProgressData;
   import uk.co.kempt.hannah.data.Spaces;
   import uk.co.kempt.hannah.data.TileDictionary;
   import uk.co.kempt.hannah.data.tiles.AbstractTile;
   import uk.co.kempt.hannah.data.tiles.BlankAssociateTile;
   import uk.co.kempt.hannah.data.tiles.BlankTile;
   import uk.co.kempt.hannah.data.tiles.ExitTile;
   import uk.co.kempt.hannah.data.tiles.StartTile;
   import uk.co.kempt.hannah.data.tiles.TreasureTile;
   import uk.co.kempt.hannah.display.EditorPages;
   import uk.co.kempt.hannah.display.GameBackground;
   import uk.co.kempt.hannah.display.HannahHUD;
   import uk.co.kempt.hannah.display.LevelChooser;
   import uk.co.kempt.hannah.sounds.HannahSoundManager;
   import uk.co.kempt.hannah.sounds.HannahSounds;
   import uk.co.kempt.hannah.utils.ExportUtil;
   import uk.co.kempt.hannah.world.Player;
   import uk.co.kempt.hannah.world.SolidBlock;
   import uk.co.kempt.hannah.world.WorldObject;
   import uk.co.kempt.hannah.world.pickups.BlueKeyPickup;
   import uk.co.kempt.hannah.world.pickups.HeartPickup;
   import uk.co.kempt.hannah.world.pickups.PurpleKeyPickup;
   import uk.co.kempt.hannah.world.pickups.YellowKeyPickup;
   import uk.co.kempt.sounds.Snd;
   import uk.co.kempt.sounds.SoundManager;
   import uk.co.kempt.utils.GarbageUtil;
   
   public class Engine extends GameScreen
   {
      
      private static const KEY_RIGHT:Number = Keyboard.RIGHT;
      
      private static const KEY_LEFT:Number = Keyboard.LEFT;
      
      public static var EDIT:Boolean = false;
      
      private static const S_EDITING:String = "editing";
      
      public static const GAME_HEIGHT:int = 600 - 28;
      
      private static var INSTANCE:uk.co.kempt.hannah.Engine;
      
      public static const GAME_WIDTH:int = 650;
      
      private static const KEY_UP:Number = Keyboard.UP;
      
      public static const GAME_FRAMERATE:int = 30;
      
      private static const S_DYING:String = "dying";
      
      private static const KEY_DOWN:Number = Keyboard.DOWN;
      
      public static const MAX_LIVES:int = 9;
      
      public static var SPACES:Spaces;
      
      private static const KEY_JUMP:Number = Keyboard.SPACE;
      
      public static var PREVIEW:Boolean = false;
      
      private static var OBJECTS_TO_EXCLUDE:Dictionary = new Dictionary();
      
      public static const SHARED_OBJECT_NAME:String = "hannahmoon";
      
      public static const DEBUG:Boolean = false;
      
      private static var LEVEL_UPDATEABLES:Vector.<WorldObject>;
      
      private static var CURRENT_LEVEL_INDEX:int = 1;
      
      private static var CURRENT_UPDATEABLES:Vector.<WorldObject>;
      
      public static const OXYGEN_DECAY:Number = 1 / GAME_FRAMERATE / 90;
      
      public static const DEFAULT_LIVES:int = 3;
      
      private static var CURRENT_LEVEL_DATA:String = LevelData.LEVEL_1;
      
      public static const FUEL_DECAY:Number = 1 / GAME_FRAMERATE / 10;
      
      private static const S_GAME:String = "game";
      
      public static const TILE_SIZE:int = 32;
      
      private static const S_INIT:String = "init";
       
      
      private var _player:Player;
      
      private var _tileDictionary:TileDictionary;
      
      private var _lives:int;
      
      private var _display2:Sprite;
      
      private var _currentLevelData:LevelData;
      
      private var _displayContainer:Sprite;
      
      private var _levelEditor:uk.co.kempt.hannah.LevelEditor;
      
      private var _gameCamera:uk.co.kempt.hannah.GameCamera;
      
      private var _progressData:ProgressData;
      
      private var _inputManager:InputManager;
      
      private var _soundEngine:SoundManager;
      
      public var wait:Sprite;
      
      private var _jumpTime:int;
      
      private var _display:Sprite;
      
      private var _particleEngine:uk.co.kempt.hannah.ParticleEngine;
      
      private var _fuelBonus:int;
      
      private var _deadCount:int;
      
      private var _menuMusic:Snd;
      
      private var _state:String;
      
      private var _complete:Boolean;
      
      private var _scroller:Scroller;
      
      private var _oxygenBonus:int;
      
      private var _bgMusic:Snd;
      
      private var _startPosition:Point;
      
      private var _soundDisabled:Boolean;
      
      private var _musicDisabled:Boolean;
      
      private var _background:GameBackground;
      
      private var _inited:Boolean;
      
      private var _jumpKeyDown:int;
      
      private var _waitCallbacks:Array;
      
      public var hud:HannahHUD;
      
      public function Engine()
      {
         INSTANCE = this;
         super();
         if(stage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
      }
      
      public static function setCurrentLevel(param1:int) : void
      {
         CURRENT_LEVEL_INDEX = param1;
         CURRENT_LEVEL_DATA = LevelData["LEVEL_" + CURRENT_LEVEL_INDEX.toString()];
      }
      
      public static function get instance() : uk.co.kempt.hannah.Engine
      {
         return INSTANCE;
      }
      
      public static function get currentLevelData() : String
      {
         return CURRENT_LEVEL_DATA;
      }
      
      public static function setCurrentLevelData(param1:String) : void
      {
         CURRENT_LEVEL_DATA = param1;
         CURRENT_LEVEL_INDEX = 0;
      }
      
      public static function clearExcludedObjects() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in OBJECTS_TO_EXCLUDE)
         {
            delete OBJECTS_TO_EXCLUDE[_loc1_];
         }
      }
      
      public static function get currentLevelNum() : int
      {
         return CURRENT_LEVEL_INDEX;
      }
      
      public function get fuelBonus() : int
      {
         return this._fuelBonus;
      }
      
      private function startGameMusic() : void
      {
         this._bgMusic = this.soundEngine.loopSound(HannahSounds.BG_MUSIC,0);
         this._bgMusic.fadeTo(this.targetMusicVolumeBG,1);
      }
      
      private function get targetMusicVolumeBG() : Number
      {
         return this.musicDisabled ? 0 : 1;
      }
      
      public function get lives() : int
      {
         return this._lives;
      }
      
      private function init() : void
      {
         if(this._inited)
         {
            return;
         }
         this._inited = true;
         this._tileDictionary = new TileDictionary();
         this._displayContainer = new Sprite();
         this._background = new GameBackground();
         this._gameCamera = new uk.co.kempt.hannah.GameCamera(new Rectangle(0,0,GAME_WIDTH,GAME_HEIGHT));
         this._scroller = new Scroller(GAME_WIDTH,GAME_HEIGHT,null,TILE_SIZE,TILE_SIZE,14540253);
         this._inputManager = new InputManager(stage);
         this._particleEngine = new uk.co.kempt.hannah.ParticleEngine();
         this._soundEngine = new HannahSoundManager();
         this._progressData = new ProgressData();
         this._state = S_INIT;
         this._waitCallbacks = [];
         this.restartGame();
         this.startMenuMusic();
         this.hud.visible = false;
         this.wait.visible = false;
         addEventListener(Event.ENTER_FRAME,this.gameLoop);
         addChild(this._background);
         addChild(this._displayContainer);
         if(this.hud)
         {
            addChild(this.hud);
         }
         addChild(this.wait);
      }
      
      private function updateMusicVolume() : void
      {
         if(this._bgMusic)
         {
            this._bgMusic.stopFade();
            this._bgMusic.fadeTo(this.targetMusicVolumeBG,0.4);
         }
         if(this._menuMusic)
         {
            this._menuMusic.stopFade();
            this._menuMusic.fadeTo(this.targetMusicVolumeMenu,0.4);
         }
      }
      
      private function onDebug4(param1:KeyboardEvent) : void
      {
         this.progressData.level = 1;
         trace("LEVEL PROGRESS RESET");
         LevelChooser.instance.refresh();
      }
      
      public function exit() : void
      {
         var _loc1_:Boolean = false;
         if(PREVIEW)
         {
            EDIT = true;
            PREVIEW = false;
            this.clear();
            this.startEditing();
            this.beginEditing();
            this._levelEditor.editorPages.show(EditorPages.BLANK);
         }
         else
         {
            _loc1_ = this._state == S_DYING ? false : true;
            this.clear();
            this.startMenuMusic();
            if(_loc1_)
            {
               Game.instance.score += this.fuelBonus;
               Game.instance.score += this.oxygenBonus;
               this._progressData.level = Math.max(this._progressData.level,CURRENT_LEVEL_INDEX + 1);
               Game.instance.doExit();
            }
            else if(this._lives > 0)
            {
               Game.instance.doFailExit();
            }
            else
            {
               Game.instance.doFinalFailExit();
            }
         }
      }
      
      private function checkSprites(param1:AbstractTile, param2:AbstractTile) : Boolean
      {
         return param1.crusting && param2.crusting && param1.crustingGroup == param2.crustingGroup;
      }
      
      public function updateCrustingWithPadding(param1:Rectangle) : void
      {
         var _loc2_:Rectangle = new Rectangle(param1.x - 1,param1.y - 1,param1.width + 2,param1.height + 2);
         _loc2_.x = Math.max(0,_loc2_.x);
         _loc2_.y = Math.max(0,_loc2_.y);
         _loc2_.width = Math.min(this.grid.width - _loc2_.x,_loc2_.width);
         _loc2_.height = Math.min(this.grid.height - _loc2_.y,_loc2_.height);
         this.updateCrusting(_loc2_);
      }
      
      private function createAssociates(param1:Rectangle) : void
      {
         var tTile:AbstractTile = null;
         var pRect:Rectangle = param1;
         var tTiles:Vector.<AbstractTile> = Vector.<AbstractTile>(this.grid.getSlice(pRect.x,pRect.y,pRect.width,pRect.height));
         var i:int = 0;
         while(i < tTiles.length)
         {
            tTile = tTiles[i];
            if(tTile.needsAssociates)
            {
               if(!tTile.associates || tTile.associates.length == 0)
               {
                  try
                  {
                     this.createAssociatesForTile(tTile);
                  }
                  catch(e:Error)
                  {
                     trace("there was a problem creating associate tiles");
                  }
               }
            }
            i++;
         }
      }
      
      public function get soundEngine() : SoundManager
      {
         return this._soundEngine;
      }
      
      public function invalidate(param1:Rectangle) : void
      {
         this.createAssociates(param1);
         this.updateCrustingWithPadding(param1);
      }
      
      public function addLife(param1:HeartPickup) : void
      {
         OBJECTS_TO_EXCLUDE[param1.uid] = true;
         this._lives = Math.min(MAX_LIVES,this._lives + 1);
      }
      
      public function exitToMenu() : void
      {
         this._state = S_DYING;
         this._lives = 0;
         this.exit();
      }
      
      public function loadLevel(param1:String) : void
      {
         CURRENT_LEVEL_DATA = param1;
         this._currentLevelData = ExportUtil.importByString2(param1);
         this._scroller.grid = this.currentLevelData.grid;
         this.levelPostProcessing();
      }
      
      public function get grid() : Grid
      {
         return this._currentLevelData.grid;
      }
      
      public function clearTiles(param1:Rectangle) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Vector.<int> = null;
         var _loc2_:Grid = this.grid;
         var _loc3_:Vector.<AbstractTile> = Vector.<AbstractTile>(_loc2_.getSlice(param1.x,param1.y,param1.width,param1.height));
         var _loc4_:Vector.<AbstractTile> = new Vector.<AbstractTile>();
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(_loc3_[_loc5_].associates)
            {
               _loc6_ = int(_loc3_[_loc5_].associates.length - 1);
               while(_loc6_ >= 0)
               {
                  _loc4_.push(_loc3_[_loc5_].associates.pop());
                  _loc6_--;
               }
            }
            else
            {
               _loc4_.push(_loc3_[_loc5_]);
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(_loc2_.isInGrid(_loc4_[_loc5_]))
            {
               _loc7_ = _loc2_.getSquareCoords(_loc4_[_loc5_]);
               _loc2_.setSquareAt(_loc7_[0],_loc7_[1],new BlankTile());
            }
            _loc5_++;
         }
      }
      
      private function clear() : void
      {
         if(this._player)
         {
            this._player.die();
            this._player = null;
         }
         if(this._levelEditor)
         {
            this._levelEditor.die();
            this._levelEditor = null;
         }
         this.endGameMusic();
         GarbageUtil.kill(this.display);
         GarbageUtil.kill(this.display2);
         this.updatePlayerDepth();
         CURRENT_UPDATEABLES = null;
         this._state = "null";
         this.hud.visible = false;
      }
      
      private function updateGame() : void
      {
         var _loc2_:Boolean = false;
         if(Boolean(stage) && Boolean(stage.focus))
         {
            stage.focus = null;
         }
         if(DEBUG)
         {
            this.display.graphics.clear();
         }
         this.player.oxygen -= OXYGEN_DECAY;
         if(this.player.oxygen <= 0)
         {
            this.killPlayer();
         }
         var _loc1_:int = 32;
         if(this._inputManager.keyIsDown(KEY_JUMP) || this._inputManager.keyIsDown(KEY_UP))
         {
            _loc2_ = this._player.canJump();
            if(_loc2_)
            {
               if(this._jumpKeyDown == -1)
               {
                  this._jumpTime = _loc1_;
                  this.player.jump();
                  this._jumpKeyDown = this._inputManager.keyIsDown(KEY_JUMP) ? int(KEY_JUMP) : int(KEY_UP);
               }
            }
            else
            {
               if(this._jumpTime > 0 && this._inputManager.keyIsDown(KEY_UP))
               {
                  if(this._jumpKeyDown != KEY_UP)
                  {
                     this._jumpTime = 0;
                  }
               }
               if(this._jumpTime > 0 && this.player.velocity.y > 0)
               {
                  this._jumpTime = 0;
               }
               if(this._jumpTime <= 0)
               {
                  this.player.flyUp();
               }
               else
               {
                  this.player.noFly();
               }
            }
         }
         else
         {
            if(this._jumpTime == _loc1_ - 2)
            {
               this._player.velocity.y += 3;
            }
            else if(this._jumpTime < _loc1_ - 2)
            {
               this._jumpTime = 0;
            }
            this._jumpKeyDown = -1;
            this.player.noFly();
         }
         if(this._jumpTime > 0)
         {
            --this._jumpTime;
         }
         this._player.crouch(this._inputManager.keyIsDown(KEY_DOWN));
         if(this._inputManager.keyIsDown(KEY_LEFT))
         {
            this.player.moveLeft();
         }
         if(this._inputManager.keyIsDown(KEY_RIGHT))
         {
            this.player.moveRight();
         }
         this.gatherWorldObjects();
         this.updateWorldObjects();
         this.updateDisplay();
         this.hud.update();
         if(this._complete)
         {
            this.exit();
         }
      }
      
      public function get oxygenBonus() : int
      {
         return this._oxygenBonus;
      }
      
      public function set soundDisabled(param1:Boolean) : void
      {
         this._soundDisabled = param1;
      }
      
      public function get goalAchieved() : Boolean
      {
         return this.hud.chestsCollected >= this.hud.totalChests;
      }
      
      public function start() : void
      {
         this.clear();
         if(!EDIT)
         {
            this.startPlaying();
         }
         else
         {
            this.startEditing();
         }
      }
      
      private function startPlaying() : void
      {
         this.executeAfterWait(this.doStartPlaying);
      }
      
      public function get targetSFXVolume() : Number
      {
         return this.soundDisabled ? 0 : 1;
      }
      
      public function get particleEngine() : uk.co.kempt.hannah.ParticleEngine
      {
         return this._particleEngine;
      }
      
      public function getWorldObjectPlayerRatio(param1:WorldObject) : Number
      {
         var _loc2_:Number = Math.sqrt(Math.pow(param1.x - this.player.x,2) + Math.pow(param1.y - this.player.y,2));
         var _loc3_:Number = Math.max(0,Math.min(1,_loc2_ / (GAME_WIDTH * 2 / 3)));
         return 1 - _loc3_;
      }
      
      public function get progressData() : ProgressData
      {
         return this._progressData;
      }
      
      private function levelPostProcessing() : void
      {
         this.tileDictionary.clear();
         this.populateLevel();
         this.invalidate(new Rectangle(0,0,this.grid.width,this.grid.height));
         this.updateBounds();
      }
      
      public function set musicDisabled(param1:Boolean) : void
      {
         this._musicDisabled = param1;
         this.updateMusicVolume();
      }
      
      public function executeAfterWait(param1:Function) : void
      {
         if(this._menuMusic)
         {
            this._menuMusic.stopFade();
            this._menuMusic.fadeTo(0,0.8,this.onMenuMusicFaded);
         }
         addChild(this.wait);
         this._waitCallbacks.push(param1);
         this.wait.addEventListener(Event.ENTER_FRAME,this.onWaitEnterFrameEvent,false,0,true);
      }
      
      private function updateEditing() : void
      {
         this._levelEditor.update();
         if(this._levelEditor.dragging)
         {
            this._gameCamera.update(true);
         }
         this.updateDisplay();
      }
      
      private function onWaitEnterFrameEvent(param1:Event) : void
      {
         var _loc3_:Function = null;
         var _loc4_:int = 0;
         if(this.wait.visible)
         {
            if(!this._menuMusic)
            {
               param1.currentTarget.removeEventListener(param1.type,arguments.callee);
               _loc4_ = int(this._waitCallbacks.length);
               while(_loc4_ >= 0)
               {
                  _loc3_ = this._waitCallbacks.shift() as Function;
                  if(_loc3_ != null)
                  {
                     _loc3_.call();
                  }
                  _loc4_--;
               }
               this.wait.visible = false;
            }
         }
         else
         {
            this.wait.visible = true;
         }
      }
      
      private function doStartPlaying() : void
      {
         this.hud.reset();
         this.loadLevel(CURRENT_LEVEL_DATA);
         this._player = new Player();
         SPACES.add(this._player);
         this._state = S_GAME;
         this._complete = false;
         this._gameCamera.following = this._player;
         this.zoom = 1;
         this._deadCount = 0;
         if(!this._menuMusic)
         {
         }
         this.hud.visible = true;
         this.startGameMusic();
         this._player.x = this._startPosition.x;
         this._player.y = this._startPosition.y;
         this._gameCamera.update(true);
         if(this.hud)
         {
            this.hud.visible = true;
         }
         this.display2.addChild(this._player);
         this.display.addChild(this.particleEngine.display);
         this.inputManager.inputEnabled = true;
         this.updateDisplay();
         uk.co.kempt.hannah.GameCamera.ACCELERATION_DAMPENING = 5;
         uk.co.kempt.hannah.GameCamera.ACCELERATION_EXPO = 1.3;
         uk.co.kempt.hannah.GameCamera.DECAY = 1 / 6;
      }
      
      public function get inputManager() : InputManager
      {
         return this._inputManager;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.init();
      }
      
      public function previewLevel() : void
      {
         EDIT = false;
         PREVIEW = true;
         this.clear();
         this._lives = DEFAULT_LIVES;
         this.startPlaying();
      }
      
      public function set zoom(param1:Number) : void
      {
         var value:Number = param1;
         var tValue:Number = Math.round(value * TILE_SIZE) / TILE_SIZE;
         try
         {
            this._scroller.zoom = tValue;
         }
         catch(e:Error)
         {
         }
         this.display.scaleX = this.display.scaleY = tValue;
         this.display2.scaleX = this.display2.scaleY = tValue;
         this.updateBounds();
      }
      
      public function get startPosition() : Point
      {
         return this._startPosition;
      }
      
      private function createAssociatesForTile(param1:AbstractTile) : void
      {
         var _loc5_:Vector.<AbstractTile> = null;
         var _loc6_:int = 0;
         var _loc2_:Vector.<int> = this.grid.getSquareCoords(param1);
         var _loc3_:int = param1.fillWidth * param1.fillHeight;
         var _loc4_:Vector.<IGridSquare> = new Vector.<IGridSquare>();
         var _loc7_:Rectangle = new Rectangle(_loc2_[0],_loc2_[1] - (param1.fillHeight - 1),param1.fillWidth,param1.fillHeight);
         this.clearTiles(_loc7_);
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            if(_loc6_ == _loc3_ - param1.fillWidth)
            {
               _loc4_.push(param1);
            }
            else
            {
               _loc4_.push(new BlankAssociateTile());
            }
            _loc6_++;
         }
         _loc5_ = Vector.<AbstractTile>(_loc4_.slice());
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc5_[_loc6_].associates = _loc5_;
            _loc6_++;
         }
         this.grid.setSubGrid(_loc7_.x,_loc7_.y,_loc7_.width,_loc7_.height,_loc4_);
         this.updateCrustingWithPadding(_loc7_);
      }
      
      public function beginEditing() : void
      {
         this._state = S_EDITING;
         this._levelEditor.init();
         this.startMenuMusic();
      }
      
      public function get display2() : Sprite
      {
         return this._display2 = this._display2 || new Sprite();
      }
      
      private function addWorldBoundaries() : void
      {
         var _loc1_:SolidBlock = null;
         _loc1_ = new SolidBlock();
         _loc1_.blockWidth = this.grid.width * TILE_SIZE;
         _loc1_.y = -TILE_SIZE;
         SPACES.add(_loc1_);
         _loc1_ = new SolidBlock();
         _loc1_.blockHeight = this.grid.height * TILE_SIZE;
         _loc1_.x = -TILE_SIZE;
         SPACES.add(_loc1_);
         _loc1_ = new SolidBlock();
         _loc1_.blockWidth = this.grid.width * TILE_SIZE;
         _loc1_.y = this.grid.height * TILE_SIZE;
         SPACES.add(_loc1_);
         _loc1_ = new SolidBlock();
         _loc1_.blockHeight = this.grid.height * TILE_SIZE;
         _loc1_.x = this.grid.width * TILE_SIZE;
         SPACES.add(_loc1_);
      }
      
      public function get soundDisabled() : Boolean
      {
         return this._soundDisabled;
      }
      
      protected function gameLoop(param1:Event) : void
      {
         switch(this._state)
         {
            case S_GAME:
               this.updateGame();
               break;
            case S_DYING:
               this.updateDying();
               break;
            case S_EDITING:
               this.updateEditing();
         }
      }
      
      public function get gameCamera() : uk.co.kempt.hannah.GameCamera
      {
         return this._gameCamera;
      }
      
      private function updateWorldObjects() : void
      {
         var _loc1_:int = 0;
         var _loc2_:WorldObject = null;
         var _loc3_:int = getTimer();
         _loc1_ = 0;
         while(_loc1_ < CURRENT_UPDATEABLES.length)
         {
            _loc2_ = CURRENT_UPDATEABLES[_loc1_];
            _loc2_.update();
            _loc1_++;
         }
         _loc3_ = getTimer() - _loc3_;
      }
      
      public function restartGame() : void
      {
         this._lives = DEFAULT_LIVES;
      }
      
      private function populateLevel() : void
      {
         var _loc2_:AbstractTile = null;
         var _loc3_:WorldObject = null;
         var _loc4_:Vector.<int> = null;
         SPACES = new Spaces();
         LEVEL_UPDATEABLES = new Vector.<WorldObject>();
         var _loc1_:Vector.<AbstractTile> = Vector.<AbstractTile>(this.grid.getSlice(0,0,this.grid.width,this.grid.height));
         var _loc5_:int = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc5_];
            if(_loc2_ is StartTile)
            {
               _loc4_ = this.grid.getSquareCoords(_loc2_);
               this._startPosition = new Point(_loc4_[0] * TILE_SIZE,_loc4_[1] * TILE_SIZE);
            }
            else if(_loc2_ is TreasureTile)
            {
               if(this.hud)
               {
                  ++this.hud.totalChests;
               }
            }
            else if(_loc2_ is ExitTile)
            {
            }
            if(Boolean(_loc2_.gameObject) && _loc2_.gameObject is WorldObject)
            {
               _loc3_ = _loc2_.gameObject as WorldObject;
               _loc4_ = this.grid.getSquareCoords(_loc2_);
               _loc3_.uid = this._currentLevelData.hash + "_" + _loc4_[0] + "_" + _loc4_[1];
               if(!OBJECTS_TO_EXCLUDE[_loc3_.uid])
               {
                  _loc3_.x = _loc4_[0] * TILE_SIZE;
                  _loc3_.y = _loc4_[1] * TILE_SIZE;
                  if(_loc3_.updateable)
                  {
                     LEVEL_UPDATEABLES.push(_loc3_);
                  }
                  SPACES.add(_loc3_);
                  if(!EDIT && _loc2_.renderable)
                  {
                     this.display2.addChild(_loc3_);
                  }
               }
            }
            _loc5_++;
         }
         this.addWorldBoundaries();
         this._startPosition = this._startPosition || new Point(GAME_WIDTH / 2,GAME_HEIGHT / 2);
      }
      
      public function updateCrusting(param1:Rectangle = null) : void
      {
         var _loc2_:Vector.<AbstractTile> = null;
         var _loc3_:AbstractTile = null;
         var _loc4_:IGridSquare = null;
         var _loc5_:AbstractTile = null;
         if(param1)
         {
            _loc2_ = Vector.<AbstractTile>(this.grid.getSlice(param1.x,param1.y,param1.width,param1.height));
         }
         else
         {
            _loc2_ = Vector.<AbstractTile>(this.grid.getSlice(0,0,this.grid.width,this.grid.height));
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc6_];
            if(_loc3_)
            {
               if(_loc4_ = this.grid.getSquareAbove(_loc3_))
               {
                  _loc5_ = _loc4_ as AbstractTile;
                  _loc3_.crustTop = !(_loc5_ != null && this.checkSprites(_loc3_,_loc5_));
               }
               if(_loc4_ = this.grid.getSquareToRight(_loc3_))
               {
                  _loc5_ = _loc4_ as AbstractTile;
                  _loc3_.crustRight = !(_loc5_ != null && this.checkSprites(_loc3_,_loc5_));
               }
               if(_loc4_ = this.grid.getSquareBelow(_loc3_))
               {
                  _loc5_ = _loc4_ as AbstractTile;
                  _loc3_.crustBottom = !(_loc5_ != null && this.checkSprites(_loc3_,_loc5_));
               }
               if(_loc4_ = this.grid.getSquareToLeft(_loc3_))
               {
                  _loc5_ = _loc4_ as AbstractTile;
                  _loc3_.crustLeft = !(_loc5_ != null && this.checkSprites(_loc3_,_loc5_));
               }
            }
            _loc6_++;
         }
      }
      
      private function gatherWorldObjects() : void
      {
         var _loc2_:int = 0;
         var _loc3_:AbstractTile = null;
         var _loc6_:WorldObject = null;
         var _loc1_:int = 4;
         CURRENT_UPDATEABLES = new Vector.<WorldObject>();
         var _loc4_:int = getTimer();
         var _loc5_:Rectangle = this._scroller.getVisibleArea(this._gameCamera.position,0,0);
         if(this._player)
         {
            CURRENT_UPDATEABLES.push(this._player);
         }
         _loc2_ = 0;
         while(_loc2_ < LEVEL_UPDATEABLES.length)
         {
            if(!(_loc6_ = LEVEL_UPDATEABLES[_loc2_]).dead)
            {
               if(this.worldObjectIsOnScreen(_loc6_))
               {
                  CURRENT_UPDATEABLES.push(_loc6_);
               }
            }
            _loc2_++;
         }
      }
      
      private function endGameMusic() : void
      {
         if(this._bgMusic)
         {
            this._bgMusic.fadeTo(0,0.1,this._bgMusic.die);
            this._bgMusic = null;
         }
      }
      
      private function updateDisplay() : void
      {
         this._gameCamera.update();
         this._background.update(this._gameCamera.viewport);
         var _loc1_:Point = this._gameCamera.position;
         _loc1_.x = Math.floor(_loc1_.x);
         _loc1_.y = Math.floor(_loc1_.y);
         this._scroller.render(_loc1_,0,0);
         this.display2.x = this.display.x = -_loc1_.x;
         this.display2.y = this.display.y = -_loc1_.y;
      }
      
      public function get musicDisabled() : Boolean
      {
         return this._musicDisabled;
      }
      
      private function onDebug(param1:KeyboardEvent) : void
      {
         if(this.player)
         {
            this.player.addToCollection(new BlueKeyPickup());
            this.player.addToCollection(new PurpleKeyPickup());
            this.player.addToCollection(new YellowKeyPickup());
            trace("ALL KEYS GIVEN");
         }
      }
      
      private function worldObjectIsOnScreen(param1:WorldObject) : Boolean
      {
         var _loc2_:Rectangle = this.gameCamera.viewport.clone();
         var _loc3_:Number = 100;
         _loc2_.x -= _loc3_;
         _loc2_.y -= _loc3_;
         _loc2_.width += _loc3_ * 2;
         _loc2_.height += _loc3_ * 2;
         var _loc4_:Boolean = _loc2_.containsPoint(param1.bounds.topLeft);
         var _loc5_:Boolean = _loc2_.containsPoint(param1.bounds.topRight);
         var _loc6_:Boolean = _loc2_.containsPoint(param1.bounds.bottomRight);
         var _loc7_:Boolean = _loc2_.containsPoint(param1.bounds.bottomLeft);
         return _loc4_ || _loc5_ || _loc6_ || _loc7_;
      }
      
      private function onMenuMusicFaded() : void
      {
         if(this._menuMusic)
         {
            this._menuMusic.die();
            this._menuMusic = null;
         }
      }
      
      public function get display() : Sprite
      {
         return this._display = this._display || new Sprite();
      }
      
      public function getWorldObjectScreenRatio(param1:WorldObject) : Number
      {
         return (param1.x - this.gameCamera.position.x - GAME_WIDTH / 2) / (GAME_WIDTH * 2 / 3);
      }
      
      public function get zoom() : Number
      {
         return this._scroller.zoom;
      }
      
      public function get currentLevelData() : LevelData
      {
         return this._currentLevelData;
      }
      
      private function startEditing() : void
      {
         this._levelEditor = new uk.co.kempt.hannah.LevelEditor();
         this._gameCamera.following = this._levelEditor.follower;
         if(this.hud)
         {
            this.hud.visible = false;
         }
         addChild(this._levelEditor);
         uk.co.kempt.hannah.GameCamera.ACCELERATION_DAMPENING = 20;
         uk.co.kempt.hannah.GameCamera.ACCELERATION_EXPO = 1;
         uk.co.kempt.hannah.GameCamera.DECAY = 0.5;
      }
      
      private function get targetMusicVolumeMenu() : Number
      {
         return this.musicDisabled ? 0 : 0.7;
      }
      
      public function levelComplete() : void
      {
         this._fuelBonus = uk.co.kempt.hannah.Engine.instance.hud.fuel.value * 500;
         this._oxygenBonus = uk.co.kempt.hannah.Engine.instance.hud.oxygen.value * 500;
         this._fuelBonus = Math.round(this._fuelBonus / 10) * 10;
         this._oxygenBonus = Math.round(this._oxygenBonus / 10) * 10;
         this._complete = true;
      }
      
      private function updateBounds() : void
      {
         if(EDIT)
         {
            this._gameCamera.scrollBoundsMin = new Point(-Number.MAX_VALUE,-Number.MAX_VALUE);
            this._gameCamera.scrollBoundsMax = new Point(Number.MAX_VALUE,Number.MAX_VALUE);
         }
         else
         {
            this._gameCamera.scrollBoundsMin = new Point(0,-28);
            this._gameCamera.scrollBoundsMax = new Point(this.grid.width * TILE_SIZE - GAME_WIDTH,this.grid.height * TILE_SIZE - GAME_HEIGHT);
         }
      }
      
      public function killPlayer() : void
      {
         if(this._state != S_DYING)
         {
            --this._lives;
            this.player.onTop = true;
            this._state = S_DYING;
            this.endGameMusic();
            this.stopUpdateables();
            this.hud.update();
         }
      }
      
      public function updatePlayerDepth() : void
      {
         var _loc1_:Boolean = !!this.player ? this.player.onTop : true;
         if(_loc1_)
         {
            this._displayContainer.addChild(this._scroller);
            this._displayContainer.addChild(this.display2);
            this._displayContainer.addChild(this.display);
         }
         else
         {
            this._displayContainer.addChild(this.display2);
            this._displayContainer.addChild(this.display);
            this._displayContainer.addChild(this._scroller);
         }
      }
      
      public function get player() : Player
      {
         return this._player;
      }
      
      private function hideChildrenOfParent() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:int = 0;
         if(parent)
         {
            _loc2_ = parent.numChildren - 1;
            while(_loc2_ >= 0)
            {
               _loc1_ = parent.getChildAt(_loc2_);
               if(_loc1_ != this)
               {
                  _loc1_.visible = false;
               }
               _loc2_--;
            }
         }
      }
      
      private function stopUpdateables() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < CURRENT_UPDATEABLES.length)
         {
            CURRENT_UPDATEABLES[_loc1_].stopAnimating();
            _loc1_++;
         }
      }
      
      public function get tileDictionary() : TileDictionary
      {
         return this._tileDictionary;
      }
      
      private function startMenuMusic() : void
      {
         if(!this._menuMusic)
         {
            this._menuMusic = this.soundEngine.loopSound(HannahSounds.MENU_MUSIC,0);
         }
         if(this._menuMusic)
         {
            this._menuMusic.fadeTo(this.targetMusicVolumeMenu,1);
         }
      }
      
      private function updateDying() : void
      {
         this.player.dying();
         this.player.y += this.player.velocity.y;
         this.player.velocity.y += WorldObject.GRAVITY * 1.8;
         if(this._deadCount > GAME_FRAMERATE * 2)
         {
            this.exit();
         }
         else
         {
            ++this._deadCount;
         }
      }
      
      private function onDebug2(param1:KeyboardEvent) : void
      {
         var _loc2_:Number = 2;
         stage.frameRate = stage.frameRate == _loc2_ ? GAME_FRAMERATE : _loc2_;
         trace("FRAMERATE SET AT " + stage.frameRate);
      }
      
      private function onDebug3(param1:KeyboardEvent) : void
      {
         this.progressData.level = LevelData.TOTAL_NUMBER_OF_LEVELS;
         trace("ALL LEVELS UNLOCKED");
         LevelChooser.instance.refresh();
      }
   }
}
