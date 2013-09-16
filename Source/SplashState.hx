package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.text.TextField;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.Lib;
import haxe.Log;

class SplashState extends GnopState
{
	private var window:Sprite;
	private var splash:Bitmap;
	private var type:String;
	
	static inline var SPLASH_WINDOW_X:Int = 69;
	static inline var SPLASH_WINDOW_Y:Int = 94;
	
	public function new( type:String = "splash" )
	{
		super();
		
		this.type = type;
	}
	
	override public function init( ?E:Event ):Void 
	{
		window = Reg.drawShadowedWindow( 502, 312 );
		window.x = SPLASH_WINDOW_X;
		window.y = SPLASH_WINDOW_Y;
		
		if ( type == "lose" ) {
			splash = Reg.lose;
			splash.x = SPLASH_WINDOW_X + 125;
			splash.y = SPLASH_WINDOW_Y + 72;
		} else if ( type == "win" ) {
			splash = Reg.win;
			splash.x = SPLASH_WINDOW_X + 104;
			splash.y = SPLASH_WINDOW_Y + 62;
		} else {
			splash = Reg.splash;
			splash.x = SPLASH_WINDOW_X + 57;
			splash.y = SPLASH_WINDOW_Y + 49;
		}
		
		addChild( window );
		addChild( splash );
		
		super.init();
	}
	
	override public function update( e:Event = null ):Void
	{
		super.update();
		
		// update stuff
	}
}