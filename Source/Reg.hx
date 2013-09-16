package;

import flash.display.GradientType;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.media.Sound;
import haxe.Log;

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
	@:bitmap( "Assets/scoreboard.png" ) class ScoreBoard extends BitmapData { }
	@:bitmap( "Assets/scorewarning.png" ) class ScoreWarning extends BitmapData { }
	@:bitmap( "Assets/septagon.png" ) class Septagon extends BitmapData { }
	@:bitmap( "Assets/setendscore.png" ) class SetEndScore extends BitmapData { }
	@:bitmap( "Assets/splash.png" ) class Splash extends BitmapData { }
	@:bitmap( "Assets/win.png" ) class Win extends BitmapData { }
	@:bitmap( "Assets/window_border.png" ) class WindowBorder extends BitmapData { }
	@:bitmap( "Assets/window_border.png" ) class WindowBorder2 extends BitmapData { }
	@:bitmap( "Assets/window_border.png" ) class WindowBorder3 extends BitmapData { }
	@:bitmap( "Assets/window_border.png" ) class WindowBorder4 extends BitmapData { }
	@:bitmap( "Assets/window_corner.png" ) class WindowCorner extends BitmapData { }
	@:bitmap( "Assets/window_corner.png" ) class WindowCorner2 extends BitmapData { }
	@:bitmap( "Assets/window_corner.png" ) class WindowCorner3 extends BitmapData { }
	@:bitmap( "Assets/window_corner.png" ) class WindowCorner4 extends BitmapData { }
	
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
	public static var about:Bitmap;
	public static var desktop:Bitmap;
	public static var icon:Bitmap;
	public static var lose:Bitmap;
	public static var septagon:Bitmap;
	public static var splash:Bitmap;
	public static var win:Bitmap;
	public static var windowBorder:Bitmap;
	public static var windowBorder2:Bitmap;
	public static var windowBorder3:Bitmap;
	public static var windowBorder4:Bitmap;
	public static var windowCorner:Bitmap;
	public static var windowCorner2:Bitmap;
	public static var windowCorner3:Bitmap;
	public static var windowCorner4:Bitmap;
	
	public static function init():Void
	{
		#if cpp || neko
			about = new Bitmap( new About(0, 0) );
			desktop = new Bitmap( new Desktop(0, 0) );
			icon = new Bitmap( new Icon(0, 0) );
			lose = new Bitmap( new Lose(0, 0) );
			septagon = new Bitmap( new Septagon(0, 0) );
			splash = new Bitmap( new Splash(0, 0) );
			win = new Bitmap( new Win(0, 0) );
			windowBorder = new Bitmap( new WindowBorder(0, 0));
			windowBorder2 = new Bitmap( new WindowBorder2(0, 0));
			windowBorder3 = new Bitmap( new WindowBorder3(0, 0));
			windowBorder4 = new Bitmap( new WindowBorder4(0, 0));
			windowCorner = new Bitmap( new WindowCorner(0, 0));
			windowCorner2 = new Bitmap( new WindowCorner2(0, 0));
			windowCorner3 = new Bitmap( new WindowCorner3(0, 0));
			windowCorner4 = new Bitmap( new WindowCorner4(0, 0));
		#else
			about = new Bitmap( Assets.getBitmapData( "assets/about.png" ) );
			desktop = new Bitmap( Assets.getBitmapData( "assets/desktop.png" ) );
			icon = new Bitmap( Assets.getBitmapData( "assets/icon.png" ) );
			lose = new Bitmap( Assets.getBitmapData( "assets/lose.png" ) );
			septagon = new Bitmap( Assets.getBitmapData( "assets/septagon.png" ) );
			splash = new Bitmap( Assets.getBitmapData( "assets/splash.png" ) );
			win = new Bitmap( Assets.getBitmapData( "assets/win.png" ) );
			windowBorder = new Bitmap( Assets.getBitmapData( "assets/window_border.png" ) );
			windowBorder2 = new Bitmap( Assets.getBitmapData( "assets/window_border.png" ) );
			windowBorder3 = new Bitmap( Assets.getBitmapData( "assets/window_border.png" ) );
			windowBorder4 = new Bitmap( Assets.getBitmapData( "assets/window_border.png" ) );
			windowCorner = new Bitmap( Assets.getBitmapData( "assets/window_corner.png" ) );
			windowCorner2 = new Bitmap( Assets.getBitmapData( "assets/window_corner.png" ) );
			windowCorner3 = new Bitmap( Assets.getBitmapData( "assets/window_corner.png" ) );
			windowCorner4 = new Bitmap( Assets.getBitmapData( "assets/window_corner.png" ) );
		#end
	}
	
	/*
	 * Used to make a rectangle easily.
	*/
	
	public static function makeRect( Width:Int, Height:Int, Color:Int = 0xffffffff, Alpha:Int = 1 ):Bitmap
	{
		var rectdata:BitmapData = new BitmapData( Width, Height, false, Color );
		var rect:Bitmap = new Bitmap( rectdata );
		rect.alpha = Alpha;
		
		return rect;
	}
	
	/*
	 * Draws an OS-styled window with a white background, as a sprite
	*/
	
	public static function drawWindow( Width:Int = 20, Height:Int = 20 ):Sprite
	{
		var window:Sprite = new Sprite();
		
		var corner1:Bitmap = Reg.windowCorner;
		var corner2:Bitmap = Reg.windowCorner2;
		var corner3:Bitmap = Reg.windowCorner3;
		var corner4:Bitmap = Reg.windowCorner4;
		var border1:Bitmap = Reg.windowBorder;
		var border2:Bitmap = Reg.windowBorder2;
		var border3:Bitmap = Reg.windowBorder3;
		var border4:Bitmap = Reg.windowBorder4;
		var whiteBox:Bitmap = Reg.makeRect( Std.int( Width - corner1.width - corner2.width ), Std.int( Height - corner1.height - corner2.height ), 0xffffffff );
		
		border1.width = border4.width = whiteBox.width;
		border2.width = border3.width = whiteBox.height;
		
		corner2.rotation = 90;
		corner3.rotation = -90;
		corner4.rotation = 180;
		border2.rotation = 90;
		border3.rotation = -90;
		border4.rotation = 180;
		
		corner2.x = corner1.width + whiteBox.width + corner2.width;
		corner3.y = corner1.height + whiteBox.height + corner4.height;
		corner4.x = corner1.width + whiteBox.width + corner4.width;
		corner4.y = corner1.height + whiteBox.height + corner4.height;
		
		border1.x = corner1.width;
		border2.x = whiteBox.width + corner1.width + corner2.width;
		border2.y = corner1.height;
		border3.y = corner1.height + whiteBox.height;
		border4.x = whiteBox.width + corner1.width;
		border4.y = corner1.height + corner2.height + whiteBox.height;
		whiteBox.x = corner1.width;
		whiteBox.y = corner1.height;
		
		window.addChild( whiteBox );
		window.addChild( corner1 );
		window.addChild( corner2 );
		window.addChild( corner3 );
		window.addChild( corner4 );
		window.addChild( border1 );
		window.addChild( border2 );
		window.addChild( border3 );
		window.addChild( border4 );
		
		return window;
	}
}