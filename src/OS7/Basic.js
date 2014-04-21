/*global PIXI*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

/**
 * A basic object class. Almost everything in OpenOS7 extends this.
 */
OS7.Basic = function(x, y, width, height)
{
	PIXI.DisplayObjectContainer.call(this);
	
	this.position.x = x || 0;
	this.position.y = y || 0;
	this.width = width || 0;
	this.height = height || 0;
	this.interactive = false; // not needed as desktop sends click/release events
	this.showHitArea = false;
	this.worldPoint = new PIXI.Point(0,0);
	this.objectType = "basic";
	this.mouseOver = false;
	this.isOS7Object = true; // just a really easy way to know
	this.updateHitArea.bind(this);
	this.updateHitArea();
	
	this.onClick.bind(this);
	this.onOver.bind(this);
	this.onOut.bind(this);
	this.onRelease.bind(this);
};

OS7.Basic.prototype = Object.create(PIXI.DisplayObjectContainer.prototype);
OS7.Basic.prototype.constructor = OS7.Basic;

OS7.Basic.mouseOver = false;

OS7.Basic.prototype.onClick = function(){};
OS7.Basic.prototype.onOver = function(){};
OS7.Basic.prototype.onMove = function(){};
OS7.Basic.prototype.onOut = function(){};
OS7.Basic.prototype.onRelease = function(){};

OS7.Basic.prototype.updateHitArea = function()
{
	if (OS7.showHitBoxes || this.showHitArea)
	{
		if (this.hitRect)
		{
			this.removeChild(this.hitRect);
			this.hitRect.clear();
		}
		else
		{
			this.hitRect = new PIXI.Graphics();
		}
		
		this.hitRect.fillAlpha = 0.1;
		this.hitRect.lineStyle(1,0xFF0000,0.5);
		this.hitRect.beginFill(0x0000FF);
		this.hitRect.drawRect(-1,-1,this.width+2,this.height+2);
		this.hitRect.endFill();
		this.addChild(this.hitRect);
	}
	
	if (this.hitArea)
	{
		this.hitArea.x = 0;
		this.hitArea.y = 0;
		this.hitArea.width = this.width;
		this.hitArea.height = this.height;
	}
	else
	{
		this.hitArea = new PIXI.Rectangle(0, 0, this.width, this.height);
	}
};

OS7.Basic.prototype.toString = function()
{
	return "[OS7 Basic]";
};

Object.defineProperty(OS7.Basic.prototype, 'global', {
	get: function() {
		this.worldPoint.x = this.worldTransform.tx;
		this.worldPoint.y = this.worldTransform.ty;
		return this.worldPoint;
	}
});