package {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.display.Stage;

	public class AgilityPet extends MovieClip {
		static var position:Number = 2;
		
		function AgilityPet() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		function init(e:Event) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, move);
		}
		
		function move(event:KeyboardEvent) {
			if(event.keyCode == Keyboard.RIGHT) {
				if(position < 3) {
					this.x = this.x + 242;
					position++;
				}
			}
			if(event.keyCode == Keyboard.LEFT) {
				if(position > 1) {
					this.x = this.x - 242;
					position--;
				}
			}
		}
	}
}