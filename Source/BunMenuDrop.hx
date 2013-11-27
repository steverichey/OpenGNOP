package;

import flash.geom.Point;
import flash.events.MouseEvent;
import flash.display.Sprite;

class BunMenuDrop extends Sprite
{
	public var members:Array<BunMenuItem>;
	
	private static inline var DROP_MENU_Y:Int = 19;
	
	public function new( MenuItems:Array<String>, Position:Int )
	{
		this.y = DROP_MENU_Y;
		members = [];
		
		var longest:Int = 0;
		
		for ( i in MenuItems ) {
			var temp:String = i;
			
			if ( temp.substring(0, 5) == BunMenuItem.GREY ) {
				temp = temp.substring( 5, temp.length );
			} else if ( temp.substring( 0, 4 ) == BunMenuItem.TAB ) {
				temp = temp.substring( 4, temp.length );
			}
			
			var bt:BunText = new BunText( temp );
			var w:Int = Std.int( bt.width );
			
			// Tabbed items are an additional 8px wide.
			
			if ( i.substring( 0, 4 ) == BunMenuItem.TAB ) {
				w += BunMenuItem.TAB_PADDING;
			}
			
			if ( w > longest ) {
				longest = w;
			}
		}
		
		longest += BunMenuItem.LEFT_PADDING_DROP + BunMenuItem.RIGHT_PADDING_DROP;
		
		var win:BunWindow = new BunWindow( longest + 3, MenuItems.length * BunMenuItem.DROP_ITEM_HEIGHT + 3, BunWindow.SHADOWED_MENU );
		addChild( win );
		
		var currentY:Int = 1;
		var posY:Int = 0;
		
		for ( i in MenuItems ) {
			var btf:BunMenuItem = new BunMenuItem( i, longest, BunMenuItem.DROP_MENU, new Point( Position, posY ) );
			btf.y = currentY;
			addChild( btf );
			members.push( btf );
			
			if ( i.substring(0, 5) != BunMenuItem.GREY && i != BunMenuItem.LINE ) {
				btf.addEventListener( MouseEvent.MOUSE_UP, clickDropItem, false, 0, true );
			}
			
			currentY += Std.int( btf.height );
			posY++;
		}
		
		visible = false;
		
		super();
	}
	
	private function clickDropItem( ?m:MouseEvent ):Void
	{
		cast( this.parent, BunMenu ).clickDropItem( m );
	}
}