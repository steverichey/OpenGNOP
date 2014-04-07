/*global PIXI*/
/*global Text*/
/*global window*/

var hour;
var zero;
var minute;
var ampm;
var date;
var xpos = 571;

function Time()
{
    ampm = "AM";
    Text.call(this, "", xpos, 5);
    date = new Date();
    var self = this;
    self.updateTime();
    window.setInterval( function(){self.updateTime();}, 1000);
}

Time.constructor = Time;
Time.prototype = Object.create(Text.prototype);

Time.prototype.updateTime = function()
{
    date = new Date();
    hour = date.getHours();
    minute = date.getMinutes();
    
    if ( hour > 12 )
    {
        hour -= 12;
        ampm = "PM";
    }
    else
    {
        ampm = "AM";
    }
    
    if ( hour === 0 )
    {
        hour = 12;
    }
    
    if ( minute < 10 )
    {
        zero = "0";
    }
    else
    {
        zero = "";
    }
    
    this.setText( hour + ":" + zero + minute + " " + ampm );
    this.updateText();
    this.position.x = xpos - this.textWidth;
};