package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.Lib;
import haxe.Log;

#if !desktop
import openfl.Assets;
#end

class BunState extends Sprite
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
	
	public function init( ?e:Event ):Void
	{
		if ( hasEventListener( Event.ADDED_TO_STAGE ) ) {
			removeEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		// used to capture clicks "away" as well as prevent interaction with underlying layers
		
		invisibleBG = new Sprite();
		invisibleBG.addChild( new Bitmap( new BitmapData( stage.stageWidth, stage.stageHeight ) ) );
		invisibleBG.alpha = 0.0;
		addChild( invisibleBG );
		
		invisibleBG.addEventListener( MouseEvent.MOUSE_DOWN, clickAway, false, 0, true  );
	}
	
	public function update( ?e:Event ):Void
	{
		// update
	}
	
	public function clickAway( ?m:MouseEvent ):Void
	{
		// handle clicks away from active state here, via override
	}
	
	public function menuSelect( Selection:Point ):Void
	{
		// handle menu selections here
	}
	
	public function getStageWidth():Int
	{
		return Lib.current.stage.stageWidth;
	}
	
	public function getStageHeight():Int
	{
		return Lib.current.stage.stageHeight;
	}
	
	public function limit( VarToLimit:Float, MinLimit:Float = 0, MaxLimit:Float = 640, ?Handler:Void->Void ):Float
	{
		var limited:Bool = false;
		
		if ( VarToLimit < MinLimit ) {
			VarToLimit = MinLimit;
			limited = true;
		}
		
		if ( VarToLimit > MaxLimit ) {
			VarToLimit = MaxLimit;
			limited = true;
		}
		
		if ( Handler != null && limited ) {
			Handler();
		}
		
		return VarToLimit;
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
	
	/**
	 * Platform-independent method to create images. For native targets, ensure that the required file is embedded via metadata tags. The design of this function prevents null errors, mostly.
	 * 
	 * @param	FileName	The name of the file to be loaded as a bitmap.
	 * @param 	bitmapData	The file to be used on native targets.
	 * @return	A bitmap with the desired image included.
	 */
	public function createImage( ?FileName:String, ?bitmapData:BitmapData ):Bitmap
	{
		var b:Bitmap;
		
		#if desktop
		if ( File != null ) {
			b = new Bitmap( bitmapData );
		} else {
			b = new Bitmap( new BitmapData( 5, 5, false, 0xff00ff00 ) );
		}
		#else
		b = new Bitmap( Assets.getBitmapData( "images/" + FileName + ".png" ) );
		#end
		
		return b;
	}
}