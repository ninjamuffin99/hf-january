package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import music.Note;
import music.Pedal;
import music.Playback;

class Text extends FlxText {

	/** The number of seconds to hold the text before it starts to fade. */
	private static var lifespan: Float = 0;

	/** The gutter size, used to keep text off screen edges. */
	public static inline var GUTTER: Int = 5;

	public function new(_color: FlxColor = 0xFFFFFFFF) {

		x = -15;
		y = -15;

		super(x, y, 0);
		moves = true;
		velocity.y = -8;
		font = AssetPaths.frucade__ttf;
		alpha = 0;
		color = _color;
	}

	/**
	 * onLick() - Figures out what text to display next, and where to display it so it looks nice.
	 *
	 * @param flakeType
	 */
	public function onLick(SnowRef: Snowflake):Void {

		var _text:String = "";

		// Store the number of the current place in the playback sequence when appropriate.
		if (SnowRef.playsNote) {

			if (Playback.mode == "Repeat") {

				if (Playback.reverse == false)
					_text = Std.string((Playback.index != 0 ? Playback.index : Playback.sequence.length));
				else
					_text = Playback.index + 2 == Playback.sequence.length + 1 ? "1" : Std.string(Playback.index + 2);
			}
			else if (PlayState.inSpellMode) {

				_text = Std.string(HUD.enharmonic(SnowRef.noteName, true));

				if (SnowRef.type == "Harmony")
					_text += "+" + Std.string(HUD.enharmonic(Note.lastHarmony, true));
				else if (SnowRef.type == "Octave")
					_text += "+" + Std.string(HUD.enharmonic(Note.lastOctave, true));

				if (Pedal.mode)
					_text += "/" + Std.string(HUD.enharmonic(Note.lastPedal, true));
			}
		}
		else if (PlayState.inSpellMode)
			_text = Std.string(HUD.modeName);

		// Show the new text feedback.
		if (_text != "")
			show(_text, Playback.mode == "Repeat" ? 5 : 10);
	}

	public function show(newText: String, offset: Int = 10):Void {

		lifespan = 1;
		text = newText;
		alpha = 1;
		maxVelocity.y = 0;
		drag.y = 0;
		x = PlayState.player.x;
		y = PlayState.player.y - 10;

		if (PlayState.player.facing == LEFT)
		{

			x-= width;// + offset;

			// Check Bounds on Left Side
			if (PlayState.player.x - width < GUTTER)
				x = GUTTER;
		}
		else { // facing == RIGHT

			x += offset;

			// Check Bounds on Right Side
			if (PlayState.player.x + width > FlxG.width - GUTTER)
				x = FlxG.width - GUTTER - width;
		}
	}

	override public function update(elapsed:Float):Void {

		velocity.x = -1 * (Math.cos(y / 4) * 8);
		maxVelocity.y = 20;
		drag.y = 5;
		acceleration.y -= drag.y;

		super.update(elapsed);

		if (lifespan > 0)
			lifespan -= elapsed;
		else
			alpha -= (elapsed/2);

		alpha = Math.max(alpha, 0);
	}
}