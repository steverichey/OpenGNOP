/*global PIXI*/
/*global Text*/
/*global Time*/
/*global Icon*/
/*global console*/
/*global Window*/
/*global Settings*/

var time;
var icons = [];
var stage;

function Desktop(stage)
{
	PIXI.Sprite.call( this, PIXI.Texture.fromImage("./images/bg.png") );
	stage.addChild( this );
	
	this.setInteractive(true);
	this.stage = stage;
	
    time = new Time();
    stage.addChild( time );
	
	var self = this;
    
	//this.addIcon( "./images/icon_settings.png", 580, 420, new Settings() );
	this.addIcon( "./images/icon_settings.png", 580, 420 );
	
	this.mousedown = this.touchstart = function()
	{
		for ( var i = 0; i < icons.length; i++ )
		{
			icons[i].setInverted(false);
		}
	};
}

Desktop.constructor = Desktop;
Desktop.prototype = Object.create(PIXI.Sprite.prototype);

Desktop.prototype.update = function()
{
	// do stuff
};

Desktop.prototype.addIcon = function( iconImage, x, y )
{
	var newicon = new Icon( iconImage, x, y, new Settings( 60, 60, 600, 400, this.stage ) );
	icons.push( newicon );
	stage.addChild( newicon );
};