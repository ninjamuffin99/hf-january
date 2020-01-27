package music;

import openfl.events.MouseEvent;
import openfl.net.FileReference;
import openfl.utils.ByteArray;

/*
	--------------------------------------------------------------------------------------------------------------
	MIDI HEADER
	--------------------------------------------------------------------------------------------------------------

	MIDI section  <-------------MIDI Header---------------> <-----Track Header----> <-Track data-> {Track out>
	Byte number   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 [22 to x]      [x+1 to x+4]
	Byte data     4D 54 68 64 00 00 00 06 00 00 00 01 00 80 4D 54 72 6B 00 00 00 0A blah blah..... 00 FF 2F 00
	MIDI section  A---------> B---------> C---> D---> E---> F---------> G---------> H------------> I--------->

	Here's a rundown of the various sections:
	A = The very first 4 bytes (hex for "MThd") show that the file is a MIDI.
	B = The next four bytes indicate how big the rest of the MIDI Header is (C, D & E). It's always 00000006 for Standard MIDI Files (SMF).
	C = MIDI has sub-formats. 0000 means that's it's a Type-0 MIDI file.
	D = The number should reflect the number of tracks in the MIDI. Type-0 is limited to 1 track.
	E = The speed of the music. The hexadecimal value 80 shown will mean 128 ticks per quarter note (crotchet).
	F = "4D 54 72 6B" is hexadecimal for the ascii "MTrk", and marks the start of the track data.
	G = This should be the number of bytes present in H & I (Track data & Track Out). Shown is 0000000A, so that means 10 more bytes (10 is decimal for hex A).
	H = All of the music data.
	I = 00 FF 2F 00 is required to show that the end of the track has been reached.

	--------------------------------------------------------------------------------------------------------------
	NOTE EVENTS
	--------------------------------------------------------------------------------------------------------------

	Event    <-- NOTE -->
	Byte no. 1  2  3  4
			 00 90 3C 60

	Byte 1 is the time-stamp for each event. The time accumulates for each time-stamp. You can have as many as 4 bytes worth of time-stamp.
	Byte 2 is the Status byte (event type). We'll use 90 here (9_ = Note On, _0 = Channel 0)
	Byte 3 is the note's pitch (3C = middle C).
	Byte 4 is the note's volume (both range from 00 - 7F).

	Subsequent note events with the same status byte can be omitted.

	7F 90 3E 60 means: first wait 7F time units, and then play on channel 0 - the musical note C at volume 60.


	--------------------------------------------------------------------------------------------------------------
*/

class MIDI {

	/** The hexadecimal value of the root note of Key.DATABASE, in Decimal. */
	private static inline var ROOT_NOTE:Int = 48;

	/** PART 1. The Standard MIDI File Header, stored as integers. */
	private static var FILE_HEADER:Array<Int> = [77,84,104,100,0,0,0,6,0,0,0,1];
	/** PART 2. The tempo, stored as hex in decimal. */
	private static var TEMPO:Array<Int> = [0,49];
	/** PART 3. The header for the individual MIDI track. */
	private static var TRACK_HEADER:Array<Int> = [77,84,114,107];
	/** PART 4. The total number of bytes used by track events and the track footer. */
	private static var trackByteTotal:UInt; // 32-bit, ie. 00 00 00 00
	/** PART 5. An array which will populate Track Events. */
	public static var trackEvents:Array<Int> = [];
	/** PART 6. The footer for the MIDI file. */
	private static var TRACK_FOOTER:Array<Int> = [0,255,47,0];	//7F B0 7B 00

	private static var instrument:Int = 0;

	/** The MIDI file, stored as bytes. */
	public static var bytes:ByteArray = new ByteArray();
	/** Used to prompt user for download/dialogue. */
	public static var file:FileReference = new FileReference();
	public static var fileName:String;

	/** The timer used to keep track of time intervals. */
	public static var timer:Float = 0;
	/** The accumulated timer since the beginning of the game. */
	private static var timerAccumulated:Float = 0;
	/** The timestamp to be added to the MIDI file. */
	private static var time:UInt;
	/** The generated time bytes for a given event, stored as an array. */
	private static var timeBytes:Array<Int> = [];

	/** Whether or not new MIDI log has been recorded. */
	public static var logged:Bool;
	/** An object full of the various note values that have been recorded, used to prevent overlaps. */
	private static var pitchesHeard:Map<Int, Int>;
	/** An object full of the various note values that have been recorded, used to prevent overlaps. */
	private static var pitchesHeard2:Map<Int, Int>;
	/** Note Ons that haven't been set to Note Off yet. */
	private static var unresolvedPitches:Array<Int> = [];
	/** Note Ons that haven't been set to Note Off yet. */
	private static var unresolvedPitches2:Array<Int> = [];

	public static function generate(?event:MouseEvent):Void {

		var score:Int = 0;
		var kind:String = "";

		for (key in PlayState.scores.keys()) {

			if (PlayState.scores.get(key) > score) {

				score = PlayState.scores.get(key);
				kind = key;
			}
		}
		
		PlayState.mostLickedScore = score;
		PlayState.mostLickedType = kind;

		// Add Note Off Delay for First Note.
		trackEvents.push(132);

		// Push Note Off Messages for all the Unresolved Note Ons.
		for (g in 0...unresolvedPitches.length) {

			trackEvents.push(0);
			trackEvents.push(128);
			trackEvents.push(unresolvedPitches[g]);
			trackEvents.push(127);
		}

		for (h in 0...unresolvedPitches2.length) {

			trackEvents.push(0);
			trackEvents.push(129);
			trackEvents.push(unresolvedPitches2[h]);
			trackEvents.push(127);
		}

		trackByteTotal = trackEvents.length + TRACK_FOOTER.length;

		for (i in 0...FILE_HEADER.length)
			bytes.writeByte(FILE_HEADER[i]);
		for (j in 0...TEMPO.length)
			bytes.writeByte(TEMPO[j]);
		for (k in 0...TRACK_HEADER.length)
			bytes.writeByte(TRACK_HEADER[k]);
		bytes.writeUnsignedInt(trackByteTotal);
		for (m in 0...trackEvents.length)
				bytes.writeByte(trackEvents[m]);
		for (n in 0...TRACK_FOOTER.length)
			bytes.writeByte(TRACK_FOOTER[n]);

		if (PlayState.mostLickedType == "Transpose")
			fileName = "key_change_conniption_fit.mid";
		else if (PlayState.mostLickedType == "Harmony")
			fileName = "harmonious_harmoniousness.mid";
		else if (PlayState.mostLickedType != "")
			fileName = PlayState.mostLickedScore + "_" + PlayState.mostLickedType + "s.mid";
		else
			fileName = "snow_eating_contest.mid";

		file.save(bytes, fileName);
		bytes.clear();
	}

	public static function log(sound:String, velocity:Float):Void {

		var pitch:Int = 0;
		
		if (sound != null) {

			for (i in 0...Note.DATABASE.length)
				if (sound == Note.DATABASE[i])
					pitch = i + ROOT_NOTE;

			time = Std.int(timer * 100);
			timeBytes = decimalToTimeStamp(time);
			velocity = (0.75 / Note.MAX_VOLUME) * velocity * 127;

			for (j in 0...timeBytes.length)
				trackEvents.push(timeBytes[j]);		//	EVENT TIME (SINCE LAST)

			if (pitchesHeard == null)
				pitchesHeard = new Map<Int, Int>();
			if (pitchesHeard2 == null)
				pitchesHeard2 = new Map<Int, Int>();


			// If we've already heard this pitch before,
			if (SnowflakeManager.timbre != "Secondary" && pitchesHeard.get(pitch) != null) {

				// Add a note off event.
				trackEvents.push(128);		// NOTE OFF
				trackEvents.push(pitch);	// PITCH
				trackEvents.push(127);		// RELEASE VELOCITY
				trackEvents.push(0);		// EVENT TIME (FOR PRECEDING NOTE ON)
			}
			else {

				// Add to the array of heard pitches.
				pitchesHeard.set(pitch, pitch);
				// Push the pitch to the list of unresolved note ons.
				unresolvedPitches.push(pitch);
			}

			if (SnowflakeManager.timbre == "Secondary" && pitchesHeard2.get(pitch) != null) {

				// Add a note off event.
				trackEvents.push(129);		// NOTE OFF
				trackEvents.push(pitch);	// PITCH
				trackEvents.push(127);		// RELEASE VELOCITY
				trackEvents.push(0);		// EVENT TIME (FOR PRECEDING NOTE ON)
			}
			else {

				// Add to the array of heard pitches.
				pitchesHeard2.set(pitch, pitch);
				// Push the pitch to the list of unresolved note ons.
				unresolvedPitches2.push(pitch);
			}

			if (SnowflakeManager.timbre == "Secondary")
				trackEvents.push(145);				//	NOTE ON
			else
				trackEvents.push(144);				//	NOTE ON

			trackEvents.push(pitch);				//	NOTE PITCH
			trackEvents.push(Std.int(velocity));				//	NOTE VELOCITY
			timer = time = 0;

			logged = true;
		}
	}

	private static function decimalToTimeStamp(value:UInt):Array<Int> {

		//Array to contain bytes (up to 4 allowed for timestamp)
		var bytes:Array<Int> = [];

		//if value is too large, truncate to largest allowable time.
		if (value > 268435455) {

			bytes = [0xFF,0xFF,0xFF,0x00];
			return bytes;	// Time Gap Too Large For MIDI Standard
		}

		var quotient:UInt  = 0;

		/*	Convert decimal to timestamp base 128 starting with last byte first.
			The last byte of a timestamp will always be below 0x80 to signal that timestamps end. */
		bytes[0] = (value % 128);			//remainder
		quotient = Math.floor(value/128); 	//quotient

		/*	add 128 decimal to each preceding byte. These bytes will all be over 0x80 (0x80 to 0xFF range), meaning there are more bytes left to read. */
		while (quotient != 0) {

			bytes.unshift((quotient % 128) + 128);
			quotient = Math.floor(quotient/128);
		}

		return bytes;
	}
}