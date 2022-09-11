package {
	import flash.display.*;
	import flash.events.*;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.utils.Timer;
	import flash.globalization.LastOperationStatus;

	// THE EXPLOSITION GOES IN THIS CLASS
	public class SimpleShooter extends MovieClip {

		//GAME ELEMENTS
		private var planeList: Array;
		private var schedulePlaneInterval: int;
		private var schedulePlaneIntervalLimit: int;
		private var bulletLauncher: BulletLauncher;
		private var myBullet: Bullet;
		private var myBoom: Boom;
		private var collisionSound: Sound = new Sound();
		private var clicksLauncher: int;
		private var myTime: Number = 10;
		private var bulletTimer: Timer = new Timer(1000, myTime);

		// CONSTRUCTOR
		public function SimpleShooter() {

			planeList = new Array();
			schedulePlaneInterval = 0;
			schedulePlaneIntervalLimit = 20;

			bulletLauncher = new BulletLauncher();
			addChild(bulletLauncher);


			addEventListener(Event.ENTER_FRAME, updateGame);

			// METHOD FOR BULLET MouseEVENT
			addEventListener(MouseEvent.CLICK, addBullet);

			// METHOD FOR COLLISION TEST
			addEventListener(Event.ENTER_FRAME, collisionTest);
		}

		//****************** UPDATE GAME: MOVE ALL PLANES, COLLISION DETECTION, ETC.  ********************************
		public function updateGame(event: Event) {
			//TASK 1: SCHEDULE PLANES TO APPEAR AT INTERVALS
			schedulePlaneInterval++;
			if (schedulePlaneInterval >= schedulePlaneIntervalLimit) {
				scheduleNextPlane();
			}

			//TAKS 2: MOVE ACTIVE PLANES AND REMOVE INACTIVE PLANES
			for (var i: int = 0; i < planeList.length; i++) {
				planeList[i].move();

				//****************** REMOVAL OF AN INACTIVE PLANE********************************
				if (!planeList[i].isActive) {
					planeList.splice(i, 1);
				}
			}
		}

		public function scheduleNextPlane() {
			//TASK 1: RESET SCHEDULE INTERVAL COUNT AND TIME LIMIT
			schedulePlaneInterval = 0;
			schedulePlaneIntervalLimit = Math.random() * 40 + 10;

			//CREATE A RANDOM PLANE AND ADD IT TO THE SCREEN
			var travelDirection: String = "right";
			if (Math.random() > .5) {
				travelDirection = "left";
			}
			var velocity: Number = Math.random() * 3 + 10;
			var altitude: Number = Math.random() * 100 + 100;

			// CREATE A NEW PLANE AND ADD IT TO THE STAGE	
			var p: Plane;
			//THREE TYPES OF PLANES
			var planeType = (int)(Math.random() * 3 + 1);

			switch (planeType) {
				case 1:
					p = new Helicopter(travelDirection, velocity, altitude);
					break;
				case 2:
					p = new SeaPlane(travelDirection, velocity, altitude);
					break;
				case 3:
					p = new Airplane(travelDirection, velocity, altitude);
					break;
			}

			addChild(p);
			planeList.push(p);
		}

		//****************** MOUSE EVENT: WHEN MOUSE CLICK BULLETS FLY  ********************************
		// KEYBOARD EVENT FOR THE BULLET TO SHOOT UPWARDS
		private function addBullet(event: MouseEvent): void {
			// TASK: ADD A BULLET OF FOOD TO THE STAGE
			myBullet = new Bullet();
			addChild(myBullet);
			clicksLauncher++;
			trace("Total clicks is: " + clicksLauncher);

			if (clicksLauncher >= 10) {
				bulletTimer.addEventListener(TimerEvent.TIMER, countDown);
				bulletTimer.start();
			}
		}
		//****************** TIMER EVENT: FOR EACH BULLET IT COUNTS AND COUNTDOWN  **************************
		public function countDown(event: TimerEvent) {
			if (myTime > 1) {
				myTime--;
				bulletLauncher.removeEventListener(MouseEvent.CLICK, addBullet);
				trace("Countdown in: " + myTime);
			} else {
				clicksLauncher = 0;
				bulletLauncher.addEventListener(MouseEvent.CLICK, addBullet);
				myTime = 5;
				bulletTimer = new Timer(5000, myTime);
				trace("Timer is done!");
			}
		}

		//****************** TEST FOR COLLISON EVENT: WHEN BULLETS HITS PLANE *****************************
		public function collisionTest(event: Event) {
			for (var i: uint = 0; i < planeList.length; i++) {
				if (myBullet.hitTestObject(planeList[i])) {
					removeChild(planeList[i]);

					if (i == 0) {
						planeList.shift();
					} else {
						planeList.splice(i, 1);
						i--;
					}
					// REMOVE THE BULLET AFTER COLLISION
					removeChild(myBullet);
					/*
					addEventListener(MouseEvent.CLICK, imageDisplay);
					function imageDisplay(): void {
						myBoom = new Boom();
						addChild(myBoom);						
					}
					*/
				}
			}
		}
	}
}