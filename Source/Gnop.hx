package;

import flash.display.Bitmap;
import flash.events.Event;
import openfl.Assets;

class Gnop extends BunState
{
	private var splash:BunWindow;
	private var menu:BunMenu;
	private var tinyicon:Bitmap;
	
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
		menu.addEventListener( Event.COMPLETE, onQuit, false, 0, true );
		addChild( menu );
	}
	
	override public function update( ?e:Event ):Void
	{
		super.update( e );
	}
	
	private function onQuit( ?e:Event ):Void
	{
		dispatchEvent( new Event( Event.COMPLETE ) );
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