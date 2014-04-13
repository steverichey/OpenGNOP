/*global PIXI*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Desktop = function()
{
	PIXI.Sprite.call(this, PIXI.Texture.fromImage("./assets/images/bg.png"));
	
	this.icons = [];
	this.windows = [];
	this.interactive = true;
	
	this.time = new OS7.Time();
	this.addChild(this.time);
	
	this.addIcon.bind(this);
	this.addWindow.bind(this);
	var settingsWindow = new OS7.Window(40, 40, 200, 300);
	settingsWindow.create = function(){
		console.log("creating");
		settingsWindow.createWindow("bacon");
	};
	
	//this.addIcon("./assets/images/icon_settings.png", 580, 420, settingsWindow);
	this.addIcon("./assets/images/icon_settings.png", 580, 420, settingsWindow);
	this.addWindow(settingsWindow);
	
	this.mousedown = this.touchstart = this.clickAway.bind(this);
};

OS7.Desktop.prototype = Object.create(PIXI.Sprite.prototype);
OS7.Desktop.prototype.constructor = OS7.Desktop;

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
}

OS7.Desktop.prototype.clickAway = function()
{
	for (var i = 0; i < this.icons.length; i++)
	{
		this.icons[i].setInverted(false);
	}
};