/*global PIXI*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Desktop.width = 0;
OS7.Desktop.height = 0;

OS7.Desktop = function(stage)
{
	PIXI.Sprite.call(this, PIXI.Texture.fromImage("./images/bg.png"));
	
	this.icons = [];
	this.interactive = true;
	this.stage = stage;
	this.time = new OS7.Time();
	this.stage.addChild(this.time);
	this.self = this;
	
	OS7.Desktop.width = this.stage.width;
	OS7.Desktop.height = this.stage.height;
	
	this.addIcon("./images/icon_settings.png", 580, 420);
	
	this.mousedown = this.touchstart = this.clickAway;
};

OS7.Desktop.prototype = Object.create( PIXI.Sprite.prototype );
OS7.Desktop.prototype.constructor = OS7.Desktop;

OS7.Desktop.prototype.clickAway = function()
{
	for ( var i = 0; i < this.icons.length; i++ )
	{
		this.icons[i].setInverted(false);
	}
};

OS7.Desktop.prototype.addIcon = function(iconImage, x, y)
{
	var newicon = new OS7.Icon( iconImage, x, y, new OS7.Settings( 70, 95, 500, 310, this.stage ) );
	this.icons.push( newicon );
	this.stage.addChild( newicon );
};