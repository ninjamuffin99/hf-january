package;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.display.Sprite;
import openfl.Lib;

class Main extends Sprite {
	
	/** Width of the game in pixels (might be less / more in actual pixels depending on your zoom). */
	var gameWidth:Int = 240;
	/** Height of the game in pixels (might be less / more in actual pixels depending on your zoom). */
	var gameHeight:Int = 110;
	/** The FlxState the game starts with. */
	var initialState:Class<FlxState> = MenuState;
	/** If -1, zoom is automatically calculated to fit the window dimensions. */
	var zoom:Float = 3;
	/** How many frames per second the game should run at. */
	var framerate:Int = 60;
	/** Whether to skip the flixel splash screen that appears in release mode. */
	var skipSplash:Bool = true;
	/** Whether to start the game in fullscreen on desktop targets */
	var startFullscreen:Bool = true;

	/** You can pretty much ignore everything from here on - your code should go in your states. */
	public function new() {

		super();
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1) {

			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		Reg.initControls();
		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));

		FlxG.scaleMode = new flixel.system.scaleModes.PixelPerfectScaleMode();

		#if !FLX_NO_KEYBOARD
		FlxG.sound.muteKeys = null;
		FlxG.sound.volumeDownKeys = null;
		FlxG.sound.volumeUpKeys = null;
		#end
	}
}