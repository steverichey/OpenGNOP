/*global PIXI*/
/*global Main*/
/*global Text*/
/*global Checkbox*/

var name;
var source;
var offsetX;
var offsetY;
var graphics;
var windowWidth;
var windowHeight;
var stage;
var windowType;
var texts;
var checkboxes;

var BLACK = 0x000000;
var BLUE_LIGHT = 0xCCCCFF;
var GREY = 0xBBBBBB;
var BLUE_DARK = 0x666699;
var WHITE = 0xFFFFFF;

function Window( x, y, width, height, stage )
{
    PIXI.Sprite.call( this, new PIXI.Texture.fromImage("") );
	
	this.position.x = x;
	this.position.y = y;
	this.windowWidth = width;
	this.windowHeight = height;
	this.stage = stage;
	this.texts = [];
	
	stage.addChild( this );
}

Window.constructor = Window;
Window.prototype = Object.create(PIXI.Sprite.prototype);

Window.prototype.create = function()
{
	// override this to build your window
};

Window.prototype.createWindow = function()
{
	this.graphics = new PIXI.Graphics();
	
	if ( this.windowType === "shadow" )
	{
		this.fillRect(this.graphics, this.position.x+2, this.position.y+2, this.windowWidth-2, this.windowHeight-2, BLACK);
		this.fillRect(this.graphics, this.position.x, this.position.y, this.windowWidth-2, this.windowHeight-2, BLACK);
		this.fillRect(this.graphics, this.position.x+1, this.position.y+1, this.windowWidth-4, this.windowHeight-4, WHITE);
	}
	else if ( this.windowType === "menu" )
	{
		this.fillRect(this.graphics, this.position.x+3, this.position.y+3, this.windowWidth-3, this.windowHeight-3, BLACK);
		this.fillRect(this.graphics, this.position.x, this.position.y, this.windowWidth-1, this.windowHeight-1, BLACK);
		this.fillRect(this.graphics, this.position.x+1, this.position.y+1, this.windowWidth-3, this.windowHeight-3, WHITE);
	}
	else // bordered
	{
		this.fillRect(this.graphics, this.position.x, this.position.y, this.windowWidth, this.windowHeight, BLACK);
		this.fillRect(this.graphics, this.position.x, this.position.y, this.windowWidth, this.windowHeight, BLACK);
		this.fillRect(this.graphics, this.position.x+1, this.position.y+1, this.windowWidth-2, this.windowHeight-2, BLUE_DARK);
		this.fillRect(this.graphics, this.position.x+1, this.position.y+1, this.windowWidth-3, this.windowHeight-3, BLUE_LIGHT);
		this.fillRect(this.graphics, this.position.x+2, this.position.y+2, this.windowWidth-4, this.windowHeight-4, GREY);
		this.fillRect(this.graphics, this.position.x+3, this.position.y+3, this.windowWidth-6, this.windowHeight-6, BLUE_DARK);
		this.fillRect(this.graphics, this.position.x+4, this.position.y+4, this.windowWidth-7, this.windowHeight-7, BLUE_LIGHT);
		this.fillRect(this.graphics, this.position.x+4, this.position.y+4, this.windowWidth-8, this.windowHeight-8, BLACK);
		this.fillRect(this.graphics, this.position.x+5, this.position.y+5, this.windowWidth-10, this.windowHeight-10, WHITE);
	}
	
	this.stage.addChild(this.graphics);
};

Window.prototype.addText = function(string, x, y)
{
	var text = new Text(string, x, y);
	this.texts.push(text);
	this.stage.addChild( text );
	
	return text;
};

Window.prototype.addCheckbox = function(string, x, y)
{
	var text = this.addText(string, x, y);
	var checkbox = new Checkbox(text.x+text.textWidth+8, text.y);
	//this.checkboxes.push(checkbox);
	this.stage.addChild(checkbox);
};

Window.prototype.destroy = function()
{
	
};

Window.prototype.fillRect = function(target, x, y, width, height, color)
{
	target.beginFill(color);
	target.drawRect(x, y, width, height);
	target.endFill();
};