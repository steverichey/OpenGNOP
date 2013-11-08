package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

class GnopBall extends Bitmap
{
	public var velocity:Point;
	
	public static inline var X_AXIS:Int = 0;
	public static inline var Y_AXIS:Int = 1;
	
	public function new()
	{
		var ball:BitmapData = new BitmapData( 10, 10, true, 0 );
		ball.fillRect( new Rectangle( 1, 1, 8, 8 ), 0xff000000 );
		ball.fillRect( new Rectangle( 3, 0, 4, 10 ), 0xff000000 );
		ball.fillRect( new Rectangle( 0, 3, 10, 4 ), 0xff000000 );
		
		this.x = 320;
		this.y = 240;
		
		velocity = new Point( -1, 1 );
		
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
}