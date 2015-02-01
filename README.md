#P04 - Website Optimization

##File Structure

##Optimization Breakdown (tl;dr)

####FPS Before any fixes

![Breakdown Image 01](readme_images/breakdown-01.png)

####After fixing misspelled adjective array value

![Breakdown Image 02](readme_images/breakdown-02.png)

####After optimizing loops within the the updatePositions() function and DOMContentLoaded event handler

![Breakdown Image 03](readme_images/breakdown-03.png)

####After reducing the number of sliding pizzas generated from 200 to 31

![Breakdown Image 04](readme_images/breakdown-04.png)

####After applying translateX() and translateZ(0) transform functions to the sliding pizza elements in the updatePositions() function

![Breakdown Image 05](readme_images/breakdown-05.png)

####After moving the calculation utlizing the scrollTop property outside of the loop contained in the updatePositions() function

![Breakdown Image 06](readme_images/breakdown-06.png)

####After removing the height and width styles applied to the sliding pizza elements within DOMContentLoaded event handler and resizing the sliding pizza image

![Breakdown Image 07](readme_images/breakdown-07.png)

####After adding the updatePositions() function as a parameter to the window.reaquestAnimationFrame method contained in the scroll event handler

![Breakdown Image 08](readme_images/breakdown-08.png)


##Resources


###Index Page


#####Critical Fold CSS

- [CSS-Tricks: Authoring Critical Above-the-Fold CSS](http://css-tricks.com/authoring-critical-fold-css/)

#####CSS Optimization

- [Google Developers: Optimize CSS Delivery](https://developers.google.com/speed/docs/insights/OptimizeCSSDelivery#example)
- [Gift of Speed: Lazy Load CSS](http://www.giftofspeed.com/defer-loading-css/)
- [Gift of Speed: Inline CSS](http://www.giftofspeed.com/inline-your-css-code/)
- [Critical Path CSS Generator](http://jonassebastianohlsson.com/criticalpathcssgenerator/) By Jonas Ohlsson
- [Loading CSS Asynchronously](http://deanhume.com/home/blogpost/loading-css-asynchronously/7104) By Dean Hume

#####CSS Media Queries

- [CSS Tricks: CSS Media Queries & Using Available Space](http://css-tricks.com/css-media-queries/)

#####Build Tools

- [Brunch HTML5 Build Tool](http://brunch.io/)
- [Brunch Dead Simple Skeleton](https://github.com/brunch/dead-simple)
- [Minify your final CSS file using Gulp.js](http://alfanso.com/minify-your-final-css-file-using-gulp-js/) By Ashit Vora
- [Compressing your Images using Gulp.js](http://alfanso.com/compressing-your-images-using-gulp-js/) By Ashit Vora
- [Introduction to Gulp.js with practical examples](http://julienrenaux.fr/2014/05/25/introduction-to-gulp-js-with-practical-examples/) By Julien Renaux
- [Grunt vs Gulp vs Brunch](http://blog.toggl.com/2014/03/grunt-vs-gulp-vs-brunch/) By Andrin Riiet

#####Image Optimization

- [Yahoo! Smush.it](http://www.smushit.com/ysmush.it/)
- [Kraken.io Optimizer](https://kraken.io/web-interface)

#####JavaScript Execution

- [Asynchronous and deferred JavaScript execution explained](http://peter.sh/experiments/asynchronous-and-deferred-javascript-execution-explained/) By Peter Beverloo
- [CSS Tricks: Async Attribute and Scripts At The Bottom](http://css-tricks.com/async-attribute-scripts-bottom/)

#####Webfonts

- [WOFF - Web Open Font Format Browser Support](http://caniuse.com/#feat=woff)

#####GZIP Compression

- [Enable GZIP compression in WHM / cPanel with EasyApache](http://myhosting.com/kb/index.php?action=showEntry&data=4906)
- [Enable Apache Gzip Compression (mod_deflate) Globally in WHM/cPanel](http://tecadmin.net/enable-apache-gzip-compression-globally-in-whm-cpanel/)
- [How to check if mod_delate in enabled](http://stackoverflow.com/questions/970151/how-to-check-mod-deflate-is-enabled-in-apache)
- [Check GZIP Compression](http://checkgzipcompression.com/)

#####HTTP Caching

- [Google Developers: Cache Control](https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/http-caching)


###Pizza Page


#####Layout & Rendering

- [Jank Free](http://jankfree.org/)
- [Gone In 60 Frames Per Second: A Pinterest Paint Performance Case Study](http://www.smashingmagazine.com/2013/06/10/pinterest-paint-performance-case-study/) By Addy Osmani
- [[VIDEO] Gone in 60fps - Making A Site Jank-Free](http://addyosmani.com/blog/making-a-site-jank-free/) By Addy Osmani

#####JavaScript Loop

- [Loop iteration performance](http://stackoverflow.com/questions/3520688/javascript-loop-performance-why-is-to-decrement-the-iterator-toward-0-faster-t)

#####JavaScript Switch

- [Switch statement performance](http://stackoverflow.com/questions/18830626/should-i-use-big-switch-statements-in-javascript-without-performance-problems)
- [Switch vs. if else](http://stackoverflow.com/questions/2922948/javascript-switch-vs-if-else-if-else)
- [Writing efficient JavaScript](http://archive.oreilly.com/pub/a/server-administration/excerpts/even-faster-websites/writing-efficient-javascript.html)
- [O'Reilly JavaScript - The Definitive Guide - Switch](http://archive.oreilly.com/pub/a/server-administration/excerpts/even-faster-websites/writing-efficient-javascript.html)

#####CSS Transform

- [CSS Tricks - Transform](http://css-tricks.com/almanac/properties/t/transform/)

#####requestAnimationFrame

- [Fixing a parallax scrolling website to run in 60 FPS](http://kristerkari.github.io/adventures-in-webkit-land/blog/2013/08/30/fixing-a-parallax-scrolling-website-to-run-in-60-fps/) By Krister Kari

#####Chrome Devtools

- [Cheatsheet](http://anti-code.com/devtools-cheatsheet/)
- [Performance profiling with the Timeline](https://developer.chrome.com/devtools/docs/timeline)

#####Chrome Office Hours

- [[VIDEO] Paul Lewis & Paul Irish investigate rendering problems](https://www.youtube.com/watch?v=z0_jD8nO5Zw)