/*global PIXI*/

function Text(string, x, y)
{
    PIXI.BitmapText.call(this, string, {font:"12px Chicago"});
    this.position.x = x;
    this.position.y = y;
}

Text.constructor = Text;
Text.prototype = Object.create(PIXI.BitmapText.prototype);