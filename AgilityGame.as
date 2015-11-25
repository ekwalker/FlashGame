package {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class AgilityGame extends MovieClip {
		
		static var pet:MovieClip;
		static var enemyShipTimer:Timer;
		static var score:Number = 0;
		static var scoreText:TextField;
		static var finalScoreText:TextField;
		static var gameOverMenu:GameOverMenu;
		var doubleChance:Number;
		
		function AgilityGame() {
			pet = new AgilityPet();
			addChild(pet);
			pet.x = 375;
			pet.y = 500;
			scoreText = new TextField();
			scoreText.x = 570;
			scoreText.y = 10;
			var scoreFormat = new TextFormat("Tempus Sans ITC", 28, 0x000000);
			scoreText.defaultTextFormat = scoreFormat;
			scoreText.width = 200;
			scoreText.text = "Score: " + String(0);
			addChild(scoreText);
			enemyShipTimer = new Timer(1460);
			enemyShipTimer.addEventListener("timer", sendEnemy);
			enemyShipTimer.start();
			gameOverMenu = new GameOverMenu();
			gameOverMenu.x = 375;
			gameOverMenu.y = 300;
			addChild(gameOverMenu);
			gameOverMenu.visible = false;
			gameOverMenu.playAgainButton.addEventListener("mouseDown", newGame);
			finalScoreText = new TextField();
			finalScoreText.x = -120;
			finalScoreText.y = -35;
			finalScoreText.width = 300;
			var finalScoreFormat = new TextFormat("Rockwell Extra Bold", 50, 0x00FFCC);
			finalScoreText.defaultTextFormat = finalScoreFormat;
		}
		
		function sendEnemy(e:Event){
			if(score > 68) {
				enemyShipTimer.delay = Math.max(300, 400 - ((score - 68) * 2));
			} else if(score > 48) {
				enemyShipTimer.delay = 500 - ((score - 48) * 5);
			} else {
				enemyShipTimer.delay = 1460 - (score * 20);
			}
			doubleChance = 10 + (score / 5);
			var rand = Math.random() * 100;
			if(rand <= doubleChance){
				var enemyList = AgilityEnemy.addDouble();
				stage.addChildAt(enemyList[0], 0);
				stage.addChildAt(enemyList[1], 0);
			} else {
				var enemy = AgilityEnemy.addShip();
				stage.addChildAt(enemy, 0);
			}
		} 
		
		static function addScore() {
			score++;
			updateTextFields();
		}
		
		static function updateTextFields():void {
			scoreText.text = "Score: " + String(score);
		}
		
		static function gameOver(){
			finalScoreText.text = "Score: " + String(score);
			gameOverMenu.addChild(finalScoreText);
			scoreText.visible = false;
			pet.visible = false;
			gameOverMenu.visible = true;
			for(var i in AgilityEnemy.list){
				AgilityEnemy.list[i].kill();
			}
		}
		
		function newGame(e:Event){
			gameOverMenu.visible = false;
			pet.visible = true;
			pet.x = 375;
			pet.y = 500;
			AgilityPet.position = 2;
			score = 0;
			updateTextFields();
			scoreText.visible = true;
			enemyShipTimer.start();
		}
	}
}