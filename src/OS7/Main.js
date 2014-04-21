/*global window*/
/*global document*/
/*global PIXI*/
/*global Desktop*/
/*global OS7*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Main = function() { };
OS7.Main.loader = {};
OS7.Main.stage = {};
OS7.Main.renderer = {};
OS7.Main.desktop = {};
OS7.Main.desktop = {};

OS7.Main.preload = function()
{
	OS7.Main.loader = new PIXI.AssetLoader(["assets/images/chicago.xml"]);
	OS7.Main.loader.onAssetLoaded = OS7.Main.init;
	OS7.Main.loader.load();
};

OS7.Main.init = function()
{
	if (typeof process !== "undefined")
	{
		OS7.isWebkit = true;
	}
	
    OS7.Main.stage = new PIXI.Stage(OS7.BG_COLOR, true);
	OS7.Main.stage.interactive = true;
    
	if ( OS7.forceCanvas )
	{
		OS7.Main.renderer = new PIXI.CanvasRenderer(OS7.SCREEN_WIDTH, OS7.SCREEN_HEIGHT);
	}
	else
	{
		OS7.Main.renderer = new PIXI.autoDetectRenderer(OS7.SCREEN_WIDTH, OS7.SCREEN_HEIGHT);
	}
	
	OS7.Main.renderer.view.style.position = "fixed";
	OS7.Main.renderer.view.style.width = OS7.SCREEN_WIDTH + "px";
	OS7.Main.renderer.view.style.height = OS7.SCREEN_HEIGHT + "px";
	OS7.Main.renderer.view.style.display = "block";
	window.onresize();
	
	document.body.appendChild(OS7.Main.renderer.view);
    
    OS7.Main.desktop = new OS7.Desktop();
	OS7.Main.stage.addChild(OS7.Main.desktop);
	
	if (OS7.onLoad && typeof OS7.onLoad === "function")
	{
		OS7.onLoad();
	}
    
	window.requestAnimFrame(OS7.Main.update);
};

OS7.Main.update = function()
{
	if (OS7.Main.desktop && OS7.Main.desktop.update)
	{
		OS7.Main.desktop.update();
	}
	
	if (OS7.Main.renderer)
	{
		OS7.Main.renderer.render(OS7.Main.stage);
	}
	
    window.requestAnimFrame(OS7.Main.update);
};

OS7.Main.onResize = function()
{
	if (OS7.Main.renderer)
	{
		if ( ( window.innerWidth < OS7.SCREEN_WIDTH || OS7.forceScaling ) && OS7.allowScaling )
		{
			OS7.Main.renderer.view.style.width = window.innerWidth + "px";
			OS7.Main.renderer.view.style.left = "0px";
		}
		else
		{
			OS7.Main.renderer.view.style.width = OS7.SCREEN_WIDTH + "px";
			OS7.Main.renderer.view.style.left = ( (  window.innerWidth - OS7.SCREEN_WIDTH ) / 2 ) + "px";
		}
		
		if ( ( window.innerHeight < OS7.SCREEN_HEIGHT || OS7.forceScaling ) && OS7.allowScaling )
		{
			OS7.Main.renderer.view.style.height = window.innerHeight + "px";
			OS7.Main.renderer.view.style.top = "0px";
		}
		else
		{
			OS7.Main.renderer.view.style.height = OS7.SCREEN_HEIGHT + "px";
			OS7.Main.renderer.view.style.top = ( ( window.innerHeight - OS7.SCREEN_HEIGHT ) / 2 ) + "px";
		}
	}
};

window.onload = OS7.Main.preload;
window.onresize = OS7.Main.onResize;