/*global Window*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

/**
 * Creates a generic Settings window for configuring global settings.
 */

function Settings(x, y, width, height, stage)
{
    Window.call(this, x, y, width, height, stage);
}

Settings.constructor = Settings;
Settings.prototype = Object.create(Window.prototype);

Settings.prototype.create = function()
{
	this.windowType = "bordered";
	this.createWindow();
	this.addText("OpenGNOP! Settings", this.position.x+16, this.position.y+16);
	var scale = this.addText("Nothing yet!", this.position.x+16, this.position.y+40);
	//var scale = this.addText("Allow Scaling?", this.position.x+16, this.position.y+40);
	//var yes = this.addCheckbox("Yes", scale.x + scale.textWidth + 8, scale.y);
	//this.addCheckbox("No", yes.position.x+32, 40);
	//this.addText("Force Scaling?", this.position.x+16, this.position.y+64);
};