package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import haxe.Log;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;

class Gnop extends Sprite
{
	private var currentState:GnopState;
	private var previousState:GnopState;
	
	public function new()
	{
		super();
		
		if ( stage != null ) {
			init();
		} else {
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
	}
	
	private function init( ?E:Event ):Void 
	{
		if ( hasEventListener( Event.ADDED_TO_STAGE ) ) {
			removeEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		Reg.init();
		
		currentState = new DesktopState();
		addChild( currentState );
		
		//Lib.current.stage.addEventListener( KeyboardEvent.KEY_DOWN, keyPress );
		Lib.current.stage.addEventListener( Event.ENTER_FRAME, update );
	}
	
	private function update( e:Event = null ):Void
	{
		currentState.update();
	}
	
	private function keyPress( k:KeyboardEvent ):Void
	{
		/*
		if ( k.charCode == 122 ) {
			if ( Lib.current.stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE ) {
				Lib.current.stage.displayState = StageDisplayState.NORMAL;
			} else {
				Lib.current.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
		}*/
	}
	
	public static function switchState( newState:GnopState ):Void
	{
		Log.trace( " youd like a new state " );
		Log.trace( newState );
	}
}