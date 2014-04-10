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
OS7.FORCE_SCALING_ON = 0;
OS7.FORCE_SCALING_OFF = 1;
OS7.ALLOW_SCALING_ON = 2;
OS7.ALLOW_SCALING_OFF = 3;
OS7.VERSION_NUMBER = "1.0";