package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.Lib;
import flash.ui.Mouse;
import flash.events.KeyboardEvent;
import flash.utils.Timer;
import open7.OSState;
import open7.sys.OSSound;
import open7.ui.OSWindow;
import openfl.Assets;

class GnopPlaystate extends OSState
{
	private var _bg:OSWindow;
	private var _player:GnopPaddle;
	private var _computer:GnopPaddle;
	private var _ball:GnopBall;
	private var _scorePlayer:GnopScore;
	private var _scoreToWin:GnopScore;
	private var _scoreComputer:GnopScore;
	
	private var _bounce:OSSound;
	private var _matchPoint:OSSound;
	
	private var _paused:Bool;
	private var _animating:Bool;
	private var _serving:Bool;
	private var _playerServing:Bool;
	
	private var _tick:Timer;
	
	private static inline var BG_X:Int = 62;
	private static inline var BG_Y:Int = 87;
	private static inline var BG_WIDTH:Int = 516;
	private static inline var BG_HEIGHT:Int = 326;
	
	private static inline var Y_MIN:Int = 116;
	public static inline var Y_MAX:Int = 405;
	private static inline var X_MIN:Int = 83;
	private static inline var X_MAX:Int = 557;
	
	private static inline var TICK_SLOW:Int = 54;
	private static inline var TICK_NORMAL:Int = 27;
	private static inline var TICK_FAST:Int = 18;
	
	// Game end types
	
	public static inline var END_QUIT:Int = 0;
	public static inline var END_LOSE:Int = 1;
	public static inline var END_WIN:Int = 2;
	
	// debug
	
	#if debug
	private static var SHOW_PATH:Bool = true;
	#end
	
	public function new()
	{
		super();
	}
	
	override public function init( ?e:Event ):Void
	{
		super.init( e );
		
		Mouse.hide();
		
		_bg = new OSWindow( BG_WIDTH, BG_HEIGHT, OSWindow.BORDERED, Assets.getBitmapData( "images/scoreboard.png" ), 8, 9 );
		_bg.x = BG_X;
		_bg.y = BG_Y;
		
		_player = new GnopPaddle( GnopMain.playerPaddleSize, GnopPaddle.PLAYER );
		_computer = new GnopPaddle( GnopMain.computerPaddleSize, GnopPaddle.COMPUTER );
		_ball = new GnopBall( GnopMain.ballSize, GnopMain.ballSpeed );
		_scorePlayer = new GnopScore( GnopScore.PLAYER );
		_scoreToWin = new GnopScore( GnopScore.WIN, GnopMain.endScore );
		_scoreComputer = new GnopScore( GnopScore.COMPUTER );
		
		_serving = true;
		
		if ( GnopMain.playerServesFirst ) {
			_ball.x = _player.x - _ball.width - 1;
			_playerServing = true;
		} else {
			_ball.x = _computer.x + _computer.width + 1;
			_playerServing = false;
		}
		
		_bounce = new OSSound( "bounce" );
		_matchPoint = new OSSound( "matchpoint" );
		
		addChild( _bg );
		addChild( _player );
		addChild( _computer );
		addChild( _ball );
		addChild( _scorePlayer );
		addChild( _scoreToWin );
		addChild( _scoreComputer );
		
		Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp, false, 0, true );
		Lib.current.stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true );
		
		// Since the tick frequency varies, we can't use the generic update timer (based on frames).
		
		var tickfreq:Int = 0;
		
		if ( GnopMain.ballSpeed == 0 ) {
			tickfreq = TICK_SLOW;
		} else if ( GnopMain.ballSpeed == 1 ) {
			tickfreq = TICK_NORMAL;
		} else {
			tickfreq = TICK_FAST;
		}
		
		_tick = new Timer( tickfreq );
		_tick.addEventListener( TimerEvent.TIMER, onTick, false, 0, true );
		_tick.start();
	}
	
	public function onTick( ?t:TimerEvent ):Void
	{
		if ( _paused || _player.animating || _computer.animating ) {
			return;
		}
		
		_player.y = limit( mouseY, Y_MIN, Y_MAX - _player.height );
		
		if ( _serving ) {
			if ( _playerServing ) {
				_ball.y = _player.y + ( _player.height - _ball.height ) / 2;
			} else {
				_ball.y = _computer.y + ( _computer.height - _ball.height ) / 2;
			}
		} else {
			_ball.y = limit( _ball.y + _ball.velocity.y, Y_MIN, Y_MAX - _ball.height, wallBounce );
			_ball.x = limit( _ball.x + _ball.velocity.x, X_MIN, X_MAX - _ball.width, paddleBounce );
			
			if ( _ball != null ) {
				if ( _ball.velocity.x < 0 ) {
					_computer.y = limit( _computer.moveTowardPredictedY(), Y_MIN, Y_MAX - _computer.height );
				}
			}
		}
	}
	
	private function paddleBounce( type:Int, value:Float ):Float
	{
		var ballMinY:Float = _ball.y;
		var ballMaxY:Float = _ball.y + _ball.height;
		var paddleMinY:Float;
		var paddleMaxY:Float;
		
		if ( type == OSState.MINIMUM ) {
			paddleMinY = _computer.y;
			paddleMaxY = _computer.y + _computer.height;
		} else {
			paddleMinY = _player.y;
			paddleMaxY = _player.y + _player.height;
		}
		
		if ( ballMaxY > paddleMinY && ballMinY < paddleMaxY ) {
			_ball.reverse( GnopBall.X_AXIS );
			_bounce.play( true );
			
			if ( type == OSState.MAXIMUM ) {
				_ball.calculateY( _player.y, _player.height );
				_computer.predictedY = predictBallDestination();
			} else {
				_ball.calculateY( _computer.y, _computer.height );
			}
		} else {
			_serving = true;
			_ball.visible = false;
			
			if ( type == OSState.MAXIMUM ) {
				_scoreComputer.score ++;
				
				_player.addEventListener( Event.COMPLETE, onCompleteExplosion, false, 0, true );
				_player.explode();
				_playerServing = false;
				value = _computer.x + _computer.width + 1;
			} else {
				_scorePlayer.score++;
				
				_computer.addEventListener( Event.COMPLETE, onCompleteExplosion, false, 0, true );
				_computer.explode();
				_playerServing = true;
				value = _player.x - _ball.width - 1;
			}
		}
		
		return value;
	}
	
	private function predictBallDestination():Float
	{
		var ballX:Float = _ball.x;
		var ballY:Float = _ball.y;
		var ballVelY:Float = _ball.velocity.y;
		
		while ( ballX > X_MIN ) {
			ballY = limit( ballY + ballVelY, Y_MIN, Y_MAX - _ball.height, function( a:Int, v:Float ) {
				ballVelY *= -1;
				return v;
			} );
			
			#if debug
			if ( SHOW_PATH ) {
				var t:Bitmap = new Bitmap( new BitmapData( 2, 2, false, Std.int( Math.random() * ( 0xffFFFFFF - 0xff000000) ) ) );
				t.x = ballX;
				t.y = ballY;
				addChild( t );
			}
			#end
			
			ballX += _ball.velocity.x;
		}
		
		return ballY + ( _ball.height / 2 );
	}
	
	private function wallBounce( type:Int, value:Float ):Float
	{
		_ball.reverse( GnopBall.Y_AXIS );
		_bounce.play( true );
		
		return value;
	}
	
	private function onKeyUp( ?k:KeyboardEvent ):Void
	{
		if ( k.keyCode == 81 ) {
			endGame( END_QUIT );
		}
		
		if ( k.keyCode == 80 ) {
			_paused = !_paused;
		}
		
		#if debug
		//haxe.Log.trace( "Key Pressed: " + k.keyCode );
		#end
	}
	
	private function onMouseDown( ?m:MouseEvent ):Void
	{
		if ( _serving ) {
			_serving = false;
			
			if ( _playerServing ) {
				_computer.predictedY = predictBallDestination();
			}
		}
	}
	
	private function onCompleteExplosion( ?e:Event ):Void
	{
		e.target.removeEventListener( Event.COMPLETE, onCompleteExplosion );
		
		if ( _scorePlayer.score == _scoreToWin.score - 1 && _playerServing ) {
			_matchPoint.play();
		} else if ( _scoreComputer.score == _scoreToWin.score - 1 && !_playerServing ) {
			_matchPoint.play();
		}
		
		if ( _scorePlayer.score >= _scoreToWin.score ) {
			endGame( END_WIN );
		} else if ( _scoreComputer.score >= _scoreToWin.score ) {
			endGame( END_LOSE );
		}
		
		if ( _computer != null ) {
			_computer.y = GnopPaddle.SPAWN_Y;
		}
		
		if ( _ball != null ) {
			_ball.reset();
		}
	}
	
	private function endGame( type:Int ):Void
	{
		_paused = true;
		
		cast( this.parent, GnopMain ).setSplash( type );
		
		Lib.current.stage.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		Lib.current.stage.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		
		removeChild( _bg );
		removeChild( _player );
		removeChild( _computer );
		removeChild( _ball );
		removeChild( _scorePlayer );
		removeChild( _scoreToWin );
		removeChild( _scoreComputer );
		
		if ( _computer.hasEventListener( Event.COMPLETE ) ) {
			_computer.removeEventListener( Event.COMPLETE, onCompleteExplosion );
		}
		
		if ( _computer.hasEventListener( Event.COMPLETE ) ) {
			_player.removeEventListener( Event.COMPLETE, onCompleteExplosion );
		}
		
		_bg = null;
		_player = null;
		_computer = null;
		_ball = null;
		_scorePlayer = null;
		_scoreToWin = null;
		_scoreComputer = null;
		
		Mouse.show();
		
		dispatchEvent( new Event( Event.COMPLETE ) );
	}
}