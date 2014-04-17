/*global OS7*/
/*global PIXI*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Text = function(string, x, y)
{
	PIXI.BitmapText.call(this, string, {font:"12px Chicago", tint:OS7.Colors.ALMOST_BLACK});
	this.position.x = x || 0;
	this.position.y = y || 0;
	this.interactive = false;
	this.wordWrap = false; //TODO implement wordwrap
	this.objectType = "text";
};

OS7.Text.prototype = Object.create(PIXI.BitmapText.prototype);
OS7.Text.prototype.constructor = OS7.Text;

OS7.Text.prototype.toString = function()
{
	return "[OS7 Text " + this.text + "]";
};