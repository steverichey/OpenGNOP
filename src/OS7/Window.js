/*global PIXI*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */
 
OS7.Window = function(x, y, width, height, windowType, topMenu)
{
	OS7.Basic.call(this, x, y, width, height);
	
	this.windowObjects = [];
	this.windowType = windowType || OS7.Window.BORDERED;
	this.topMenu = topMenu;
	this.objectType = "window";
	this.createWindow.bind(this);
	this.addText.bind(this);
	this.addImage.bind(this);
	this.windowGraphics = new PIXI.Graphics();
	this.addChild(this.windowGraphics);
	this.visible = false;
};

OS7.Window.prototype = Object.create(OS7.Basic.prototype);
OS7.Window.prototype.constructor = OS7.Window;

OS7.Window.BORDERED = "border";
OS7.Window.SHADOWED = "shadow";
OS7.Window.MENU = "menu";

OS7.Window.prototype.onClick = function()
{
	if (OS7.MainDesktop.activeWindow !== this)
	{
		OS7.MainDesktop.setActiveWindow(this);
	}
};

OS7.Window.prototype.create = function()
{
	this.createWindow(this.windowType);
	OS7.MainDesktop.addWindow(this);
	this.visible = true;
	
	for (var i = 0; i < this.children.length; i++)
	{
		this.children[i].visible = true;
	}
	
	if (this.topMenu)
	{
		OS7.MainDesktop.setActiveTopMenu(this.topMenu);
	}
};

OS7.Window.prototype.destroy = function() {};

OS7.Window.prototype.createWindow = function(windowType)
{
	if (windowType === OS7.Window.SHADOWED)
	{
		OS7.Window.fillRect(this.windowGraphics, 2, 2, this.width-2, this.height-2, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.windowGraphics, 0, 0, this.width-2, this.height-2, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.windowGraphics, 1, 1, this.width-4, this.height-4, OS7.Colors.WHITE);
	}
	else if (windowType === OS7.Window.MENU)
	{
		OS7.Window.fillRect(this.windowGraphics, 3, 3, this.width-3, this.height-3, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.windowGraphics, 0, 0, this.width-1, this.height-1, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.windowGraphics, 1, 1, this.width-3, this.height-3, OS7.Colors.WHITE);
	}
	else // bordered
	{
		OS7.Window.fillRect(this.windowGraphics, 0, 0, this.width, this.height, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.windowGraphics, 0, 0, this.width, this.height, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.windowGraphics, 1, 1, this.width-2, this.height-2, OS7.Colors.BLUE_DARK);
		OS7.Window.fillRect(this.windowGraphics, 1, 1, this.width-3, this.height-3, OS7.Colors.BLUE_LIGHT);
		OS7.Window.fillRect(this.windowGraphics, 2, 2, this.width-4, this.height-4, OS7.Colors.GREY);
		OS7.Window.fillRect(this.windowGraphics, 3, 3, this.width-6, this.height-6, OS7.Colors.BLUE_DARK);
		OS7.Window.fillRect(this.windowGraphics, 4, 4, this.width-7, this.height-7, OS7.Colors.BLUE_LIGHT);
		OS7.Window.fillRect(this.windowGraphics, 4, 4, this.width-8, this.height-8, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.windowGraphics, 5, 5, this.width-10, this.height-10, OS7.Colors.WHITE);
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
	text.visible = this.visible;
	
	if (text.textWidth > this.width)
	{
		text.wordWrap = true;
		text.width = this.width;
	}
	
	this.addChild(text);
};

OS7.Window.prototype.addImage = function(imagePath, x, y)
{
	var image = new PIXI.Sprite.fromImage(imagePath);
	image.x = x;
	image.y = y;
	image.visible = this.visible;
	
	this.addChild(image);
};

OS7.Window.prototype.toString = function()
{
	return "[OS7 Window]";
};