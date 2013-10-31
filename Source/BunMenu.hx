package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.display.Sprite;
import flash.events.MouseEvent;
import haxe.Log;

class BunMenu extends BunState
{
	private var menuItems:Array<Array<String>>;
	
	private var topMenu:Array<BunMenuItem>;
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
		super.init( e );
		
		topMenu = [];
		dropMenus = [];
		var currentX:Int = 10;
		var posX:Int = 0;
		
		for ( i in menuItems ) {
			createTopItem( i[0], currentX, posX );
			createDropMenu( currentX, i );
			currentX += Std.int( topMenu[topMenu.length - 1].width );
			posX++;
		}
		
		for ( i in topMenu ) {
			addChild( i );
			i.addEventListener( MouseEvent.MOUSE_DOWN, showMenu, false, 0, true );
		}
		
		for ( i in dropMenus ) {
			addChild( i );
		}
	}
	
	override public function clickAway( m:MouseEvent ):Void
	{
		super.clickAway( m );
		Log.trace( "Click away" );
		clearMenus();
		
		for ( i in topMenu ) {
			i.setInverted( false );
			i.removeEventListener( MouseEvent.MOUSE_OVER, moveMenu );
		}
	}
	
	private function showMenu( m:MouseEvent ):Void
	{
		if ( !m.target.inverted ) {
			clearMenus();
			
			for ( i in topMenu ) {
				i.removeEventListener( MouseEvent.MOUSE_OVER, moveMenu );
			}
		} else {
			showOneMenu( m.target.position );
			
			for ( i in topMenu ) {
				i.addEventListener( MouseEvent.MOUSE_OVER, moveMenu, false, 0, true );
			}
		}
	}
	
	private function moveMenu( m:MouseEvent ):Void
	{
		showOneMenu( m.target.position );
		
		var i:Int = 0;
		
		while ( i < topMenu.length ) {
			if ( i != m.target.position ) {
				topMenu[i].setInverted( false );
			} else {
				topMenu[i].setInverted( true );
			}
			
			i++;
		}
	}
	
	private function showOneMenu( P:Int ):Void
	{
		var i:Int = 0;
		
		while( i < dropMenus.length ) {
			if ( i != P ) {
				dropMenus[ i ].visible = false;
			} else {
				dropMenus[ i ].visible = true;
			}
			
			i++;
		}
	}
	
	private function clearMenus():Void
	{
		for ( s in dropMenus ) {
			s.visible = false;
		}
	}
	
	private function clearMenu( m:MouseEvent ):Void
	{
		m.target.removeEventListener( MouseEvent.MOUSE_OUT, clearMenu );
		dropMenus[ m.target.position ].visible = false;
	}
	
	private function createTopItem( Name:String, X:Int, Position:Int ):Void
	{
		var s:BunMenuItem = new BunMenuItem( Name, Name.length * 10, BunMenuItem.TOP_MENU, Position );
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
			var bt:BunText = new BunText( i );
			
			if ( bt.width > longest ) {
				longest = Std.int( bt.width );
			}
		}
		
		var w:BunWindow = new BunWindow( longest, Arr.length * 16, BunWindow.SHADOWED );
		s.addChild( w );
		
		var currentY:Int = 1;
		var posY:Int = 0;
		
		for ( i in Arr ) {
			var btf:BunMenuItem = new BunMenuItem( i, longest, BunMenuItem.DROP_MENU, posY );
			btf.y = currentY;
			s.addChild( btf );
			currentY += Std.int( btf.height );
			posY++;
		}
		
		s.visible = false;
		dropMenus.push( s );
	}
}