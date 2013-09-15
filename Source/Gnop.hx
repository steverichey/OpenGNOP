package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.Lib;
import flash.display.Sprite;
import flash.text.TextField;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import haxe.Log;

#if cpp || neko
	@:bitmap( "Assets/desktop.png" ) class Desktop extends BitmapData { }
	@:bitmap( "Assets/icon.png" ) class Icon extends BitmapData { }
	@:bitmap( "Assets/septagon.png" ) class Septagon extends BitmapData { }
#else
	import openfl.Assets;
#end
	
class Gnop extends Sprite
{
	private var invisibleBG:Sprite;
	private var icon:Sprite;
	private var iconInverted:Bool;
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
		
		#if cpp || neko
			var desktop:Bitmap = new Bitmap( new Desktop(0, 0) );
		#else
			var desktop:Bitmap = new Bitmap( Assets.getBitmapData( "assets/desktop.png" ) );
		#end
		
		addChild( desktop );
		
		invisibleBG = new Sprite();
		invisibleBG.graphics.beginFill( 0x0000ff, 0 );
		invisibleBG.graphics.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
		invisibleBG.graphics.endFill();
		addChild( invisibleBG );
		
		icon = new Sprite();
		
		#if cpp || neko
			icon.addChild( new Bitmap( new Icon(0, 0) ) );
		#else
			icon.addChild( new Bitmap( Assets.getBitmapData( "assets/icon.png" ) ) );
		#end
		
		icon.x = ( stage.stageWidth - icon.width ) / 2;
		icon.y = ( stage.stageHeight - icon.height ) / 2;
		addChild( icon );
		
		#if cpp || neko
			fakeSeptagon = new Bitmap( new Septagon(0, 0) );
		#else
			fakeSeptagon = new Bitmap( Assets.getBitmapData( "assets/septagon.png" ) );
		#end
		
		fakeSeptagon.x = 17;
		fakeSeptagon.y = 3;
		addChild( fakeSeptagon );
		
		invisibleBG.addEventListener( MouseEvent.MOUSE_DOWN, clickDesktop );
		icon.addEventListener( MouseEvent.DOUBLE_CLICK, openFile );
		icon.addEventListener( MouseEvent.MOUSE_DOWN, clickIcon );
	}
	
	private function clickDesktop( m:MouseEvent ):Void
	{
		if ( iconInverted ) {
			icon.transform.colorTransform = new ColorTransform( 1, 1, 1, 1, 0, 0, 0 );
			iconInverted = false;
		}
	}
	
	private function clickIcon( m:MouseEvent ):Void
	{
		if ( !iconInverted ) {
			icon.transform.colorTransform = new ColorTransform( -1, -1, -1, 1, 255, 255, 255 );
			iconInverted = true;
		}
	}
	
	private function openFile( m:MouseEvent ):Void
	{
		Log.trace( "aww yeah" );
	}
}