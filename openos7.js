/**
 * OpenGNOP! - v0.1.0
 * Copyright (c) 2014, Steve Richey
 *
 * Compiled: 2014-04-21
 *
 * OpenGNOP! is licensed under the MIT License.
 * 
 *//*global window*/
/*global document*/
/*global PIXI*/
/*global requestAnimFrame*/
/*global Desktop*/

/**
 * OpenOS7, pure HTML5 OS7 remake.
 *
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 * Requires PixiJS, structure heavily influenced by PixiJS.
 * Currently only required for OpenGNOP! but may be used in the future for other Bungie remakes.
 */

/**
 * @module OS7
 */
var OS7 = OS7 || {};

/**
 * @class Consts
 */
OS7.VERSION_NUMBER = "0.1.0";
OS7.SCREEN_WIDTH = 640;
OS7.SCREEN_HEIGHT = 480;
OS7.BG_COLOR = 0x000000;

OS7.Colors = {};
OS7.Colors.BLACK = 0x000000;
OS7.Colors.ALMOST_BLACK = 0x010101;
OS7.Colors.BLUE_LIGHT = 0xCCCCFF;
OS7.Colors.GREY = 0xBBBBBB;
OS7.Colors.GREY_LIGHT = 0x888888;
OS7.Colors.BG_GREY_LIGHT = 0xAAAAAA;
OS7.Colors.BG_GREY_DARK = 0x666666;
OS7.Colors.BLUE_DARK = 0x666699;
OS7.Colors.WHITE = 0xFFFFFF;

OS7.forceScaling = false;
OS7.allowScaling = true;
OS7.forceCanvas = false;
OS7.showHitBoxes = false;
OS7.isWebkit = false;

OS7.mouse = new PIXI.Point(0,0);
OS7.mouse.justPressed = false;
OS7.mouse.justMoved = false;
OS7.mouse.justReleased = false;
OS7.mouse.pressed = false;

// Override this to load your code

OS7.onLoad = null;

OS7.collide = function(pointX, pointY, basic)
{
	if(basic.visible)
	{
		if (basic.global.x && basic.width && pointX < basic.global.x + basic.width)
		{
			if (basic.global.y && basic.height && pointY < basic.global.y + basic.height)
			{
				if (pointX > basic.global.x)
				{
					if (pointY > basic.global.y)
					{
						return true;
					}
				}
			}
		}
	}
	
	return false;
};
/*global window*/
/*global document*/
/*global PIXI*/
/*global Desktop*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Main = function() { };
OS7.Main.loader = {};
OS7.Main.stage = {};
OS7.Main.renderer = {};
OS7.Main.desktop = {};
OS7.Main.desktop = {};

OS7.Main.preload = function()
{
	OS7.Main.loader = new PIXI.AssetLoader(["assets/images/chicago.xml"]);
	OS7.Main.loader.onAssetLoaded = OS7.Main.init;
	OS7.Main.loader.load();
};

OS7.Main.init = function()
{
	if (typeof process !== "undefined")
	{
		OS7.isWebkit = true;
	}
	
    OS7.Main.stage = new PIXI.Stage(OS7.BG_COLOR, true);
	OS7.Main.stage.interactive = true;
    
	if ( OS7.forceCanvas )
	{
		OS7.Main.renderer = new PIXI.CanvasRenderer(OS7.SCREEN_WIDTH, OS7.SCREEN_HEIGHT);
	}
	else
	{
		OS7.Main.renderer = new PIXI.autoDetectRenderer(OS7.SCREEN_WIDTH, OS7.SCREEN_HEIGHT);
	}
	
	OS7.Main.renderer.view.style.position = "fixed";
	OS7.Main.renderer.view.style.width = OS7.SCREEN_WIDTH + "px";
	OS7.Main.renderer.view.style.height = OS7.SCREEN_HEIGHT + "px";
	OS7.Main.renderer.view.style.display = "block";
	window.onresize();
	
	document.body.appendChild(OS7.Main.renderer.view);
    
    OS7.Main.desktop = new OS7.Desktop();
	OS7.Main.stage.addChild(OS7.Main.desktop);
	
	if (OS7.onLoad && typeof OS7.onLoad === "function")
	{
		OS7.onLoad();
	}
    
	window.requestAnimFrame(OS7.Main.update);
};

OS7.Main.update = function()
{
	if (OS7.Main.desktop && OS7.Main.desktop.update)
	{
		OS7.Main.desktop.update();
	}
	
	if (OS7.Main.renderer)
	{
		OS7.Main.renderer.render(OS7.Main.stage);
	}
	
    window.requestAnimFrame(OS7.Main.update);
};

OS7.Main.onResize = function()
{
	if (OS7.Main.renderer)
	{
		if ( ( window.innerWidth < OS7.SCREEN_WIDTH || OS7.forceScaling ) && OS7.allowScaling )
		{
			OS7.Main.renderer.view.style.width = window.innerWidth + "px";
			OS7.Main.renderer.view.style.left = "0px";
		}
		else
		{
			OS7.Main.renderer.view.style.width = OS7.SCREEN_WIDTH + "px";
			OS7.Main.renderer.view.style.left = ( (  window.innerWidth - OS7.SCREEN_WIDTH ) / 2 ) + "px";
		}
		
		if ( ( window.innerHeight < OS7.SCREEN_HEIGHT || OS7.forceScaling ) && OS7.allowScaling )
		{
			OS7.Main.renderer.view.style.height = window.innerHeight + "px";
			OS7.Main.renderer.view.style.top = "0px";
		}
		else
		{
			OS7.Main.renderer.view.style.height = OS7.SCREEN_HEIGHT + "px";
			OS7.Main.renderer.view.style.top = ( ( window.innerHeight - OS7.SCREEN_HEIGHT ) / 2 ) + "px";
		}
	}
};

window.onload = OS7.Main.preload;
window.onresize = OS7.Main.onResize;
/*global PIXI*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

/**
 * A basic object class. Almost everything in OpenOS7 extends this.
 */
OS7.Basic = function(x, y, width, height)
{
	PIXI.DisplayObjectContainer.call(this);
	
	this.position.x = x || 0;
	this.position.y = y || 0;
	this.width = width || 0;
	this.height = height || 0;
	this.interactive = false; // not needed as desktop sends click/release events
	this.showHitArea = false;
	this.worldPoint = new PIXI.Point(0,0);
	this.objectType = "basic";
	this.mouseOver = false;
	this.isOS7Object = true; // just a really easy way to know
	this.updateHitArea.bind(this);
	this.updateHitArea();
	
	this.onClick.bind(this);
	this.onOver.bind(this);
	this.onOut.bind(this);
	this.onRelease.bind(this);
};

OS7.Basic.prototype = Object.create(PIXI.DisplayObjectContainer.prototype);
OS7.Basic.prototype.constructor = OS7.Basic;

OS7.Basic.mouseOver = false;

OS7.Basic.prototype.onClick = function(){};
OS7.Basic.prototype.onOver = function(){};
OS7.Basic.prototype.onMove = function(){};
OS7.Basic.prototype.onOut = function(){};
OS7.Basic.prototype.onRelease = function(){};

OS7.Basic.prototype.updateHitArea = function()
{
	if (OS7.showHitBoxes || this.showHitArea)
	{
		if (this.hitRect)
		{
			this.removeChild(this.hitRect);
			this.hitRect.clear();
		}
		else
		{
			this.hitRect = new PIXI.Graphics();
		}
		
		this.hitRect.fillAlpha = 0.1;
		this.hitRect.lineStyle(1,0xFF0000,0.5);
		this.hitRect.beginFill(0x0000FF);
		this.hitRect.drawRect(-1,-1,this.width+2,this.height+2);
		this.hitRect.endFill();
		this.addChild(this.hitRect);
	}
	
	if (this.hitArea)
	{
		this.hitArea.x = 0;
		this.hitArea.y = 0;
		this.hitArea.width = this.width;
		this.hitArea.height = this.height;
	}
	else
	{
		this.hitArea = new PIXI.Rectangle(0, 0, this.width, this.height);
	}
};

OS7.Basic.prototype.toString = function()
{
	return "[OS7 Basic]";
};

Object.defineProperty(OS7.Basic.prototype, 'global', {
	get: function() {
		this.worldPoint.x = this.worldTransform.tx;
		this.worldPoint.y = this.worldTransform.ty;
		return this.worldPoint;
	}
});
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
	this.topMenus = [];
	this.dropMenus = [];
	this.menuItems = [];
	this.clearFlag = false;
	this.objectType = "desktop";
	this.headerActive = false;
	this.activeTopMenu = null;
	this.activeWindow = null;
	
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
		optionsDrop = new OS7.DropMenu(["Settings...", "About", "Quit"], optionsFunctions);
	}
	else
	{
		optionsDrop = new OS7.DropMenu(["Settings...", "About"], optionsFunctions);
	}
	
	var optionsMenu = new OS7.MenuItem(OS7.MenuItem.SEPTAGON, optionsDrop);
	this.addTopMenu(optionsMenu);
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
		
		for (i = 0; i < this.topMenus.length; i++)
		{
			this.topMenus[i].invert(true);
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
	this.addChild(newicon);
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
}

OS7.Desktop.prototype.addWindow = function(windowClass)
{
	// we don't need to add the window again if it's already active, just give it focus
	
	if (this.windows.indexOf(windowClass) !== -1)
	{
		this.setActiveWindow(windowClass);
		return;
	}
	
	this.windows.push(windowClass);
	this.addChild(windowClass);
	this.setActiveWindow(windowClass);
	
	if(windowClass.topMenu)
	{
		this.addTopMenu(windowClass.topMenu);
	}
	else
	{
		// if the user didn't define a topmenu, just create a "File" -> "Exit" menu
		
		var genericFunction = [function(){ OS7.MainDesktop.removeWindow(windowClass); }];
		var genericDropMenu = new OS7.DropMenu(["Exit"], genericFunction);
		var genericTopMenu = new OS7.MenuItem("File", genericDropMenu, 0, null, windowClass);
		windowClass.topMenu = genericTopMenu;
		this.addTopMenu(genericTopMenu);
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

OS7.Desktop.prototype.addTopMenu = function(menuItem)
{
	var lastMenuPos = this.topMenus.length-1;
	
	if (lastMenuPos >= 0)
	{
		var lastMenu = this.topMenus[lastMenuPos];
		menuItem.x = lastMenu.x + lastMenu.width;
	}
	else
	{
		menuItem.x = 8;
	}
	
	menuItem.y = 1;
	
	this.topMenus.push(menuItem);
	this.addChild(menuItem);
	
	if(menuItem.dropMenu)
	{
		this.addDropMenu(menuItem.dropMenu);
	}
};

OS7.Desktop.prototype.setActiveTopMenu = function(topMenu)
{
	if (this.topMenus)
	{
		// TODO
	}
};

OS7.Desktop.prototype.removeTopMenu = function(topMenu)
{
	var menuPos = this.topMenus.indexOf(topMenu);
	
	if (menuPos !== -1)
	{
		this.topMenus.splice(menuPos, 1);
		this.removeChild(topMenu);
		
		if (topMenu.dropMenu)
		{
			this.removeDropMenu(topMenu.dropMenu);
		}
	}
};

OS7.Desktop.prototype.addDropMenu = function(dropMenu)
{
	var lastMenuPos = this.topMenus.length-1;
	var lastMenu = this.topMenus[lastMenuPos];
	
	dropMenu.x = lastMenu.x;
	dropMenu.y = 19;
	
	this.dropMenus.push(dropMenu);
	this.addChild(dropMenu);
	
	for (var i = 0; i < dropMenu.menuItems.length; i++)
	{
		this.menuItems.push(dropMenu.menuItems[i]);
		this.addChild(dropMenu.menuItems[i]);
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
/*global OS7*/
/*global PIXI*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Text = function(string, x, y)
{
	PIXI.BitmapText.call(this, string, {font:"12px Chicago", tint:OS7.Colors.ALMOST_BLACK});
	this.position.x = x || 0;
	this.position.y = y || 0;
	this.interactive = false;
	this.wordWrap = false; //TODO implement wordwrap
	this.objectType = "text";
};

OS7.Text.prototype = Object.create(PIXI.BitmapText.prototype);
OS7.Text.prototype.constructor = OS7.Text;

OS7.Text.prototype.toString = function()
{
	return "[OS7 Text " + this.text + "]";
};
/*global OS7*/
/*global window*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Time = function()
{
	OS7.Text.call(this, "", 571, 5);
	this.updateTime();
    window.setInterval(this.updateTime.bind(this), 1000);
};

OS7.Time.prototype = Object.create(OS7.Text.prototype);
OS7.Time.prototype.constructor = OS7.Time;

OS7.Time.prototype.updateTime = function()
{
	this.prevText = this.text;
	this.date = new Date();
    this.hour = this.date.getHours();
    this.minute = this.date.getMinutes();
	this.zero = "";
	this.ampm = "AM";
    
    if ( this.hour > 12 )
    {
        this.hour -= 12;
		this.ampm = "PM";
    }
    
    if ( this.hour === 0 )
    {
        this.hour = 12;
    }
    
    if ( this.minute < 10 )
    {
        this.zero = "0";
    }
    
    this.setText( this.hour + ":" + this.zero + this.minute + " " + this.ampm );
	
	if ( this.prevText !== this.text )
	{
		this.updateText();
		this.position.x = 571 - this.textWidth;
	}
};
/*global OS7*/
/*global PIXI*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Icon = function(textureString, x, y, windowClass)
{
	OS7.Basic.call(this, x, y);
	
	this.dragging = false;
	this.offset = new PIXI.Point();
	this.offset.x = 0;
	this.offset.y = 0;
	this.objectType = "icon";
	this.inverted = false;
	this.clickTime = -OS7.Icon.MIN_CLICK_TIME;
	this.invertFilter = new PIXI.InvertFilter();
	this.windowClass = windowClass;
	
	this.image = new PIXI.Sprite.fromImage(textureString);
	this.addChild(this.image);
	this.width = 43;
	this.height = 42;
	this.updateHitArea();
};

OS7.Icon.prototype = Object.create(OS7.Basic.prototype);
OS7.Icon.prototype.constructor = OS7.Icon;

OS7.Icon.MIN_CLICK_TIME = 750;

OS7.Icon.prototype.onClick = function()
{
	this.setInverted(true);
	this.offset.x = OS7.mouse.x - this.position.x;
	this.offset.y = OS7.mouse.y - this.position.y;
	this.dragging = true;
};

OS7.Icon.prototype.onMove = function()
{
	if (this.dragging)
	{
		this.position.x = OS7.mouse.x - this.offset.x;
		this.position.y = OS7.mouse.y - this.offset.y;
		
		if (this.position.y < 20)
		{
			this.position.y = 20;
		}
		
		if (this.position.x < 0)
		{
			this.position.x = 0;
		}
		
		if (this.position.x > OS7.SCREEN_WIDTH - this.width)
		{
			this.position.x = OS7.SCREEN_WIDTH - this.width;
		}
		
		if (this.position.y > OS7.SCREEN_HEIGHT - this.height)
		{
			this.position.y = OS7.SCREEN_HEIGHT - this.height;
		}
	}
};

OS7.Icon.prototype.onRelease = function()
{
	if (this.dragging)
	{
		this.dragging = false;
		var rightnow = new Date().getTime();
		
		if (rightnow - this.clickTime < OS7.Icon.MIN_CLICK_TIME)
		{
			if (this.windowClass)
			{
				this.windowClass.create();
			}
		}
		else
		{
			this.clickTime = rightnow;
		}
	}
};

OS7.Icon.prototype.setInverted = function(status)
{
	if (status)
	{
		this.filters = [this.invertFilter];
		this.inverted = true;
	}
	else
	{
		this.filters = null;
		this.inverted = false;
	}
};

OS7.Icon.prototype.toString = function()
{
	return "[OS7 Icon]";
};
/*global PIXI*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */
 
OS7.Window = function(x, y, width, height, windowType, topMenu)
{
	OS7.Basic.call(this, x, y, width, height);
	
	this.windowObjects = [];
	this.windowType = windowType || "bordered";
	this.topMenu = topMenu;
	this.objectType = "window";
	this.createWindow.bind(this);
	this.addText.bind(this);
};

OS7.Window.prototype = Object.create(OS7.Basic.prototype);
OS7.Window.prototype.constructor = OS7.Window;

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
	
	for (var i = 0; i < this.windowObjects.length; i++)
	{
		this.addChild(this.windowObjects[i]);
	}
};

OS7.Window.prototype.destroy = function() {};

OS7.Window.prototype.createWindow = function(windowType)
{
	this.windowGraphics = new PIXI.Graphics();

	if ( windowType === "shadow" )
	{
		OS7.Window.fillRect(this.windowGraphics, 2, 2, this.width-2, this.height-2, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.windowGraphics, 0, 0, this.width-2, this.height-2, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.windowGraphics, 1, 1, this.width-4, this.height-4, OS7.Colors.WHITE);
	}
	else if ( windowType === "menu" )
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
	
	if (text.textWidth > this.width)
	{
		text.wordWrap = true;
		text.width = this.width;
	}
	
	this.windowObjects.push(text);
};

OS7.Window.prototype.toString = function()
{
	return "[OS7 Window]";
};
/*global OS7*/
/*global PIXI*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */
 
OS7.SettingsWindow = function()
{
	OS7.Window.call(this, 40, 40, 400, 400, "shadow");
	this.addText("Coming soon!", 20, 20);
};

OS7.SettingsWindow.prototype = Object.create(OS7.Window.prototype);
OS7.SettingsWindow.prototype.constructor = OS7.SettingsWindow;
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
/*global PIXI*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

/**
 * A DropMenu is just a container for a group of MenuItems, with a Window background.
 * 
 * @class	DropMenu
 * @extends	Basic
 * @constructor
 * @param	dropItems {Array}		An array of text strings describing what each MenuItem will read.
 * @param 	dropFunctions {Array}	An array of functions called by each MenuItem.
 */

OS7.DropMenu = function(dropItems, dropFunctions)
{
	this.width = 0;
	this.menuItems = [];
	var widthText;
	
	for (var i = 0; i < dropItems.length; i++)
	{
		widthText = new OS7.Text(dropItems[i],0,0);
		
		if (widthText.textWidth > this.width)
		{
			this.width = widthText.textWidth;
		}
	}
	
	this.width += 27;
	this.height = 16 * dropItems.length + 3;
	
	OS7.Basic.call(this, 0, 19, this.width, this.height);
	
	this.visible = false;
	this.objectType = "dropmenu";
	this.window = new OS7.Window(0, 0, this.width, this.height);
	this.window.createWindow("menu");
	this.addChild(this.window);
	this.toggleVisibility.bind(this);
	
	for (var o = 0; o < dropItems.length; o++)
	{
		var newItem = new OS7.MenuItem(dropItems[o], null, this.width - 3, dropFunctions[o]);
		newItem.x = this.x + 1;
		newItem.y = this.y + o * 16 + 1;
		newItem.visible = false;
		//this.addChild(newItem); // don't need to add it here, as it's added to the desktop later
		this.menuItems.push(newItem);
	}
};

OS7.DropMenu.prototype = Object.create(OS7.Basic.prototype);
OS7.DropMenu.prototype.constructor = OS7.DropMenu;

Object.defineProperty(OS7.DropMenu.prototype, 'x', {
    get: function() {
        return this.window.x;
    },
    set: function(value) {
        this.window.x = value;
		
		for (var i = 0; i < this.menuItems.length; i++)
		{
			this.menuItems[i].x = value + 1;
		}
    }
});

OS7.DropMenu.prototype.clear = function()
{
	for (var i = 0; i < this.menuItems.length; i++)
	{
		this.menuItems[i].invert(true);
	}
	
	this.visible = false;
};

OS7.DropMenu.prototype.toggleVisibility = function(forceTo)
{
	if (typeof forceTo === "boolean")
	{
		this.visible = forceTo;
	}
	else
	{
		this.visible = !this.visible;
	}
	
	for (var i = 0; i < this.menuItems.length; i++)
	{
		this.menuItems[i].invert(true);
		this.menuItems[i].visible = this.visible;
	}
};

OS7.DropMenu.prototype.toString = function()
{
	var returnString = "";
	
	for (var i = 0; i < this.menuItems.length; i++)
	{
		if (i !== 0)
		{
			returnString += ", ";
		}
		
		returnString += this.menuItems[i].toString();
	}
	
	return "[OS7 DropMenu containing " + returnString + "]";
};