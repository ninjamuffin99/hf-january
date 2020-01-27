package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;

class Player extends FlxSprite {

	/** Initial Player X Position. */
	public static inline var X_INIT:Int = 20;
	/** Size of the player's boundary on the left side of the screen, in pixels. */
	private var boundsLeft:Int = 0;
	/** Whether the player has stopped moving. */
	private var stopped:Bool = false;
	/** Whether the player's tongue is up. */
	public var tongueUp:Bool = false;
	
	/** constructor */
	public function new() {

		x = X_INIT;
		y = 79;

		super(x, y);
		loadGraphic(AssetPaths.player1__png, true, 16, 33);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		width    = 10;
		height   = 3;
		offset.x = 4;
		offset.y = 7;

		// Set player's x position bounds
		boundsLeft = 2;

		// Add animations.
		animation.add("idle", [78,79,80,81,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0], 6, false);
		animation.add("tongueUpStopped", [73,74,75,76,5,5,5,5,5,6,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,6,5], 6, false);
		animation.add("tongueUp", [2,3,4,5], 18, false);
		animation.add("tongueDown", [4,3,2,0], 18, false);
		animation.add("walk", [33,35,37,7,9,11,13,15,17,19,21,23,25,27,29,31], 12);
		animation.add("walkTongue", [66,68,70,40,42,44,46,48,50,52,54,56,58,60,62,64], 12);

		animation.add("run", animation.getByName("walk").frames, 16);
		animation.add("runTongue", animation.getByName("walkTongue").frames, 16);
	}

	override public function update(elapsed:Float):Void {

		//////////////
		// MOVEMENT //
		//////////////

		acceleration.x = 0;
		maxVelocity.x  = Reg.inputPressed(Reg.ACT_SPEEDUP) ? 55 : 35;

		// slow down during certain parts of the walk cycle.
		if ((animation.frameIndex > 10 && animation.frameIndex < 15) ||
			(animation.frameIndex > 26 && animation.frameIndex < 32) ||
			(animation.frameIndex > 43 && animation.frameIndex < 48) ||
			(animation.frameIndex > 59 && animation.frameIndex < 65))
			maxVelocity.x -= 15;
		
		var left: Bool = Reg.inputPressed(Reg.ACT_PLAYER_MOVE_L) || (PlayState.onAutoPilot && PlayState.autoPilotMovement == "Left");
		var right:Bool = Reg.inputPressed(Reg.ACT_PLAYER_MOVE_R) || (PlayState.onAutoPilot && PlayState.autoPilotMovement == "Right");
		
		// stand still if pressing both left and right.
		if ((left && right) || (PlayState.onAutoPilot && PlayState.autoPilotMovement == "Still"))
			left = right = false;
			
		if (left) {

			facing = FlxObject.LEFT;
			SnowflakeManager.timbre = "Secondary";
			velocity.x = -maxVelocity.x;
		}
		else if (right) {

			facing = FlxObject.RIGHT;
			SnowflakeManager.timbre = "Primary";
			velocity.x = maxVelocity.x;
		}

		if (!left && !right) {

			drag.x = 100;
			stopped = true;
		}

		///////////////
		// ANIMATION //
		///////////////

		var up:Bool   = Reg.inputPressed(Reg.ACT_TONGUE_OUT); 
		var down:Bool = Reg.inputPressed(Reg.ACT_TONGUE_IN);

		if (velocity.x != 0) {

			var animPrefix:String = Reg.inputPressed(Reg.ACT_SPEEDUP) ? "run" : "walk";

			animation.play(tongueUp ? animPrefix + "Tongue" : animPrefix);

			// tongue changes are toggle based.
			tongueUp = up ? true : down ? false : tongueUp;
		}
		else { // if player velocity is 0

			// and still looking up
			if (tongueUp == false && up) {

				animation.play("tongueUp",true);
				tongueUp = true;
			}
			else if (tongueUp == true && down) {

				animation.play("tongueDown",true);
				tongueUp = false;
			}

			if (stopped == true)
				animation.play(tongueUp ? "tongueUpStopped" : "idle");

			stopped = false;
		}

		super.update(elapsed);

		// wrap player around the screen.
		x = x < -1 * width ? FlxG.width : x > FlxG.width + width ? -1 * width : x;
	}
}