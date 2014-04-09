# ![GNOP! Icon](assets/icon-readme.png) OpenGNOP!

<p align="center">
<img src="assets/screenshot.png" alt="GNOP! Screenshot"/>
</p>

An open-source remake of Bungie's GNOP! by [Steve Richey](https://github.com/steverichey) written in JavaScript using the [Pixi.js](http://www.pixijs.com/) library.

Much of the code is based on [GNOP! Flash](https://github.com/steverichey/gnopflash), but the engine has been completely re-written.

In addition, the code has been simplified, streamlined, and improved wherever possible.  Large assets were removed entirely and are now created dynamically.

## Project goals:
* Extensible interface that can be used for other System 7 projects (OpenOS7)
* Simple, easy-to-use API
* Fast, light, in-browser gameplay
* Standalone executable via [NodeJS](http://nodejs.org/)
* Automation and continuous integration via [TravisCI](https://travis-ci.org/) and [Grunt](http://gruntjs.com/)

# Setup

If you want to compile OpenGNOP! yourself, you'll need to install [NodeJS](http://nodejs.org/) and set it up with the following commands:

````
npm install -g grunt-cli
npm install grunt
grunt build
````

Note: This section is incomplete, once there's a release candidate, this section will be updated.

---

Contributions to OpenGNOP! and OpenOS7 are highly welcome. Furthermore, if you wanted to spearhead another Bungie remake such as OpenODS, OpenMinotaur, or OpenPID, I'd be happy to help!

OpenGNOP! is intended to emulate Bungie Software’s original [GNOP! 1.0](http://en.wikipedia.org/wiki/Gnop!), programmed by [Alexander Seropian](http://en.wikipedia.org/wiki/Alex_Seropian) in Think C in 1990 for the Macintosh. GNOP! was the first game released by Bungie Software (now just [Bungie](http://www.bungie.net)), although it wasn’t until the 1992 release of [Minotaur: The Labyrinths of Crete](http://en.wikipedia.org/wiki/Minotaur:_The_Labyrinths_of_Crete) that Bungie was a fully-fledged company comprised of Seropian and fellow classmate [Jason Jones](http://en.wikipedia.org/wiki/Jason_Jones_(programmer)).

OpenGNOP!, and OpenOS7 (the backbone that contains the core OS functionality) are shared under an MIT license. 

---

[![Analytics](https://ga-beacon.appspot.com/UA-47369324-5/OpenGNOP/readme)](https://github.com/igrigorik/ga-beacon "OpenGNOP! Analytics via GA-Beacon")  [![Built with Grunt](https://cdn.gruntjs.com/builtwith.png)](http://gruntjs.com/ "OpenGNOP! is built with GruntJS")  [![Build Status](https://travis-ci.org/steverichey/OpenGNOP.png)](https://travis-ci.org/steverichey/OpenGNOP "OpenGNOP! Continuous Integration")  [![Stories in Ready](https://badge.waffle.io/steverichey/opengnop.png?label=ready&title=Ready)](https://waffle.io/steverichey/opengnop "OpenGNOP! Issue Tracking via Waffle.io")  [![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/steverichey/opengnop/trend.png)](https://bitdeli.com/free "OpenGNOP! Analytics via Bitdeli")  [![Gittip donate button](http://img.shields.io/gittip/steverichey.png)](https://www.gittip.com/steverichey/ "Support the development of OpenGNOP! via Gittip")  [![PayPal Badge](http://img.shields.io/paypal/donate.png?color=yellow)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=stevenpatrickrichey%40gmail.com&item_name=Open%20source%20donation%20to%20Steve%20Richey&currency_code=USD&bn=PP-DonationsBF%3abtn_donate_SM%2egif%3aNonHosted "Support the development of OpenGNOP! via Paypal") [![Flattr Badge](http://img.shields.io/badge/flattr-donate-orange.svg)](https://flattr.com/submit/auto?user_id=steverichey&url=https://github.com/steverichey/opengnop&title=opengnop&language=&tags=github&category=software)
