package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.geom.Point;

/**
 * Just creates a themed window object, with the option to embed an image asset as window content.
 */
class BunWindow extends Bitmap
{
	private var _pixels:BitmapData;
	
	public static var BORDERED:String = "bordered";
	public static var SHADOWED:String = "shadowed";
	
	/**
	 * Class to create an OS window.
	 * 
	 * @param	Width	The width of the window to be created.
	 * @param	Height	The height of the window to be created.
	 * @param	type	The type of window, either BunWindow.BORDERED or BunWindow.SHADOWED
	 * @param 	Content	Optional, an additional element to draw in the window.
	 * @param 	ContentX	X position of content, relative to window top-left.
	 * @param 	ContentY	Y position of content, relative to window top-left.
	 */
	public function new( Width:Int, Height:Int, type:String, Content:BitmapData = null, ContentX:Int = 0, ContentY:Int = 0 )
	{
		if ( type == BORDERED ) {
			_pixels = drawBorderedWindow( Width, Height, Content, ContentX, ContentY );
		} else {
			_pixels = drawShadowedWindow( Width, Height, Content, ContentX, ContentY  );
		}
		
		super( _pixels );
	}
	
	/**
	 * Create a window with OS-styled borders.
	 * 
	 * @param	Width	The width of the window, including the borders.
	 * @param	Height	The height of the window, including the borders.
	 * @return	A bitmap of the window.
	 */
	public function drawBorderedWindow( Width:Int = 20, Height:Int = 20, Content:BitmapData = null, ContentX:Int = 0, ContentY:Int = 0 ):BitmapData
	{
		var window:BitmapData = new BitmapData( Width, Height, false, 0xff000000 );
		
		window.fillRect( new Rectangle( 1, 1, Width - 2, Height - 2 ), 0xff666699 );
		window.fillRect( new Rectangle( 1, 1, Width - 3, Height - 3 ), 0xffCCCCFF );
		window.fillRect( new Rectangle( 2, 2, Width - 4, Height - 4 ), 0xffBBBBBB );
		window.fillRect( new Rectangle( 3, 3, Width - 6, Height - 6 ), 0xff666699 );
		window.fillRect( new Rectangle( 4, 4, Width - 7, Height - 7 ), 0xffCCCCFF );
		window.fillRect( new Rectangle( 4, 4, Width - 8, Height - 8 ), 0xff000000 );
		window.fillRect( new Rectangle( 5, 5, Width - 10, Height - 10), 0xffFFFFFF );
		
		if ( Content != null ) {
			var b:BitmapData = new BitmapData( Content.width, Content.height, false, 0xffFFFFFF );
			b.draw( Content, new Matrix(), new ColorTransform(), BlendMode.NORMAL );
			copyAllPixelData( window, b, ContentX, ContentY );
		}
		
		return window;
	}
	
	/**
	 * Draws an OS-styled shadowed window with a white background.
	 * 
	 * @param	Width	The total width of the window, including the shadow.
	 * @param	Height	The total height of the window, including the shadow.
	 * @return	A shadowed window sprite.
	 */
	public function drawShadowedWindow( Width:Int = 20, Height:Int = 20, Content:BitmapData = null, ContentX:Int = 0, ContentY:Int = 0 ):BitmapData
	{
		var window:BitmapData = new BitmapData( Width + 2, Height + 2, true, 0 );
		
		window.fillRect( new Rectangle( 2, 2, Width, Height ), 0xff000000 );
		window.fillRect( new Rectangle( 0, 0, Width, Height ), 0xff000000 );
		window.fillRect( new Rectangle( 1, 1, Width - 2, Height - 2 ), 0xffFFFFFF );
		
		if ( Content != null ) {
			var b:BitmapData = new BitmapData( Content.width, Content.height, false, 0xffFFFFFF );
			b.draw( Content, new Matrix(), new ColorTransform(), BlendMode.NORMAL );
			copyAllPixelData( window, b, ContentX, ContentY );
		}
		
		return window;
	}
	
	/**
	 * Copy all of the bitmap pixels from one bitmap to another.
	 * 
	 * @param	To		The bitmap to receive the pixels.
	 * @param	From	The bitmap to send the pixels.
	 * @param	X		The x position at which To will recieve pixels.
	 * @param	Y		The y position at which To will recieve pixels.
	 */
	public function copyAllPixelData( To:BitmapData, From:BitmapData, X:Int, Y:Int ):Void
	{
		To.copyPixels( From, new Rectangle( 0, 0, From.width, From.height ), new Point( X, Y ) );
	}
}