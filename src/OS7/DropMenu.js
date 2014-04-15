/*global PIXI*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.DropMenu = function(dropItems, dropFunctions, x, y)
{
	OS7.Basic.call(this, x, y);
	
	this.width = 0;
	this.menuItems = [];
	this.dropFunctions = dropFunctions;
	
	for (var i = 0; i < dropItems.length; i++)
	{
		var widthText = new OS7.Text(dropItems[i],0,0);
		
		if (widthText.textWidth > this.width)
		{
			this.width = widthText.textWidth;
		}
	}
	
	this.width += 27;
	this.height = 16 * dropItems.length + 3;
	
	this.window = new OS7.Window(0, 0, this.width, this.height);
	this.window.createWindow("menu");
	this.addChild(this.window);
	
	for (var o = 0; o < dropItems.length; o++)
	{
		var newItem = new OS7.MenuItem(dropItems[o], 1, o*16+1, null, this.width - 3);
		this.addChild(newItem);
		this.menuItems.push(newItem);
	}
};

OS7.DropMenu.prototype = Object.create(OS7.Basic.prototype);
OS7.DropMenu.prototype.constructor = OS7.DropMenu;