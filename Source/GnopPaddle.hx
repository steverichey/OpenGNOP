package;

import flash.display.Bitmap;
import flash.display.BitmapData;

#if desktop
@:bitmap( "assets/images/paddle_explode.png" ) class Image_About extends BitmapData { }
@:bitmap( "assets/images/paddle_ash.png" ) class Image_About extends BitmapData { }
#else
import openfl.Assets;
#end

class GnopPaddle extends Bitmap
{
	private var _height:Int;
	
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
		
		_height = Height;
		this.y = SPAWN_Y;
		
		super( new BitmapData( WIDTH, HEIGHT_MULTIPLIER * ( Height + 1 ), false, 0xff000000 ) );
	}
	
	public function explode():Void
	{
		bitmapData = Assets.getBitmapData( "images/paddle_explode.png" );
		this.x -= 4;
	}
	
	public function ash():Void
	{
		bitmapData = Assets.getBitmapData( "images/paddle_ash.png" );
	}
	
	public function restore():Void
	{
		bitmapData = new BitmapData( WIDTH, HEIGHT_MULTIPLIER * ( _height + 1 ), false, 0xff000000 );
		this.x += 4;
		this.y = SPAWN_Y;
	}
}