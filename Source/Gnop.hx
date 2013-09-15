package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;

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
		
		Lib.current.stage.addEventListener( Event.ENTER_FRAME, update );
	}
	
	private function update( e:Event = null ):Void
	{
		currentState.update();
	}
}