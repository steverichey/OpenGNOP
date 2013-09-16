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
	private static var _game:GameClass;
	
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
		
		_game = new GameClass();
		addChild( _game );
	}
	
	public static function staticInit():Void
	{
		_game = new GameClass();
		
		//addChild( _game );
	}
	
	public static function switchState( newState:GnopState ):Void
	{
		_game.switchState( newState );
	}
	
	public static function addLayer( newState:GnopState ):Void
	{
		_game.addLayer( newState );
	}
}