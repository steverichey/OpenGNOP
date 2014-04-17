/*global PIXI*/
/*global OS7*/
/*global window*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Desktop = function()
{
	OS7.Basic.call(this, 0, 0, OS7.SCREEN_WIDTH, OS7.SCREEN_HEIGHT);
	
	OS7.MainDesktop = this;
	this.icons = [];
	this.windows = [];
	this.headerMenus = [];
	this.dropMenus = [];
	this.clearFlag = false;
	
	this.addChild(this.createBackground());
	
	var clickListener = new OS7.Basic(0,0,640,480);
	clickListener.interactive = true; // only this needs to be interactive
	clickListener.mousedown = clickListener.touchstart = function(data)
	{
		OS7.mouse.x = data.global.x;
		OS7.mouse.y = data.global.y;
		OS7.mouse.justPressed = true;
		OS7.mouse.pressed = true;
	};
	//clickListener.mousemove = clickListener.touchm
	
	clickListener.mouseup = clickListener.touchend = function(data)
	{
		OS7.mouse.x = data.global.x;
		OS7.mouse.y = data.global.y;
		OS7.mouse.justReleased = true;
		OS7.mouse.pressed = false;
	};
	this.addChild(clickListener);
	
	this.headerIcons = new PIXI.Sprite.fromImage("./assets/images/header_icons.png");
	this.headerIcons.position.x = 580;
	this.headerIcons.position.y = 2;
	this.addChild(this.headerIcons);
	
	this.addChild(new OS7.Time());
	
	this.addIcon.bind(this);
	this.addWindow.bind(this);
	this.addTopMenu.bind(this);
	this.addDropMenu.bind(this);
	
	var optionsFunctions = [
		function(){
			//open settings window
		},
		function(){
			window.close();
		}
	];
	
	var optionsDrop = new OS7.DropMenu(["Settings...", "Quit"], optionsFunctions, 0, 0);
	var optionsMenu = new OS7.MenuItem(OS7.MenuItem.SEPTAGON, 8, 1, optionsDrop);
	this.addTopMenu(optionsMenu);
};

OS7.Desktop.prototype = Object.create(OS7.Basic.prototype);
OS7.Desktop.prototype.constructor = OS7.Desktop;

OS7.MainDesktop = {};

OS7.Desktop.prototype.update = function()
{
	if (OS7.mouse.justPressed)
	{
		this.clearFlag = true;
		var i = 0;
		
		for (i = 0; i < this.icons.length; i++)
		{
			if (OS7.collide(OS7.mouse.x, OS7.mouse.y, this.icons[i]))
			{
				console.log("clicked an icon");
				this.icons[i].onClick();
				this.clearFlag = false;
			}
		}
		
		for (i = 0; i < this.headerMenus.length; i++)
		{
			if (OS7.collide(OS7.mouse.x, OS7.mouse.y, this.headerMenus[i]))
			{
				console.log("clicked a header");
				this.headerMenus[i].onClick();
				this.clearFlag = false;
			}
		}
		
		for (i = 0; i < this.dropMenus.length; i++)
		{
			if (OS7.collide(OS7.mouse.x, OS7.mouse.y, this.dropMenus[i]))
			{
				console.log("clicked a drop menu");
				this.dropMenus[i].onClick();
				this.clearFlag = false;
			}
		}
		
		if (this.clearFlag)
		{
			console.log("clicked nothing");
			console.log(this.toString());
			
			if (OS7.mouse.y > 20)
			{
				for (i = 0; i < this.icons.length; i++)
				{
					this.icons[i].setInverted(false);
				}
			}
			
			for (i = 0; i < this.headerMenus.length; i++)
			{
				this.headerMenus[i].invert(true);
			}
			
			for (i = 0; i < this.dropMenus.length; i++)
			{
				this.dropMenus[i].visible = false;
			}
		}
	}
	
	OS7.mouse.justPressed = false;
	OS7.mouse.justReleased = false;
};

OS7.Desktop.prototype.addIcon = function(iconImage, x, y, windowClass)
{
	var newicon = new OS7.Icon(iconImage, x, y, windowClass);
	this.icons.push(newicon);
	this.addChild(newicon);
};

OS7.Desktop.prototype.addWindow = function(windowClass)
{
	this.windows.push(windowClass);
	this.addChild(windowClass);
};

OS7.Desktop.prototype.addTopMenu = function(menuItem)
{
	this.headerMenus.push(menuItem);
	this.addChild(menuItem);
	
	if(menuItem.dropMenu)
	{
		this.addDropMenu(menuItem.dropMenu);
	}
};

OS7.Desktop.prototype.addDropMenu = function(dropMenu)
{
	this.dropMenus.push(dropMenu);
	this.addChild(dropMenu);
};

OS7.Desktop.prototype.createBackground = function()
{
	var bg = new PIXI.Graphics();
	
	bg.beginFill(OS7.Colors.WHITE);
	bg.drawRect(0,0,OS7.SCREEN_WIDTH,19);
	bg.endFill();
	bg.beginFill(OS7.Colors.BLACK);
	bg.drawRect(0,19,OS7.SCREEN_WIDTH,1);
	bg.endFill();
	bg.beginFill(OS7.Colors.BG_GREY_DARK);
	bg.drawRect(0,20,OS7.SCREEN_WIDTH,OS7.SCREEN_HEIGHT-20);
	bg.endFill();
	bg.lineStyle(1,OS7.Colors.BG_GREY_LIGHT,1);
	
	for (var xPos = OS7.SCREEN_WIDTH; xPos >= 0; xPos -= 2)
	{
		bg.moveTo(xPos, 20);
		bg.lineTo(OS7.SCREEN_WIDTH, OS7.SCREEN_WIDTH - xPos + 20);
	}
	
	for (var yPos = 22; yPos < OS7.SCREEN_HEIGHT; yPos += 2)
	{
		bg.moveTo(0, yPos);
		bg.lineTo(OS7.SCREEN_WIDTH, OS7.SCREEN_WIDTH - xPos + 20);
		xPos -= 2;
	}
	
	var cX = [5, 3, 2, 2, 1];
	var cY = [1, 2, 2, 3, 5];
	
	bg.lineStyle(0, OS7.Colors.BLACK, 0);
	bg.beginFill(OS7.Colors.BLACK);
	
	for (var i = 0; i <= 5; i++)
	{
		bg.drawRect(0, 0, cX[i], cY[i]);
		bg.drawRect(OS7.SCREEN_WIDTH-cX[i], 0, cX[i], cY[i]);
		bg.drawRect(0, OS7.SCREEN_HEIGHT-cY[i], cX[i], cY[i]);
		bg.drawRect(OS7.SCREEN_WIDTH-cX[i], OS7.SCREEN_HEIGHT-cY[i], cX[i], cY[i]);
	}
	
	bg.endFill();
	bg.cacheAsBitmap = true;
	
	return bg;
};

OS7.Desktop.prototype.toString = function()
{
	var returnString = "";
	var i = 0;
	
	for (i = 0; i < this.icons.length; i++)
	{
		if (i != 0)
		{
			returnString += ", ";
		}
		
		returnString += this.icons[i].toString();
	}		
	
	for (i = 0; i < this.headerMenus.length; i++)
	{
		if (i != 0)
		{
			returnString += ", ";
		}
		
		returnString += this.headerMenus[i].toString();
	}
	
	for (i = 0; i < this.dropMenus.length; i++)
	{
		if (i != 0)
		{
			returnString += ", ";
		}
		
		returnString += this.dropMenus[i].toString();
	}
	
	return "[OS7 Desktop containing " + returnString + "]";
};