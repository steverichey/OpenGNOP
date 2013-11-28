package;

import open7.ui.OSText;

class GnopScore extends OSText
{
	private var _score:Int;
	
	public static inline var PLAYER:Int = 0;
	public static inline var WIN:Int = 1;
	public static inline var COMPUTER:Int = 2;
	
	private static inline var MIN_SCORE:Int = 0;
	private static inline var MAX_SCORE:Int = 999;
	
	public function new( type:Int, ?DefaultScore:Int )
	{
		this.y = 101;
		
		if ( type == PLAYER ) {
			this.x = 537;
		} else if ( type == WIN ) {
			this.x = 377;
			this.y += 1;
		} else {
			this.x = 77;
		}
		
		super( "000" );
		
		if ( DefaultScore != null ) {
			score = DefaultScore;
		}
	}
	
	public var score(get, set):Int;
	
	private function get_score():Int
	{
		return _score;
	}
	
	private function set_score( NewScore:Int ):Int
	{
		if ( NewScore < MIN_SCORE ) {
			NewScore = MIN_SCORE;
		}
		
		if ( NewScore > MAX_SCORE ) {
			NewScore = MAX_SCORE;
		}
		
		_score = NewScore;
		
		var displayScore:String = "";
		
		if ( _score < 10 ) {
			displayScore = "00" + _score;
		} else if ( _score < 100 ) {
			displayScore = "0" + _score;
		} else if ( _score < 1000 ) {
			displayScore = Std.string( _score );
		}
		
		this.text = displayScore;
		
		return _score;
	}
}