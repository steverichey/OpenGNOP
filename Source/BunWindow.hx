package;

import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.display.Bitmap;
import flash.display.BitmapData;
import haxe.Log;

/**
 * Just creates a themed window object, with the option to embed an image asset as window content.
 */
class BunWindow extends Bitmap
{
	public static inline var BORDERED:UInt = 0;
	public static inline var SHADOWED:UInt = 1;
	public static inline var SHADOWED_MENU:UInt = 2;
	
	public static inline var BLACK:UInt = 0xff000000;
	public static inline var BLUE_LIGHT:UInt = 0xffCCCCFF;
	public static inline var GREY:UInt = 0xffBBBBBB;
	public static inline var BLUE_DARK:UInt = 0xff666699;
	public static inline var WHITE:UInt = 0xffFFFFFF;
	
	/**
	 * Class to create an OS window.
	 * 
	 * @param	Width	The width of the window to be created.
	 * @param	Height	The height of the window to be created.
	 * @param	type	The type of window, either BunWindow.BORDERED, BunWindow.SHADOWED, or BunWindow.SHADOWED_MENU.
	 * @param 	Content	Optional, an additional element to draw in the window.
	 * @param 	ContentX	X position of content, relative to window top-left.
	 * @param 	ContentY	Y position of content, relative to window top-left.
	 */
	public function new( Width:Int, Height:Int, type:UInt, Content:BitmapData = null, ContentX:Int = 0, ContentY:Int = 0 )
	{
		var window:BitmapData = new BitmapData( Width, Height, true, 0 );
		
		if ( type == BORDERED ) {
			window.fillRect( new Rectangle( 0, 0, Width, Height ), BLACK );
			window.fillRect( new Rectangle( 1, 1, Width - 2, Height - 2 ), BLUE_DARK );
			window.fillRect( new Rectangle( 1, 1, Width - 3, Height - 3 ), BLUE_LIGHT );
			window.fillRect( new Rectangle( 2, 2, Width - 4, Height - 4 ), GREY );
			window.fillRect( new Rectangle( 3, 3, Width - 6, Height - 6 ), BLUE_DARK );
			window.fillRect( new Rectangle( 4, 4, Width - 7, Height - 7 ), BLUE_LIGHT );
			window.fillRect( new Rectangle( 4, 4, Width - 8, Height - 8 ), BLACK );
			window.fillRect( new Rectangle( 5, 5, Width - 10, Height - 10), WHITE );
		} else if ( type == SHADOWED_MENU ) {
			window.fillRect( new Rectangle( 3, 3, Width - 3, Height - 3 ), BLACK );
			window.fillRect( new Rectangle( 0, 0, Width - 1, Height - 1 ), BLACK );
			window.fillRect( new Rectangle( 1, 1, Width - 3, Height - 3 ), WHITE );
		} else {
			window.fillRect( new Rectangle( 2, 2, Width - 2, Height - 2 ), BLACK );
			window.fillRect( new Rectangle( 0, 0, Width - 2, Height - 2 ), BLACK );
			window.fillRect( new Rectangle( 1, 1, Width - 4, Height - 4 ), WHITE );
		}
		
		if ( Content != null ) {
			drawContent( window, Content, ContentX, ContentY );
		}
		
		super( window );
	}
	
	/**
	 * Erase all content previously in the window and update it with a new BitmapData at X and Y.
	 * 
	 * @param	NewContent	The new content to be drawn in the window.
	 * @param	X			The X position at which to draw the new content.
	 * @param	Y			The Y position at which to draw the new content.
	 */
	public function updateContent( NewContent:BitmapData, X:Int, Y:Int ):Void
	{
		// Wipe previous content by drawing over it with white.
		
		Log.trace( "Pixel: " + bitmapData.getPixel32( 1, 1 ) );
		Log.trace( "White: " + WHITE );
		Log.trace( "Blue: " + BLUE_LIGHT );
		Log.trace( "Equals Blue? " + ( bitmapData.getPixel32(1, 1) == BLUE_LIGHT ) );
		Log.trace( "Equals White? " + ( bitmapData.getPixel32(1, 1) == WHITE ) );
		/*
		if ( windowType == BORDERED ) {
			bitmapData.fillRect( new Rectangle( 5, 5, bitmapData.width - 10, bitmapData.height - 10 ), 0xffFFFFFF );
		} else if ( windowType == SHADOWED_MENU ) {
			bitmapData.fillRect( new Rectangle( 1, 1, bitmapData.width - 3, bitmapData.height - 3 ), 0xffFFFFFF );
		} else {
			bitmapData.fillRect( new Rectangle( 1, 1, bitmapData.width - 4, bitmapData.height - 4 ), 0xffFFFFFF );
		}
		*/
		drawContent( bitmapData, NewContent, X, Y );
	}
	
	/**
	 * Internal function to draw BitmapData from a source to a destination. Mostly serves to abstract the use of Matrix.
	 * 
	 * @param	To		The BitmapData on which to draw.
	 * @param	From	The BitmapData from which to draw.
	 * @param	X		The X position at which to draw the From BitmapData on To.
	 * @param	Y		The Y position at which to draw the From BitmapData on To.
	 */
	private function drawContent( To:BitmapData, From:BitmapData, X:Int, Y:Int ):Void
	{
		To.draw( From, new Matrix( 1, 0, 0, 1, X, Y ) );
	}
}