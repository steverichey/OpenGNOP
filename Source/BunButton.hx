package;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import openfl.Assets;

class BunButton extends Sprite
{
	private var _normal:Bitmap;
	private var _inverted:Bitmap;
	private var _type:Int;
	
	public static inline var OKAY:Int = 0;
	public static inline var CANCEL:Int = 1;
	
	/**
	 * Create an OS-themed button of the chosen type with all the necessary event listeners.
	 * 
	 * @param	ButtonType	Either BunButton.OKAY or BunButton.CANCEL
	 */
	public function new( ButtonType:Int )
	{
		super();
		
		if ( ButtonType == CANCEL ) {
			_normal = new Bitmap( Assets.getBitmapData( "images/cancel.png" ) );
			_inverted = new Bitmap( Assets.getBitmapData( "images/cancel_inv.png" ) );
		} else {
			_normal = new Bitmap( Assets.getBitmapData( "images/ok.png" ) );
			_inverted = new Bitmap( Assets.getBitmapData( "images/ok_inv.png" ) );
			_inverted.x = 5;
			_inverted.y = 5;
		}
		
		_inverted.visible = false;
		
		addChild( _normal );
		addChild( _inverted );
		
		addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true );
	}
	
	private function onMouseDown( ?m:MouseEvent ):Void
	{
		invert();
		addEventListener( MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true );
		addEventListener( MouseEvent.MOUSE_UP, onMouseUp, false, 0, true );
	}
	
	private function onMouseOut( ?m:MouseEvent ):Void
	{
		removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
		invert();
		addEventListener( MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true );
	}
	
	private function onMouseUp( ?m:MouseEvent ):Void
	{
		removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
		removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
		invert();
		dispatchEvent( new Event( Event.COMPLETE ) );
	}
	
	private function onMouseOver( ?m:MouseEvent ):Void
	{
		removeEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
		invert();
		addEventListener( MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true );
	}
	
	private function invert():Void
	{
		_inverted.visible = !_inverted.visible;
		//_normal.visible = !_normal.visible;
	}
}