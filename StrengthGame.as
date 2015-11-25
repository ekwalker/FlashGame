package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	public class StrengthGame extends MovieClip {

		static var spawnTimer:Timer;
		static var score:Number = 0;
		static var scoreText:TextField;
		static var finalScoreText:TextField;
		static var gameOverMenu:GameOverMenu;
		static var lives:Number = 3;
		static var fullHeart1:FullHeart;
		static var fullHeart2:FullHeart;
		static var fullHeart3:FullHeart;
		static var fullHeartList:Array;
		static var emptyHeart1:EmptyHeart;
		static var emptyHeart2:EmptyHeart;
		static var emptyHeart3:EmptyHeart;
		static var emptyHeartList:Array;
		static var topLayer:TopLayer;
		
		public function StrengthGame() {
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
			scoreText = new TextField();
			scoreText.x = 570;
			scoreText.y = 10;
			var scoreFormat = new TextFormat("Tempus Sans ITC", 28, 0x000000);
			scoreText.defaultTextFormat = scoreFormat;
			scoreText.width = 200;
			scoreText.text = "Score: " + String(0);
			stage.addChild(scoreText);
			spawnTimer = new Timer(1000);
			spawnTimer.addEventListener("timer", spawn);
			spawnTimer.start();
			fullHeart1 = new FullHeart();
			fullHeart1.x = 40;
			fullHeart1.y = 25;
			fullHeart2 = new FullHeart();
			fullHeart2.x = 94;
			fullHeart2.y = 25;
			fullHeart3 = new FullHeart();
			fullHeart3.x = 148;
			fullHeart3.y = 25;
			stage.addChild(fullHeart1);
			stage.addChild(fullHeart2);
			stage.addChild(fullHeart3);
			fullHeartList = new Array(fullHeart1, fullHeart2, fullHeart3);
			emptyHeart1 = new EmptyHeart();
			emptyHeart1.x = 40;
			emptyHeart1.y = 25;
			emptyHeart1.visible = false;
			emptyHeart2 = new EmptyHeart();
			emptyHeart2.x = 94;
			emptyHeart2.y = 25;
			emptyHeart2.visible = false;
			emptyHeart3 = new EmptyHeart();
			emptyHeart3.x = 148;
			emptyHeart3.y = 25;
			emptyHeart3.visible = false;
			stage.addChild(emptyHeart1);
			stage.addChild(emptyHeart2);
			stage.addChild(emptyHeart3);
			emptyHeartList = new Array(emptyHeart1, emptyHeart2, emptyHeart3);
			topLayer = new TopLayer();
			topLayer.x = 364.6;
			topLayer.y = 368.7;
			stage.addChildAt(topLayer, 4);
			gameOverMenu = new GameOverMenu();
			gameOverMenu.x = 375;
			gameOverMenu.y = 300;
			stage.addChildAt(gameOverMenu, 5);
			gameOverMenu.visible = false;
			gameOverMenu.playAgainButton.addEventListener("mouseDown", newGame);
			finalScoreText = new TextField();
			finalScoreText.x = -120;
			finalScoreText.y = -35;
			finalScoreText.width = 300;
			var finalScoreFormat = new TextFormat("Rockwell Extra Bold", 50, 0x00FFCC);
			finalScoreText.defaultTextFormat = finalScoreFormat;
		}
		
		public function spawn(e:Event) {
			var friendlyChance = Math.random() * 100;
			var xlist = new Array(147.2, 295.2, 457.2, 604.2, 147.2, 295.2, 457.2, 604.2, 147.2, 295.2, 457.2, 604.2);
			var ylist = new Array(272.25, 219.5, 272.25, 219.5, 400.8, 341.45, 400.8, 341.45, 527.4, 462.4, 527.4, 462.4);
			var send;
			var sendChance = Math.floor(Math.random() * 12);
			if(friendlyChance < 15) {
				send = new StrengthPet(ylist[sendChance]);
			} else {
				send = new StrengthEnemy(ylist[sendChance]);
			}
			send.x = xlist[sendChance];
			send.y = ylist[sendChance];
			stage.addChildAt(send, 3);
		}
		
		static function updateTextFields():void {
			scoreText.text = "Score: " + String(score);
		}
		
		static function loseLife() {
			lives--;
			emptyHeartList[lives].visible = true;
			fullHeartList[lives].visible = false;
		}
		
		function gameOver() {
			spawnTimer.stop();
			this.removeEventListener(Event.ENTER_FRAME, enterFrame);
			finalScoreText.text = "Score: " + String(score);
			gameOverMenu.addChild(finalScoreText);
			scoreText.visible = false;
			gameOverMenu.visible = true;
			for(var i in StrengthEnemy.list){
				StrengthEnemy.list[i].kill();
			}
			for(var j in StrengthPet.list){
				StrengthPet.list[j].kill();
			}
		}
		
		function newGame(e:Event) {
			for(var i = 0; i < 3; i++) {
				emptyHeartList[i].visible = false;
				fullHeartList[i].visible = true;
			}
			lives = 3;
			gameOverMenu.visible = false;
			score = 0;
			updateTextFields();
			scoreText.visible = true;
			spawnTimer.start();
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		function enterFrame(e:Event) {
			if(lives < 1) {
				gameOver();
			}
			var time:Number = flash.utils.getTimer();
			for(var i in StrengthEnemy.list) {
				if(StrengthEnemy.list[i].duration <= time) {
					StrengthEnemy.list[i].kill();
					loseLife();
					updateTextFields();
				}
			}
			for(var j in StrengthPet.list) {
				if(StrengthPet.list[j].duration <= time) {
					StrengthPet.list[j].kill();
					score++;
					updateTextFields();
				}
			}
		}
	}
}
