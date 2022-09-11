package {
	import flash.display.*;
	import flash.events.Event;

	public class Plane extends MovieClip {
		// DATA MEMBERS
		private const RIGHT_BOUNDARY: int = 1000;
		private const LEFT_BOUNDARY: int = -200;
		private var velocity: Number;
		private var travelDirection: String;
		public var isActive: Boolean;
		
		// EXPLICIT CONSTRUCTOR
		public function Plane(travelDirection: String, velocity: Number, altitude: Number):void {
			//trace("hello");
			// SET PLANE ATTRIBUTES BASED ON TRAVEL DIRECTION
			this.travelDirection = travelDirection;
			
			if (travelDirection == "left") {
				this.x = LEFT_BOUNDARY;
				this.velocity = velocity;
				this.scaleX = -1; // REVERSE THE IMAGE
			} else if (travelDirection == "right") {
				this.x = RIGHT_BOUNDARY;
				this.velocity = -velocity;
			}
		
		    //SET THE VERTICAL LOCATION OF THE PLANE ALTITUDE
			this.y = altitude;
			this.isActive = true;

		}
			
		// MOVE METHOD "FUNCTIONALITY"
		public function move(): void {
			// TASK 1: UPDATE THE POSITION BY ADDING VELOCITY
			this.x += velocity;

			// TASK 2: CHECK IF A PLANE HAS MOVED BEYOND ITS BOUNDARY
			if (travelDirection == "left" && this.x > RIGHT_BOUNDARY || travelDirection == "right" && this.x < LEFT_BOUNDARY) {
				selfDelete();
			}
		}
			
		// SELFDELETE METHOD
		public function selfDelete():void {
			// TASK 1: SET PLANE AS IN-ACTIVE
			isActive = false;
			
			// TASK 2: REMOVE THE PLANE
			parent.removeChild(this);
		}
	}
}