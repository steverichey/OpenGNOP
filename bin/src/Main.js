/*global window*/
/*global document*/
/*global PIXI*/
/*global requestAnimFrame*/
/*global Desktop*/

var gameCanvas = document.getElementById("game-canvas");
var width = gameCanvas.width;
var height = gameCanvas.height;
var bgColor = 0xFFFFFF;

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
    stage = new PIXI.Stage(bgColor);
    renderer = PIXI.autoDetectRenderer(width, height, gameCanvas);
    
    desktop = new Desktop( stage );
    
    requestAnimFrame( update );
}

function update()
{
    desktop.update();
    renderer.render( stage );
    requestAnimFrame( update );
}

window.onload = preload();