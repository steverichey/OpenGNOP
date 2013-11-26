package;

import flash.Lib;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.utils.Timer;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.TimerEvent;

class BunTextInput extends Sprite
{
	public var active:Bool;
	
	private var _bg:Bitmap;
	private var _text:BunText;
	private var _blinkTimer:Timer;
	private var _blinker:Bitmap;
	
	/**
	 * Create a new OS-themed input field. The background is white, there's a black blinking cursor, and it's disabled initially.
	 * 
	 * @param	DefaultText		The text for the input field to display initially.
	 * @param	Width			The width of the input field. The field will not accept input that exceeds this width.
	 * @param	Height			The height of the input field.
	 */
	public function new( DefaultText:String, Width:Int, Height:Int )
	{
		super();
		
		active = false;
		
		_bg = new Bitmap( new BitmapData( Width, Height, false ) );
		
		_blinkTimer = new Timer( 500 );
		_blinkTimer.addEventListener( TimerEvent.TIMER, onBlink, false, 0, true );
		
		_text = new BunText( DefaultText );
		
		_blinker = new Bitmap( new BitmapData( 2, Height, false, 0xff000000 ) );
		_blinker.x = _text.width;
		
		addChild( _bg );
		addChild( _text );
		addChild( _blinker );
		
		Lib.current.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true );
		_blinkTimer.start();
	}
	
	private function onKeyDown( k:KeyboardEvent ):Void
	{
		if ( active ) {
			if ( k.keyCode == 8 ) {
				if ( _text.text.length > 1 ) {
					_text.text = _text.text.substr( 0, _text.text.length - 1 );
				} else if ( _text.text.length == 1 ) {
					_text.text = "";
				}
			} else {
				var temp:String = _text.text + String.fromCharCode( k.charCode );
				
				if ( BunText.predictWidth( temp ) < _bg.width - 2 ) {
					_text.text = temp;
				}
			}
			
			_blinker.x = _text.width;
			
			#if debug
			//haxe.Log.trace( "Key: " + k.keyCode );
			#end
		}
	}
	
	private function onBlink( ?t:TimerEvent ):Void
	{
		_blinker.visible = !_blinker.visible;
	}
	
	/**
	 * The text currently held by this input box. Can use to set the text to an arbitrary value; will trim the string down to fit the input box.
	 */
	public var text(get, set):String;
	
	private function get_text():String
	{
		return _text.text;
	}
	
	private function set_text( NewText:String ):String
	{
		while ( BunText.predictWidth( NewText ) > _bg.width - 2 ) {
			NewText = NewText.substr( 0, NewText.length - 1 );
		}
		
		_text.text = NewText;
		_blinker.x = _text.width;
		
		return _text.text;
	}
}