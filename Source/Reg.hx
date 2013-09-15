package;

import flash.display.GradientType;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;

#if cpp || neko
	@:bitmap( "Assets/desktop.png" ) class Desktop extends BitmapData { }
	@:bitmap( "Assets/icon.png" ) class Icon extends BitmapData { }
	@:bitmap( "Assets/septagon.png" ) class Septagon extends BitmapData { }
#else
	import openfl.Assets;
#end

/*
 * A handy HaxeFlixel-esque class to store images in one place.
 * Automagically toggles between Assets (flash, js) and embeds (cpp, neko).
*/

class Reg
{
	public static var desktop:Bitmap;
	public static var icon:Bitmap;
	public static var septagon:Bitmap;
	
	public static function init():Void
	{
		#if cpp || neko
			desktop = new Bitmap( new Desktop(0, 0) );
			icon = new Bitmap( new Icon(0, 0) ) );
			septagon = new Bitmap( new Septagon(0, 0) );
		#else
			desktop = new Bitmap( Assets.getBitmapData( "assets/desktop.png" ) );
			icon = new Bitmap( Assets.getBitmapData( "assets/icon.png" ) );
			septagon = new Bitmap( Assets.getBitmapData( "assets/septagon.png" ) );
		#end
	}
	
	/*
	 * Used to make a rectangle easily.
	*/
	
	public static function makeRect( Width:Int, Height:Int, Color:Int, Alpha:Int = 1 ):Bitmap
	{
		var rectdata:BitmapData = new BitmapData( Width, Height, false, Color );
		var rect:Bitmap = new Bitmap( rectdata );
		rect.alpha = Alpha;
		
		return rect;
	}
}