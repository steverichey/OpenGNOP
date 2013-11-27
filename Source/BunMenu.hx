package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

/**
 * Class to create an OS-styled top menu, given an array of string arrays to convert to a menu.
 */
class BunMenu extends BunState
{
	/**
	 * Internal storage of the items to put in the menu.
	 */
	private var menuItems:Array<Array<String>>;
	
	/**
	 * Reference to the top menu items.
	 */
	private var topMenu:Array<BunMenuItem>;
	
	/**
	 * Reference to the drop menu items.
	 */
	private var dropMenus:Array<BunMenuDrop>;
	
	/**
	 * Storage for the selected item position.
	 */
	private var selectedItemPosition:Point;
	
	/**
	 * Storage for the actual selected item, as a BunMenuItem.
	 */
	private var selectedItem:BunMenuItem;
	
	/**
	 * Timer for the flicker effect when an item is selected.
	 */
	private var animTimer:Timer;
	
	/**
	 * Variable that indicates whether or not the menu should be inactive (used during flicker animation).
	 */
	public static var lockOut:Bool;
	
	private static inline var FLICKER_FREQ:Int = 50;
	private static inline var FLICKER_TIMES:Int = 11;
	
	public function new( MenuItems:Array<Array<String>> )
	{
		menuItems = MenuItems;
		
		super();
	}
	
	/**
	 * Initialization function, called via BunState.
	 * 
	 * @param	e	The added to stage event.
	 */
	override public function init( ?e:Event )
	{
		super.init( e );
		
		topMenu = [];
		dropMenus = [];
		selectedItemPosition = new Point(0, 0);
		
		animTimer = new Timer( FLICKER_FREQ, FLICKER_TIMES );
		animTimer.addEventListener( TimerEvent.TIMER, flickerTimer, false, 0, true );
		animTimer.addEventListener( TimerEvent.TIMER_COMPLETE, endFlickerTimer, false, 0, true );
		
		var currentX:Int = 9;
		var posX:Int = 0;
		
		for ( i in menuItems ) {
			createTopItem( i[0], currentX, posX );
			createDropMenu( currentX, i, posX );
			currentX += Std.int( topMenu[topMenu.length - 1].width );
			//currentX += Std.int( topMenu[topMenu.length - 1].width ) - 5; // really there's a 5px overlap, but that is causing some problems
			posX++;
		}
		
		for ( i in topMenu ) {
			addChild( i );
			i.addEventListener( MouseEvent.MOUSE_DOWN, showMenu, false, 0, true );
		}
		
		for ( i in dropMenus ) {
			addChild( i );
		}
		
		updateCheckmarks();
	}
	
	/**
	 * Function to clear everything when the user clicks away from the menu. Called via BunState.
	 * 
	 * @param	m	A MouseEvent.
	 */
	override public function clickAway( ?m:MouseEvent ):Void
	{
		super.clickAway( m );
		
		clearMenus();
		
		for ( i in topMenu ) {
			i.setInverted( false );
			i.removeEventListener( MouseEvent.MOUSE_OVER, moveMenu );
		}
	}
	
	/**
	 * Called when a top menu is clicked; either shows or hides the applicable menu as appropriate.
	 * 
	 * @param	m	A MouseEvent.
	 */
	private function showMenu( ?m:MouseEvent ):Void
	{
		if ( !lockOut ) {
			if ( !m.target.inverted ) {
				clearMenus();
				
				for ( i in topMenu ) {
					i.removeEventListener( MouseEvent.MOUSE_OVER, moveMenu );
				}
			} else {
				showOneMenu( m.target.position.x );
				
				for ( i in topMenu ) {
					i.addEventListener( MouseEvent.MOUSE_OVER, moveMenu, false, 0, true );
				}
			}
		}
	}
	
	/**
	 * Uninvert top menu items and clear the associated drop menu, except for the selected menu.
	 * 
	 * @param	m	A MouseEvent.
	 */
	private function moveMenu( ?m:MouseEvent ):Void
	{
		showOneMenu( m.target.position.x );
		
		var i:Int = 0;
		
		while ( i < topMenu.length ) {
			if ( i != m.target.position.x ) {
				topMenu[i].setInverted( false );
			} else {
				topMenu[i].setInverted( true );
			}
			
			i++;
		}
	}
	
	/**
	 * Display only one drop menu; clear all the others.
	 * 
	 * @param	P	The menu to show, as the position.
	 */
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
	
	/**
	 * Hide all drop menus.
	 */
	private function clearMenus():Void
	{
		for ( s in dropMenus ) {
			s.visible = false;
		}
	}
	
	/**
	 * Hide one drop menu.
	 * 
	 * @param	m	A MouseEvent.
	 */
	private function clearMenu( ?m:MouseEvent ):Void
	{
		m.target.removeEventListener( MouseEvent.MOUSE_OUT, clearMenu );
		dropMenus[ m.target.position.x ].visible = false;
	}
	
	public function clickDropItem( ?m:MouseEvent ):Void
	{
		if ( !lockOut ) {
			selectedItemPosition = m.target.position;
			selectedItem = m.target;
			
			lockOut = true;
			
			animTimer.start();
		}
	}
	
	private function flickerTimer( ?t:TimerEvent ):Void
	{
		selectedItem.setInverted( !selectedItem.inverted );
	}
	
	private function endFlickerTimer( ?t:TimerEvent ):Void
	{
		clickAway();
		lockOut = false;
		animTimer.reset();
		cast( this.parent, BunState ).menuSelect( selectedItemPosition );
	}
	
	/**
	 * Cycles through each drop menu and sets the check marks per the parent BunState's getCheckmarkUpdates() function.
	 */
	public function updateCheckmarks():Void
	{
		var xpos:Int = 0;
		var ypos:Int = 0;
		var a:Array<Array<Bool>> = cast( this.parent, BunState ).getCheckmarkUpdates();
		
		while ( xpos < a.length ) {
			while ( ypos < a[xpos].length ) {
				dropMenus[xpos].members[ypos].setCheck( a[xpos][ypos] );
				ypos++;
			}
			ypos = 0;
			xpos++;
		}
	}
	
	/**
	 * Creates a BunMenuItem as a top menu item.
	 * 
	 * @param	Name		The displayed name of this menu item.
	 * @param	X			The X position of this menu item; Y is always 1.
	 * @param	Position	An integer representing the order of this item; will be used to display/hide the drop menu.
	 */
	private function createTopItem( Name:String, X:Int, Position:Int ):Void
	{
		var temp:BunText = new BunText( Name );
		var len:Int = Std.int ( temp.width ) + BunMenuItem.LEFT_PADDING_TOP + BunMenuItem.RIGHT_PADDING_TOP;
		var s:BunMenuItem = new BunMenuItem( Name, len, BunMenuItem.TOP_MENU, new Point( Position, 0 ) );
		s.x = X;
		s.y = 1;
		
		topMenu.push( s );
	}
	
	/**
	 * Creates a drop menu at X from an array of menu item names.
	 * 
	 * @param	X			The position at which this menu should be created; Y is always 19.
	 * @param	Arr			The contents of the array; the first item is assumed to be the menu title and is ignored.
	 * @param 	XPosition	The X position of this menu, in terms of the number of drop menus. The first is 0, the second is 1, etc.
	 */
	private function createDropMenu( X:Int, Arr:Array<String>, XPosition:Int ):Void
	{
		// Remove the first array element, which is the top menu name.
		
		Arr.shift();
		
		var dm:BunMenuDrop = new BunMenuDrop( Arr, XPosition );
		dm.x = X;
		dm.visible = false;
		
		dropMenus.push( dm );
	}
}