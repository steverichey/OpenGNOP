/*global OS7*/
/*global PIXI*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Text = function(string, x, y)
{
	PIXI.BitmapText.call(this, string, {font:"12px Chicago"});
	this.position.x = x;
	this.position.y = y;
}

OS7.Text.prototype = Object.create( PIXI.BitmapText.prototype );
OS7.Text.prototype.constructor = OS7.Text;