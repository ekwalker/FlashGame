package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.MouseEvent; 
	
	public class StrengthEnemy extends MovieClip {
		
		static var list:Array = new Array();
		public var duration:Number;
		private var ylevel:Number;
		private var down:Boolean;

		public function StrengthEnemy(y_level:Number) {
			ylevel = y_level;
			var down = false;
			this.addEventListener(MouseEvent.CLICK, click);
			this.addEventListener(Event.ENTER_FRAME, move);
			this.duration = flash.utils.getTimer() + 1500;
			list.push(this);
		}
		
		public function kill(){
			for(var i in list) {
				if(list[i] == this) {
					delete list[i];
				}
			}
			this.removeEventListener(MouseEvent.CLICK, click);
			stage.removeChild(this);
		}
		
		function click(event:MouseEvent) {
			for(var i in list) {
				if(list[i] == this) {
					delete list[i];
				}
			}
			this.removeEventListener(MouseEvent.CLICK, click);
			stage.removeChild(this);
			StrengthGame.score++;
			StrengthGame.updateTextFields();
		}
		
		function move(e:Event) {
			var moveSpeed = 2;
			if(this.down) {
				if(y < this.ylevel) {
					y += moveSpeed;
				}
			} else {
				if(y > this.ylevel - 60) {
					y -= moveSpeed;
				} else {
					this.down = true;
				}
			} 
		}
	}
}
