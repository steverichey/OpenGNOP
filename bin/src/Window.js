/*global PIXI*/
/*global Main*/

var name;
var source;
var offsetX;
var offsetY;
var graphics;
var width;
var height;

var BLACK = 0x000000;
var BLUE_LIGHT = 0xCCCCFF;
var GREY = 0xBBBBBB;
var BLUE_DARK = 0x666699;
var WHITE = 0xFFFFFF;

function Window( x, y, width, height, stage )
{
    PIXI.Sprite.call( this, new PIXI.Texture.fromImage("") );
	
	this.width = width;
	this.height = height;
	
	this.position.x = x;
	this.position.y = y;
	
	stage.addChild( this );
}

Window.constructor = Window;
Window.prototype = Object.create(PIXI.Sprite.prototype);

Window.prototype.create = function()
{
	this.graphics = new PIXI.Graphics()
	this.graphics.bounds.width = this.width;
	this.graphics.bounds.height = this.height;
	this.fillRect(this.graphics, 0, 0, this.width, this.height, BLACK);
	this.addChild(this.graphics);
};

Window.prototype.destroy = function()
{
	
};

Window.prototype.fillRect = function( target, x, y, width, height, color )
{
	target.beginFill(color);
	target.drawRect(x, y, width, height);
	target.endFill();
};