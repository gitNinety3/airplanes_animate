package  {
	import flash.display.*;
	import flash.events.Event;
	//import flash.utils.getTimer;
	import flash.events.MouseEvent;
	
	public class Bullet extends MovieClip {
		// DATA MEMBERS
		private var travelDirection: String;
		private var velocity: int = 10;
		private var remove: Object;
		private var clicked: int = 0;
		
		// FOR ELAPSED TIME
		private var vx: Number; 	// VELOCITY  FOR X
		//private var lastTime: int;

		// CONSTUCTOR
		public function Bullet() {
			this.x = 475.5;
			this.y = 442;
			
			// TASK: MAKE THE BULLET FLY UP 
			addEventListener(Event.ENTER_FRAME, removeBullet);
		
			// TASK 3: ADD A GAME LOOP, THE ENTER_FRAME LISTENER EVENT
			addEventListener(Event.ENTER_FRAME, shootBullet);
			
		}
	
		public function removeBullet(event:Event) {
			// when button is press bullet is suppse to go in the negative 
			//	y direction and be removed once it leaves the stage
			remove = MovieClip(root);
		}
	
		public function shootBullet(event:Event) {
			/*
			// TASK 1: COMPUTE THE ELAPSED TIME.
			var timePassed: int = getTimer() - lastTime;
			lastTime +=  timePassed;
			
			// FOR BULLET COUNTS
			// TASK 4: COUNT THE NUMBER OF BULLETS
			addEventListener(MouseEvent.CLICK, addClick);
			function addClick(event:MouseEvent): void {
				clicked++;
			}
			//trace ("Bullet: " + clicked + " in: " + lastTime + " mili-seconds");
			trace (lastTime);
			*/
			// FIRE BULLETS IN THE -Y DIRECTION
			y -= velocity;
			if (this.y < -1 * this.height) {
				removeEventListener(Event.ENTER_FRAME, shootBullet);
				remove.removeChild(this);
			}
		}
	}
}

