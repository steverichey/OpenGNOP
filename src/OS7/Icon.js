/*global OS7*/
/*global PIXI*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Icon = function(textureString, x, y, windowClass)
{
	OS7.Basic.call(this, x, y);
	this.texture = PIXI.Texture.fromImage(textureString);
	
	this.dragging = false;
	this.offset = new PIXI.Point();
	this.offset.x = 0;
	this.offset.y = 0;
	this.inverted = false;
	this.clickTime = -OS7.Icon.MIN_CLICK_TIME;
	this.invertFilter = new PIXI.InvertFilter();
	this.windowClass = windowClass;
};

OS7.Icon.prototype = Object.create(OS7.Basic.prototype);
OS7.Icon.prototype.constructor = OS7.Icon;

OS7.Icon.MIN_CLICK_TIME = 750;

OS7.Icon.prototype.onClick = function(data)
{
	this.setInverted(true);
	this.offset.x = data.global.x - this.position.x;
	this.offset.y = data.global.y - this.position.y;
	this.dragging = true;
};

OS7.Icon.prototype.onMove = function(data)
{
	if (this.dragging)
	{
		this.position.x = data.global.x - this.offset.x;
		this.position.y = data.global.y - this.offset.y;
		
		if (this.position.y < 20)
		{
			this.position.y = 20;
		}
		
		if (this.position.x < 0)
		{
			this.position.x = 0;
		}
		
		if (this.position.x > OS7.SCREEN_WIDTH - this.width)
		{
			this.position.x = OS7.SCREEN_WIDTH - this.width;
		}
		
		if (this.position.y > OS7.SCREEN_HEIGHT - this.height)
		{
			this.position.y = OS7.SCREEN_HEIGHT - this.height;
		}
	}
};

OS7.Icon.prototype.onRelease = function(data)
{
	if (this.dragging)
	{
		this.dragging = false;
		var rightnow = new Date().getTime();
		
		if (rightnow - this.clickTime < OS7.Icon.MIN_CLICK_TIME)
		{
			this.windowClass.create();
		}
		else
		{
			this.clickTime = rightnow;
		}
	}
};

OS7.Icon.prototype.setInverted = function(status)
{
	if (status)
	{
		this.filters = [this.invertFilter];
		this.inverted = true;
	}
	else
	{
		this.filters = null;
		this.inverted = false;
	}
};