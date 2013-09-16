package;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.ColorTransform;
import flash.Lib;
import haxe.Log;

class GnopState extends Sprite
{
	private var invisibleBG:Sprite;
	
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
		
		// used to capture clicks "away" as well as prevent interaction with underlying layers
		
		invisibleBG = new Sprite();
		invisibleBG.addChild( Reg.makeRect( stage.stageWidth, stage.stageHeight, 0xff00ff00, 0 ) );
		addChild( invisibleBG );
		
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
	
	public function invert( sprite:Sprite )
	{
		var temp:ColorTransform = sprite.transform.colorTransform;
		
		temp.redMultiplier *= -1;
		temp.greenMultiplier *= -1;
		temp.blueMultiplier *= -1;
		
		if ( temp.redOffset == 0 ) {
			temp.redOffset = 255;
			temp.greenOffset = 255;
			temp.blueOffset = 255;
		} else {
			temp.redOffset = 0;
			temp.greenOffset = 0;
			temp.blueOffset = 0;
		}
		
		sprite.transform.colorTransform = temp;
	}
}