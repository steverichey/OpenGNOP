/*global PIXI*/
/*global OS7*/
/*global Date*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Icon = function(iconImage, x, y, windowClass)
{
    PIXI.Sprite.call( this, PIXI.Texture.fromImage(iconImage) );
	
	this.dragging = false;
	this.offsetX = 0;
	this.offsetY = 0;
	this.inverted = false;
	this.clickTime = -OS7.Icon.MIN_CLICK_TIME;
	
	this.invertFilter = new PIXI.InvertFilter();
	
    this.position.x = x;
    this.position.y = y;
	this.windowClass = windowClass;
    
    this.interactive = true;
	
	this.mousedown = this.touchstart = this.onClick;
	this.mousemove = this.touchmove = this.onMove;
	this.mouseup = this.touchend = this.mouseupoutside = this.touchendoutside = this.onRelease;
};

OS7.Icon.MIN_CLICK_TIME = 750;

OS7.Icon.prototype = Object.create(PIXI.Sprite.prototype);
OS7.Icon.constructor = OS7.Icon;

OS7.Icon.prototype.onClick = function(data)
{
	this.setInverted( true );
	this.offsetX = data.global.x - this.position.x;
	this.offsetY = data.global.y - this.position.y;
	this.dragging = true;
};

OS7.Icon.prototype.onMove = function(data)
{
	if ( this.dragging )
	{
		this.position.x = data.global.x - this.offsetX;
		this.position.y = data.global.y - this.offsetY;

		if ( this.position.y < 20 )
		{
			this.position.y = 20;
		}

		if ( this.position.x < 0 )
		{
			this.position.x = 0;
		}

		if ( this.position.x > OS7.Desktop.width - this.width )
		{
			this.position.x = OS7.Desktop.width - this.width;
		}

		if ( this.position.y > OS7.Desktop.height - this.height )
		{
			this.position.y = OS7.Desktop.height - this.height;
		}
	}
};

OS7.Icon.prototype.onRelease = function(data)
{
	if ( this.dragging )
	{
		this.dragging = false;
		var rightnow = new Date().getTime();
		
		if ( rightnow - this.clickTime < OS7.Icon.MIN_CLICK_TIME )
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
		this.filters = [ this.invertFilter ];
		this.inverted = true;
	}
	else
	{
		this.filters = null;
		this.inverted = false;
	}
};