/*global OS7*/
/*global PIXI*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.TopMenu = function(memberItems)
{
	OS7.Basic.call(this, 8, 1);
	this.menuItems = memberItems || [];
	this.objectType = "topmenu";
};

OS7.TopMenu.prototype = Object.create(OS7.Basic.prototype);
OS7.TopMenu.constructor = OS7.TopMenu;

OS7.TopMenu.prototype.setActive = function(status)
{
	for (var i = 0; i < this.menuItems.length; i++)
	{
		if (status)
		{
			OS7.MainDesktop.addTopMenuItem(this.menuItems[i]);
		}
		else
		{
			OS7.MainDesktop.removeTopMenuItem(this.menuItems[i]);
		}
	}
};

OS7.TopMenu.prototype.toString = function()
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
	
	return "[OS7 TopMenu containing " + returnString + "]";
};