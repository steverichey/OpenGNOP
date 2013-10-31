package;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.Lib;
import haxe.Log;

class GameClass extends Sprite
{
	private var _bg:Bitmap;
	private var _desktop:DesktopState;
	private var _time:BunTime;
	
	public function new()
	{
		super();
		
		_bg = generateDesktopBg();
		addChild( _bg );
		
		_desktop = new DesktopState();
		addChild( _desktop );
		
		addEventListener( Event.ENTER_FRAME, update );
		addEventListener( Event.RESIZE, onResize );
	}
	
	private function update( ?e:Event ):Void
	{
		_desktop.update();
	}
	
	private function onResize( e:Event ):Void
	{
		// this doesn't seem to get called, ever
	}
	
	private function generateDesktopBg():Bitmap
	{
		var w:Int = Lib.current.stage.stageWidth;
		var h:Int = Lib.current.stage.stageHeight;
		var blk:Int = 0xff000000;
		var wht:Int = 0xffFFFFFF;
		var dgrey:Int = 0xff666666;
		var lgrey:Int = 0xffAAAAAA;
		
		// create black background
		
		var bd:BitmapData = new BitmapData( w, h, false, blk );
		
		// draw white top, grey bottom
		
		bd.fillRect( new Rectangle( 0, 0, w, 19 ), wht );
		bd.fillRect( new Rectangle( 0, 20, w, 460 ), lgrey );
		
		// alternating dark grey pixels on bottom
		
		var X:Int = 0;
		var Y:Int = 20;
		
		while ( Y < 480 ) {
			while ( X < 640 ) {
				bd.setPixel( X, Y, dgrey );
				X += 2;
			}
			Y += 1;
			X = Y % 2;
		}
		
		// round corners
		
		var cX:Array<Int> = [ 5, 3, 2, 2, 1 ];
		var cY:Array<Int> = [ 1, 2, 2, 3, 5 ];
		
		for ( i in 0...5 ) {
			bd.fillRect( new Rectangle( 0, 0, cX[i], cY[i] ), blk );
			bd.fillRect( new Rectangle( w-cX[i], 0, cX[i], cY[i] ), blk );
			bd.fillRect( new Rectangle( 0, h-cY[i], cX[i], cY[i] ), blk );
			bd.fillRect( new Rectangle( w-cX[i], h-cY[i], cX[i], cY[i] ), blk );
		}
		
		return new Bitmap( bd );
	}
}