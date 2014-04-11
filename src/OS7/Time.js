/*global OS7*/
/*global window*/

/**
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 */

OS7.Time = function()
{
	OS7.Text.call(this, "00:00 AM", 571, 5);
	this.position.x = 571 - this.textWidth;
	
	this.updateTime();
    window.setInterval(this.updateTime, 1000);
};

OS7.Time.prototype = Object.create( OS7.Text.prototype );
OS7.Time.prototype.constructor = OS7.Time;

OS7.Time.prototype.updateTime = function()
{
	this.date = new Date();
    this.hour = this.date.getHours();
    this.minute = this.date.getMinutes();
	this.zero = "";
	this.ampm = "AM";
    
    if ( this.hour > 12 )
    {
        this.hour -= 12;
		this.ampm = "PM";
    }
    
    if ( this.hour === 0 )
    {
        this.hour = 12;
    }
    
    if ( this.minute < 10 )
    {
        this.zero = "0";
    }
    
    this.setText( this.hour + ":" + this.zero + this.minute + " " + this.ampm );
    this.updateText();
    this.position.x = 571 - this.textWidth;
};