package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import openfl.Assets;

class GnopMain extends BunState
{
	private var _splash:BunWindow;
	private var _menu:BunMenu;
	private var _tinyicon:Bitmap;
	private var _about:BunWindowExt;
	private var _endscore:BunWindowExt;
	private var _instructions:BunWindowExt;
	private var _scoreWarning:BunWindowExt;
	private var _playstate:GnopPlaystate;
	private var _start:BunSound;
	private var _lose:BunSound;
	private var _win:BunSound;
	private var _endType:Int;
	
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
	private static inline var SCORE_WARNING:Int = 3;
	
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
	private static inline var SET_TEXT:String = "Set Ending Score";
	private static inline var SET_INPUT_X:Int = 154;
	private static inline var SET_INPUT_Y:Int = 30;
	private static inline var SET_INPUT_WIDTH:Int = 35;
	private static inline var SET_INPUT_HEIGHT:Int = 16;
	
	private static inline var INSTRUCTIONS_X:Int = 20;
	private static inline var INSTRUCTIONS_Y:Int = 27;
	private static inline var INSTRUCTIONS_WIDTH:Int = 424;
	private static inline var INSTRUCTIONS_HEIGHT:Int = 312;
	private static inline var INSTRUCTIONS_OK_X:Int = 180;
	private static inline var INSTRUCTIONS_OK_Y:Int = 269;
	
	private static inline var WARNING_X:Int = 33;
	private static inline var WARNING_Y:Int = 58;
	private static inline var WARNING_WIDTH:Int = 350;
	private static inline var WARNING_HEIGHT:Int = 90;
	private static inline var WARNING_HAND_X:Int = 28;
	private static inline var WARNING_HAND_Y:Int = 18;
	private static inline var WARNING_TEXT_X:Int = 71;
	private static inline var WARNING_TEXT_Y:Int = 25;
	private static inline var WARNING_TEXT:String = "Ending score must be/between 0 and 100.";
	private static inline var WARNING_OK_X:Int = 248;
	private static inline var WARNING_OK_Y:Int = 29;
	
	private static inline var SCORE_MIN:Int = 0;
	private static inline var SCORE_MAX:Int = 100;
	
	public function new()
	{
		super();
	}
	
	override public function init( e:Event = null ):Void
	{
		super.init( e );
		
		// Add the initial splash screen.
		
		_splash = new BunWindow( 502, 312, BunWindow.SHADOWED, Assets.getBitmapData( "images/splash.png" ), 57, 49 );
		_splash.x = 69;
		_splash.y = 94;
		addChild( _splash );
		
		// Add the top menu.
		
		_menu = new BunMenu( getMenuItems() );
		addChild( _menu );
		
		// Add the "tiny icon" in the top menu.
		
		_tinyicon = new Bitmap( Assets.getBitmapData( "images/icon_tiny.png" ) );
		_tinyicon.x = 609;
		_tinyicon.y = 5;
		addChild( _tinyicon );
		
		// setup child windows
		
		_about = new BunWindowExt( ABOUT_WIDTH, ABOUT_HEIGHT, BunWindow.BORDERED, Assets.getBitmapData( "images/about.png" ), ABOUT_IMG_X, ABOUT_IMG_Y );
		_about.x = ABOUT_X;
		_about.y = ABOUT_Y;
		_about.addOk( ABOUT_OK_X, ABOUT_OK_Y );
		_about.visible = false;
		addChild( _about );
		
		_instructions = new BunWindowExt( INSTRUCTIONS_WIDTH, INSTRUCTIONS_HEIGHT, BunWindow.BORDERED, Assets.getBitmapData( "images/instructions.png" ), 27, 12 );
		_instructions.x = INSTRUCTIONS_X;
		_instructions.y = INSTRUCTIONS_Y;
		_instructions.addOk( INSTRUCTIONS_OK_X, INSTRUCTIONS_OK_Y );
		_instructions.visible = false;
		addChild( _instructions );
		
		var temp:BitmapData = new BitmapData( 41, 27, false, 0xff000000 );
		temp.fillRect( new Rectangle( 1, 1, temp.width - 2, temp.height - 2 ), 0xffFFFFFF );
		_endscore = new BunWindowExt( SET_WIDTH, SET_HEIGHT, BunWindow.BORDERED, temp, 151, 27 );
		_endscore.x = SET_X;
		_endscore.y = SET_Y;
		_endscore.addOk( SET_OK_X, SET_OK_Y );
		_endscore.addText( SET_TEXT_X, SET_TEXT_Y, SET_TEXT );
		_endscore.addCancel( SET_CANCEL_X, SET_CANCEL_Y );
		_endscore.addInput( SET_INPUT_X, SET_INPUT_Y, SET_INPUT_WIDTH, SET_INPUT_HEIGHT, Std.string( endScore ) );
		_endscore.visible = false;
		addChild( _endscore );
		
		_scoreWarning = new BunWindowExt( WARNING_WIDTH, WARNING_HEIGHT, BunWindow.BORDERED, Assets.getBitmapData( "images/warn.png" ), WARNING_HAND_X, WARNING_HAND_Y );
		_scoreWarning.x = WARNING_X;
		_scoreWarning.y = WARNING_Y;
		_scoreWarning.addText( WARNING_TEXT_X, WARNING_TEXT_Y, WARNING_TEXT );
		_scoreWarning.addOk( WARNING_OK_X, WARNING_OK_Y );
		_scoreWarning.visible = false;
		addChild( _scoreWarning );
		
		_start = new BunSound( "start" );
		_start.addEventListener( Event.SOUND_COMPLETE, beginGame, false, 0, true );
		_win = new BunSound( "win" );
		_lose = new BunSound( "lose" );
	}
	
	override public function update( ?e:Event ):Void
	{
		super.update( e );
		
		if ( _playstate != null ) {
			_playstate.update();
		}
	}
	
	private function startNewGame():Void
	{
		_start.play();
	}
	
	private function beginGame( ?e:Event ):Void
	{
		_playstate = new GnopPlaystate();
		_playstate.addEventListener( Event.COMPLETE, onGameComplete, false, 0, true );
		addChild( _playstate );
		_splash.visible = false;
	}
	
	private function onGameComplete( ?e:Event ):Void
	{
		_playstate.removeEventListener( Event.COMPLETE, onGameComplete );
		_splash.visible = true;
		removeChild( _playstate );
		_playstate = null;
		
		if ( _endType == GnopPlaystate.END_LOSE ) {
			_lose.play();
		} else {
			_win.play();
		}
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
				_menu.updateCheckmarks();
			case { x:2, y:2 }:
				playerPaddleSize = 1;
				_menu.updateCheckmarks();
			case { x:2, y:3 }:
				playerPaddleSize = 2;
				_menu.updateCheckmarks();
			case { x:2, y:6 }:
				computerPaddleSize = 0;
				_menu.updateCheckmarks();
			case { x:2, y:7 }:
				computerPaddleSize = 0;
				_menu.updateCheckmarks();
			case { x:2, y:8 }:
				computerPaddleSize = 0;
				_menu.updateCheckmarks();
			case { x:3, y:0 }:
				ballSize = 0;
				_menu.updateCheckmarks();
			case { x:3, y:1 }:
				ballSize = 1;
				_menu.updateCheckmarks();
			case { x:3, y:2 }:
				ballSize = 2;
				_menu.updateCheckmarks();
			case { x:3, y:4 }:
				ballSpeed = 0;
				_menu.updateCheckmarks();
			case { x:3, y:5 }:
				ballSpeed = 1;
				_menu.updateCheckmarks();
			case { x:3, y:6 }:
				ballSpeed = 2;
				_menu.updateCheckmarks();
			case { x:4, y:0 }:
				difficulty = 0;
				_menu.updateCheckmarks();
			case { x:4, y:1 }:
				difficulty = 1;
				_menu.updateCheckmarks();
			case { x:4, y:2 }:
				difficulty = 2;
				_menu.updateCheckmarks();
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
			_about.visible = true;
			_about.addEventListener( Event.COMPLETE, onCloseAbout, false, 0, true );
		}
		
		if ( WindowType == INSTRUCTIONS ) {
			_instructions.visible = true;
			_instructions.addEventListener( Event.COMPLETE, onCloseInstructions, false, 0, true );
		}
		
		if ( WindowType == SET_ENDING_SCORE ) {
			_endscore.visible = true;
			_endscore.acceptInput = true;
			_endscore.addEventListener( Event.CANCEL, onCancelEndScore, false, 0, true );
			_endscore.addEventListener( Event.COMPLETE, onCloseEndScore, false, 0, true );
		}
		
		if ( WindowType == SCORE_WARNING ) {
			_scoreWarning.visible = true;
			_scoreWarning.addEventListener( Event.COMPLETE, onCloseWarning, false, 0, true );
		}
	}
	
	private function onCloseAbout( ?e:Event ):Void
	{
		_about.removeEventListener( Event.COMPLETE, onCloseAbout );
		_about.visible = false;
	}
	
	private function onCloseInstructions( ?e:Event ):Void
	{
		_instructions.removeEventListener( Event.COMPLETE, onCloseInstructions );
		_instructions.visible = false;
	}
	
	private function onCancelEndScore( ?e:Event ):Void
	{
		_endscore.input = Std.string( endScore );
		_endscore.acceptInput = false;
		_endscore.removeEventListener( Event.CANCEL, onCancelEndScore );
		_endscore.removeEventListener( Event.COMPLETE, onCloseEndScore );
		_endscore.visible = false;
	}
	
	private function onCloseEndScore( ?e:Event ):Void
	{
		var newscore:Int = Std.parseInt( _endscore.input );
		
		if ( newscore > SCORE_MIN && newscore < SCORE_MAX ) {
			endScore = newscore;
			onCancelEndScore();
		} else {
			_endscore.acceptInput = false;
			_endscore.removeEventListener( Event.CANCEL, onCancelEndScore );
			_endscore.removeEventListener( Event.COMPLETE, onCloseEndScore );
			createWindow( SCORE_WARNING );
		}
	}
	
	private function onCloseWarning( ?e:Event ):Void
	{
		_scoreWarning.removeEventListener( Event.COMPLETE, onCloseWarning );
		_scoreWarning.visible = false;
		
		_endscore.acceptInput = true;
		_endscore.addEventListener( Event.CANCEL, onCancelEndScore, false, 0, true );
		_endscore.addEventListener( Event.COMPLETE, onCloseEndScore, false, 0, true );
	}
	
	public function setSplash( type:Int ):Void
	{
		_endType = type;
		
		if ( type == GnopPlaystate.END_QUIT ) {
			_splash.updateContent( Assets.getBitmapData( "images/splash.png" ), 57, 49 );
		} else if ( type == GnopPlaystate.END_LOSE ) {
			_splash.updateContent( Assets.getBitmapData( "images/lose.png" ), 125, 72 );
		} else {
			_splash.updateContent(  Assets.getBitmapData( "images/win.png" ), 104, 62 );
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