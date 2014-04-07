/*global PIXI*/
/*global Text*/
/*global Time*/

var time;

function Desktop(stage)
{
    var bg = new PIXI.Sprite.fromImage("./images/bg.png");
    stage.addChild( bg );
    
    time = new Time();
    stage.addChild( time );
}

Desktop.constructor = Desktop;
Desktop.prototype = Object.create(PIXI.Sprite.prototype);

Desktop.prototype.update = function()
{
    //time.update();
};