package;

import flash.display.Bitmap;
import flash.display.BitmapData;

#if desktop
@:bitmap( "assets/images/about.png" ) class Image_About extends BitmapData { }
@:bitmap( "assets/images/cancel.png" ) class Image_Cancel extends BitmapData { }
@:bitmap( "assets/images/cancel_inv.png" ) class Image_Cancel_Inv extends BitmapData { }
@:bitmap( "assets/images/checkmark.png" ) class Image_Checkmark extends BitmapData { }
@:bitmap( "assets/images/fail01.png" ) class Image_Fail01 extends BitmapData { }
@:bitmap( "assets/images/fail02.png" ) class Image_Fail02 extends BitmapData { }
@:bitmap( "assets/images/font.png" ) class Image_Font extends BitmapData { }
@:bitmap( "assets/images/icon.png" ) class Image_Icon extends BitmapData { }
@:bitmap( "assets/images/icon_tiny.png" ) class Image_Icon_Tiny extends BitmapData { }
@:bitmap( "assets/images/septagon.png" ) class Image_Septagon extends BitmapData { }
#else
import openfl.Assets;
#end

/**
 * Class which allows for easy platform-independent addition of images. Might have a lot of overhead! Need to perform tests.
 */
class BunAsset extends Bitmap
{
	/**
	 * Call this to create a bitmap by loading the required file.
	 * 
	 * @param	FileName	The name of the file to load.
	 */
	public function new( FileName:String )
	{
		var b:BitmapData;
		
		#if desktop
		switch ( FileName ) {
			case "icon":
				b = new Image_Icon(0, 0);
			default:
				b = new BitmapData( 5, 5, false, 0xff00FF00 ) );
		}
		#else
		b = Assets.getBitmapData( "images/" + FileName + ".png" );
		#end
		
		super( b );
	}
}