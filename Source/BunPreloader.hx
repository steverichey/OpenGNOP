package;

import flash.display.Sprite;
import flash.events.Event;

/**
 * Simple preloader class with OS-esque visuals. Influenced by NMEPreloader.
 */
class BunPreloader extends Sprite
{
	private var _progress:Sprite;
	private static inline var STAGE_WIDTH:Int = 640;
	private static inline var STAGE_HEIGHT:Int = 480;
	private static inline var BAR_WIDTH:Int = 160;
	private static inline var BAR_HEIGHT:Int = 12;
	private static inline var BAR_X:Int = 240;
	private static inline var BAR_Y:Int = 338;
	private static inline var BORDER_THICKNESS:Int = 1;
	private static inline var COLOR_BG:Int = 0xffDDDDDD;
	private static inline var COLOR_BORDER:Int = 0xff000000;
	private static inline var COLOR_PROGRESS_BG:Int = 0xffCCCCFF;
	private static inline var COLOR_PROGRESS:Int = 0xff444444;
	
	public function new():Void
	{
		super();
		
		if ( stage != null ) {
			onInit();
		} else {
			addEventListener( Event.ADDED_TO_STAGE, onInit );
		}
	}
	
	public function onInit( ?e:Event ):Void
	{
		var bg:Sprite = drawRect( STAGE_WIDTH, STAGE_HEIGHT, COLOR_BG );
		var outer:Sprite = drawRect( BAR_WIDTH, BAR_HEIGHT, COLOR_BORDER );
		var inner:Sprite = drawRect( BAR_WIDTH - 2 * BORDER_THICKNESS, BAR_HEIGHT - 2 * BORDER_THICKNESS, COLOR_PROGRESS_BG );
		_progress = drawRect( Std.int( inner.width ), Std.int( inner.height ), COLOR_PROGRESS );
		
		outer.x = BAR_X;
		outer.y = BAR_Y;
		inner.x = outer.x + BORDER_THICKNESS;
		inner.y = outer.y + BORDER_THICKNESS;
		_progress.x = inner.x;
		_progress.y = inner.y;
		_progress.scaleX = 0;
		
		addChild( bg );
		addChild( outer );
		addChild( inner );
		addChild( _progress );
	}
	
	public function onLoaded():Void
	{
		//dispatchEvent ( new Event ( Event.COMPLETE ) );
	}
	
	public function onUpdate( bytesLoaded:Int, bytesTotal:Int ):Void
	{
		_progress.scaleX = bytesLoaded / bytesTotal;
	}
	
	private function drawRect( Width:Int, Height:Int, Color:Int ):Sprite
	{
		var s:Sprite = new Sprite();
		s.graphics.beginFill( Color );
		s.graphics.drawRect( 0, 0, Width, Height );
		s.graphics.endFill();
		
		return s;
	}
}