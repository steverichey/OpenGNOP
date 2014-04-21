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
	this.dropMenus = [];
	this.menuItems = [];
	this.topMenuItems = [];
	this.clearFlag = false;
	this.objectType = "desktop";
	this.headerActive = false;
	this.activeTopMenu = null;
	this.activeWindow = null;
	
	this.iconLayer = 1;
	this.windowLayer = 2;
	this.menuLayer = 3;
	this.menuItemLayer = 4;
	
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
	
	clickListener.mouseup = clickListener.mouseupoutside = clickListener.touchend = clickListener.touchendoutside = function(data)
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
	this.removeIcon.bind(this);
	
	this.addWindow.bind(this);
	this.setActiveWindow.bind(this);
	this.removeWindow.bind(this);
	
	this.setActiveTopMenu.bind(this);
	this.addTopMenuItem.bind(this);
	this.removeTopMenuItem.bind(this);
	
	this.addDropMenu.bind(this);
	this.removeDropMenu.bind(this);
	
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
		optionsDrop = new OS7.DropMenu(["Settings...", "About", "Quit"], optionsFunctions);
	}
	else
	{
		optionsDrop = new OS7.DropMenu(["Settings...", "About"], optionsFunctions);
	}
	
	var defaultTopMenu = new OS7.TopMenu([new OS7.MenuItem(OS7.MenuItem.SEPTAGON, optionsDrop)]);
	this.setActiveTopMenu(defaultTopMenu);
};

OS7.Desktop.prototype = Object.create(OS7.Basic.prototype);
OS7.Desktop.prototype.constructor = OS7.Desktop;

OS7.MainDesktop = {};

OS7.Desktop.prototype.update = function()
{
	this.clearFlag = OS7.mouse.justPressed;
	
	for (var i = 0; i < this.children.length; i++)
	{
		if (this.children[i].isOS7Object)
		{
			if (OS7.collide(OS7.mouse.x, OS7.mouse.y, this.children[i]))
			{
				if (OS7.mouse.justPressed && this.children[i].onClick)
				{
					this.children[i].onClick();
					this.clearFlag = false;
				}
				else if (OS7.mouse.justReleased && this.children[i].onRelease)
				{
					// if we just clicked on a dropmenu menuitem, we'll need to clear dropmenus
					
					if (this.children[i].objectType === "menuitem" && !this.children[i].dropMenu)
					{
						this.clearFlag = true;
					}
					
					this.children[i].onRelease();
				}
				else if (OS7.mouse.justMoved)
				{
					if (this.children[i].onOver && !this.children[i].mouseOver)
					{
						this.children[i].mouseOver = true;
						this.children[i].onOver();
					}
				}
			}
			else if (this.children[i].onMove && OS7.mouse.justMoved)
			{
				this.children[i].onMove();
			}
			else if (this.children[i].onOut && this.children[i].mouseOver)
			{
				this.children[i].mouseOver = false;
				this.children[i].onOut();
			}
		}
	}
	
	// if the user clicked away, or selected a dropmenu menuitem, need to clear top and drop menus
	
	if (this.clearFlag)
	{
		if (OS7.mouse.y > 20)
		{
			for (i = 0; i < this.icons.length; i++)
			{
				this.icons[i].setInverted(false);
			}
		}
		
		for (i = 0; i < this.topMenuItems.length; i++)
		{
			this.topMenuItems[i].invert(true);
		}
		
		for (i = 0; i < this.dropMenus.length; i++)
		{
			this.dropMenus[i].toggleVisibility(false);
		}
		
		this.headerActive = false;
		this.clearFlag = false;
	}
	
	// call update on windows
	
	for (i = 0; i < this.windows.length; i++)
	{
		if (this.windows[i].update)
		{
			this.windows[i].update();
		}
	}
	
	// clear mouse flags for next frame
	
	OS7.mouse.justPressed = false;
	OS7.mouse.justMoved = false;
	OS7.mouse.justReleased = false;
};

OS7.Desktop.prototype.addIcon = function(iconImage, x, y, windowClass)
{
	var newicon = new OS7.Icon(iconImage, x, y, windowClass);
	this.icons.push(newicon);
	this.addChildAt(newicon, this.iconLayer);
};

OS7.Desktop.prototype.removeIcon = function(iconClass)
{
	var iconPos = this.icons.indexOf(iconClass);
	
	if (iconPos === -1)
	{
		return;
	}
	
	this.removeChild(iconClass);
	this.icons.splice(iconPos,1);
	
	if (iconClass.windowClass)
	{
		this.removeWindow(iconClass.windowClass);
	}
};

OS7.Desktop.prototype.addWindow = function(windowClass)
{
	// we don't need to add the window again if it's already active, just give it focus
	
	if (this.windows.indexOf(windowClass) !== -1)
	{
		this.setActiveWindow(windowClass);
		return;
	}
	
	this.windows.push(windowClass);
	this.addChildAt(windowClass, this.windowLayer);
	this.setActiveWindow(windowClass);
	
	if(windowClass.topMenu)
	{
		this.setActiveTopMenu(windowClass.topMenu);
	}
	else
	{
		// if the user didn't define a topmenu, just create a "File" -> "Exit" menu
		
		var genericFunction = [function(){ OS7.MainDesktop.removeWindow(windowClass); }];
		var genericDropMenu = new OS7.DropMenu(["Exit"], genericFunction);
		var genericTopMenu = new OS7.MenuItem("File", genericDropMenu, 0, null, windowClass);
		windowClass.topMenu = genericTopMenu;
		this.setActiveTopMenu(genericTopMenu);
	}
};

OS7.Desktop.prototype.setActiveWindow = function(windowClass)
{
	// can't set a window to active if it's not on the desktop!
	
	if (this.windows.indexOf(windowClass) === -1)
	{
		return;
	}
	
	this.activeWindow = windowClass;
	windowClass.index = 0;
	
	if (windowClass.topMenu)
	{
		this.setActiveTopMenu(windowClass.topMenu);
	}
};

OS7.Desktop.prototype.removeWindow = function(windowClass)
{
	var windowPos = this.windows.indexOf(windowClass);
	
	if (windowPos !== -1)
	{
		if (this.activeWindow === windowClass)
		{
			this.activeWindow = null;
		}
		
		this.windows.splice(windowPos, 1);
		this.removeChild(windowClass);
		
		if (windowClass.topMenu)
		{
			this.removeTopMenu(windowClass.topMenu);
		}
	}
};

OS7.Desktop.prototype.setActiveTopMenu = function(topMenu)
{
	if (topMenu && topMenu.isOS7Object && topMenu.objectType === "topmenu")
	{
		if(this.activeTopMenu)
		{
			this.activeTopMenu.setActive(false);
		}
		
		this.activeTopMenu = topMenu;
		this.activeTopMenu.setActive(true);
	}
};

OS7.Desktop.prototype.addTopMenuItem = function(menuItem)
{
	// only the active top menu can add items	
	
	if (this.activeTopMenu && this.activeTopMenu.menuItems.indexOf(menuItem) === -1)
	{
		return;
	}
	
	var lastMenuPos = this.topMenuItems.length - 1;
	
	if (lastMenuPos >= 0)
	{
		var lastMenu = this.topMenuItems[lastMenuPos];
		menuItem.x = lastMenu.x + lastMenu.width;
	}
	else
	{
		menuItem.x = 8;
	}
	
	menuItem.y = 1;
	
	this.topMenuItems.push(menuItem);
	this.addChildAt(menuItem, this.menuItemLayer);
	
	if(menuItem.dropMenu)
	{
		this.addDropMenu(menuItem.dropMenu);
	}
};

OS7.Desktop.prototype.removeTopMenuItem = function(menuItem)
{
	var menuPos = this.topMenuItems.indexOf(menuItem);
	
	if (menuPos !== -1)
	{
		this.topMenuItems.splice(menuPos, 1);
		this.removeChild(menuItem);
		
		if (menuItem.dropMenu)
		{
			this.removeDropMenu(menuItem.dropMenu);
		}
	}
};

OS7.Desktop.prototype.addDropMenu = function(dropMenu)
{
	var lastMenuPos = this.topMenuItems.length-1;
	var lastMenu = this.topMenuItems[lastMenuPos];
	
	dropMenu.x = lastMenu.x;
	dropMenu.y = 19;
	
	this.dropMenus.push(dropMenu);
	this.addChildAt(dropMenu, this.menuLayer);
	
	for (var i = 0; i < dropMenu.menuItems.length; i++)
	{
		this.menuItems.push(dropMenu.menuItems[i]);
		this.addChildAt(dropMenu.menuItems[i], this.menuItemLayer);
	}
};

OS7.Desktop.prototype.removeDropMenu = function(dropMenu)
{
	var menuPos = this.dropMenus.indexOf(dropMenu);
	
	if (menuPos !== -1)
	{
		this.dropMenus[menuPos].toggleVisibility(false);
		
		var itemPos = 0;
		
		for (var i = dropMenu.menuItems.length - 1; i >= 0; i--)
		{
			
			itemPos = this.menuItems.indexOf(dropMenu.menuItems[i]);
			
			if (itemPos !== -1)
			{
				this.removeChild(this.menuItems[itemPos]);
				this.menuItems.splice(itemPos,1);
			}
		}
		
		this.dropMenus.splice(menuPos, 1);
		this.removeChild(dropMenu);
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
	
	for (var i = 0; i < this.children.length; i++)
	{
		if (i !== 0)
		{
			returnString += ", ";
		}
		
		returnString += this.children[i].toString();
	}
	
	return "[OS7 Desktop containing " + returnString + "]";
};