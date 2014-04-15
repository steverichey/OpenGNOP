/*global PIXI*/
/*global OS7*/
/*global window*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Desktop = function()
{
	OS7.Basic.call(this, 0, 0);
	
	OS7.MainDesktop = this;
	this.icons = [];
	this.windows = [];
	this.headerMenus = [];
	this.dropMenus = [];
	this.interactive = true;
	
	//this.bg = this.createBackground();
	//this.bg.interactive = true;
	//this.addChild(this.bg);
	
	this.bg = new OS7.Basic(0,0);
	this.bg.addChild(this.createBackground());
	this.addChild(this.bg);
	this.bg.onClick = this.clickAway.bind(this);
	
	this.headerIcons = new PIXI.Sprite.fromImage("./assets/images/header_icons.png");
	this.headerIcons.position.x = 580;
	this.headerIcons.position.y = 2;
	this.addChild(this.headerIcons);
	
	this.time = new OS7.Time();
	this.addChild(this.time);
	
	this.addIcon.bind(this);
	this.addWindow.bind(this);
	this.addTopMenu.bind(this);
	this.addDropMenu.bind(this);
	
	var optionsFunctions = [
		function(){
			this.addWindow(settingsWindow);
		},
		function(){
			window.close();
		}
	];
	
	var optionsDrop = new OS7.DropMenu(["Settings...", "Quit"], optionsFunctions, 0, 0);
	var optionsMenu = new OS7.MenuItem(OS7.MenuItem.SEPTAGON, 8, 1, optionsDrop);
	this.addTopMenu(optionsMenu);
	
	this.bg.mousedown = function(data) {
		console.log("super clickk");
	};
	//this.bg.mousedown = this.bg.touchstart = this.clickAway.bind(this);
	//this.mousedown = this.touchstart = this.clickAway.bind(this);
};

OS7.Desktop.prototype = Object.create(OS7.Basic.prototype);
OS7.Desktop.prototype.constructor = OS7.Desktop;
OS7.MainDesktop = {};

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

OS7.Desktop.prototype.clickAway = function()
{
	console.log("clicked away");
	
	for (var i = 0; i < this.icons.length; i++)
	{
		this.icons[i].setInverted(false);
	}
	
	for (var o = 0; o < this.headerMenus.length; o++)
	{
		this.headerMenus[i].invert(true);
	}
	
	for (var q = 0; q < this.dropMenus.length; q++)
	{
		this.dropMenus[q].visible = false;
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