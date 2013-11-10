package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import haxe.Log;

class GnopBall extends Bitmap
{
	public var velocity:Point;
	
	public static inline var X_AXIS:Int = 0;
	public static inline var Y_AXIS:Int = 1;
	
	public static inline var SMALL:Int = 0;
	public static inline var NORMAL_SIZE:Int = 1;
	public static inline var LARGE:Int = 2;
	public static inline var BOARD:Int = 3;
	
	public static inline var SLOW:Int = 0;
	public static inline var NORMAL_SPEED:Int = 1;
	public static inline var FAST:Int = 2;
	
	private static inline var BLK:Int = 0xff000000;
	private static inline var SPEED_X_SLOW:Int = 2;
	private static inline var SPEED_X_NORMAL:Int = 4;
	private static inline var SPEED_X_FAST:Int = 8;
	
	public function new( BallSize:Int, BallSpeed:Int )
	{
		var ball:BitmapData;
		
		if ( BallSize == SMALL ) {
			ball = new BitmapData( 6, 6, true, 0 );
			ball.fillRect( new Rectangle( 0, 1, 6, 4 ), BLK );
			ball.fillRect( new Rectangle( 1, 0, 4, 6 ), BLK );
		} else if ( BallSize == NORMAL_SIZE ) {
			ball = new BitmapData( 10, 10, true, 0 );
			ball.fillRect( new Rectangle( 1, 1, 8, 8 ), BLK );
			ball.fillRect( new Rectangle( 3, 0, 4, 10 ), BLK );
			ball.fillRect( new Rectangle( 0, 3, 10, 4 ), BLK );
		} else if ( BallSize == LARGE ) {
			ball = new BitmapData( 14, 14, true, 0 );
			ball.fillRect( new Rectangle( 0, 4, 14, 6 ), BLK );
			ball.fillRect( new Rectangle( 4, 0, 6, 14 ), BLK );
			ball.fillRect( new Rectangle( 1, 3, 12, 8 ), BLK );
			ball.fillRect( new Rectangle( 3, 1, 8, 12 ), BLK );
			ball.fillRect( new Rectangle( 2, 2, 10, 10 ), BLK );
		} else {
			ball = new BitmapData( 8, 8, true, 0 );
			ball.fillRect( new Rectangle( 0, 2, 8, 4 ), BLK );
			ball.fillRect( new Rectangle( 2, 0, 4, 8 ), BLK );
			ball.fillRect( new Rectangle( 1, 1, 6, 6 ), BLK );
		}
		
		var xspeed:Int = 0;
		
		if ( BallSpeed == SLOW ) {
			xspeed = SPEED_X_SLOW;
		} else if ( BallSpeed == NORMAL_SPEED ) {
			xspeed = SPEED_X_NORMAL;
		} else {
			xspeed = SPEED_X_FAST;
		}
		
		if ( GnopMain.playerServesFirst ) {
			xspeed *= -1;
		}
		
		velocity = new Point( xspeed, 0 );
		
		super( ball );
	}
	
	public function reverse( Axis:Int ):Void
	{
		if ( Axis  == X_AXIS ) {
			velocity.x *= -1;
		} else {
			velocity.y *= -1;
		}
	}
	
	public function calculateY( PaddleY:Float, PaddleHeight:Float ):Void
	{
		var thisMid:Float = this.y + this.height / 2;
		var paddleMid:Float = PaddleY + PaddleHeight / 2;
		var fromCenter:Float = paddleMid - thisMid;
		var maxDist:Float = ( this.height + PaddleHeight ) / 2;
		var sign:Int = 1;
		
		if ( fromCenter > 0 ) {
			sign = -1;
		}
		
		velocity.y *= sign * ( fromCenter * fromCenter ) / maxDist;
		
		Log.trace( "ThisMid: " + thisMid + ", PaddleMid: " + paddleMid + ", FromCenter: " + fromCenter + ", Max: " + maxDist + ", PaddleY: " + PaddleY + ", PaddleHeight: " + PaddleHeight );
	}
	
	public function reset():Void
	{
		velocity.y = 0;
		visible = true;
	}
}