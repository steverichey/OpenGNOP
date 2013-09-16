package;

import flash.display.GradientType;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.media.Sound;

#if cpp || neko
	@:bitmap( "Assets/about.png" ) class About extends BitmapData { }
	@:bitmap( "Assets/cancel.png" ) class Cancel extends BitmapData { }
	@:bitmap( "Assets/cancel_inv.png" ) class CancelInv extends BitmapData { }
	@:bitmap( "Assets/checkmark.png" ) class Checkmark extends BitmapData { }
	@:bitmap( "Assets/desktop.png" ) class Desktop extends BitmapData { }
	@:bitmap( "Assets/fail01.png" ) class Fail01 extends BitmapData { }
	@:bitmap( "Assets/fail02.png" ) class Fail02 extends BitmapData { }
	@:bitmap( "Assets/icon.png" ) class Icon extends BitmapData { }
	@:bitmap( "Assets/icon_tiny.png" ) class Icon_Tiny extends BitmapData { }
	@:bitmap( "Assets/instructions.png" ) class Instructions extends BitmapData { }
	@:bitmap( "Assets/lose.png" ) class Lose extends BitmapData { }
	@:bitmap( "Assets/ok.png" ) class Okay extends BitmapData { }
	@:bitmap( "Assets/ok_inv.png" ) class Okay_Inv extends BitmapData { }
	@:bitmap( "Assets/play_border_1px.png" ) class PlayBorder extends BitmapData { }
	@:bitmap( "Assets/play_corner.png" ) class PlayCorner extends BitmapData { }
	@:bitmap( "Assets/scoreboard.png" ) class ScoreBoard extends BitmapData { }
	@:bitmap( "Assets/scorewarning.png" ) class ScoreWarning extends BitmapData { }
	@:bitmap( "Assets/septagon.png" ) class Septagon extends BitmapData { }
	@:bitmap( "Assets/setendscore.png" ) class SetEndScore extends BitmapData { }
	@:bitmap( "Assets/splash.png" ) class Splash extends BitmapData { }
	@:bitmap( "Assets/win.png" ) class Win extends BitmapData { }
	
	@:sound( "Assets/bounce.mp3" ) class Bounce extends Sound { }
	@:sound( "Assets/lose.mp3" ) class Lose extends Sound { }
	@:sound( "Assets/matchpoint.mp3" ) class MatchPoint extends Sound { }
	@:sound( "Assets/miss.mp3" ) class Miss extends Sound { }
	@:sound( "Assets/start.mp3" ) class Start extends Sound { }
	@:sound( "Assets/win.mp3" ) class Win extends Sound { }
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