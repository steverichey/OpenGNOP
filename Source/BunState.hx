package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.Lib;

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
	
	public function getStageWidth():Int
	{
		return Lib.current.stage.stageWidth;
	}
	
	public function getStageHeight():Int
	{
		return Lib.current.stage.stageHeight;
	}
	
	public function menuSelect( Selection:Point ):Void
	{
		// handle menu selections here
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
	
	public function getCheckmarkUpdates():Array<Array<Bool>>
	{
		return [ [] ];
	}
	
	public function invert( s:Sprite )
	{
		var temp:ColorTransform = s.transform.colorTransform;
		
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
		
		s.transform.colorTransform = temp;
	}
}