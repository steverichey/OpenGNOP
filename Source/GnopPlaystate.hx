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
	private var _scorePlayer:GnopScore;
	private var _scoreToWin:GnopScore;
	private var _scoreComputer:GnopScore;
	private var _paused:Bool = false;
	
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
		
		_player = new GnopPaddle( GnopMain.playerPaddleSize, GnopPaddle.PLAYER );
		_computer = new GnopPaddle( GnopMain.computerPaddleSize, GnopPaddle.COMPUTER );
		_ball = new GnopBall( GnopMain.ballSize, GnopMain.ballSpeed );
		_scorePlayer = new GnopScore( GnopScore.PLAYER );
		_scoreToWin = new GnopScore( GnopScore.WIN );
		_scoreToWin.score = GnopMain.endScore;
		_scoreComputer = new GnopScore( GnopScore.COMPUTER );
		
		addChild( _bg );
		addChild( _player );
		addChild( _computer );
		addChild( _ball );
		addChild( _scorePlayer );
		addChild( _scoreToWin );
		addChild( _scoreComputer );
		
		Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp, false, 0, true );
		this.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true );		
	}
	
	override public function update( ?e:Event ):Void
	{
		super.update( e );
		
		if ( _paused ) {
			return;
		}
		
		_player.y = limit( mouseY, Y_MIN, Y_MAX - _player.height );
		_computer.y = limit( _ball.y, Y_MIN, Y_MAX - _computer.height );
		_ball.y = limit( _ball.y + _ball.velocity.y, Y_MIN, Y_MAX - _ball.height, wallBounce );
		_ball.x = limit( _ball.x + _ball.velocity.x, X_MIN, X_MAX - _ball.width, paddleBounce );
	}
	
	private function paddleBounce( type:Int, value:Float ):Float
	{
		var ballMinY:Float = _ball.y;
		var ballMaxY:Float = _ball.y + _ball.height;
		var paddleMinY:Float;
		var paddleMaxY:Float;
		
		if ( type == BunState.MINIMUM ) {
			paddleMinY = _computer.y;
			paddleMaxY = _computer.y + _computer.height;
		} else {
			paddleMinY = _player.y;
			paddleMaxY = _player.y + _player.height;
		}
		
		if ( ballMaxY > paddleMinY && ballMinY < paddleMaxY ) {
			_ball.reverse( GnopBall.X_AXIS );
		} else {
			value = 320;
			
			if ( type == BunState.MINIMUM ) {
				_scoreComputer.score ++;
			} else {
				_scorePlayer.score ++;
			}
		}
		
		return value;
	}
	
	private function wallBounce( type:Int, value:Float ):Float
	{
		_ball.reverse( GnopBall.Y_AXIS );
		
		return value;
	}
	
	private function onKeyUp( ?k:KeyboardEvent ):Void
	{
		if ( k.keyCode == 81 ) {
			endGame( END_QUIT );
		}
		
		#if debug
		Log.trace( "Key Pressed: " + k.keyCode );
		#end
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