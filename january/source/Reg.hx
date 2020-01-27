package;

import flixel.math.FlxVector;
import flixel.FlxG;
import flixel.input.FlxInput.FlxInputState;
import openfl.Assets;

class Reg {

	public static var score:Int = 0;

	public static inline var ACT_PLAYER_MOVE_L:Int 	= 	0;
	public static inline var ACT_PLAYER_MOVE_R:Int 	= 	1;
	public static inline var ACT_TONGUE_OUT:Int 	= 	2;
	public static inline var ACT_TONGUE_IN:Int 		= 	3;
	public static inline var ACT_AUTOPILOT:Int 		= 	4;
	public static inline var ACT_IMPROV:Int	 		= 	5;
	public static inline var ACT_GAMEMODE_L:Int		= 	6;
	public static inline var ACT_GAMEMODE_R:Int		= 	7;
	public static inline var ACT_MUSICMODE_L:Int	= 	8;
	public static inline var ACT_MUSICMODE_R:Int	= 	9;
	public static inline var ACT_HUD:Int			= 	10;
	public static inline var ACT_ATTACK_TIME:Int	= 	11;
	public static inline var ACT_RESET:Int			= 	12;
	public static inline var ACT_PEDALPOINT:Int		= 	13;
	public static inline var ACT_PENTATONICS:Int	= 	14;
	public static inline var ACT_SPEEDUP:Int		= 	15;
	public static inline var ACT_CHANGEKEY:Int		= 	16;
	public static inline var ACT_SNOW_FREQ:Int		= 	17;
	public static inline var ACT_NOTE_LENGTH:Int	= 	18;
	public static inline var ACT_NOTE_NAMES:Int		= 	19;
	public static inline var ACT_SAVE:Int			= 	20;
	public static inline var ACT_REVERSE:Int		= 	21;
	public static inline var ACT_ANY:Int			= 	22;


	#if !FLX_NO_KEYBOARD
	public static var ActionsKeys:Array<Array<String>>;

	public static var KEY_DEFAULT_ANY:Array<String> 			= ["ANY"];
	public static var KEY_DEFAULT_PLAYER_MOVE_L:Array<String> 	= ["LEFT", "A"];
	public static var KEY_DEFAULT_PLAYER_MOVE_R:Array<String> 	= ["RIGHT", "D"];
	public static var KEY_DEFAULT_TONGUE_OUT:Array<String> 		= ["UP", "W"];
	public static var KEY_DEFAULT_TONGUE_IN:Array<String> 		= ["DOWN", "S"];
	public static var KEY_DEFAULT_AUTOPILOT:Array<String> 		= ["ZERO"];
	public static var KEY_DEFAULT_IMPROV:Array<String> 			= ["I"];
	public static var KEY_DEFAULT_GAMEMODE_L:Array<String> 		= ["LBRACKET"];
	public static var KEY_DEFAULT_GAMEMODE_R:Array<String> 		= ["RBRACKET"];
	public static var KEY_DEFAULT_MUSICMODE_L:Array<String> 	= ["COMMA"];
	public static var KEY_DEFAULT_MUSICMODE_R:Array<String> 	= ["PERIOD"];
	public static var KEY_DEFAULT_HUD:Array<String> 			= ["H"];
	public static var KEY_DEFAULT_ATTACK_TIME:Array<String>		= ["T"];
	public static var KEY_DEFAULT_RESET:Array<String> 			= ["BACKSLASH"];
	public static var KEY_DEFAULT_PEDALPOINT:Array<String> 		= ["P"];
	public static var KEY_DEFAULT_PENTATONICS:Array<String> 	= ["SLASH"];
	public static var KEY_DEFAULT_SPEEDUP:Array<String> 		= ["CONTROL"];
	public static var KEY_DEFAULT_CHANGEKEY:Array<String> 		= ["K"];
	public static var KEY_DEFAULT_SNOW_FREQ:Array<String> 		= ["PLUS"];
	public static var KEY_DEFAULT_NOTE_LENGTH:Array<String> 	= ["SHIFT"];
	public static var KEY_DEFAULT_NOTE_NAMES:Array<String> 		= ["N"];
	public static var KEY_DEFAULT_SAVE:Array<String>	 		= ["M"];
	public static var KEY_DEFAULT_REVERSE:Array<String>	 		= ["ENTER"];
	#end

	#if !FLX_NO_GAMEPAD
	public static var ActionsButtons:Array<Array<String>>;

	public static var BTN_DEFAULT_ANY:Array<String> 			= ["ANY"];
	public static var BTN_DEFAULT_PLAYER_MOVE_L:Array<String> 	= ["LEFT_STICK_X_NEG"];
	public static var BTN_DEFAULT_PLAYER_MOVE_R:Array<String> 	= ["LEFT_STICK_X_POS"];
	public static var BTN_DEFAULT_TONGUE_OUT:Array<String> 		= ["RIGHT_STICK_Y_NEG"];
	public static var BTN_DEFAULT_TONGUE_IN:Array<String> 		= ["RIGHT_STICK_Y_POS"];
	public static var BTN_DEFAULT_AUTOPILOT:Array<String> 		= ["LEFT_STICK_CLICK"];
	public static var BTN_DEFAULT_IMPROV:Array<String> 			= ["RIGHT_STICK_CLICK"];
	public static var BTN_DEFAULT_GAMEMODE_L:Array<String> 		= ["LEFT_TRIGGER"];
	public static var BTN_DEFAULT_GAMEMODE_R:Array<String> 		= ["RIGHT_TRIGGER"];
	public static var BTN_DEFAULT_MUSICMODE_L:Array<String> 	= ["LEFT_SHOULDER"];
	public static var BTN_DEFAULT_MUSICMODE_R:Array<String> 	= ["RIGHT_SHOULDER"];
	public static var BTN_DEFAULT_HUD:Array<String> 			= [];
	public static var BTN_DEFAULT_ATTACK_TIME:Array<String> 	= ["DPAD_UP"];
	public static var BTN_DEFAULT_RESET:Array<String> 			= ["DPAD_LEFT"];
	public static var BTN_DEFAULT_PEDALPOINT:Array<String> 		= ["A"];
	public static var BTN_DEFAULT_PENTATONICS:Array<String> 	= ["B"];
	public static var BTN_DEFAULT_SPEEDUP:Array<String> 		= ["X"];
	public static var BTN_DEFAULT_CHANGEKEY:Array<String> 		= ["START"];
	public static var BTN_DEFAULT_SNOW_FREQ:Array<String> 		= ["Y"];
	public static var BTN_DEFAULT_NOTE_LENGTH:Array<String> 	= ["DPAD_DOWN"];
	public static var BTN_DEFAULT_NOTE_NAMES:Array<String> 		= ["BACK"];
	public static var BTN_DEFAULT_SAVE:Array<String>	 		= ["GUIDE"];
	public static var BTN_DEFAULT_REVERSE:Array<String>	 		= ["DPAD_RIGHT"];

	public static var wasLeftStickX:Int = 0;
	public static var wasLeftStickY:Int = 0;
	public static var wasRightStickX:Int = 0;
	public static var wasRightStickY:Int = 0;

	public static inline var DEADZONE:Float = .2;
	#end

	#if !FLX_NO_KEYBOARD
	public static function changeKey(ActIndex:Int, ChangeTo:String):Void {

		ChangeTo = StringTools.trim(ChangeTo);
		ActionsKeys[ActIndex] = [];
		var s:EReg = ~/,[\s]*/;
		var splits:Array<String> = s.split(ChangeTo);

		for (r in splits)
			ActionsKeys[ActIndex].push(r);
	}
	#end

	#if !FLX_NO_GAMEPAD
	public static function stickCheck():Void {

		var axesL:FlxVector = FlxG.gamepads.lastActive.getAnalogAxes(LEFT_ANALOG_STICK);
		var axesR:FlxVector = FlxG.gamepads.lastActive.getAnalogAxes(RIGHT_ANALOG_STICK);

		wasLeftStickX  = axesL.x < -DEADZONE ? -1 : axesL.x > DEADZONE ? 1 : 0;
		wasLeftStickY  = axesL.y < -DEADZONE ? -1 : axesL.y > DEADZONE ? 1 : 0;
		wasRightStickX = axesR.x < -DEADZONE ? -1 : axesR.x > DEADZONE ? 1 : 0;
		wasRightStickY = axesR.y < -DEADZONE ? -1 : axesR.y > DEADZONE ? 1 : 0;
	}

	public static function changeButton(ActIndex:Int, ChangeTo:String):Void {

		ChangeTo = StringTools.trim(ChangeTo);
		ActionsButtons[ActIndex] = [];
		var s:EReg = ~/,[\s]*/;
		var splits:Array<String> = s.split(ChangeTo);
		
		for (r in splits)
			ActionsButtons[ActIndex].push(r);
	}
	#end

	public static function initControls():Void {

		// we need to do some complicated file reading and parsing things here

		#if !FLX_NO_KEYBOARD
		ActionsKeys = [];
		ActionsKeys.push(KEY_DEFAULT_PLAYER_MOVE_L);
		ActionsKeys.push(KEY_DEFAULT_PLAYER_MOVE_R);
		ActionsKeys.push(KEY_DEFAULT_TONGUE_OUT);
		ActionsKeys.push(KEY_DEFAULT_TONGUE_IN);
		ActionsKeys.push(KEY_DEFAULT_AUTOPILOT);
		ActionsKeys.push(KEY_DEFAULT_IMPROV);
		ActionsKeys.push(KEY_DEFAULT_GAMEMODE_L);
		ActionsKeys.push(KEY_DEFAULT_GAMEMODE_R);
		ActionsKeys.push(KEY_DEFAULT_MUSICMODE_L);
		ActionsKeys.push(KEY_DEFAULT_MUSICMODE_R);
		ActionsKeys.push(KEY_DEFAULT_HUD);
		ActionsKeys.push(KEY_DEFAULT_ATTACK_TIME);
		ActionsKeys.push(KEY_DEFAULT_RESET);
		ActionsKeys.push(KEY_DEFAULT_PEDALPOINT);
		ActionsKeys.push(KEY_DEFAULT_PENTATONICS);
		ActionsKeys.push(KEY_DEFAULT_SPEEDUP);
		ActionsKeys.push(KEY_DEFAULT_CHANGEKEY);
		ActionsKeys.push(KEY_DEFAULT_SNOW_FREQ);
		ActionsKeys.push(KEY_DEFAULT_NOTE_LENGTH);
		ActionsKeys.push(KEY_DEFAULT_NOTE_NAMES);
		ActionsKeys.push(KEY_DEFAULT_SAVE);
		ActionsKeys.push(KEY_DEFAULT_REVERSE);
		ActionsKeys.push(KEY_DEFAULT_ANY);
		#end

		#if !FLX_NO_GAMEPAD
		ActionsButtons = [];
		ActionsButtons.push(BTN_DEFAULT_PLAYER_MOVE_L);
		ActionsButtons.push(BTN_DEFAULT_PLAYER_MOVE_R);
		ActionsButtons.push(BTN_DEFAULT_TONGUE_OUT);
		ActionsButtons.push(BTN_DEFAULT_TONGUE_IN);
		ActionsButtons.push(BTN_DEFAULT_AUTOPILOT);
		ActionsButtons.push(BTN_DEFAULT_IMPROV);
		ActionsButtons.push(BTN_DEFAULT_GAMEMODE_L);
		ActionsButtons.push(BTN_DEFAULT_GAMEMODE_R);
		ActionsButtons.push(BTN_DEFAULT_MUSICMODE_L);
		ActionsButtons.push(BTN_DEFAULT_MUSICMODE_R);
		ActionsButtons.push(BTN_DEFAULT_HUD);
		ActionsButtons.push(BTN_DEFAULT_ATTACK_TIME);
		ActionsButtons.push(BTN_DEFAULT_RESET);
		ActionsButtons.push(BTN_DEFAULT_PEDALPOINT);
		ActionsButtons.push(BTN_DEFAULT_PENTATONICS);
		ActionsButtons.push(BTN_DEFAULT_SPEEDUP);
		ActionsButtons.push(BTN_DEFAULT_CHANGEKEY);
		ActionsButtons.push(BTN_DEFAULT_SNOW_FREQ);
		ActionsButtons.push(BTN_DEFAULT_NOTE_LENGTH);
		ActionsButtons.push(BTN_DEFAULT_NOTE_NAMES);
		ActionsButtons.push(BTN_DEFAULT_SAVE);
		ActionsButtons.push(BTN_DEFAULT_REVERSE);
		ActionsButtons.push(BTN_DEFAULT_ANY);
		#end

		#if !flash
		var strConfig:String = Assets.getText("config/Controls.cfg");
		var match:EReg = ~/^([A-Z_]*)\s+=\s+([A-Z_,\s]*)$/gm;

		match.map(strConfig, function(r) {
			
			switch(r.matched(1)) {

				#if !FLX_NO_KEYBOARD
				case "KEY_PLAYER_MOVE_L":	changeKey(ACT_PLAYER_MOVE_L, r.matched(2));
				case "KEY_PLAYER_MOVE_R":	changeKey(ACT_PLAYER_MOVE_R, r.matched(2));
				case "KEY_TONGUE_OUT":		changeKey(ACT_TONGUE_OUT, r.matched(2));
				case "KEY_TONGUE_IN":		changeKey(ACT_TONGUE_IN, r.matched(2));
				case "KEY_AUTOPILOT":		changeKey(ACT_AUTOPILOT, r.matched(2));
				case "KEY_IMPROV":			changeKey(ACT_IMPROV, r.matched(2));
				case "KEY_GAMEMODE_L":		changeKey(ACT_GAMEMODE_L, r.matched(2));
				case "KEY_GAMEMODE_R":		changeKey(ACT_GAMEMODE_R, r.matched(2));
				case "KEY_MUSICMODE_L":		changeKey(ACT_MUSICMODE_L, r.matched(2));
				case "KEY_MUSICMODE_R":		changeKey(ACT_MUSICMODE_R, r.matched(2));
				case "KEY_HUD":				changeKey(ACT_HUD, r.matched(2));
				case "KEY_ATTACK_TIME":		changeKey(ACT_ATTACK_TIME, r.matched(2));
				case "KEY_RESET":			changeKey(ACT_RESET, r.matched(2));
				case "KEY_PEDALPOINT":		changeKey(ACT_PEDALPOINT, r.matched(2));
				case "KEY_PENTATONICS":		changeKey(ACT_PENTATONICS, r.matched(2));
				case "KEY_SPEEDUP":			changeKey(ACT_SPEEDUP, r.matched(2));
				case "KEY_CHANGEKEY":		changeKey(ACT_CHANGEKEY, r.matched(2));
				case "KEY_SNOW_FREQ":		changeKey(ACT_SNOW_FREQ, r.matched(2));
				case "KEY_NOTE_LENGTH":		changeKey(ACT_NOTE_LENGTH, r.matched(2));
				case "KEY_NOTE_NAMES":		changeKey(ACT_NOTE_NAMES, r.matched(2));
				case "KEY_SAVE":			changeKey(ACT_SAVE, r.matched(2));
				case "KEY_REVERSE":			changeKey(ACT_REVERSE, r.matched(2));
				#end
				
				#if !FLX_NO_GAMEPAD
				case "BTN_PLAYER_MOVE_L":	changeButton(ACT_PLAYER_MOVE_L, r.matched(2));
				case "BTN_PLAYER_MOVE_R":	changeButton(ACT_PLAYER_MOVE_R, r.matched(2));
				case "BTN_TONGUE_OUT":		changeButton(ACT_TONGUE_OUT, r.matched(2));
				case "BTN_TONGUE_IN":		changeButton(ACT_TONGUE_IN, r.matched(2));
				case "BTN_AUTOPILOT":		changeButton(ACT_AUTOPILOT, r.matched(2));
				case "BTN_IMPROV":			changeButton(ACT_IMPROV, r.matched(2));
				case "BTN_GAMEMODE_L":		changeButton(ACT_GAMEMODE_L, r.matched(2));
				case "BTN_GAMEMODE_R":		changeButton(ACT_GAMEMODE_R, r.matched(2));
				case "BTN_MUSICMODE_L":		changeButton(ACT_MUSICMODE_L, r.matched(2));
				case "BTN_MUSICMODE_R":		changeButton(ACT_MUSICMODE_R, r.matched(2));
				case "BTN_HUD":				changeButton(ACT_HUD, r.matched(2));
				case "BTN_ATTACK_TIME":		changeButton(ACT_ATTACK_TIME, r.matched(2));
				case "BTN_RESET":			changeButton(ACT_RESET, r.matched(2));
				case "BTN_PEDALPOINT":		changeButton(ACT_PEDALPOINT, r.matched(2));
				case "BTN_PENTATONICS":		changeButton(ACT_PENTATONICS, r.matched(2));
				case "BTN_SPEEDUP":			changeButton(ACT_SPEEDUP, r.matched(2));
				case "BTN_CHANGEKEY":		changeButton(ACT_CHANGEKEY, r.matched(2));
				case "BTN_SNOW_FREQ":		changeButton(ACT_SNOW_FREQ, r.matched(2));
				case "BTN_NOTE_LENGTH":		changeButton(ACT_NOTE_LENGTH, r.matched(2));
				case "BTN_NOTE_NAMES":		changeButton(ACT_NOTE_NAMES, r.matched(2));
				case "BTN_SAVE":			changeButton(ACT_SAVE, r.matched(2));
				case "BTN_REVERSE":			changeButton(ACT_REVERSE, r.matched(2));
				#end

				default:
			}

			return '';
		});
		#end
	}

	public static function inputPressed(Input:Int):Bool {

		var isPressed:Bool = false;

		#if !FLX_NO_KEYBOARD
		for (s in ActionsKeys[Input])
			isPressed = isPressed || (s == "ANY" ? FlxG.keys.pressed.ANY : FlxG.keys.checkStatus(FlxKey.fromString(s), FlxInputState.PRESSED));
		#end

		#if !FLX_NO_GAMEPAD
		if (FlxG.gamepads.lastActive != null) {

			var any:Bool = false;
			
			for (s in ActionsButtons[Input]) {

				switch (s) {

					case "LEFT_STICK_X_NEG":  any = isPressed = isPressed || FlxG.gamepads.lastActive.getXAxis(LEFT_ANALOG_STICK) < -DEADZONE;
					case "LEFT_STICK_X_POS":  any = isPressed = isPressed || FlxG.gamepads.lastActive.getXAxis(LEFT_ANALOG_STICK) > DEADZONE;
					case "LEFT_STICK_Y_NEG":  any = isPressed = isPressed || FlxG.gamepads.lastActive.getYAxis(LEFT_ANALOG_STICK) < -DEADZONE;
					case "LEFT_STICK_Y_POS":  any = isPressed = isPressed || FlxG.gamepads.lastActive.getYAxis(LEFT_ANALOG_STICK) > DEADZONE;
					case "RIGHT_STICK_X_NEG": any = isPressed = isPressed || FlxG.gamepads.lastActive.getXAxis(RIGHT_ANALOG_STICK) < -DEADZONE;
					case "RIGHT_STICK_X_POS": any = isPressed = isPressed || FlxG.gamepads.lastActive.getXAxis(RIGHT_ANALOG_STICK) > DEADZONE;
					case "RIGHT_STICK_Y_NEG": any = isPressed = isPressed || FlxG.gamepads.lastActive.getYAxis(RIGHT_ANALOG_STICK) < -DEADZONE;
					case "RIGHT_STICK_Y_POS": any = isPressed = isPressed || FlxG.gamepads.lastActive.getYAxis(RIGHT_ANALOG_STICK) > DEADZONE;
					case "ANY": // note cases never fall through in Haxe.
					default   :
						isPressed = isPressed || FlxG.gamepads.lastActive.checkStatus(FlxGamepadInputID.fromString(s), FlxInputState.PRESSED);
				}

				if (s == "ANY")
					isPressed = isPressed || FlxG.gamepads.lastActive.pressed.ANY || any;
			}
		}
		#end

		return isPressed;
	}

	public static function inputJustPressed(Input:Int):Bool {

		var isPressed:Bool = false;

		#if !FLX_NO_KEYBOARD
		for (s in ActionsKeys[Input]) {

			if (s == "ANY")
				isPressed = isPressed || FlxG.keys.justPressed.ANY;
			else
				isPressed = isPressed || FlxG.keys.checkStatus(FlxKey.fromString(s), FlxInputState.JUST_PRESSED);
		}
		#end

		#if !FLX_NO_GAMEPAD
		if (FlxG.gamepads.lastActive != null) {

			var any:Bool = false;

			for (s in ActionsButtons[Input]) {

				switch (s) {

					case "LEFT_STICK_X_NEG":  any = isPressed = isPressed || (FlxG.gamepads.lastActive.getXAxis(LEFT_ANALOG_STICK) < -DEADZONE && wasLeftStickX == 0);
					case "LEFT_STICK_X_POS":  any = isPressed = isPressed || (FlxG.gamepads.lastActive.getXAxis(LEFT_ANALOG_STICK) > DEADZONE && wasLeftStickX == 0);
					case "LEFT_STICK_Y_NEG":  any = isPressed = isPressed || (FlxG.gamepads.lastActive.getYAxis(LEFT_ANALOG_STICK) < -DEADZONE && wasLeftStickY == 0);
					case "LEFT_STICK_Y_POS":  any = isPressed = isPressed || (FlxG.gamepads.lastActive.getYAxis(LEFT_ANALOG_STICK) > DEADZONE && wasLeftStickY == 0);
					case "RIGHT_STICK_X_NEG": any = isPressed = isPressed || (FlxG.gamepads.lastActive.getXAxis(RIGHT_ANALOG_STICK) < -DEADZONE && wasRightStickX == 0);
					case "RIGHT_STICK_X_POS": any = isPressed = isPressed || (FlxG.gamepads.lastActive.getXAxis(RIGHT_ANALOG_STICK) > DEADZONE && wasRightStickX == 0);
					case "RIGHT_STICK_Y_NEG": any = isPressed = isPressed || (FlxG.gamepads.lastActive.getYAxis(RIGHT_ANALOG_STICK) < -DEADZONE && wasRightStickY == 0);
					case "RIGHT_STICK_Y_POS": any = isPressed = isPressed || (FlxG.gamepads.lastActive.getYAxis(RIGHT_ANALOG_STICK) > DEADZONE && wasRightStickY == 0);
					case "ANY":

					default:
						isPressed = isPressed || FlxG.gamepads.lastActive.checkStatus(FlxGamepadInputID.fromString(s), FlxInputState.JUST_PRESSED);
				}

				if (s == "ANY")
					isPressed = isPressed || FlxG.gamepads.lastActive.justPressed.ANY || any;
			}
		}
		#end

		return isPressed;
	}

	public static function inputJustReleased(Input:Int):Bool {

		var isPressed:Bool = false;

		#if !FLX_NO_KEYBOARD
		for (s in ActionsKeys[Input])
			isPressed = isPressed || (s == "ANY" ? FlxG.keys.justReleased.ANY : FlxG.keys.checkStatus(FlxKey.fromString(s), FlxInputState.JUST_RELEASED));
		#end

		#if !FLX_NO_GAMEPAD
		if (FlxG.gamepads.lastActive != null) {

			var any:Bool = false;
			
			for (s in ActionsButtons[Input]) {

				switch (s) {

					case "LEFT_STICK_X_NEG":  any = isPressed = isPressed || (FlxG.gamepads.lastActive.getXAxis(LEFT_ANALOG_STICK)  == 0 && wasLeftStickX < 0);
					case "LEFT_STICK_X_POS":  any = isPressed = isPressed || (FlxG.gamepads.lastActive.getXAxis(LEFT_ANALOG_STICK)  == 0 && wasLeftStickX > 0);
					case "LEFT_STICK_Y_NEG":  any = isPressed = isPressed || (FlxG.gamepads.lastActive.getYAxis(LEFT_ANALOG_STICK)  == 0 && wasLeftStickY < 0);
					case "LEFT_STICK_Y_POS":  any = isPressed = isPressed || (FlxG.gamepads.lastActive.getYAxis(LEFT_ANALOG_STICK)  == 0 && wasLeftStickY > 0);
					case "RIGHT_STICK_X_NEG": any = isPressed = isPressed || (FlxG.gamepads.lastActive.getXAxis(RIGHT_ANALOG_STICK) == 0 && wasRightStickX < 0);
					case "RIGHT_STICK_X_POS": any = isPressed = isPressed || (FlxG.gamepads.lastActive.getXAxis(RIGHT_ANALOG_STICK) == 0 && wasRightStickX > 0);
					case "RIGHT_STICK_Y_NEG": any = isPressed = isPressed || (FlxG.gamepads.lastActive.getYAxis(RIGHT_ANALOG_STICK) == 0 && wasRightStickY < 0);
					case "RIGHT_STICK_Y_POS": any = isPressed = isPressed || (FlxG.gamepads.lastActive.getYAxis(RIGHT_ANALOG_STICK) == 0 && wasRightStickY > 0);
					case "ANY":
					default   : isPressed = isPressed || FlxG.gamepads.lastActive.checkStatus(FlxGamepadInputID.fromString(s), FlxInputState.JUST_RELEASED);
				}

				if (s == "ANY")
					isPressed = isPressed || FlxG.gamepads.lastActive.justReleased.ANY || any;
			}
		}
		#end

		return isPressed;
	}
}