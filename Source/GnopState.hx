package;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import haxe.Log;

class GnopState extends Sprite
{
	public function new()
	{
		super();
		
		if ( stage != null ) {
			init();
		} else {
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
	}
	
	public function init( e:Event = null ):Void
	{
		if ( hasEventListener( Event.ADDED_TO_STAGE ) ) {
			removeEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		Lib.current.stage.addEventListener( Event.ENTER_FRAME, update );
	}
	
	public function update( e:Event = null ):Void
	{
		// update
	}
	
	public function getStageWidth():Int
	{
		return stage.stageWidth;
	}
	
	public function getStageHeight():Int
	{
		return stage.stageHeight;
	}
	
	public function limit( sprite:Sprite, newX:Float, newY:Float, minX:Int = 0, minY:Int = 0, maxX:Int = 640, maxY:Int = 480 ):Void
	{
		var newSpriteX:Int = Std.int( newX );
		var newSpriteY:Int = Std.int( newY );
		var spriteXLim:Int = Std.int( maxX - sprite.width );
		var spriteYLim:Int = Std.int( maxY - sprite.height );
		
		if ( newSpriteX < minX ) {
			newSpriteX = minX;
		}
		
		if ( newSpriteX > spriteXLim ) {
			newSpriteX = spriteXLim;
		}
		
		if ( newSpriteY < minY ) {
			newSpriteY = minY;
		}
		
		if ( newSpriteY > spriteYLim ) {
			newSpriteY = spriteYLim;
		}
		
		sprite.x = newSpriteX;
		sprite.y = newSpriteY;
	}
}