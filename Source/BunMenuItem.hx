package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import haxe.Log;
import openfl.Assets;

class BunMenuItem extends Sprite
{
	private var _tf:BunText;
	private var _bm:Bitmap;
	private var _bg:Bitmap;
	
	public static var TOP_MENU:String = "topmenu";
	public static var DROP_MENU:String = "dropmenu";
	
	private static var GREY:Int = 0xff888888;
	
	public function new( Text:String, Width:Int, ItemType:String )
	{
		super();
		
		var w:Int = Width;
		var inactive:Bool = false;
		
		if ( Text.substring(0, 5) == "GREY_" || Text.substring(0, 4) == "TAB_" || Text == "LINE" ) {
			inactive = true;
		}
		
		if ( Text == "SEPTAGON" ) {
			w = 29;
		}
		
		if ( ItemType == TOP_MENU ) {
			_bg = new Bitmap( new BitmapData( w, 18, false ) );
		} else {
			_bg = new Bitmap( new BitmapData( w, 16, false ) );
		}
		
		if ( Text == "SEPTAGON" ) {
			_bm = new Bitmap( Assets.getBitmapData( "images/septagon.png" ) );
			_bm.x = ( _bg.width - _bm.width ) / 2;
			_bm.y = ( _bg.height - _bm.height ) / 2;
		} else if ( Text == "LINE" ) {
			_bm = new Bitmap( new BitmapData( w, 1, false, GREY ) );
			_bm.x = ( _bg.width - _bm.width ) / 2;
			_bm.y = ( _bg.height - _bm.height ) / 2;
		} else {
			if ( Text.substring(0, 5) == "GREY_" ) {
				_tf = new BunText( Text.substring( 6, Text.length ) );
				_tf.color = GREY;
			} else if ( Text.substring(0, 4) == "TAB_" ) {
				_tf = new BunText( Text.substring( 5, Text.length ) );
			} else {
				_tf = new BunText( Text );
			}
			
			_tf.x = ( _bg.width - _tf.width ) / 2;
			
			if ( Text.substring(0, 4) == "TAB_" ) {
				_tf.x += 5;
			}
			
			_tf.y = ( _bg.height - _tf.height ) / 2;
		}
		
		addChild( _bg );
		
		if ( _tf != null ) {
			addChild( _tf );
		}
		
		if ( _bm != null ) {
			addChild( _bm );
		}
		
		if ( ItemType == TOP_MENU ) {
			this.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true );
		} else if ( !inactive ) {
			this.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true );
		}
	}
	
	private function onMouseDown( m:MouseEvent ):Void
	{
		invert( _bg );
		
		if ( _tf != null ) {
			invert( _tf );
		}
	}
	
	private function onMouseOver( m:MouseEvent ):Void
	{
		invert( _bg );
		
		if ( _tf != null ) {
			invert( _tf );
		}
	}
	
	private function invert( b:Bitmap ):Void
	{
		var temp:ColorTransform = b.transform.colorTransform;
		
		temp.redMultiplier *= -1;
		temp.greenMultiplier *= -1;
		temp.blueMultiplier *= -1;
		
		if ( temp.redOffset == 0 ) {
			temp.redOffset = 255;
			temp.greenOffset = 255;
			temp.blueOffset = 255;
		} else {
			temp.redOffset = 0;
			temp.greenOffset = 0;
			temp.blueOffset = 0;
		}
		
		b.transform.colorTransform = temp;
	}
}