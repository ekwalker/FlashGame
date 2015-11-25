package{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class AgilityEnemy extends MovieClip {
	
		static var speed:Number = 5;
		static var list:Array = new Array();
		
		function AgilityEnemy(){
			speed = Math.min(19, 5 + (AgilityGame.score / 5));
			addEventListener(Event.ENTER_FRAME, enterFrame);
			list.push(this);
		}
		
		function enterFrame(e:Event){
			this.y += speed;
			if(this.hitTestObject(AgilityGame.pet)){
				AgilityGame.enemyShipTimer.stop();
				AgilityGame.gameOver();
			}
			if(this.y >= 595){
				kill();
				AgilityGame.addScore();
			}
		}
		
		function kill(){
			for(var i in list) {
				if(list[i] == this) {
					delete list[i];
				}
			}
			removeEventListener("enterFrame", enterFrame);
			stage.removeChild(this);
		}
		
		static function addShip():AgilityEnemy {
			var enemy = new AgilityEnemy();
			var spawn = Math.random()*3;
			if(spawn < 1) {
				enemy.x = 121;
			} else if(spawn < 2) {
				enemy.x = 375;
			} else {
				enemy.x = 629;
			}
			enemy.y = -54;
			return enemy;
		}
		
		static function addDouble():Array {
			var enemy = new AgilityEnemy();
			var enemyTwo = new AgilityEnemy();
			var spawn = Math.random()*3;
			var enemyList = new Array();
			if(spawn < 1) {
				enemy.x = 375;
				enemyTwo.x = 629;
			} else if(spawn < 2) {
				enemy.x = 121;
				enemyTwo.x = 629;
			} else {
				enemy.x = 121;
				enemyTwo.x = 375;
			}
			enemy.y = -54;
			enemyTwo.y = -54;
			enemyList.push(enemy);
			enemyList.push(enemyTwo);
			return enemyList;
		}
	}
}