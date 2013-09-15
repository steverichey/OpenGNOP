package;

import flash.Lib;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import haxe.Log;

class GnopPreloader extends NMEPreloader
{
	private var loadBar:Bitmap;
	
	public function new()
	{
		super();
	}
	
	override public function onInit():Void
	{
		// destroy default stuff
		
		removeChild( outline );
		removeChild( progress );
		outline = null;
		progress = null;
		
		var barBorder = new Bitmap( new BitmapData( Std.int( getWidth() ) - 20, 20, false, 0xffffffff ) );
		barBorder.x = ( getWidth() - barBorder.width ) / 2;
		barBorder.y = ( getHeight() - barBorder.height ) / 2;
		addChild( barBorder );
		
		loadBar = new Bitmap( new BitmapData( Std.int( getWidth() ) - 22, 18, false, 0xffffffff ) );
		loadBar.x = ( getWidth() - loadBar.width ) / 2;
		loadBar.y = ( getHeight() - loadBar.height ) / 2;
		loadBar.width = 1;
		addChild( loadBar );
	}
	
	override public function onUpdate(bytesLoaded:Int, bytesTotal:Int)
	{
		loadBar.width = ( bytesLoaded / bytesTotal ) * ( getWidth() - 22 );
	}
	
	override public function onLoaded()
	{
		dispatchEvent( new Event( Event.COMPLETE ) );
	}
}