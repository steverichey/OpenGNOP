package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Point;
import openfl.Assets;

class BunMenuItem extends Sprite
{
	private var _tf:BunText;
	private var _bm:Bitmap;
	private var _bg:Bitmap;
	private var _cm:Bitmap;
	private var _inverted:Bool;
	
	public var position:Point;
	public var inverted:Bool;
	
	public static inline var TOP_MENU:Int = 0;
	public static inline var DROP_MENU:Int = 1;
	
	public static inline var TAB_PADDING:Int = 8;
	public static inline var LEFT_PADDING_DROP:Int = 14;
	public static inline var RIGHT_PADDING_DROP:Int = 10;
	public static inline var LEFT_PADDING_TOP:Int = 9;
	public static inline var RIGHT_PADDING_TOP:Int = 9;
	public static inline var DROP_ITEM_HEIGHT:Int = 16;
	public static inline var TOP_ITEM_HEIGHT:Int = 18;
	
	private static inline var COLOR_GREY:Int = 0xff888888;
	private static inline var CHECK_PADDING_LEFT:Int = 3;
	private static inline var CHECK_PADDING_TOP:Int = 3;
	
	/**
	 * Constants which are parsed to create items that are not simple text.
	 */
	public static inline var SEPTAGON:String = "SEPTAGON";
	public static inline var LINE:String = "LINE";
	public static inline var GREY:String = "GREY_";
	public static inline var TAB:String = "TAB_";
	
	/**
	 * Functions to prepend GREY_ or TAB_ to a string.
	 */
	public static inline function GREYED( S:String ):String
	{
		return GREY + S;
	}
	
	public static inline function TABBED( S:String ):String
	{
		return TAB + S;
	}
	
	/**
	 * Create a new BunMenuItem, which is a sprite with BunText that can be easily inverted and report its position in the menu.
	 * 
	 * @param	Text		The text for the BunText item to display.
	 * @param	Width		The width of the menu item.
	 * @param	ItemType	Whether this is a top menu or drop menu item; use BunItemMenu.TOP_ITEM or BunItemMenu.DROP_ITEM.
	 * @param	Position	A point describing this item's x,y position, with the septagon being 0,0
	 */
	public function new( Text:String, Width:Int, ItemType:Int, Position:Point )
	{
		super();
		
		this.position = Position;
		
		var w:Int = Width;
		var inactive:Bool = false;
		
		if ( Text.substring(0, 5) == GREY || Text == LINE ) {
			inactive = true;
		}
		
		if ( Text == SEPTAGON ) {
			w = 29;
		}
		
		if ( ItemType == TOP_MENU ) {
			_bg = new Bitmap( new BitmapData( w, TOP_ITEM_HEIGHT, false ) );
		} else {
			_bg = new Bitmap( new BitmapData( w, DROP_ITEM_HEIGHT, false ) );
		}
		
		if ( Text == SEPTAGON ) {
			_bm = new Bitmap( Assets.getBitmapData( "images/septagon.png" ) );
			_bm.x = 8;
			_bm.y = 1;
		} else if ( Text == LINE ) {
			_bm = new Bitmap( new BitmapData( w, 1, false, COLOR_GREY ) );
			_bm.y = ( _bg.height - _bm.height ) / 2;
			
			if ( ItemType == DROP_MENU ) {
				_bm.x += 1;
				_bg.x += 1;
			}
		} else {
			if ( Text.substring(0, 5) == GREY ) {
				_tf = new BunText( Text.substring( 5, Text.length ) );
				_tf.color = COLOR_GREY;
			} else if ( Text.substring(0, 4) == TAB ) {
				_tf = new BunText( Text.substring( 4, Text.length ) );
			} else {
				_tf = new BunText( Text );
			}
			
			if ( ItemType == TOP_MENU ) {
				_tf.x = LEFT_PADDING_TOP;
			} else {
				_tf.x = 1 + LEFT_PADDING_DROP;
				_bg.x = 1;
			}
			
			if ( Text.substring(0, 4) == TAB ) {
				_tf.x += TAB_PADDING;
			}
			
			_tf.y = ( _bg.height - _tf.height ) / 2;
		}
		
		addChild( _bg );
		
		if ( _tf != null ) {
			addChild( _tf );
		}
		
		if ( _bm != null ) {
			addChild( _bm );
		}
		
		if ( ItemType == DROP_MENU && !inactive ) {
			_cm = new Bitmap( Assets.getBitmapData( "images/checkmark.png" ) );
			_cm.x = CHECK_PADDING_LEFT;
			_cm.y = CHECK_PADDING_TOP;
			_cm.visible = false;
			addChild( _cm );
		}
		
		if ( ItemType == TOP_MENU ) {
			this.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true );
		} else if ( !inactive ) {
			this.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true );
			this.addEventListener( MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true );
		}
	}
	
	private function onMouseDown( m:MouseEvent ):Void
	{
		if ( !BunMenu.lockOut ) {
			setInverted( !inverted );
		}
	}
	
	private function onMouseOver( m:MouseEvent ):Void
	{
		if ( !BunMenu.lockOut ) {
			setInverted( true );
		}
	}
	
	private function onMouseOut( m:MouseEvent ):Void
	{
		if ( !BunMenu.lockOut ) {
			setInverted( false );
		}
	}
	
	public function setInverted( NewInverted:Bool ):Void
	{
		if ( inverted != NewInverted ) {
			invert( _bg );
			
			if ( _tf != null ) {
				invert( _tf );
			}
			
			if ( _cm != null ) {
				invert( _cm );
			}
			
			inverted = NewInverted;
		}
	}
	
	public function setCheck( CheckVisibility:Bool ):Void
	{
		if ( _cm != null ) {
			_cm.visible = CheckVisibility;
		}
	}
	
	private function invert( b:Bitmap ):Void
	{
		var temp:ColorTransform = b.transform.colorTransform;
		
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
		
		b.transform.colorTransform = temp;
	}
}