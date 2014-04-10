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