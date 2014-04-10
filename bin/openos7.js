/**
 * OpenGNOP! - v0.1.0
 * Copyright (c) 2014, Steve Richey
 *
 * Compiled: 2014-04-10
 *
 * OpenGNOP! is licensed under the MIT License.
 * 
 *//**
 * @author Mat Groves http://matgroves.com/ @Doormat23
 */

// This is "borrowed" from PixiJS, it's used by Grunt.

(function()
{

    var root = this;
/*global window*/
/*global document*/
/*global PIXI*/
/*global requestAnimFrame*/
/*global Desktop*/

/**
 * OpenOS7, pure HTML5 OS7 remake.
 *
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 * Requires PixiJS, structure heavily influenced by PixiJS.
 */

/**
 * @module OS7
 */
var OS7 = OS7 || {};

/**
 * @class Consts
 */
OS7.FORCE_SCALING_ON = 0;
OS7.FORCE_SCALING_OFF = 1;
OS7.ALLOW_SCALING_ON = 2;
OS7.ALLOW_SCALING_OFF = 3;
OS7.VERSION_NUMBER = "1.0";

console.log("hey");
/*global window*/
/*global document*/
/*global PIXI*/
/*global Desktop*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Main = function()
{
	this.gameCanvas = document.getElementById("game-canvas");
	this.width = 640;
	this.height = 480;
	this.bgColor = 0xFFFFFF;
	this.forceScaling = false;
	this.allowScaling = true;
	this.forceCanvas = false;
};

OS7.Main.preload = function()
{
	this.loader = new PIXI.AssetLoader(["images/chicago.xml"]);
	this.loader.onAssetLoaded = this.init;
	this.loader.load();
};

OS7.Main.init = function()
{
    this.stage = new PIXI.Stage(this.bgColor,true);
	this.stage.interactive = true;
    
	if ( this.forceCanvas )
	{
		this.renderer = new PIXI.CanvasRenderer(this.width, this.height);
	}
	else
	{
		this.renderer = new PIXI.autoDetectRenderer(this.width, this.height);
	}
	
	this.renderer.view.style.position = "fixed";
	this.renderer.view.style.width = this.width + "px";
	this.renderer.view.style.height = this.height + "px";
	this.renderer.view.style.display = "block";
	window.onresize();
	
	document.body.appendChild(this.renderer.view);
    
    this.desktop = new Desktop(this.stage);
    
	window.requestAnimFrame(this.update);
};

OS7.Main.update = function()
{
    this.desktop.update();
    this.renderer.render( this.stage );
    window.requestAnimFrame(this.update);
};

OS7.Main.onResize = function()
{
	if (this.renderer)
	{
		if ( ( window.innerWidth < this.width || this.forceScaling ) && this.allowScaling )
		{
			this.renderer.view.style.width = window.innerWidth + "px";
			this.renderer.view.style.left = "0px";
		}
		else
		{
			this.renderer.view.style.width = this.width + "px";
			this.renderer.view.style.left = ( (  window.innerWidth - this.width ) / 2 ) + "px";
		}
		
		if ( ( window.innerHeight < this.height || this.forceScaling ) && this.allowScaling )
		{
			this.renderer.view.style.height = window.innerHeight + "px";
			this.renderer.view.style.top = "0px";
		}
		else
		{
			this.renderer.view.style.height = this.height + "px";
			this.renderer.view.style.top = ( ( window.innerHeight - this.height ) / 2 ) + "px";
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
/*global PIXI*/
/*global OS7*/
/*global Text*/
/*global Checkbox*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Window = function(x, y, width, height)
{
    PIXI.Sprite.call( this, new PIXI.Texture.fromImage("") );
	
	this.position.x = x;
	this.position.y = y;
	this.windowWidth = width;
	this.windowHeight = height;
	this.windowType = "bordered";
	this.texts = [];
};

OS7.Window.constructor = OS7.Window;
OS7.Window.prototype = Object.create(PIXI.Sprite.prototype);

OS7.Window.prototype.create = function()
{
	// override this to build your window
};

OS7.Window.prototype.destroy = function()
{
	// override this to remove your window
};

OS7.Window.prototype.createWindow = function()
{
	this.graphics = new PIXI.Graphics();
	
	if ( this.windowType === "shadow" )
	{
		OS7.Window.fillRect(this.graphics, this.position.x+2, this.position.y+2, this.windowWidth-2, this.windowHeight-2, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.graphics, this.position.x, this.position.y, this.windowWidth-2, this.windowHeight-2, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.graphics, this.position.x+1, this.position.y+1, this.windowWidth-4, this.windowHeight-4, OS7.Colors.WHITE);
	}
	else if ( this.windowType === "menu" )
	{
		OS7.Window.fillRect(this.graphics, this.position.x+3, this.position.y+3, this.windowWidth-3, this.windowHeight-3, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.graphics, this.position.x, this.position.y, this.windowWidth-1, this.windowHeight-1, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.graphics, this.position.x+1, this.position.y+1, this.windowWidth-3, this.windowHeight-3, OS7.Colors.WHITE);
	}
	else // bordered
	{
		OS7.Window.fillRect(this.graphics, this.position.x, this.position.y, this.windowWidth, this.windowHeight, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.graphics, this.position.x, this.position.y, this.windowWidth, this.windowHeight, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.graphics, this.position.x+1, this.position.y+1, this.windowWidth-2, this.windowHeight-2, OS7.Colors.BLUE_DARK);
		OS7.Window.fillRect(this.graphics, this.position.x+1, this.position.y+1, this.windowWidth-3, this.windowHeight-3, OS7.Colors.BLUE_LIGHT);
		OS7.Window.fillRect(this.graphics, this.position.x+2, this.position.y+2, this.windowWidth-4, this.windowHeight-4, OS7.Colors.GREY);
		OS7.Window.fillRect(this.graphics, this.position.x+3, this.position.y+3, this.windowWidth-6, this.windowHeight-6, OS7.Colors.BLUE_DARK);
		OS7.Window.fillRect(this.graphics, this.position.x+4, this.position.y+4, this.windowWidth-7, this.windowHeight-7, OS7.Colors.BLUE_LIGHT);
		OS7.Window.fillRect(this.graphics, this.position.x+4, this.position.y+4, this.windowWidth-8, this.windowHeight-8, OS7.Colors.BLACK);
		OS7.Window.fillRect(this.graphics, this.position.x+5, this.position.y+5, this.windowWidth-10, this.windowHeight-10, OS7.Colors.WHITE);
	}
	
	this.stage.addChild(this.graphics);
};

OS7.Window.prototype.addText = function(string, x, y)
{
	var text = new Text(string, x, y);
	this.texts.push(text);
	this.stage.addChild( text );
	
	return text;
};

OS7.Window.prototype.addCheckbox = function(string, x, y)
{
	var text = this.addText(string, x, y);
	var checkbox = new Checkbox(text.x+text.textWidth+8, text.y);
	this.checkboxes.push(checkbox);
	this.stage.addChild(checkbox);
};

/**
 * Function to fill a graphics object.
 */
OS7.Window.fillRect = function(target, x, y, width, height, color)
{
	target.beginFill(color);
	target.drawRect(x, y, width, height);
	target.endFill();
};
/*global PIXI*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Text = function(string, x, y)
{
    PIXI.BitmapText.call(this, string, {font:"12px Chicago"});
    this.position.x = x;
    this.position.y = y;
};

OS7.Text.constructor = OS7.Text;
OS7.Text.prototype = Object.create(PIXI.BitmapText.prototype);
/*global PIXI*/
/*global OS7*/
/*global Text*/
/*global window*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Time.X_POSITION = 571;
OS7.Time.Y_POSITION = 5;

OS7.Time = function()
{
	Text.call(this, "", OS7.Time.X_POSITION, OS7.Time.Y_POSITION);
	
    this.updateTime();
    window.setInterval(this.updateTime, 1000);
};

OS7.Time.constructor = OS7.Time;
OS7.Time.prototype = Object.create(OS7.Text.prototype);

OS7.Time.prototype.updateTime = function()
{
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
    this.updateText();
    this.position.x = OS7.Time.X_POSITION - this.textWidth;
};
/*global PIXI*/
/*global OS7*/
/*global Date*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Icon.MIN_CLICK_TIME = 750;

OS7.Icon = function(iconImage, x, y, windowClass)
{
    PIXI.Sprite.call( this, PIXI.Texture.fromImage(iconImage) );
	
	this.dragging = false;
	this.offsetX = 0;
	this.offsetY = 0;
	this.inverted = false;
	this.clickTime = -OS7.Icon.MIN_CLICK_TIME;
	
	this.invertFilter = new PIXI.InvertFilter();
	
    this.position.x = x;
    this.position.y = y;
	this.windowClass = windowClass;
    
    this.interactive = true;
	
	this.mousedown = this.touchstart = this.onClick;
	this.mousemove = this.touchmove = this.onMove;
	this.mouseup = this.touchend = this.mouseupoutside = this.touchendoutside = this.onRelease;
};

OS7.Icon.prototype = Object.create(PIXI.Sprite.prototype);
OS7.Icon.constructor = OS7.Icon;

OS7.Icon.prototype.onClick = function(data)
{
	this.setInverted( true );
	this.offsetX = data.global.x - this.position.x;
	this.offsetY = data.global.y - this.position.y;
	this.dragging = true;
};

OS7.Icon.prototype.onMove = function(data)
{
	if ( this.dragging )
	{
		this.position.x = data.global.x - this.offsetX;
		this.position.y = data.global.y - this.offsetY;

		if ( this.position.y < 20 )
		{
			this.position.y = 20;
		}

		if ( this.position.x < 0 )
		{
			this.position.x = 0;
		}

		if ( this.position.x > OS7.Desktop.width - this.width )
		{
			this.position.x = OS7.Desktop.width - this.width;
		}

		if ( this.position.y > OS7.Desktop.height - this.height )
		{
			this.position.y = OS7.Desktop.height - this.height;
		}
	}
};

OS7.Icon.prototype.onRelease = function(data)
{
	if ( this.dragging )
	{
		this.dragging = false;
		var rightnow = new Date().getTime();
		
		if ( rightnow - this.clickTime < OS7.Icon.MIN_CLICK_TIME )
		{
			this.windowClass.create();
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
		this.filters = [ this.invertFilter ];
		this.inverted = true;
	}
	else
	{
		this.filters = null;
		this.inverted = false;
	}
};
/*global Window*/

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
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Colors.BLACK = 0x000000;
OS7.Colors.BLUE_LIGHT = 0xCCCCFF;
OS7.Colors.GREY = 0xBBBBBB;
OS7.Colors.BLUE_DARK = 0x666699;
OS7.Colors.WHITE = 0xFFFFFF;
/*global PIXI*/

function Checkbox(x, y)
{
    PIXI.Graphics.call(this);
	
    this.position.x = x;
    this.position.y = y;
	
	this.beginFill(0xFFFFFF);
	this.lineStyle(1, 0x000000);
	this.drawRect(this.position.x, this.position.y, 10, 10);
	this.endFill();
}

Checkbox.constructor = Checkbox;
Checkbox.prototype = Object.create(PIXI.Graphics.prototype);
/**
 * @author Mat Groves http://matgroves.com/ @Doormat23
 */

// Just like Header, this is borrowed from PixiJS.

    if (typeof exports !== 'undefined') {
        if (typeof module !== 'undefined' && module.exports) {
            exports = module.exports = OS7;
        }
        exports.OS7 = OS7;
    } else if (typeof define !== 'undefined' && define.amd) {
        define(OS7);
    } else {
        root.OS7 = OS7;
    }
}).call(this);