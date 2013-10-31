package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.display.Sprite;

class BunMenu extends BunState
{
	private var menuItems:Array<Array<String>>;
	
	private var topMenu:Array<Sprite>;
	private var dropMenus:Array<Sprite>;
	
	private static var SEPTAGON:String = "SEPTAGON";
	private static var LINE:String = "LINE";
	private static var GREY:String = "GREY_";
	private static var TAB:String = "TAB_";
	
	public function new( MenuItems:Array<Array<String>> )
	{
		super();
		
		menuItems = MenuItems;
	}
	
	override public function init( e:Event = null )
	{
		// first item is 10, 1 ?
		
		topMenu = [];
		dropMenus = [];
		var currentX:Int = 10;
		
		for ( i in menuItems ) {
			createTopItem( i[0], currentX );
			createDropMenu( currentX, i );
			currentX += Std.int( topMenu[topMenu.length - 1].width );
		}
		
		for ( i in topMenu ) {
			addChild( i );
		}
		
		for ( i in dropMenus ) {
			addChild( i );
		}
	}
	
	private function createTopItem( Name:String, X:Int ):Void
	{
		var s:BunMenuItem = new BunMenuItem( Name, Name.length * 10, BunMenuItem.TOP_MENU );
		s.x = X;
		s.y = 1;
		
		topMenu.push( s );
	}
	
	private function createDropMenu( X:Int, Arr:Array<String> ):Void
	{
		//Arr = Arr.splice( 0, 1 );
		
		var s:Sprite = new Sprite();
		s.x = X;
		s.y = 19;
		
		var longest:Int = 0;
		
		for ( i in Arr ) {
			if ( i.length > longest ) {
				longest = i.length;
			}
		}
		
		var w:BunWindow = new BunWindow( longest * 6, Arr.length * 10, BunWindow.SHADOWED );
		s.addChild( w );
		
		var currentY:Int = 1;
		
		for ( i in Arr ) {
			var btf:BunMenuItem = new BunMenuItem( i, 50, BunMenuItem.DROP_MENU );
			btf.y = currentY;
			s.addChild( btf );
			currentY += Std.int( btf.height );
		}
		
		dropMenus.push( s );
	}
}