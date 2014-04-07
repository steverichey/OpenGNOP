/*global Main*/
/*global PIXI*/
/*global Icon*/
/*global window*/

var gnopIcon;

function Gnop()
{
	Main.desktop.addIcon( "./images/icon.png" );
}

Gnop.constructor = Gnop;
Gnop.prototype = Object.create(Gnop.prototype);

window.onload = new Gnop();