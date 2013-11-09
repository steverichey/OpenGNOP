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
import flash.events.KeyboardEvent;

#if desktop
import flash.media.Sound;

@:sound( "sounds/bounce.ogg" ) class Sound_Bounce extends Sound { }
@:sound( "sounds/matchpoint.ogg" ) class Sound_MatchPoint extends Sound { }
#else
import openfl.Assets;
#end

class GnopPlaystate extends BunState
{
	private var _bg:BunWindow;
	private var _player:GnopPaddle;
	private var _computer:GnopPaddle;
	private var _ball:GnopBall;
	private var _scorePlayer:GnopScore;
	private var _scoreToWin:GnopScore;
	private var _scoreComputer:GnopScore;
	
	private var _bounce:BunSound;
	private var _matchPoint:BunSound;
	
	private var _paused:Bool;
	private var _animating:Bool;
	private var _serving:Bool;
	private var _playerServing:Bool;
	
	private static inline var BG_X:Int = 62;
	private static inline var BG_Y:Int = 87;
	private static inline var BG_WIDTH:Int = 516;
	private static inline var BG_HEIGHT:Int = 326;
	
	private static inline var Y_MIN:Int = 116;
	public static inline var Y_MAX:Int = 405;
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
		
		#if desktop
		_bounce = new BunSound( Sound_Bounce() );
		_matchPoint = new BunSound( Sound_MatchPoint() );
		#else
		_bounce = new BunSound( "bounce" );
		_matchPoint = new BunSound( "matchpoint" );
		#end
		
		addChild( _bg );
		addChild( _player );
		addChild( _computer );
		addChild( _ball );
		addChild( _scorePlayer );
		addChild( _scoreToWin );
		addChild( _scoreComputer );
		
		Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp, false, 0, true );
		Lib.current.stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true );
	}
	
	override public function update( ?e:Event ):Void
	{
		super.update( e );
		
		if ( _paused || _player.animating || _computer.animating ) {
			return;
		}
		
		_player.y = limit( mouseY, Y_MIN, Y_MAX - _player.height );
		_computer.y = limit( mouseY, Y_MIN, Y_MAX - _computer.height );
		
		if ( _serving ) {
			if ( _playerServing ) {
				_ball.y = _player.y + ( _player.height - _ball.height ) / 2;
			} else {
				_ball.y = _computer.y + ( _computer.height - _ball.height ) / 2;
			}
		} else {
			_ball.y = limit( _ball.y + _ball.velocity.y, Y_MIN, Y_MAX - _ball.height, wallBounce );
			_ball.x = limit( _ball.x + _ball.velocity.x, X_MIN, X_MAX - _ball.width, paddleBounce );
		}
	}
	
	private function paddleBounce( type:Int, value:Float ):Float
	{
		var ballMinY:Float = _ball.y;
		var ballMaxY:Float = _ball.y + _ball.height;
		var paddleMinY:Float;
		var paddleMaxY:Float;
		var isPlayer:Bool;
		
		if ( type == BunState.MINIMUM ) {
			paddleMinY = _computer.y;
			paddleMaxY = _computer.y + _computer.height;
			isPlayer = false;
		} else {
			paddleMinY = _player.y;
			paddleMaxY = _player.y + _player.height;
			isPlayer = true;
		}
		
		if ( ballMaxY > paddleMinY && ballMinY < paddleMaxY ) {
			_ball.reverse( GnopBall.X_AXIS );
			_bounce.play( true );
			
			if ( isPlayer ) {
				_ball.calculateY( _player.x, _player.height );
			} else {
				_ball.calculateY( _computer.x, _computer.height );
			}
		} else {
			_serving = true;
			_ball.visible = false;
			
			if ( isPlayer ) {
				_player.addEventListener( Event.COMPLETE, onCompleteExplosion, false, 0, true );
				_player.explode();
				_playerServing = false;
				value = _computer.x + _computer.width + 1;
			} else {
				_computer.addEventListener( Event.COMPLETE, onCompleteExplosion, false, 0, true );
				_computer.explode();
				_playerServing = true;
				value = _player.x - _ball.width - 1;
			}
			
			if ( type == BunState.MINIMUM ) {
				_scorePlayer.score ++;
				
				if ( _scorePlayer.score == _scoreToWin.score - 1 ) {
					_matchPoint.play();
				}
				
				if ( _scorePlayer.score >= _scoreToWin.score ) {
					endGame( END_WIN );
				}
			} else {
				_scoreComputer.score ++;
				
				if ( _scoreComputer.score == _scoreToWin.score - 1 ) {
					_matchPoint.play();
				}
				
				if ( _scoreComputer.score >= _scoreToWin.score ) {
					endGame( END_LOSE );
				}
			}
		}
		
		return value;
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
		Log.trace( "Key Pressed: " + k.keyCode );
		#end
	}
	
	private function onMouseDown( ?m:MouseEvent ):Void
	{
		if ( _serving ) {
			_serving = false;
		}
		
		#if debug
		Log.trace( "Mouse down." );
		#end
	}
	
	private function onCompleteExplosion( ?e:Event ):Void
	{
		e.target.removeEventListener( Event.COMPLETE, onCompleteExplosion );
		_ball.visible = true;
	}
	
	private function endGame( type:Int ):Void
	{
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