package;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.Lib;

class GameClass extends Sprite
{
	private var currentState:GnopState;
	
	public function new()
	{
		super();
		
		if ( stage != null ) {
			init();
		} else {
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
	}
	
	public function init( e:Event = null ):Void
	{
		if ( hasEventListener( Event.ADDED_TO_STAGE ) ) {
			removeEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		switchState( new DesktopState() );
		
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
	
	public function switchState( newState:GnopState ):Void
	{
		if ( currentState != null ) {
			removeChild( currentState );
			currentState = null;
		}
		
		currentState = newState;
		addChild( currentState );
	}
}