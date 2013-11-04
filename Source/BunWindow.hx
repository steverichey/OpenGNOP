package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.geom.Point;
import openfl.Assets;

/**
 * Just creates a themed window object, with the option to embed an image asset as window content.
 */
class BunWindow extends Bitmap
{
	public static var BORDERED:String = "bordered";
	public static var SHADOWED:String = "shadowed";
	public static var SHADOWED_MENU:String = "menu";
	
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
	public function new( Width:Int, Height:Int, type:String, Content:BitmapData = null, ContentX:Int = 0, ContentY:Int = 0 )
	{
		var window:BitmapData = new BitmapData( Width, Height, false, 0xff000000 );
		
		if ( type == BORDERED ) {
			window.fillRect( new Rectangle( 1, 1, Width - 2, Height - 2 ), 0xff666699 );
			window.fillRect( new Rectangle( 1, 1, Width - 3, Height - 3 ), 0xffCCCCFF );
			window.fillRect( new Rectangle( 2, 2, Width - 4, Height - 4 ), 0xffBBBBBB );
			window.fillRect( new Rectangle( 3, 3, Width - 6, Height - 6 ), 0xff666699 );
			window.fillRect( new Rectangle( 4, 4, Width - 7, Height - 7 ), 0xffCCCCFF );
			window.fillRect( new Rectangle( 4, 4, Width - 8, Height - 8 ), 0xff000000 );
			window.fillRect( new Rectangle( 5, 5, Width - 10, Height - 10), 0xffFFFFFF );
		} else {
			if ( type == SHADOWED_MENU ) {
				window.fillRect( new Rectangle( 3, 3, Width - 2, Height - 2 ), 0xff000000 );
			} else {
				window.fillRect( new Rectangle( 2, 2, Width, Height ), 0xff000000 );
			}
			
			window.fillRect( new Rectangle( 0, 0, Width, Height ), 0xff000000 );
			window.fillRect( new Rectangle( 1, 1, Width - 2, Height - 2 ), 0xffFFFFFF );
		}
		
		if ( Content != null ) {
			var b:BitmapData = new BitmapData( Content.width, Content.height, false, 0xffFFFFFF );
			b.draw( Content, new Matrix(), new ColorTransform(), BlendMode.NORMAL );
			window.copyPixels( b, new Rectangle( 0, 0, b.width, b.height ), new Point( ContentX, ContentY ) );
		}
		
		super( window );
	}
}