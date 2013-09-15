package;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;

class GnopState extends Sprite
{
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
		
		Lib.current.stage.addEventListener( Event.ENTER_FRAME, update );
	}
	
	public function update( e:Event = null ):Void
	{
		// update
	}
}