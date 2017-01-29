# hf-january
Disasterpeace's January, ported to HaxeFlixel by @SeiferTim

January is a generative music tool. You walk around and look up to lick snowflakes with your tongue. The tool uses a set of rules to make choices about what pitch the next note (or notes) will be. It also gives the player freedom to play various types of chords, and choose when and how notes will be played. There are a bunch of advanced features, which you can explore below. It was made with Flixel and Flash/AS3.

It has since been ported to HaxeFlixel, which allows for native binaries for PC, Mac, etc. Some new features have also been added in the process.

*Basic Controls*

Use the `ARROW KEYS` or `WASD` to move around and use your tongue.

*Advanced Controls*

Use the `BRACKETS` to toggle through the game modes:<br>
"Write" is the default mode<br>
"Repeat" allows you to repeat up to the last 8 notes from Write mode.<br>
"Detour" allows you to generate notes freely without effecting your Repeat sequence.

Use `ENTER` to reverse the order of your Repeat sequence.<br>
Use `BACKSLASH` to reset your sequence in Write mode. Use it to go back to the beginning of your sequence in Repeat mode.

Use `H` to toggle display of the HUD, which shows note information.<br>
Use `N` to toggle display of note names.<br>
Use `M` to toggle display of a button for saving your performance to a MIDI file!

Use `T` to change the attack time of the notes. (Fast, Medium, Slow, or Molasses).<br>
Use `SHIFT` to change the note lengths (Random, Short, Medium, or Full).

Use `PLUS` to change the amount of snowfall. (Flurry, Shower, or Blizzard).

Use `K` to change the Musical Key! (C, or A).<br>
Use `COMMA, PERIOD` to toggle through modes (Ionian, Dorian, Lydian, Mixolydian, or Aeolian)<br>
Use `SLASH`. to toggle Pentatonics Mode. Turns the current scale/mode into its simpler Pentatonic version.<br>
Use `P`. to toggle Pedal Point Mode. Adds pedal tones (a root or fifth note) to non-chord generating snowflakes.

`I`. Improv Move - January will periodically change things for you!<br>
`ZERO`. Auto Pilot, if you want to see/hear the tool play itself!<br>

`CONTROL`. Hold this to move really fast! (aka cheat)

Gamepads are also supported. Controls can be customized by editing the Controls.cfg file.
