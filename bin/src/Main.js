/*global window*/
/*global document*/
/*global PIXI*/
/*global requestAnimFrame*/
/*global Desktop*/

var gameCanvas = document.getElementById("game-canvas");
var width = 640;
var height = 480;
var bgColor = 0xFFFFFF;
var forceScaling = false;
var allowScaling = true;
var forceCanvas = false;

var stage;
var renderer;
var desktop;
var loader;

function preload()
{
    loader = new PIXI.AssetLoader(["images/chicago.xml"]);
    loader.onAssetLoaded = init;
    loader.load();
}

function init()
{
    stage = new PIXI.Stage(bgColor,true);
	//PIXI.BaseTexture.scaleMode = PIXI.scaleModes.NEAREST;
	//PIXI.BaseTexture.scaleMode = PIXI.scaleModes.NEAREST;
	stage.setInteractive(true);
    
	if ( forceCanvas )
	{
		renderer = new PIXI.CanvasRenderer( width, height );
	}
	else
	{
		renderer = PIXI.autoDetectRenderer(width, height);
	}
	
	renderer.view.style.position = "fixed";
	renderer.view.style.width = width + "px";
	renderer.view.style.height = height + "px";
	renderer.view.style.display = "block";
	window.onresize();
	
	document.body.appendChild(renderer.view);
    
    desktop = new Desktop( stage );
    
    requestAnimFrame( update );
}

function update()
{
    desktop.update();
    renderer.render( stage );
    requestAnimFrame( update );
}

window.onresize = function()
{
	if ( renderer !== null )
	{
		if ( ( window.innerWidth < width || forceScaling ) && allowScaling )
		{
			renderer.view.style.width = window.innerWidth + "px";
			renderer.view.style.left = "0px";
		}
		else
		{
			renderer.view.style.width = width + "px";
			renderer.view.style.left = ( (  window.innerWidth - width ) / 2 ) + "px";
		}
		
		if ( ( window.innerHeight < height || forceScaling ) && allowScaling )
		{
			renderer.view.style.height = window.innerHeight + "px";
			renderer.view.style.top = "0px";
		}
		else
		{
			renderer.view.style.height = height + "px";
			renderer.view.style.top = ( ( window.innerHeight - height ) / 2 ) + "px";
		}
	}
};

window.onload = preload();