/*global PIXI*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */
 
OS7.MenuItem = function(content, x, y, dropMenu, width)
{
	OS7.Basic.call(this, x, y);
	this.width = width || 0;
	
	if (dropMenu)
	{
		this.dropMenu = dropMenu;
		this.dropMenu.position.x = this.position.x;
		this.dropMenu.position.y = 19;
		this.dropMenu.visible = false;
		OS7.MainDesktop.addDropMenu(this.dropMenu);
		
		this.height = 18;
	}
	else
	{
		this.height = 16;
	}
	
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
		this.interactive = false;
	}
	else
	{
		this.text = new OS7.Text(content);
		this.text.position.y = 2;
		
		if (this.dropMenu)
		{
			this.text.position.x = 9;
			
			if (this.width === 0)
			{
				this.width = this.text.position.x + this.text.textWidth + 9;
			}
		}
		else
		{
			this.text.position.x = 14;
			
			if (this.width === 0)
			{
				this.width = this.text.position.x + this.text.textWidth + 10;
			}
		}
		
		
		this.addChild(this.text);
	}
	
	this.bg = new PIXI.Graphics();
	this.bg.beginFill(OS7.Colors.WHITE);
	this.bg.drawRect(0,0,this.width,this.height);
	this.bg.endFill();
	this.bg.interactive = true;
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
	
	if (this.interactive)
	{
		this.invert.bind(this);
	}
};

OS7.MenuItem.prototype = Object.create(PIXI.DisplayObjectContainer.prototype);
OS7.MenuItem.prototype.constructor = OS7.MenuItem;

OS7.MenuItem.SEPTAGON = "SEPTAGON";
OS7.MenuItem.LINE = "LINE";
OS7.MenuItem.GREY = "GREY_";

OS7.MenuItem.prototype.onClick = function(data)
{
	if (this.dropMenu)
	{
		this.dropMenu.visible = !this.dropMenu.visible;
	}
	
	this.invert();
};

OS7.MenuItem.prototype.onRelease = function(data)
{
	if (!this.dropMenu)
	{
		this.invert();
	}
};

OS7.MenuItem.prototype.invert = function(forceClear)
{
	if (this.bg.tint === OS7.Colors.WHITE && !forceClear)
	{
		this.bg.tint = OS7.Colors.ALMOST_BLACK;
	}
	else
	{
		this.bg.tint = OS7.Colors.WHITE;
	}
	
	if (this.text)
	{
		if (this.text.tint === OS7.Colors.ALMOST_BLACK && !forceClear)
		{
			this.text.tint = OS7.Colors.WHITE;
		}
		else
		{
			this.text.tint = OS7.Colors.ALMOST_BLACK;
		}
		
		this.text.dirty = true;
	}
};