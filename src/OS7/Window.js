/*global PIXI*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */
 
OS7.Window = function(x, y, width, height)
{
	OS7.Basic.call(this, x, y);
	
	this.windowWidth = width;
	this.windowHeight = height;
	this.texts = [];
	this.sprites = [];
	this.createWindow.bind(this);
	this.addText.bind(this);
	this.addSprite.bind(this);
};

OS7.Window.prototype = Object.create(OS7.Basic.prototype);
OS7.Window.prototype.constructor = OS7.Window;

OS7.Window.prototype.create = function() {};
OS7.Window.prototype.destroy = function() {};

OS7.Window.prototype.createWindow = function(windowType)
{
	this.windowGraphics = new PIXI.Graphics();

	if ( windowType === "shadow" )
	{
		OS7.Window.fillRect(this.windowGraphics, this.position.x+2, this.position.y+2, this.windowWidth-2, this.windowHeight-2, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.windowGraphics, this.position.x, this.position.y, this.windowWidth-2, this.windowHeight-2, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.windowGraphics, this.position.x+1, this.position.y+1, this.windowWidth-4, this.windowHeight-4, OS7.Colors.WHITE);
	}
	else if ( windowType === "menu" )
	{
		OS7.Window.fillRect(this.windowGraphics, this.position.x+3, this.position.y+3, this.windowWidth-3, this.windowHeight-3, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.windowGraphics, this.position.x, this.position.y, this.windowWidth-1, this.windowHeight-1, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.windowGraphics, this.position.x+1, this.position.y+1, this.windowWidth-3, this.windowHeight-3, OS7.Colors.WHITE);
	}
	else // bordered
	{
		OS7.Window.fillRect(this.windowGraphics, this.position.x, this.position.y, this.windowWidth, this.windowHeight, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.windowGraphics, this.position.x, this.position.y, this.windowWidth, this.windowHeight, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.windowGraphics, this.position.x+1, this.position.y+1, this.windowWidth-2, this.windowHeight-2, OS7.Colors.BLUE_DARK);
		OS7.Window.fillRect(this.windowGraphics, this.position.x+1, this.position.y+1, this.windowWidth-3, this.windowHeight-3, OS7.Colors.BLUE_LIGHT);
		OS7.Window.fillRect(this.windowGraphics, this.position.x+2, this.position.y+2, this.windowWidth-4, this.windowHeight-4, OS7.Colors.GREY);
		OS7.Window.fillRect(this.windowGraphics, this.position.x+3, this.position.y+3, this.windowWidth-6, this.windowHeight-6, OS7.Colors.BLUE_DARK);
		OS7.Window.fillRect(this.windowGraphics, this.position.x+4, this.position.y+4, this.windowWidth-7, this.windowHeight-7, OS7.Colors.BLUE_LIGHT);
		OS7.Window.fillRect(this.windowGraphics, this.position.x+4, this.position.y+4, this.windowWidth-8, this.windowHeight-8, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.windowGraphics, this.position.x+5, this.position.y+5, this.windowWidth-10, this.windowHeight-10, OS7.Colors.WHITE);
	}
	
	this.addChild(this.windowGraphics);
};

OS7.Window.fillRect = function(target, x, y, width, height, color)
{
	target.beginFill(color);
	target.drawRect(x, y, width, height);
	target.endFill();
};

OS7.Window.prototype.addText = function(textString, x, y)
{
	var text = new OS7.Text(textString,x,y);
	this.addChild(text);
	this.texts.push(text);
};

OS7.Window.prototype.addSprite = function(sprite, x, y)
{
	sprite.position.x = x;
	sprite.position.y = y;
	this.addChild(sprite);
	this.sprites.push(sprite);
};