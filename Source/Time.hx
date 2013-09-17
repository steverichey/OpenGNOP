package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.text.AntiAliasType;
import flash.text.GridFitType;
import flash.text.TextField;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class Time extends Sprite
{
	private var tf:TextField;
	
	public function new()
	{
		super();
		
		init();
	}
	
	public function init( ?E:Event ):Void 
	{	
		tf = new TextField();
		tf.autoSize = TextFieldAutoSize.LEFT;
		tf.defaultTextFormat = new TextFormat( "pix Chicago", 8, 0xff000000 );
		tf.antiAliasType = AntiAliasType.ADVANCED;
		tf.gridFitType = GridFitType.PIXEL;
		tf.sharpness = 400;
		tf.text = currentTime();
		addChild( tf );
	}
	
	public function update():Void
	{
		var cur:String = currentTime();
		
		if ( cur != tf.text ) {
			tf.text = cur;
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