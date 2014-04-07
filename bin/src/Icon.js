/*global PIXI*/

var normalTexture;
var invertFilter;
var normalFilter;
var dragging = false;
var offsetX = 0;
var offsetY = 0;
var inverted = false;
var dragging = false;
var stage;

function Icon( iconImage, x, y, stage )
{
    normalTexture = PIXI.Texture.fromImage( iconImage );
	invertFilter = new PIXI.InvertFilter();
	normalFilter = new PIXI.BlurXFilter();
	
    PIXI.Sprite.call( this, normalTexture );
    this.position.x = x;
    this.position.y = y;
	this.stage = stage;
    
    this.setInteractive(true);
	
	this.mousedown = this.touchstart = function( data )
	{
		this.setInverted( true );
		this.offsetX = data.global.x - this.position.x;
		this.offsetY = data.global.y - this.position.y;
		this.dragging = true;
	};
	
	this.mousemove = this.touchmove = function( data )
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
			
			if ( this.position.x > width - this.width )
			{
				this.position.x = width - this.width;
			}
			
			if ( this.position.y > height - this.height )
			{
				this.position.y = height - this.height;
			}
		}
	};
	
	this.mouseup = this.touchend = this.mouseupoutside = this.touchendoutside = function( data )
	{
		if ( this.dragging )
		{
			this.dragging = false;
		}
	};
}

Icon.constructor = Icon;
Icon.prototype = Object.create(PIXI.Sprite.prototype);

Icon.prototype.setInverted = function( status )
{
	if ( status )
	{
		this.filters = [ invertFilter ];
		inverted = true;
	}
	else
	{
		this.filters = null;
		inverted = false;
	}
};