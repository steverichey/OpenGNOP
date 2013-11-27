package;

import flash.events.Event;
import flash.display.BitmapData;
import flash.geom.Matrix;

class BunGame extends BunState
{
	/**
	 * Generic class for games, should be extended for the game's Main function.
	 */
	public function new()
	{
		super();
	}
	
	override public function init( ?e:Event ):Void
	{
		super.init(e);
	}
	
	override public function update( ?e:Event ):Void
	{
		super.update(e);
	}
	
	public function getIcon():BitmapData
	{
		var defaultText:BunText = new BunText( "NO/ICON" );
		var defaultData:BitmapData = new BitmapData( 43, 42 );
		defaultData.draw( defaultText, new Matrix() );
		
		return defaultData;
	}
	
	private function getMenuItems():Array<Array<String>>
	{
		var a:Array<Array<String>> = [
			[ "No Menu Found!" ]
			];
		
		return a;
	}
	
	//public function 
}