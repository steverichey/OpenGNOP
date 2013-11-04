package;

import flash.events.Event;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import haxe.Log;

class BunTime extends Sprite
{
	private var tf:BunText;
	
	public function new()
	{
		super();
		
		init();
	}
	
	public function init( ?e:Event ):Void 
	{	
		tf = new BunText( currentTime() );
		tf.x = -tf.width;
		addChild( tf );
	}
	
	public function update( ?e:Event ):Void
	{
		var cur:String = currentTime();
		
		if ( cur != tf.text ) {
			tf.text = cur;
			tf.x = -tf.width;
		}
	}
	
	private function currentTime():String
	{
		var now:Date = Date.now();
		var hours:Int = now.getHours();
		var minutes:Int = now.getMinutes();
		var ampm:String = "AM";
		
		if ( hours > 12 ) {
			hours -= 12;
			ampm = "PM";
		} else if ( hours == 0 ) {
			hours = 12;
		}
		
		var min:String;
		
		if ( minutes < 10 ) {
			min = "0" + Std.string( minutes );
		} else {
			min = Std.string( minutes );
		}
		
		return Std.string( hours ) + ":" + min + " " + ampm;
	}
}