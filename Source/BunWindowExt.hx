package;

import flash.events.Event;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.geom.Point;
import flash.Lib;
import openfl.Assets;

/**
 * Just creates a themed window object, with the option to embed an image asset as window content.
 */
class BunWindowExt extends Sprite
{
	private var _bitmap:BunWindow;
	private var _ok:BunButton;
	private var _cancel:BunButton;
	private var _text:BunText;
	private var _input:BunTextInput;
	public var active:Bool;
	
	/**
	 * Create an OS window that can contain buttons and text entry fields.
	 * 
	 * @param	Width	The width of the window to be created.
	 * @param	Height	The height of the window to be created.
	 * @param	type	The type of window, either BunWindow.BORDERED, BunWindow.SHADOWED, or BunWindow.SHADOWED_MENU.
	 * @param 	Content	Optional, an additional element to draw in the window.
	 * @param 	ContentX	X position of content, relative to window top-left.
	 * @param 	ContentY	Y position of content, relative to window top-left.
	 */
	public function new( Width:Int, Height:Int, type:UInt, Content:BitmapData = null, ContentX:Int = 0, ContentY:Int = 0 )
	{
		_bitmap = new BunWindow( Width, Height, type, Content, ContentX, ContentY );
		addChild( _bitmap );
		
		active = false;
		
		super();
	}
	
	public function addOk( X:Int, Y:Int ):Void
	{
		_ok = new BunButton( BunButton.OKAY );
		_ok.x = X;
		_ok.y = Y;
		_ok.addEventListener( Event.COMPLETE, onClickOk, false, 0, true );
		Lib.current.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true );
		Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp, false, 0, true );
		addChild( _ok );
	}
	
	private function onKeyDown( k:KeyboardEvent ):Void
	{
		if ( active && k.keyCode == 13 ) {
			if ( _ok != null ) {
				if ( !_ok.highlighted ) {
					_ok.highlight();
				}
			}
		}
	}
	
	private function onKeyUp( ?k:KeyboardEvent ):Void
	{
		if ( active && k.keyCode == 13 ) {
			if ( _ok != null ) {
				if ( _ok.highlighted ) {
					_ok.highlight();
					dispatchEvent( new Event( Event.COMPLETE ) );
				}
			}
		}
	}
	
	private function onClickOk( ?e:Event ):Void
	{
		dispatchEvent( new Event( Event.COMPLETE ) );
	}
	
	public function addCancel( X:Int, Y:Int ):Void
	{
		_cancel = new BunButton( BunButton.CANCEL );
		_cancel.x = X;
		_cancel.y = Y;
		_cancel.addEventListener( Event.COMPLETE, onClickCancel, false, 0, true );
		addChild( _cancel );
	}
	
	private function onClickCancel( ?e:Event ):Void
	{
		dispatchEvent( new Event( Event.CANCEL ) );
	}
	
	public function addText( X:Int, Y:Int, Text:String ):Void
	{
		_text = new BunText( Text );
		_text.x = X;
		_text.y = Y;
		addChild( _text );
	}
	
	public function addInput( X:Int, Y:Int, Width:Int, Height:Int, Text:String ):Void
	{
		_input = new BunTextInput( Text, Width, Height );
		_input.x = X;
		_input.y = Y;
		addChild( _input );
	}
	
	public var acceptInput(get, set):Bool;
	
	private function get_acceptInput():Bool
	{
		return _input.active;
	}
	
	private function set_acceptInput( Value:Bool ):Bool
	{
		_input.active = Value;
		
		return _input.active;
	}
	
	public var input(get, set):String;
	
	private function get_input():String
	{
		return _input.text;
	}
	
	private function set_input( NewInput:String ):String
	{
		_input.text = NewInput;
		
		return _input.text;
	}
}