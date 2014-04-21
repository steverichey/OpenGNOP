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
	this.window = new OS7.Window(0, 0, this.width, this.height, OS7.Window.MENU);
	this.window.createWindow(OS7.Window.MENU);
	this.window.windowGraphics.visible = true;
	this.window.visible = true;
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