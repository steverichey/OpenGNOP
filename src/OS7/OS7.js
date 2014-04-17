/*global window*/
/*global document*/
/*global PIXI*/
/*global requestAnimFrame*/
/*global Desktop*/

/**
 * OpenOS7, pure HTML5 OS7 remake.
 *
 * @author Steve Richey http://www.steverichey.com @stvr_tweets
 * Requires PixiJS, structure heavily influenced by PixiJS.
 * Currently only required for OpenGNOP! but may be used in the future for other Bungie remakes.
 */

/**
 * @module OS7
 */
var OS7 = OS7 || {};

/**
 * @class Consts
 */
OS7.VERSION_NUMBER = "0.1.0";
OS7.SCREEN_WIDTH = 640;
OS7.SCREEN_HEIGHT = 480;
OS7.BG_COLOR = 0x000000;

OS7.Colors = {};
OS7.Colors.BLACK = 0x000000;
OS7.Colors.ALMOST_BLACK = 0x010101;
OS7.Colors.BLUE_LIGHT = 0xCCCCFF;
OS7.Colors.GREY = 0xBBBBBB;
OS7.Colors.GREY_LIGHT = 0x888888;
OS7.Colors.BG_GREY_LIGHT = 0xAAAAAA;
OS7.Colors.BG_GREY_DARK = 0x666666;
OS7.Colors.BLUE_DARK = 0x666699;
OS7.Colors.WHITE = 0xFFFFFF;

OS7.forceScaling = false;
OS7.allowScaling = true;
OS7.forceCanvas = false;
OS7.showHitBoxes = false;
OS7.isWebkit = false;

OS7.mouse = new PIXI.Point(0,0);
OS7.mouse.justPressed = false;
OS7.mouse.justReleased = false;
OS7.mouse.pressed = false;

OS7.collide = function(pointX, pointY, basic)
{
	if(basic.visible)
	{
		if (basic.global.x && basic.width && pointX < basic.global.x + basic.width)
		{
			if (basic.global.y && basic.height && pointY < basic.global.y + basic.height)
			{
				if (pointX > basic.global.x)
				{
					if (pointY > basic.global.y)
					{
						return true;
					}
				}
			}
		}
	}
	
	return false;
};