/*global PIXI*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Text = function(string, x, y)
{
    PIXI.BitmapText.call(this, string, {font:"12px Chicago"});
    this.position.x = x;
    this.position.y = y;
};

OS7.Text.constructor = OS7.Text;
OS7.Text.prototype = Object.create(PIXI.BitmapText.prototype);