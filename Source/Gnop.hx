package;

import flash.events.Event;
import openfl.Assets;

class Gnop extends BunState
{
	private var splash:BunWindow;
	private var menu:BunMenu;
	
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
		
		splash = new BunWindow( 502, 312, BunWindow.SHADOWED, Assets.getBitmapData( "images/splash.png" ), 57, 49 );
		splash.x = 69;
		splash.y = 94;
		addChild( splash );
		
		menu = new BunMenu( getMenuItems() );
		addChild( menu );
	}
	
	override public function update( ?e:Event ):Void
	{
		
	}
	
	private function getMenuItems():Array<Array<String>>
	{
		var a:Array<Array<String>> = [
			[ "SEPTAGON", "About Gnop..." ],
			[ "File", "New Game", "LINE", "Quit" ],
			[ "Paddles", "GREY_Player", "TAB_Small", "TAB_Normal", "TAB_Large", "LINE", "GREY_Computer", "TAB_Small", "TAB_Normal", "TAB_Large" ],
			[ "Ball", "Small", "Normal", "Large", "LINE", "Slow", "Normal", "Fast" ],
			[ "Options", "Novice", "Intermediate", "Expert", "LINE", "Set Ending Score...", "LINE", "Computer Serves First", "You Serve First", "LINE", "Sound" ],
			[ "Help", "Instructions..." ]
			];
		
		return a;
	}
}