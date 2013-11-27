package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;
import openfl.Assets;

/**
 * Created for OpenGNOP, but HEAVILY based on FlxBitmapFont. I do not claim to have created this; just tried to make a simpler, Haxe version of that class.
 * 
 * @author STVR
 */
class BunText extends Bitmap
{
	/**
	 * Alignment of the text when multiLine = true. Set to BunText.ALIGN_LEFT (default), BunText.ALIGN_RIGHT or BunText.ALIGN_CENTER.
	 */
	public var align:String = ALIGN_LEFT;
	
	/**
	 * Align each line of multi-line text to the left.
	 */
	public static inline var ALIGN_LEFT:String = "left";
	
	/**
	 * Align each line of multi-line text to the right.
	 */
	public static inline var ALIGN_RIGHT:String = "right";
	
	/**
	 * Align each line of multi-line text in the center.
	 */
	public static inline var ALIGN_CENTER:String = "center";
	
	/**
	 * Just a string containing the characters in the font image.
	 */
	private static inline var TEXT_SET:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789±!@#$%^&*()_+§-={}[]|"+String.fromCharCode(92)+":"+String.fromCharCode(34)+";"+String.fromCharCode(39)+"?,./ ";
	
	/**
	 * Since this isn't a fixed-width font, we need data on the width of each character.
	 */
	private static inline function TEXT_SET_WIDTH():Map<String,Int>
	{
		var m:Map < String, Int > = [
			"A" => 8, "B" => 8, "C" => 8, "D" => 8, "E" => 7, "F" => 7, "G" => 8, "H" => 8, 
			"I" => 4, "J" => 8, "K" => 9, "L" => 7, "M" => 12, "N" => 9, "O" => 8, "P" => 8, 
			"Q" => 8, "R" => 8, "S" => 7, "T" => 8, "U" => 8, "V" => 8, "W" => 12, "X" => 8, 
			"Y" => 8, "Z" => 8, "a" => 8, "b" => 8, "c" => 7, "d" => 8, "e" => 8, "f" => 7, 
			"g" => 8, "h" => 8, "i" => 4, "j" => 7, "k" => 8, "l" => 4, "m" => 12, "n" => 8, 
			"o" => 8, "p" => 8, "q" => 8, "r" => 7, "s" => 7, "t" => 6, "u" => 8, 
			"v" => 8, "w" => 12, "x" => 8, "y" => 8, "z" => 8, "0" => 8, "1" => 5, "2" => 8, 
			"3" => 8, "4" => 9, "5" => 8, "6" => 8, "7" => 8, "8" => 8, "9" => 8, "±" => 7, 
			"!" => 4, "@" => 11, "#" => 10, "$" => 7, "%" => 11, "^" => 7, "&" => 10, "*" => 7, 
			"(" => 5, ")" => 5, "_" => 10, "+" => 7, "§" => 7, "-" => 7, "=" => 8, "{" => 5, 
			"}" => 5, "[" => 5, "]" => 5, "|" => 3, String.fromCharCode(92) => 7, ":" => 4, String.fromCharCode(34) => 5, ";" => 4, 
			String.fromCharCode(39) => 3, "?" => 8, "," => 4, "." => 4, "/" => 7, " " => 4
		];
		
		return m;
	}
	
	/**
	 * Something has to indicate returns; Haxe has poor escape sequence support.
	 */
	private static inline var RETURN_CHAR:String = "/";
	
	/**
	 * Height of default font characters.
	 */
	private static inline var CHAR_HEIGHT:Int = 13;
	
	/**
	 * Number of pixels in between lines.
	 */
	private static inline var LINE_SPACING:Int = 3;
	
	/**
	 * Static storage of the character map, once created.
	 */
	private static var _storedMap:Map<String,BitmapData>;
	
	/**
	 * Internal value representing text displayed. Retrieved via .text
	 */
	private var _text:String;
	
	/**
	 * Create a new BunText object.  TODO: MULTIPLE LINES NEED 3 MORE PIXELS OF SPACE BETWEEN THEM
	 * 
	 * @param	Text		Initial text of this object.
	 */
	public function new( ?Text:String )
	{
		if ( _storedMap == null ) {
			var characterMap:Map<String,BitmapData> = new Map<String,BitmapData>();
			
			//	Take a copy of the font for internal use, we won't need it long.
			var fontData:BitmapData = Assets.getBitmapData( "images/font.png" );
			
			//	Now generate our bitmapdata in the map for faster copyPixels later on
			var currentX:Int = 0;
			
			for ( i in 0...TEXT_SET.length ) {
				// generate new bitmapdata from source image
				var bd:BitmapData = new BitmapData( getCharWidth(i), CHAR_HEIGHT, true, 0 );
				bd.copyPixels( fontData, new Rectangle( currentX, 0, getCharWidth(i), CHAR_HEIGHT ), new Point(0, 0) );
				characterMap.set( TEXT_SET.charAt(i), bd );
				currentX += getCharWidth( i );
			}
			
			_storedMap = characterMap;
			
			fontData.dispose();
			fontData = null;
		}
		
		if ( Text != null ) {
			// Clean the input string, set the internal variable, and update the bitmapdata.
			
			Text = cleanString( Text );
			_text = Text;
			super( textToBitmap( _text ) );
		} else {
			super( new BitmapData( 1, 1, true, 0 ) );
		}
	}
	
	/**
	 * The string displayed by this object.
	 */
	public var text(get,set):String;
	
	private function get_text():String
	{
		return _text;
	}
	
	private function set_text( NewText:String ):String
	{
		NewText = cleanString( NewText );
		
		if ( _text != NewText ) {
			_text = NewText;
			
			if ( bitmapData != null ) {
				bitmapData.dispose();
				bitmapData = null;
			}
			
			if ( _text != "" ) {
				bitmapData = textToBitmap( _text );
			} else {
				bitmapData = new BitmapData( 1, CHAR_HEIGHT, true, 0 );
			}
		}
		
		return _text;
	}
	
	public var color(get, set):Int;
	
	/**
	 * Literally just looks for a pixel with alpha != 0 and then returns its color.  No internal variable stores color.
	 * 
	 * @return	The color, as an integer.
	 */
	private function get_color():Int
	{
		var xp:Int = 0;
		var yp:Int = 0;
		var col:Int = 0;
		
		while ( col == 0 ) {
			var c:Int = bitmapData.getPixel( xp, yp );
			
			if ( c != 0 ) {
				col = c;
			}
			
			xp++;
			
			if ( xp > bitmapData.width ) {
				xp = 0;
				yp++;
			}
			
			if ( yp > bitmapData.height ) {
				col = -1;
			}
		}
		
		return col;
	}
	
	/**
	 * Perform a ColorTransform on this object's BitmapData to change the color of the text. Might have wierd color effects after multiple color changes.
	 * 
	 * @param	NewColor	The color to set this object to.
	 * @return	The color, of course.
	 */
	private function set_color( NewColor:Int ):Int
	{
		var r:Int = NewColor & 255;
		var g:Int = ( NewColor >> 8 ) & 255;
		var b:Int = ( NewColor >> 16 ) & 255;
		
		bitmapData.colorTransform( bitmapData.rect, new ColorTransform( 0, 0, 0, 1, r, g, b ) );
		
		return NewColor;
	}
	
	/**
	 * Internal function to remove characters not in the font set from the string.
	 */
	private function cleanString( newString:String ):String
	{
		var s:String = "";
		
		for ( i in 0...newString.length ) {
			if ( _storedMap.exists( newString.charAt(i) ) ) {
				s += newString.charAt(i);
			}
		}
		
		return s;
	}
	
	/**
	 * Internal function to convert text to an image using the bitmap font.
	 */
	private function textToBitmap( BitmapText:String ):BitmapData
	{	
		var temp:BitmapData;
		
		var lines:Array<String> = BitmapText.split( RETURN_CHAR );
		var cx:Int = 0;
		var cy:Int = 0;
		
		// Make sure the temp bitmapdata has enough room for our text
		temp = new BitmapData( getLongestLine( lines ), ( lines.length * CHAR_HEIGHT ), true, 0 );
		
		//	Loop through each line of text
		for ( l in lines ) {
			//	Calculate alignment
			switch (align) {
				case ALIGN_LEFT:
					cx = 0;
				case ALIGN_RIGHT:
					//cx = temp.width - ( l.length * ( _characterWidth + customSpacingX ) );
				case ALIGN_CENTER:
					//cx = Std.int( ( temp.width / 2 ) - ( ( l.length * ( _characterWidth + customSpacingX ) ) / 2 ) );
			}
			
			// create a line of bitmapped text in temp
			pasteLine( l, temp, cx, cy );
			
			// update y position for next line
			cy += CHAR_HEIGHT + LINE_SPACING;
		}
		
		return temp;
	}
	
	/**
	 * Internal function that takes a single line of text (2nd parameter) and pastes it into the BitmapData at the given coordinates.
	 * 
	 * @param	Line			The single line of text to paste
	 * @param	Output			The BitmapData that the text will be drawn onto
	 * @param	X				The x coordinate to paste the text to.
	 * @param	Y				The y coordinate to paste the text to.
	 */
	private function pasteLine( Line:String, Output:BitmapData, X:Int = 0, Y:Int = 0 ):Void
	{
		for ( i in 0...Line.length ) {
			var w:Int = getCharWidth( i, false, Line );
			Output.copyPixels( _storedMap.get( Line.charAt(i) ), new Rectangle( 0, 0, w, CHAR_HEIGHT ), new Point( X, Y ) );
			X += w;
		}
	}
	
	/**
	 * Works out the longest line of text in an array of strings.
	 * 
	 * @return	The length of the longest line.
	*/
	private function getLongestLine( Lines:Array<String> ):Int
	{
		var longestLine:Int = 0;
		
		for ( s in Lines ) {
			var l:Int = 0;
			for ( i in 0...s.length + 1 ) {
				l += TEXT_SET_WIDTH().get( s.charAt( i ) );
			}
			
			if ( l > longestLine ) {
				longestLine = l;
			}
		}
		
		return longestLine;
	}
	
	/**
	 * Internal function to get the width of a character in the font image.
	 * 
	 * @param	Position	The position of a character in the TEXT_SET string.
	 * @param 	UseTextSet	Whether or not to use TEXT_SET by default.
	 * @param 	AltString	If UseTextSet is false, the alternate string to use.
	 * @return	The width of the character at that position.
	 */
	private function getCharWidth( Position:Int, UseTextSet:Bool = true, ?AltString:String ):Int
	{
		var i:Int = 0;
		
		if ( UseTextSet ) {
			i = TEXT_SET_WIDTH().get( TEXT_SET.charAt( Position ) );
		} else {
			i = TEXT_SET_WIDTH().get( AltString.charAt( Position ) );
		}
		
		return i;
	}
	
	/**
	 * Predict the width of a string.
	 * 
	 * @param	Text	The string of which to predict the width.
	 * @return	The width of the string, in pixels.
	 */
	public static inline function predictWidth( Text:String ):Int
	{
		var wid:Int = 0;
		
		for ( i in 0...Text.length ) {
			var c:String = Text.charAt( i );
			if ( TEXT_SET_WIDTH().exists( c ) ) {
				wid += TEXT_SET_WIDTH().get( c );
			}
		}
		
		return wid;
	}
}