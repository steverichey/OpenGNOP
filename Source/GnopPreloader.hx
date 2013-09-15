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
	private var bg:Bitmap;
	
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
		
		//bg = new Bitmap( new BitmapData( Std.int( Lib.current.stage.width ), Std.int( Lib.current.stage.height ), false, 0xff00ff00 ) );
		bg = new Bitmap( new BitmapData( 8, 8, false, 0xff00ff00 ) );
		addChild( bg );
	}
	
	override public function onUpdate(bytesLoaded:Int, bytesTotal:Int)
	{
		bg.x ++;
	}
	
	override public function onLoaded()
	{
		dispatchEvent( new Event( Event.COMPLETE ) );
	}
}