package;

import flash.display.Bitmap;
import flash.display.BitmapData;

class GnopPaddle extends Bitmap
{
	public static inline var PLAYER:Int = 0;
	public static inline var COMPUTER:Int = 1;
	
	private static inline var PLAYER_X:Int = 557;
	private static inline var COMPUTER_X:Int = 75;
	private static inline var SPAWN_Y:Int = 240;
	private static inline var WIDTH:Int = 8;
	private static inline var HEIGHT_MULTIPLIER:Int = 14;
	
	public function new( Height:Int, PaddleType:Int )
	{
		if ( PaddleType == PLAYER ) {
			this.x = PLAYER_X;
		} else {
			this.x = COMPUTER_X;
		}
		
		this.y = SPAWN_Y;
		
		super( new BitmapData( WIDTH, HEIGHT_MULTIPLIER * ( Height + 1 ), false, 0xff000000 ) );
	}
}