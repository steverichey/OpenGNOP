package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.text.TextField;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import openfl.Assets;
import flash.geom.Point;

class BunDesktop extends BunState
{
	private var icon:Sprite;
	private var iconInverted:Bool;
	private var dragging:Bool;
	private var timeOfFirstClick:Int;
	private var iconDiffX:Float;
	private var iconDiffY:Float;
	
	private var _time:BunTime;
	private var _game:GnopMain;
	private var _defaultMenu:BunMenu;
	private var _infoWindow:BunWindowExt;
	
	private static inline var DOUBLE_CLICK_TIME:Int = 500;
	private static inline var NEGATIVE_DEFAULT_CLICK_TIME:Int = -2000;
	private static inline var SEPTAGON_X:Int = 17;
	private static inline var SEPTAGON_Y:Int = 2;
	private static inline var TIME_X:Int = 571;
	private static inline var TIME_Y:Int = 5;
	
	public function new()
	{
		super();
	}
	
	override public function init( ?e:Event ):Void 
	{
		super.init();
		
		timeOfFirstClick = NEGATIVE_DEFAULT_CLICK_TIME;
		
		icon = new Sprite();
		icon.addChild( new Bitmap( GnopMain.getIcon() ) );
		icon.x = ( stage.stageWidth - icon.width ) / 2;
		icon.y = ( stage.stageHeight - icon.height ) / 2;
		addChild( icon );
		
		var sept:Bitmap = new Bitmap( Assets.getBitmapData( "images/septagon.png" ) );
		sept.x = SEPTAGON_X;
		sept.y = SEPTAGON_Y;
		addChild( sept );
		
		//_defaultMenu = new BunMenu( [ [ BunMenuItem.SEPTAGON, "About OpenGnop..." ] ] );
		//addChild( _defaultMenu );
		
		_time = new BunTime();
		_time.x = TIME_X;
		_time.y = TIME_Y;
		addChild( _time );
		/*
		_infoWindow = new BunWindowExt( 100, 100, BunWindow.BORDERED );
		_infoWindow.addText( 6, 6, "Hi" );
		_infoWindow.addOk( 20, 20 );
		_infoWindow.addEventListener( Event.COMPLETE, onCloseInfo, false, 0, true );
		_infoWindow.visible = false;
		addChild( _infoWindow );
		*/
		icon.addEventListener( MouseEvent.MOUSE_DOWN, clickIcon, false, 0, true  );
	}
	
	override public function update( ?e:Event ):Void
	{
		super.update();
		
		if ( _game == null ) {
			if ( dragging && icon.visible ) {
				icon.x = limit( mouseX - iconDiffX, 0, getStageWidth() - icon.width );
				icon.y = limit( mouseY - iconDiffY, 20, getStageHeight() - icon.height );
			}
		} else {
			_game.update( e );
		}
		
		_time.update();
	}
	
	private function onCloseInfo( ?e:Event ):Void
	{
		_infoWindow.visible = false;
	}
	
	override public function clickAway( ?m:MouseEvent ):Void
	{
		super.clickAway( m );
		
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
	
	override public function menuSelect( Selection:Point ):Void
	{
		_infoWindow.visible = true;
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
		
		// Change this file for other games.
		// For example, if you wanted to use the Bun files to run OpenODS, you
		// could change _game = new Gnop(); to _game = new ODS(); and then put
		// the necessary game logic in a new file called ODS.hx with class ODS.
		
		_game = new GnopMain();
		addChild( _game );
		
		_game.addEventListener( Event.COMPLETE, onCloseGame, false, 0, true );
	}
	
	private function onCloseGame( e:Event ):Void
	{
		_game.removeEventListener( Event.COMPLETE, onCloseGame );
		removeChild( _game );
		_game = null;
		
		icon.addEventListener( MouseEvent.MOUSE_DOWN, clickIcon, false, 0, true );
	}
}