/*global Window*/

function Settings(x, y, width, height, stage)
{
    Window.call(this, x, y, width, height, stage);
}

Settings.constructor = Settings;
Settings.prototype = Object.create(Window.prototype);