/*global PIXI*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */
 
OS7.MenuItem = function(content, dropMenu, width, callFunction, parentWindow)
{
	this.width = width || 0;
	this.type = content || "BLANK";
	this.parentWindow = parentWindow;
	
	if (dropMenu)
	{
		this.dropMenu = dropMenu;
		this.height = 18;
	}
	else
	{
		this.height = 16;
		
		if (callFunction)
		{
			this.callFunction = callFunction;
		}
	}
	
	OS7.Basic.call(this, 0, 0, this.width, this.height);
	
	if (content === OS7.MenuItem.SEPTAGON)
	{
		this.width = 29;
		this.logo = new PIXI.Sprite.fromImage("./assets/images/septagon.png");
		this.logo.position.x = 8;
		this.logo.position.y = 2;
		this.addChild(this.logo);
	}
	else if (content === OS7.MenuItem.LINE)
	{
		this.width = 5;
		this.line = new PIXI.Graphics();
		this.line.beginFill(OS7.Colors.GREY_LIGHT);
		this.line.drawRect(0,8,this.width,1);
		this.line.endFill();
		this.addChild(this.line);
	}
	else
	{
		this.text = new OS7.Text(content);
		
		if (this.dropMenu)
		{
			this.text.position.x = 9;
			this.text.position.y = 3;
			
			if (this.width === 0)
			{
				this.width = this.text.position.x + this.text.textWidth + 9;
			}
		}
		else
		{
			this.text.position.x = 14;
			this.text.position.y = 2;
			
			if (this.width === 0)
			{
				this.width = this.text.position.x + this.text.textWidth + 10;
			}
		}
	}
	
	this.bg = new PIXI.Graphics();
	this.bg.beginFill(OS7.Colors.WHITE);
	this.bg.drawRect(0,0,this.width,this.height);
	this.bg.endFill();
	this.addChild(this.bg);
	
	if (this.logo)
	{
		this.addChild(this.logo);
	}
	
	if (this.line)
	{
		this.addChild(this.line);
	}
	
	if (this.text)
	{
		this.addChild(this.text);
	}
	
	this.invert.bind(this);
	this.objectType = "menuitem";
	this.updateHitArea();
};

OS7.MenuItem.prototype = Object.create(OS7.Basic.prototype);
OS7.MenuItem.prototype.constructor = OS7.MenuItem;

OS7.MenuItem.SEPTAGON = "SEPTAGON";
OS7.MenuItem.LINE = "LINE";
OS7.MenuItem.GREY = "GREY_";

OS7.MenuItem.prototype.onClick = function()
{
	if (this.dropMenu)
	{
		this.dropMenu.toggleVisibility();
		OS7.MainDesktop.headerActive = !OS7.MainDesktop.headerActive;
		OS7.MainDesktop.activeTopMenu = this;
		this.invert();
	}
};

OS7.MenuItem.prototype.onOver = function()
{
	if (!this.dropMenu)
	{
		this.invert();
	}
	else if (OS7.MainDesktop.headerActive && OS7.MainDesktop.activeTopMenu !== this)
	{
		this.onClick();
	}
};

OS7.MenuItem.prototype.onOut = function()
{
	if (!this.dropMenu)
	{
		this.invert();
	}
};

OS7.MenuItem.prototype.onRelease = function()
{
	if (this.callFunction && typeof this.callFunction === "function")
	{
		this.callFunction();
	}
	
	if (!this.dropMenu)
	{
		this.invert(true);
	}
};

OS7.MenuItem.prototype.invert = function(forceClear)
{
	if (this.bg.tint === OS7.Colors.BLACK || forceClear)
	{
		this.bg.tint = OS7.Colors.WHITE;
	}
	else
	{
		this.bg.tint = OS7.Colors.BLACK;
	}
	
	if (this.text)
	{
		if (this.text.tint === OS7.Colors.WHITE || forceClear)
		{
			this.text.tint = OS7.Colors.ALMOST_BLACK;
		}
		else
		{
			this.text.tint = OS7.Colors.WHITE;
		}
		
		this.text.dirty = true;
	}
};

OS7.MenuItem.prototype.toString = function()
{
	return "[OS7 MenuItem " + this.type + "]";
};