package;

import flash.Lib;
import flash.display.Sprite;
import flash.text.TextField;
import flash.events.Event;

class Gnop extends Sprite
{
	private var tf:TextField;
	
	public function new()
	{
		super();
		
		if (stage != null) {
			init();
		} else {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}
	
	private function init( ?E:Event ):Void 
	{
		if (hasEventListener(Event.ADDED_TO_STAGE)) {
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		tf = new TextField();
		tf.text = "Hello world!";
		addChild( tf );
	}
}