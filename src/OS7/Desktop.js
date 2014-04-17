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
	this.allObjects = [];
	this.clearFlag = false;
	this.objectType = "desktop";
	
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
	
	clickListener.mousemove = clickListener.touchmove = function(data)
	{
		OS7.mouse.x = data.global.x;
		OS7.mouse.y = data.global.y;
		OS7.mouse.justMoved = true;
	};
	
	clickListener.mouseup = clickListener.mouseupoutside = clickListener.touchend = clickListener.touchendoutside = function(data)//clickListener.touchend = function(data)
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
	
	var aboutWindow = new OS7.Window(80, 60, 400, 170);
	aboutWindow.addText("OpenOS7 is a pure JavaScript re-creation of the\nSystem 7 OS using PixiJS for rendering.\n\nOpenOS7 was created by Steve Richey (aka STVR) for\nOpenGNOP! but you can use it for other stuff too.\n\nOpenOS7 is licensed under the MIT license.\n\nCopyright (c) 2014 Steve Richey.", 20, 20);
	
	var settingsWindow = new OS7.SettingsWindow();
	
	var optionsFunctions = [
		function(){
			settingsWindow.create();
		},
		function(){
			aboutWindow.create();
		}
	];
	
	var optionsDrop;
	
	if (OS7.isWebkit)
	{
		optionsFunctions.push(function(){window.close();});
		optionsDrop = new OS7.DropMenu(["Settings...", "About", "Quit"], optionsFunctions, 0, 0);
	}
	else
	{
		optionsDrop = new OS7.DropMenu(["Settings...", "About"], optionsFunctions, 0, 0);
	}
	
	var optionsMenu = new OS7.MenuItem(OS7.MenuItem.SEPTAGON, 8, 1, optionsDrop);
	this.addTopMenu(optionsMenu);
};

OS7.Desktop.prototype = Object.create(OS7.Basic.prototype);
OS7.Desktop.prototype.constructor = OS7.Desktop;

OS7.MainDesktop = {};

OS7.Desktop.prototype.update = function()
{
	var i;
	
	if (OS7.mouse.justPressed)
	{
		this.clearFlag = true;
		
		for (i = 0; i < this.allObjects.length; i++)
		{
			if (OS7.collide(OS7.mouse.x, OS7.mouse.y, this.allObjects[i]))
			{
				if (this.allObjects[i].onClick)
				{
					this.allObjects[i].onClick();
				}
				this.clearFlag = false;
			}
		}
	}
	else if (OS7.mouse.justReleased)
	{
		for (i = 0; i < this.allObjects.length; i++)
		{
			if (OS7.collide(OS7.mouse.x, OS7.mouse.y, this.allObjects[i]))
			{
				if (this.allObjects[i].onRelease)
				{
					this.allObjects[i].onRelease();
				}
				
				if (this.allObjects[i] && this.allObjects[i].objectType && this.allObjects[i].objectType === "dropmenu")
				{
					this.clearFlag = true;
				}
				else
				{
					this.clearFlag = false;
				}
			}
		}
	}
	
	if (OS7.mouse.justMoved)
	{
		for (i = 0; i < this.allObjects.length; i++)
		{
			if (OS7.collide(OS7.mouse.x, OS7.mouse.y, this.allObjects[i]))
			{
				if (this.allObjects[i].onOver)
				{
					this.allObjects[i].mouseOver = true;
					this.allObjects[i].onOver();
				}
			}
			else if (this.allObjects[i].mouseOver)
			{
				if (this.allObjects[i].onOut)
				{
					this.allObjects[i].mouseOver = false;
					this.allObjects[i].onOut();
				}
			}
		}
	}
	
	if (this.clearFlag)
	{
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
	
	OS7.mouse.justPressed = false;
	OS7.mouse.justMoved = false;
	OS7.mouse.justReleased = false;
};

OS7.Desktop.prototype.addIcon = function(iconImage, x, y, windowClass)
{
	var newicon = new OS7.Icon(iconImage, x, y, windowClass);
	this.icons.push(newicon);
	this.allObjects.push(newicon);
	this.addChild(newicon);
};

OS7.Desktop.prototype.addWindow = function(windowClass)
{
	this.windows.push(windowClass);
	this.allObjects.push(windowClass);
	this.addChild(windowClass);
	
	if(windowClass.topMenu)
	{
		this.addTopMenu(windowClass.topMenu);
	}
	else
	{
		var genericFunction = [function(){
			OS7.MainDesktop.removeWindow(windowClass);
		}];
		var genericDropMenu = new OS7.DropMenu(["Exit"], genericFunction);
		var genericTopMenu = new OS7.MenuItem("File", 0, 0, genericDropMenu);
		windowClass.topMenu = genericTopMenu;
		this.addTopMenu(genericTopMenu);
	}
};

OS7.Desktop.prototype.removeWindow = function(windowClass)
{
	var windowPos = this.windows.indexOf(windowClass);
	
	if (windowPos !== -1)
	{
		this.windows.splice(windowPos, 1);
		this.removeChild(windowClass);
		this.allObjects.splice(this.allObjects.indexOf(windowClass),1);
		
		if (windowClass.topMenu)
		{
			this.removeTopMenu(windowClass.topMenu);
		}
	}
};

OS7.Desktop.prototype.addTopMenu = function(menuItem)
{
	var lastMenuPos = this.headerMenus.length-1;
	
	if (lastMenuPos >= 0)
	{
		var lastMenu = this.headerMenus[lastMenuPos];
		menuItem.x = lastMenu.x + lastMenu.width;
	}
	else
	{
		menuItem.x = 8;
	}
	
	menuItem.y = 1;
	
	this.headerMenus.push(menuItem);
	this.allObjects.push(menuItem);
	this.addChild(menuItem);
	
	if(menuItem.dropMenu)
	{
		this.addDropMenu(menuItem.dropMenu);
	}
};

OS7.Desktop.prototype.removeTopMenu = function(topMenu)
{
	var menuPos = this.headerMenus.indexOf(topMenu);
	
	if (menuPos !== -1)
	{
		this.headerMenus.splice(menuPos, 1);
		this.removeChild(topMenu);
		this.allObjects.splice(this.allObjects.indexOf(topMenu),1);
		
		if (topMenu.dropMenu)
		{
			this.removeDropMenu(topMenu.dropMenu);
		}
	}
};

OS7.Desktop.prototype.addDropMenu = function(dropMenu)
{
	var lastMenuPos = this.headerMenus.length-1;
	var lastMenu = this.headerMenus[lastMenuPos];
	
	dropMenu.x = lastMenu.x;
	dropMenu.y = 19;
	
	this.dropMenus.push(dropMenu);
	this.allObjects.push(dropMenu);
	this.addChild(dropMenu);
};

OS7.Desktop.prototype.removeDropMenu = function(dropMenu)
{
	var menuPos = this.dropMenus.indexOf(dropMenu);
	
	if (menuPos !== -1)
	{
		this.dropMenus.splice(menuPos, 1);
		this.removeChild(dropMenu);
		this.allObjects.splice(this.allObjects.indexOf(dropMenu),1);
	}
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
	
	for (var i = 0; i < this.allObjects.length; i++)
	{
		if (i !== 0)
		{
			returnString += ", ";
		}
		
		returnString += this.allObjects[i].toString();
	}
	
	return "[OS7 Desktop containing " + returnString + "]";
};