package;

import flash.display.GradientType;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.media.Sound;
import flash.text.Font;
import haxe.Log;

#if desktop
@:bitmap( "assets/images/about.png" ) class Image_About extends BitmapData { }
@:bitmap( "assets/images/border.png" ) class Image_Border extends BitmapData { }
@:bitmap( "assets/images/corner.png" ) class Image_Corner extends BitmapData { }
#else
import openfl.Assets;
#end

/**
 * A class with generic, handy functions for the "BungieOS".
 */
class BunOs
{
	
	/**
	 * Abstracted bitmap creation function.
	 * 
	 * @param	FileName	The filename of the image asset. For desktop targets, this is used to create a new embedded BitmapData.
	 * @return	A bitmap.
	 */
	public function createBitmapData( FileName:String ):BitmapData
	{
		var b:BitmapData;
		
		#if desktop
		case ( FileName ) {
			switch "border":
				b = new Image_Border(0, 0);
			switch "corner":
				b = new Image_Corner(0, 0);
		}
		#else
		b = Assets.getBitmapData( IMAGE_PATH + FileName + IMAGE_EXT, false );
		#end
		
		return b;
	}
	
	
	public function createBitmap( FileName:String )
	{
		return new Bitmap( createBitmapData( FileName ) );
	}
	
	
	public function copyAllPixels( To:Bitmap, From:Bitmap, X:Int, Y:Int ):Void
	{
		copyAllPixelData( To.bitmapData, From.bitmapData, X, Y );
	}
}