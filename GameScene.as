package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	
	public class GameScene extends MovieClip 
	{
		
		private var bitmapManager:BitmapManager = new BitmapManager("Animations.xml");
		private var tileSet:BitmapData;
		private var canvas:BitmapData
		private var backGround:BitmapData;
		private var iteration:int = 0;
		private var animations:Array = new Array();
		var characters:Array = CharacterFactory.createCharacters();
		private var hole:Hole = new Hole();
		
		public function GameScene() {			
			bitmapManager.addEventListener(BitmapManager.TILES_LOADED,startGame);
			
			//var charA:Character = new Character(characters[0].getName(),characters[0].getEvol());
			
			backGround = new BitmapData(800, 600, true, 0x00FF0000);			
			canvas = backGround.clone();			
			var canvasBC:Bitmap = new Bitmap(canvas);			
			addChild(canvasBC);
			
			
			for(var i:int = 0;i<3;i++){
				this.addChild(characters[i]);				
				characters[i].addEventListener("evolve",clickOnChar);
			}
			
			bitmapManager.loadAll();
		}
		
		public function clickOnChar(e:Event) {
			trace("char " +e.target.getName());
			//hole.addEvolution(e.target as Character);
		}
		
		private function startGame(event:Event):void{
			//load bitmaps
			trace("GameScene");
			backGround.copyPixels(bitmapManager.getTileSet("Background"),new Rectangle(0,0,800,600),new Point(0,0));			
			
			/*for (var c:Character in characters)
			{
				c.setAnimations(bitmapManager.getAnimationsFromTileSet("Character"+c.name));
			}*/
			
			characters[0].setAnimations( bitmapManager.getAnimationsFromTileSet("Faith"));
			characters[1].setAnimations( bitmapManager.getAnimationsFromTileSet("Science"));
			characters[2].setAnimations( bitmapManager.getAnimationsFromTileSet("Innocence"));
			characters[0].getEvol().setAnimations(bitmapManager.getAnimationsFromTileSet("EvolutionA"),new Point(200,200));
			//do we need a game loop?
			addEventListener(Event.ENTER_FRAME, gameLoop);
		}
		
		public function gameLoop(e:Event) {
			canvas.copyPixels(backGround,backGround.rect, new Point(0,0));
			drawCanvas();
		}
		
		private function drawCanvas():void {
			iteration++;
			for(var i:int = 0;i<3;i++){
				var tile:BitmapData = characters[i].currentAnimation.getNextFrame();			
				canvas.copyPixels(tile, tile.rect, characters[i].getPosition(), BitmapManager.getAlphaBitmap(tile.width, tile.height), null, true);
			}
			/*
			for(var i:int = 0;i<animations.length;i++){
				var tile:BitmapData = animations[i].getNextFrame();			
				canvas.copyPixels(tile, tile.rect, new Point(50, i * 70 + 50), BitmapManager.getAlphaBitmap(tile.width, tile.height), null, true);
				
			}*/
			
			/*
			var tileEvol:BitmapData = characters[0].getEvol().getCurrentAnimation().getNextFrame();
			
			canvas.copyPixels(tileEvol, tileEvol.rect, characters[0].getEvol().position, BitmapManager.getAlphaBitmap(tileEvol.width, tileEvol.height), null, true);
			*/
		}
	}
}