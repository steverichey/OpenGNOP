package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.Lib;
import flash.display.Sprite;
import flash.text.TextField;
import flash.events.Event;
import flash.events.MouseEvent;
import haxe.Log;

@:bitmap( "Assets/desktop.png" ) class Desktop extends BitmapData { }
@:bitmap( "Assets/icon.png" ) class Icon extends BitmapData { }

class Gnop extends Sprite
{
	private var invisibleBG:Sprite;
	private var icon:Sprite;
	private var fakeSeptagon:Bitmap;
	
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
		
		var desktop:Bitmap = new Bitmap( new Desktop(0,0) );
		//addChild( desktop );
		
		invisibleBG = new Sprite();
		invisibleBG.graphics.beginFill( 0x000000, 0 );
		invisibleBG.graphics.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
		invisibleBG.graphics.endFill();
		addChild( invisibleBG );
		
		invisibleBG.addEventListener( MouseEvent.MOUSE_DOWN, invisclick );
		
		icon = new Sprite();
		icon.addChild( new Bitmap( new Icon(0, 0) ) );
		icon.x = ( stage.stageWidth - icon.width ) / 2;
		icon.y = ( stage.stageHeight - icon.height ) / 2;
		addChild( icon );
		
		Log.trace( "loaded" );
	}
	
	private function invisclick( m:MouseEvent ):Void
	{
		Lib.trace( "you click" );
	}
}