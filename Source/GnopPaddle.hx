package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

#if desktop
import flash.media.Sound;

@:bitmap( "assets/images/paddle_explode.png" ) class Image_About extends BitmapData { }
@:bitmap( "assets/images/paddle_ash.png" ) class Image_About extends BitmapData { }
@:sound( "sounds/explode.ogg" ) class Sound_Explode extends Sound { }
@:sound( "sounds/land.ogg" ) class Sound_Land extends Sound { }
#else
import openfl.Assets;
#end

class GnopPaddle extends Bitmap
{
	public var animating:Bool;
	public var predictedY:Float;
	
	private var _height:Int;
	private var _explode:BunSound;
	private var _land:BunSound;
	private var _explodeTimer:Timer;
	private var _ashen:Bool;
	private var _playedLand:Bool;
	private var _speed:Float;
	
	public static inline var PLAYER:Int = 0;
	public static inline var COMPUTER:Int = 1;
	public static inline var SPAWN_Y:Int = 240;
	
	private static inline var PLAYER_X:Int = 557;
	private static inline var COMPUTER_X:Int = 75;
	private static inline var WIDTH:Int = 8;
	private static inline var HEIGHT_MULTIPLIER:Int = 14;
	private static inline var TIMER_FREQ:Int = 20;
	private static inline var TIMER_NUM_TIMES:Int = 50;
	private static inline var NOVICE_SPEED:Float = 1.0;
	private static inline var INTERMEDIATE_SPEED:Float = 2.0;
	private static inline var EXPERT_SPEED:Float = 4.0;
	
	public function new( Height:Int, PaddleType:Int )
	{
		if ( PaddleType == PLAYER ) {
			this.x = PLAYER_X;
		} else {
			this.x = COMPUTER_X;
			
			if ( GnopMain.difficulty == 0 ) {
				_speed = NOVICE_SPEED;
			} else if ( GnopMain.difficulty == 1 ) {
				_speed = INTERMEDIATE_SPEED;
			} else {
				_speed = EXPERT_SPEED;
			}
		}
		
		_height = Height;
		this.y = SPAWN_Y;
		predictedY = 0.0;
		_explodeTimer = new Timer( TIMER_FREQ, TIMER_NUM_TIMES );
		_explodeTimer.addEventListener( TimerEvent.TIMER, onExplodeTimer );
		_explodeTimer.addEventListener( TimerEvent.TIMER_COMPLETE, restore );
		
		_explode = new BunSound( "explode" );
		_land = new BunSound( "land" );
		
		super( new BitmapData( WIDTH, HEIGHT_MULTIPLIER * ( Height + 1 ), false, 0xff000000 ) );
	}
	
	public function moveTowardPredictedY():Float
	{
		var amountToMove:Float = 0.0;
		
		if ( predictedY < this.y ) {
			amountToMove = -_speed;
		} else {
			amountToMove = _speed;
		}
		
		return amountToMove + this.y;
	}
	
	public function explode():Void
	{
		animating = true;
		bitmapData = Assets.getBitmapData( "images/paddle_explode.png" );
		this.x -= 4;
		_playedLand = false;
		_explodeTimer.start();
		_explode.play();
	}
	
	private function onExplodeTimer( ?t:TimerEvent ):Void
	{
		if ( _explodeTimer.currentCount > TIMER_NUM_TIMES / 2 ) {
			ash();
		}
	}
	
	private function ash():Void
	{
		if ( !_ashen ) {
			bitmapData = Assets.getBitmapData( "images/paddle_ash.png" );
			_ashen = true;
		} else if ( this.y < GnopPlaystate.Y_MAX - this.height ) {
			this.y += 4;
		} else if ( !_playedLand ) {
			_land.play();
			_playedLand = true;
		}
	}
	
	private function restore( ?t:TimerEvent ):Void
	{
		_explodeTimer.reset();
		_ashen = false;
		bitmapData = new BitmapData( WIDTH, HEIGHT_MULTIPLIER * ( _height + 1 ), false, 0xff000000 );
		this.x += 4;
		this.y = SPAWN_Y;
		animating = false;
		dispatchEvent( new Event( Event.COMPLETE ) );
	}
}