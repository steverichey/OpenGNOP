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