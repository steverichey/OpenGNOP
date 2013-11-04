package;

import flash.display.Bitmap;
import flash.events.Event;
import flash.geom.Point;
import haxe.Log;
import openfl.Assets;

class Gnop extends BunState
{
	private var splash:BunWindow;
	private var menu:BunMenu;
	private var tinyicon:Bitmap;
	private var about:BunWindowExt;
	private var endscore:BunWindowExt;
	private var instructions:BunWindowExt;
	
	private var playerPaddleSize:Int = 1;
	private var computerPaddleSize:Int = 1;
	private var ballSize:Int = 1;
	private var ballSpeed:Int = 1;
	private var difficulty:Int = 1;
	private var endScore:Int = 4;
	private var sound:Bool = true;
	
	private static inline var ABOUT_GNOP:Int = 0;
	private static inline var SET_ENDING_SCORE:Int = 1;
	private static inline var INSTRUCTIONS:Int = 2;
	
	private static inline var ABOUT_X:Int = 4;
	private static inline var ABOUT_Y:Int = 26;
	private static inline var ABOUT_WIDTH:Int = 474;
	private static inline var ABOUT_HEIGHT:Int = 314;
	private static inline var ABOUT_OK_X:Int = 361;
	private static inline var ABOUT_OK_Y:Int = 191;
	
	private static inline var SET_X:Int = 75;
	private static inline var SET_Y:Int = 45;
	private static inline var SET_WIDTH:Int = 232;
	private static inline var SET_HEIGHT:Int = 120;
	private static inline var SET_OK_X:Int = 122;
	private static inline var SET_OK_Y:Int = 67;
	private static inline var SET_CANCEL_X:Int = 46;
	private static inline var SET_CANCEL_Y:Int = 71;
	
	private static inline var INSTRUCTIONS_X:Int = 20;
	private static inline var INSTRUCTIONS_Y:Int = 27;
	private static inline var INSTRUCTIONS_WIDTH:Int = 424;
	private static inline var INSTRUCTIONS_HEIGHT:Int = 312;
	private static inline var INSTRUCTIONS_OK_X:Int = 180;
	private static inline var INSTRUCTIONS_OK_Y:Int = 269;
	
	// about image is 21,12 from top-left of white
	// instructions image is 27,12 from top-left of white
	// score warning image is 23,13 from top-left of white
	//         TODO: simplify score warning to just use hand sign as image
	// score set image is 35,22 from top-left of white
	//         TODO: simplify this window, doesn't even need image
	
	public function new()
	{
		super();
	}
	
	override public function init( e:Event = null ):Void
	{
		super.init( e );
		
		// Add the initial splash screen.
		
		splash = new BunWindow( 502, 312, BunWindow.SHADOWED, Assets.getBitmapData( "images/splash.png" ), 57, 49 );
		splash.x = 69;
		splash.y = 94;
		addChild( splash );
		
		// Add the "tiny icon" in the top menu.
		
		tinyicon = new Bitmap( Assets.getBitmapData( "images/icon_tiny.png" ) );
		tinyicon.x = 609;
		tinyicon.y = 5;
		addChild( tinyicon );
		
		// Add the top menu.
		
		menu = new BunMenu( getMenuItems() );
		addChild( menu );
		
		// setup child windows
		
		about = new BunWindowExt( ABOUT_WIDTH, ABOUT_HEIGHT, BunWindow.BORDERED, Assets.getBitmapData( "images/about.png" ), 21, 12 );
		about.x = ABOUT_X;
		about.y = ABOUT_Y;
		about.addOk( ABOUT_OK_X, ABOUT_OK_Y );
		about.visible = false;
		addChild( about );
		
		instructions = new BunWindowExt( INSTRUCTIONS_WIDTH, INSTRUCTIONS_HEIGHT, BunWindow.BORDERED, Assets.getBitmapData( "images/instructions.png" ), 27, 12 );
		instructions.x = INSTRUCTIONS_X;
		instructions.y = INSTRUCTIONS_Y;
		instructions.addOk( INSTRUCTIONS_OK_X, INSTRUCTIONS_OK_Y );
		instructions.visible = false;
		addChild( instructions );
	}
	
	override public function update( ?e:Event ):Void
	{
		super.update( e );
	}
	
	override public function menuSelect( Selection:Point ):Void
	{
		super.menuSelect( Selection );
		
		switch ( Selection ) {
			case { x:0, y:0 }:
				createWindow( ABOUT_GNOP );
			case { x:1, y:0 }:
				// new game
			case { x:1, y:2 }:
				dispatchEvent( new Event( Event.COMPLETE ) );
			case { x:2, y:1 }:
				playerPaddleSize = 0;
				menu.updateCheckmarks();
			case { x:2, y:2 }:
				playerPaddleSize = 1;
				menu.updateCheckmarks();
			case { x:2, y:3 }:
				playerPaddleSize = 2;
				menu.updateCheckmarks();
			case { x:2, y:6 }:
				computerPaddleSize = 0;
				menu.updateCheckmarks();
			case { x:2, y:7 }:
				computerPaddleSize = 0;
				menu.updateCheckmarks();
			case { x:2, y:8 }:
				computerPaddleSize = 0;
				menu.updateCheckmarks();
			case { x:3, y:0 }:
				ballSize = 0;
				menu.updateCheckmarks();
			case { x:3, y:1 }:
				ballSize = 1;
				menu.updateCheckmarks();
			case { x:3, y:2 }:
				ballSize = 2;
				menu.updateCheckmarks();
			case { x:3, y:4 }:
				ballSpeed = 0;
				menu.updateCheckmarks();
			case { x:3, y:5 }:
				ballSpeed = 1;
				menu.updateCheckmarks();
			case { x:3, y:6 }:
				ballSpeed = 2;
				menu.updateCheckmarks();
			case { x:4, y:0 }:
				difficulty = 0;
				menu.updateCheckmarks();
			case { x:4, y:1 }:
				difficulty = 1;
				menu.updateCheckmarks();
			case { x:4, y:2 }:
				difficulty = 2;
				menu.updateCheckmarks();
			case { x:4, y:4 }:
				createWindow( SET_ENDING_SCORE );
			case { x:4, y:6 }:
				// computer serves first
			case { x:4, y:7 }:
				// you serve first
			case { x:4, y:9 }:
				// sound
			case { x:5, y:0 } :
				createWindow( INSTRUCTIONS );
		}
		
		//Log.trace( selectedItemPosition );
	}
	
	private function createWindow( WindowType:Int ):Void
	{
		if ( WindowType == ABOUT_GNOP ) {
			about.visible = true;
			about.addEventListener( Event.COMPLETE, onCloseAbout, false, 0, true );
		}
		
		if ( WindowType == INSTRUCTIONS ) {
			instructions.visible = true;
			instructions.addEventListener( Event.COMPLETE, onCloseInstructions, false, 0, true );
		}
	}
	
	private function onCloseAbout( ?e:Event ):Void
	{
		about.removeEventListener( Event.COMPLETE, onCloseAbout );
		about.visible = false;
	}
	
	private function onCloseInstructions( ?e:Event ):Void
	{
		instructions.removeEventListener( Event.COMPLETE, onCloseInstructions );
		instructions.visible = false;
	}
	
	private function getMenuItems():Array<Array<String>>
	{
		var a:Array<Array<String>> = [
			[ BunMenuItem.SEPTAGON, "About Gnop..." ],
			[ "File", "New Game", BunMenuItem.LINE, "Quit" ],
			[ "Paddles", BunMenuItem.GREYED("Player"), BunMenuItem.TABBED("Small"), BunMenuItem.TABBED("Normal"), BunMenuItem.TABBED("Large"), BunMenuItem.LINE, BunMenuItem.GREYED("Computer"), BunMenuItem.TABBED("Small"), BunMenuItem.TABBED("Normal"), BunMenuItem.TABBED("Large") ],
			[ "Ball", "Small", "Normal", "Large", BunMenuItem.LINE, "Slow", "Normal", "Fast" ],
			[ "Options", "Novice", "Intermediate", "Expert", BunMenuItem.LINE, "Set Ending Score...", BunMenuItem.LINE, "Computer Serves First", "You Serve First", BunMenuItem.LINE, "Sound" ],
			[ "Help", "Instructions..." ]
			];
		
		return a;
	}
}