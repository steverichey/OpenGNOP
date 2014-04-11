/*global PIXI*/
/*global OS7*/
/*global Text*/
/*global Checkbox*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Window = function(x, y, width, height)
{
    PIXI.Sprite.call( this, new PIXI.Texture.fromImage("") );
	
	this.position.x = x;
	this.position.y = y;
	this.windowWidth = width;
	this.windowHeight = height;
	this.windowType = "bordered";
	this.texts = [];
};

OS7.Window.constructor = OS7.Window;
OS7.Window.prototype = Object.create(PIXI.Sprite.prototype);

OS7.Window.prototype.create = function()
{
	// override this to build your window
};

OS7.Window.prototype.destroy = function()
{
	// override this to remove your window
};

OS7.Window.prototype.createWindow = function()
{
	this.graphics = new PIXI.Graphics();
	
	if ( this.windowType === "shadow" )
	{
		OS7.Window.fillRect(this.graphics, this.position.x+2, this.position.y+2, this.windowWidth-2, this.windowHeight-2, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.graphics, this.position.x, this.position.y, this.windowWidth-2, this.windowHeight-2, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.graphics, this.position.x+1, this.position.y+1, this.windowWidth-4, this.windowHeight-4, OS7.Colors.WHITE);
	}
	else if ( this.windowType === "menu" )
	{
		OS7.Window.fillRect(this.graphics, this.position.x+3, this.position.y+3, this.windowWidth-3, this.windowHeight-3, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.graphics, this.position.x, this.position.y, this.windowWidth-1, this.windowHeight-1, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.graphics, this.position.x+1, this.position.y+1, this.windowWidth-3, this.windowHeight-3, OS7.Colors.WHITE);
	}
	else // bordered
	{
		OS7.Window.fillRect(this.graphics, this.position.x, this.position.y, this.windowWidth, this.windowHeight, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.graphics, this.position.x, this.position.y, this.windowWidth, this.windowHeight, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.graphics, this.position.x+1, this.position.y+1, this.windowWidth-2, this.windowHeight-2, OS7.Colors.BLUE_DARK);
		OS7.Window.fillRect(this.graphics, this.position.x+1, this.position.y+1, this.windowWidth-3, this.windowHeight-3, OS7.Colors.BLUE_LIGHT);
		OS7.Window.fillRect(this.graphics, this.position.x+2, this.position.y+2, this.windowWidth-4, this.windowHeight-4, OS7.Colors.GREY);
		OS7.Window.fillRect(this.graphics, this.position.x+3, this.position.y+3, this.windowWidth-6, this.windowHeight-6, OS7.Colors.BLUE_DARK);
		OS7.Window.fillRect(this.graphics, this.position.x+4, this.position.y+4, this.windowWidth-7, this.windowHeight-7, OS7.Colors.BLUE_LIGHT);
		OS7.Window.fillRect(this.graphics, this.position.x+4, this.position.y+4, this.windowWidth-8, this.windowHeight-8, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.graphics, this.position.x+5, this.position.y+5, this.windowWidth-10, this.windowHeight-10, OS7.Colors.WHITE);
	}
	
	this.stage.addChild(this.graphics);
};

OS7.Window.prototype.addText = function(string, x, y)
{
	var text = new OS7.Text(string, x, y);
	this.texts.push(text);
	this.stage.addChild( text );
	
	return text;
};

OS7.Window.prototype.addCheckbox = function(string, x, y)
{
	var text = this.addText(string, x, y);
	var checkbox = new OS7.Checkbox(text.x+text.textWidth+8, text.y);
	this.checkboxes.push(checkbox);
	this.stage.addChild(checkbox);
};

/**
 * Function to fill a graphics object.
 */
OS7.Window.fillRect = function(target, x, y, width, height, color)
{
	target.beginFill(color);
	target.drawRect(x, y, width, height);
	target.endFill();
};