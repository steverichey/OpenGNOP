/*global console*/
/*global window*/
/*global document*/
/*global PIXI*/
/*global requestAnimFrame*/

var gameCanvas = document.getElementById("game-canvas");
var width = gameCanvas.width;
var height = gameCanvas.height;
var textProp = {font:"12px Chicago"};

var stage;
var renderer;

function init()
{
    var assetsToLoader = ["images/chicago.xml"];
    
    // create a new loader
    var loader = new PIXI.AssetLoader(assetsToLoader);
    
    // use callback
    loader.onComplete = onAssetsLoaded;
    
	// begin load
    loader.load();
    
    function onAssetsLoaded()
    {
        var bitmapFontText = new PIXI.BitmapText("ZA 90 za )(*&^%$#@!~` -=_+[]{} []|:'?,.", textProp);
        bitmapFontText.x = 40;
        bitmapFontText.y = 4;
        stage.addChild(bitmapFontText);
    }
    
    stage = new PIXI.Stage(0x000000);
    renderer = PIXI.autoDetectRenderer(width, height, gameCanvas);
    
    var bg = new PIXI.Sprite.fromImage("./images/bg.png");
    stage.addChild( bg );
    
    //var text = new PIXI.Text("Pixi.js can has text!", textProp);
    //text.x = 40;
    //text.smoothProperty = false;
    //stage.addChild( text );
    
    requestAnimFrame( update );
}

function update()
{
    renderer.render( stage );
    requestAnimFrame( update );
}

window.onload = init();