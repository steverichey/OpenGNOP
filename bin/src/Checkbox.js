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