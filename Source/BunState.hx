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
	
	public static inline var MINIMUM:Int = 0;
	public static inline var MAXIMUM:Int = 1;
	
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
	
	/**
	 * Checks to see if a variable is in range, and returns either that variable, the minimum if the variable is too low, or the maximum if the variable is too high.
	 * 
	 * @param	VarToLimit	The variable to range check.
	 * @param	MinLimit	The minimum amount this variable should be.
	 * @param	MaxLimit	The maximum amount this variable should be.
	 * @param	?Handler	Optional: A function to call if the variable was limited; should be of type myFunction( type:Int ):Void where type can be either BunState.MINIMUM or BunState.MAXIMUM
	 * @return	The variable, or if it was out of range, the applicable limit.
	 */
	public function limit( VarToLimit:Float, MinLimit:Float, MaxLimit:Float, ?Handler:Int->Float->Float ):Float
	{
		var limited:Bool = false;
		var limitType:Int = 0;
		
		if ( VarToLimit < MinLimit ) {
			VarToLimit = MinLimit;
			limited = true;
			limitType = MINIMUM;
		}
		
		if ( VarToLimit > MaxLimit ) {
			VarToLimit = MaxLimit;
			limited = true;
			limitType = MAXIMUM;
		}
		
		if ( Handler != null && limited ) {
			VarToLimit = Handler( limitType, VarToLimit );
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