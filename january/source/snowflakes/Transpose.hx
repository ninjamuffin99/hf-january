package snowflakes;
import flixel.FlxG;
import music.Key;
import music.Mode;
import music.Note;

/** A snowflake that plays a chord in a new key and mode. */
class Transpose extends Snowflake {

	public function new() {
		super();

		loadGraphic(AssetPaths.transpose__png, true, 5, 6);

		windY = 15;

		animation.add("default", [0,1,2,3,4,3,2,1], 3, true);

		volume = FlxG.random.float(Note.MAX_VOLUME * 0.33, Note.MAX_VOLUME * 0.83);
	}

	public override function onLick():Void {
		super.onLick();

		Mode.change();
		Key.change();
		fadeOutDissonance();
		playChord();
	}

	public override function update(elapsed:Float):Void {

		super.update(elapsed);
		animation.play("default");
	}

	// THIS DOESN'T PLAY NICE WITH SHORTENED NOTES (aka notes that are already fading)
	private function fadeOutDissonance():Void {

		var sound:PlayState.SoundDef;
		var newKey:Array<String> = Key.current == "C Major" ? Key.C_MAJOR : Key.C_MINOR;

		// Run through all sounds.
		for (sound in PlayState.sounds) {

			var noteOk:Bool = false;

			// If the sound has volume,
			if (sound.note != null && sound.note.active == true) {
				
				// Compare to current key notes.
				for (note in newKey) {

					if (sound.name == note || sound.name == "_" + note) {

						noteOk = true;
						break;
					}
				}

				if (noteOk)
					continue;

				// If a note made it this far, it's not in the current key, so fade it out.
				if (sound.note.tweening)
					sound.note.tween.cancel();

				sound.note.fadeO(0.2);
			}
		}
	}
}