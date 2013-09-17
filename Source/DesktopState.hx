package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.text.TextField;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;

class DesktopState extends GnopState
{
	private var icon:Sprite;
	private var iconInverted:Bool;
	private var fakeSeptagon:Bitmap;
	private var dragging:Bool;
	private var timeOfFirstClick:Int;
	private var iconDiffX:Float;
	private var iconDiffY:Float;
	
	static inline var DOUBLE_CLICK_TIME:Int = 500;
	static inline var NEGATIVE_DEFAULT_CLICK_TIME:Int = -2000;
	
	public function new()
	{
		super();
	}
	
	override public function init( ?E:Event ):Void 
	{
		super.init();
		
		timeOfFirstClick = NEGATIVE_DEFAULT_CLICK_TIME;
		
		icon = new Sprite();
		icon.addChild( Reg.icon );
		icon.x = ( stage.stageWidth - icon.width ) / 2;
		icon.y = ( stage.stageHeight - icon.height ) / 2;
		addChild( icon );
		
		fakeSeptagon = Reg.septagon;
		fakeSeptagon.x = 17;
		fakeSeptagon.y = 3;
		addChild( fakeSeptagon );
		
		icon.addEventListener( MouseEvent.MOUSE_DOWN, clickIcon, false, 0, true  );
		invisibleBG.addEventListener( MouseEvent.MOUSE_DOWN, clickDesktop, false, 0, true  );
	}
	
	override public function update( e:Event = null ):Void
	{
		super.update();
		
		if ( dragging && icon.visible ) {
			limit( icon, mouseX - iconDiffX, mouseY - iconDiffY, 0, 20, getStageWidth(), getStageHeight() );
		}
	}
	
	private function clickDesktop( m:MouseEvent ):Void
	{
		if ( iconInverted ) {
			invert( icon );
			iconInverted = false;
		}
	}
	
	private function clickIcon( m:MouseEvent ):Void
	{
		icon.removeEventListener( MouseEvent.MOUSE_DOWN, clickIcon );
		
		if ( !iconInverted ) {
			invert( icon );
			iconInverted = true;
		}
		
		var timeBetweenClicks:Int = Lib.getTimer() - timeOfFirstClick;
		
		if ( timeBetweenClicks < DOUBLE_CLICK_TIME ) {
			openFile();
			return;
		}
		
		dragging = true;
		timeOfFirstClick = Lib.getTimer();
		
		iconDiffX = mouseX - icon.x;
		iconDiffY = mouseY - icon.y;
		
		addEventListener( MouseEvent.MOUSE_UP, unclickIcon, false, 0, true );
	}
	
	private function unclickIcon( m:MouseEvent ):Void
	{
		dragging = false;
		
		removeEventListener( MouseEvent.MOUSE_UP, unclickIcon );
		icon.addEventListener( MouseEvent.MOUSE_DOWN, clickIcon, false, 0, true );
	}
	
	private function openFile():Void
	{
		dragging = false;
		Gnop.addLayer( new SplashState() );
	}
}