/*global PIXI*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

/**
 * A basic object class. Almost everything in OpenOS7 extends this.
 */
OS7.Basic = function(x, y)
{
	PIXI.DisplayObjectContainer.call(this);
	
	this.position.x = x || 0;
	this.position.y = y || 0;
	
	this.interactive = true;
	this.mousedown = this.touchstart = this.onClick.bind(this);
	this.mouseup = this.touchend = this.mouseupoutside = this.touchendoutside = this.onRelease.bind(this);
};

OS7.Basic.prototype = Object.create(PIXI.DisplayObjectContainer.prototype);
OS7.Basic.prototype.constructor = OS7.Basic;

OS7.Basic.prototype.onClick = function(data)
{
	// override this!
};

OS7.Basic.prototype.onMove = function(data)
{
	// override this!
};

OS7.Basic.prototype.onRelease = function(data)
{
	// override this!
};