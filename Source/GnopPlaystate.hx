package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.Lib;
import flash.ui.Mouse;
import haxe.Log;
import openfl.Assets;
import flash.events.KeyboardEvent;

class GnopPlaystate extends BunState
{
	private var _bg:BunWindow;
	private var _player:GnopPaddle;
	private var _computer:GnopPaddle;
	private var _ball:GnopBall;
	
	private static inline var BG_X:Int = 62;
	private static inline var BG_Y:Int = 87;
	private static inline var BG_WIDTH:Int = 516;
	private static inline var BG_HEIGHT:Int = 326;
	
	private static inline var Y_MIN:Int = 116;
	private static inline var Y_MAX:Int = 405;
	private static inline var X_MIN:Int = 83;
	private static inline var X_MAX:Int = 557;
	
	// Game end types
	
	public static inline var END_QUIT:Int = 0;
	public static inline var END_LOSE:Int = 1;
	public static inline var END_WIN:Int = 2;
	
	public function new()
	{
		super();
	}
	
	override public function init( ?e:Event ):Void
	{
		super.init( e );
		
		Mouse.hide();
		
		_bg = new BunWindow( BG_WIDTH, BG_HEIGHT, BunWindow.BORDERED, Assets.getBitmapData( "images/scoreboard.png" ), 8, 9 );
		_bg.x = BG_X;
		_bg.y = BG_Y;
		addChild( _bg );
		
		_player = new GnopPaddle( 1, GnopPaddle.PLAYER );
		addChild( _player );
		
		_computer = new GnopPaddle( 1, GnopPaddle.COMPUTER );
		addChild( _computer );
		
		_ball = new GnopBall();
		addChild( _ball );
		
		Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp, false, 0, true );
		this.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true );		
	}
	
	override public function update( ?e:Event ):Void
	{
		super.update( e );
		
		_player.y = limit( mouseY, Y_MIN, Y_MAX - _player.height );
		_ball.x = limit( _ball.x + 1, X_MIN, X_MAX - _ball.width );
		_ball.y = limit( _ball.y + 1, Y_MIN, Y_MAX - _ball.height );
	}
	
	private function onKeyUp( ?k:KeyboardEvent ):Void
	{
		if ( k.keyCode == 81 ) {
			endGame( END_QUIT );
		}
	}
	
	private function onMouseDown( ?m:MouseEvent ):Void
	{
		Log.trace( "mouse down" );
	}
	
	private function endGame( type:Int ):Void
	{
		cast( this.parent, GnopMain ).setSplash( type );
		
		Mouse.show();
		
		dispatchEvent( new Event( Event.COMPLETE ) );
	}
}