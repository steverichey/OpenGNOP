package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import haxe.Log;
import openfl.Assets;

class GnopMain extends BunState
{
	private var splash:BunWindow;
	private var menu:BunMenu;
	private var tinyicon:Bitmap;
	private var about:BunWindowExt;
	private var endscore:BunWindowExt;
	private var instructions:BunWindowExt;
	private var playstate:GnopPlaystate;
	
	public static var playerPaddleSize:Int = 1;
	public static var computerPaddleSize:Int = 1;
	public static var ballSize:Int = 1;
	public static var ballSpeed:Int = 1;
	public static var difficulty:Int = 1;
	public static var endScore:Int = 4;
	public static var playerServesFirst:Bool = true;
	public static var sound:Bool = true;
	
	private static inline var ABOUT_GNOP:Int = 0;
	private static inline var SET_ENDING_SCORE:Int = 1;
	private static inline var INSTRUCTIONS:Int = 2;
	
	private static inline var ABOUT_X:Int = 4;
	private static inline var ABOUT_Y:Int = 26;
	private static inline var ABOUT_WIDTH:Int = 474;
	private static inline var ABOUT_HEIGHT:Int = 314;
	private static inline var ABOUT_OK_X:Int = 361;
	private static inline var ABOUT_OK_Y:Int = 191;
	private static inline var ABOUT_IMG_X:Int = 21;
	private static inline var ABOUT_IMG_Y:Int = 12;
	
	private static inline var SET_X:Int = 75;
	private static inline var SET_Y:Int = 45;
	private static inline var SET_WIDTH:Int = 232;
	private static inline var SET_HEIGHT:Int = 120;
	private static inline var SET_OK_X:Int = 122;
	private static inline var SET_OK_Y:Int = 67;
	private static inline var SET_CANCEL_X:Int = 46;
	private static inline var SET_CANCEL_Y:Int = 71;
	private static inline var SET_TEXT_X:Int = 39;
	private static inline var SET_TEXT_Y:Int = 32;
	
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
		
		// Add the top menu.
		
		menu = new BunMenu( getMenuItems() );
		addChild( menu );
		
		// Add the "tiny icon" in the top menu.
		
		tinyicon = new Bitmap( Assets.getBitmapData( "images/icon_tiny.png" ) );
		tinyicon.x = 609;
		tinyicon.y = 5;
		addChild( tinyicon );
		
		// setup child windows
		
		about = new BunWindowExt( ABOUT_WIDTH, ABOUT_HEIGHT, BunWindow.BORDERED, Assets.getBitmapData( "images/about.png" ), ABOUT_IMG_X, ABOUT_IMG_Y );
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
		
		var temp:BitmapData = new BitmapData( 41, 27, false, 0xff000000 );
		temp.fillRect( new Rectangle( 1, 1, temp.width - 2, temp.height - 2 ), 0xffFFFFFF );
		endscore = new BunWindowExt( SET_WIDTH, SET_HEIGHT, BunWindow.BORDERED, temp, 151, 27 );
		endscore.x = SET_X;
		endscore.y = SET_Y;
		endscore.addOk( SET_OK_X, SET_OK_Y );
		endscore.addText( SET_TEXT_X, SET_TEXT_Y, "Set Ending Score" );
		endscore.addCancel( SET_CANCEL_X, SET_CANCEL_Y );
		endscore.visible = false;
		addChild( endscore );
	}
	
	override public function update( ?e:Event ):Void
	{
		super.update( e );
		
		if ( playstate != null ) {
			playstate.update();
		}
	}
	
	private function startNewGame():Void
	{
		playstate = new GnopPlaystate();
		playstate.addEventListener( Event.COMPLETE, onGameComplete, false, 0, true );
		addChild( playstate );
		splash.visible = false;
	}
	
	private function onGameComplete( ?e:Event ):Void
	{
		playstate.removeEventListener( Event.COMPLETE, onGameComplete );
		splash.visible = true;
		removeChild( playstate );
		playstate = null;
	}
	
	override public function menuSelect( Selection:Point ):Void
	{
		super.menuSelect( Selection );
		
		switch ( Selection ) {
			case { x:0, y:0 }:
				createWindow( ABOUT_GNOP );
			case { x:1, y:0 }:
				startNewGame();
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
		
		if ( WindowType == SET_ENDING_SCORE ) {
			endscore.visible = true;
			endscore.addEventListener( Event.COMPLETE, onCloseEndScore, false, 0, true );
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
	
	private function onCloseEndScore( ?e:Event ):Void
	{
		// todo add code here to check if the end score submitted is valid
		endscore.removeEventListener( Event.COMPLETE, onCloseEndScore );
		endscore.visible = false;
	}
	
	public function setSplash( type:Int ):Void
	{
		if ( type == GnopPlaystate.END_QUIT ) {
			splash.updateContent( Assets.getBitmapData( "images/splash.png" ), 57, 49 );
		} else if ( type == GnopPlaystate.END_LOSE ) {
			splash.updateContent( Assets.getBitmapData( "images/lose.png" ), 125, 72 );
		} else {
			splash.updateContent(  Assets.getBitmapData( "images/win.png" ), 104, 62 );
		}
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