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
	private var shadow:Bitmap;
	private var border:Bitmap;
	private var white:Bitmap;
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
		shadow = Reg.makeRect( 502, 312, 0xff000000 );
		shadow.x = SPLASH_WINDOW_X + 2;
		shadow.y = SPLASH_WINDOW_Y + 2;
		
		border = Reg.makeRect( 502, 312, 0xff000000 );
		border.x = SPLASH_WINDOW_X;
		border.y = SPLASH_WINDOW_Y;
		
		white = Reg.makeRect( 500, 310 );
		white.x = SPLASH_WINDOW_X + 1;
		white.y = SPLASH_WINDOW_Y + 1;
		
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
		
		addChild( shadow );
		addChild ( border );
		addChild( white );
		addChild( splash );
		
		super.init();
	}
	
	override public function update( e:Event = null ):Void
	{
		super.update();
		
		// update stuff
	}
}