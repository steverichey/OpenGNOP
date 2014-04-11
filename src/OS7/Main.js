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
	
};

OS7.Main.preload = function()
{
	this.loader = new PIXI.AssetLoader(["assets/images/chicago.xml"]);
	this.loader.onAssetLoaded = OS7.Main.init;
	this.loader.load();
};

OS7.Main.init = function()
{
    this.stage = new PIXI.Stage(OS7.BG_COLOR, true);
	this.stage.interactive = true;
    
	if ( OS7.forceCanvas )
	{
		this.renderer = new PIXI.CanvasRenderer(OS7.SCREEN_WIDTH, OS7.SCREEN_HEIGHT);
	}
	else
	{
		this.renderer = new PIXI.autoDetectRenderer(OS7.SCREEN_WIDTH, OS7.SCREEN_HEIGHT);
	}
	
	this.renderer.view.style.position = "fixed";
	this.renderer.view.style.width = OS7.SCREEN_WIDTH + "px";
	this.renderer.view.style.height = OS7.SCREEN_HEIGHT + "px";
	this.renderer.view.style.display = "block";
	window.onresize();
	
	document.body.appendChild(this.renderer.view);
    
    this.desktop = new OS7.Desktop(this.stage);
	this.stage.addChild(this.desktop);
    
	window.requestAnimFrame(OS7.Main.update);
};

OS7.Main.update = function()
{
    this.desktop.update();
    this.renderer.render(this.stage);
    window.requestAnimFrame(this.update);
};

OS7.Main.onResize = function()
{
	if (this.renderer)
	{
		if ( ( window.innerWidth < OS7.SCREEN_WIDTH || OS7.forceScaling ) && OS7.allowScaling )
		{
			this.renderer.view.style.width = window.innerWidth + "px";
			this.renderer.view.style.left = "0px";
		}
		else
		{
			this.renderer.view.style.width = OS7.SCREEN_WIDTH + "px";
			this.renderer.view.style.left = ( (  window.innerWidth - OS7.SCREEN_WIDTH ) / 2 ) + "px";
		}
		
		if ( ( window.innerHeight < OS7.SCREEN_HEIGHT || OS7.forceScaling ) && OS7.allowScaling )
		{
			this.renderer.view.style.height = window.innerHeight + "px";
			this.renderer.view.style.top = "0px";
		}
		else
		{
			this.renderer.view.style.height = OS7.SCREEN_HEIGHT + "px";
			this.renderer.view.style.top = ( ( window.innerHeight - OS7.SCREEN_HEIGHT ) / 2 ) + "px";
		}
	}
};