/**
 * @author Mat Groves http://matgroves.com/ @Doormat23
 */

// Just like Header, this is borrowed from PixiJS.

    if (typeof exports !== 'undefined') {
        if (typeof module !== 'undefined' && module.exports) {
            exports = module.exports = OS7;
        }
        exports.OS7 = OS7;
    } else if (typeof define !== 'undefined' && define.amd) {
        define(OS7);
    } else {
        root.OS7 = OS7;
    }
}).call(this);