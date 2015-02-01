#P04 - Website Optimization

Live website: http://optimization.mikejoyce.io

##File Structure

######app/

Contains development CSS, JS and images, sorted into corresponding directories.

######public/

Contains the production ready CSS, JS and images built from the app/ directory.

######views/

Contains the HTML for the pizza and individual project pages.

##The Build

I used the [Brunch](http://brunch.io) build tool for this project.

######

Install Brunch

`npm install -g brunch`

Build

`brunch build --production`

More detailed documentation [here](https://github.com/brunch/brunch/tree/stable/docs).


##The Optimization Process

###Sliding Pizzas

Read through the code in pizza.js (originally main.js) to try and understand how the code functions. I then console logged my way from the randomName function up into the generator function and through this identified that the global literal adjectives array contains the value ‘noise’, but the getAdj function contains the switch case ‘noisy’. I renamed the value in the global adjectives array to ‘noisy’ and checked to make sure that both the adjectives/nouns array literals matched the cases within the getAdj and getNoun functions.

`var adjectives = ["dark", "color", "whimsical", "shiny", "noisy", "apocalyptic", "insulting", "praise", "scientific"];`

Did a little research on switch statements vs. if/else blocks out of curiosity. After reading through questions on StackOverflow and a few blog posts the consensus seems to be that a switch statement is preferable if there are more than 2 or 3 conditions to evaluate, so I left the getAdj and getNoun functions as they are.

Looked into loop optimisation and ended up changing up the loops contained in the updatePositions and onDOMContentLoaded event handler.

```
function updatePositions() {
  frame++;
  window.performance.mark("mark_start_frame");

  var items = document.querySelectorAll('.mover');
  for (var i = items.length; i--;) {
    var phase = Math.sin((document.body.scrollTop / 1250) + (i % 5));
    items[i].style.left = items[i].basicLeft + 100 * phase + 'px';
  }

  // User Timing API to the rescue again. Seriously, it's worth learning.
  // Super easy to create custom metrics.
  window.performance.mark("mark_end_frame");
  window.performance.measure("measure_frame_duration", "mark_start_frame", "mark_end_frame");
  if (frame % 10 === 0) {
    var timesToUpdatePosition = window.performance.getEntriesByName("measure_frame_duration");
    logAverageFrame(timesToUpdatePosition);
  }
}
```

```
document.addEventListener('DOMContentLoaded', function() {
  var cols = 8;
  var s = 256;
  for (var i = 200; i--;) {
    var elem = document.createElement('img');
    elem.className = 'mover';
    elem.src = "../public/img/pizza.png";
    elem.style.height = "100px";
    elem.style.width = "73.333px";
    elem.basicLeft = (i % cols) * s;
    elem.style.top = (Math.floor(i / cols) * s) + 'px';
    document.querySelector("#movingPizzas1").appendChild(elem);
  }
  updatePositions();
});
```

Moved onto the DOMContentLoad handler which fires a function to generate the sliding pizzas and reduced the amount of sliding pizza elements the for loop generates from 200 down to 31, which sufficiently fills the screen with sliding pizzas.

```
document.addEventListener('DOMContentLoaded', function() {
  var cols = 8;
  var s = 256;
  for (var i = 31; i--;) {
    var elem = document.createElement('img');
    elem.className = 'mover';
    elem.src = "../public/img/pizza.png";
    elem.style.height = "100px";
    elem.style.width = "73.333px";
    elem.basicLeft = (i % cols) * s;
    elem.style.top = (Math.floor(i / cols) * s) + 'px';
    document.querySelector("#movingPizzas1").appendChild(elem);
  }
  updatePositions();
});
``` 

Applied transform and force GPU hardware acceleration to items within updatePositions function.


```
function updatePositions() {
  frame++;
  window.performance.mark("mark_start_frame");

  var items = document.querySelectorAll('.mover');
  for (var i = items.length; i--;) {
    var phase = Math.sin((document.body.scrollTop / 1250) + (i % 5));
    //items[i].style.left = items[i].basicLeft + 100 * phase + 'px';
    var left = -items[i].basicLeft + 1000 * phase + 'px';
 		items[i].style.transform = "translateX("+left+") translateZ(0)";
  }

  // User Timing API to the rescue again. Seriously, it's worth learning.
  // Super easy to create custom metrics.
  window.performance.mark("mark_end_frame");
  window.performance.measure("measure_frame_duration", "mark_start_frame", "mark_end_frame");
  if (frame % 10 === 0) {
    var timesToUpdatePosition = window.performance.getEntriesByName("measure_frame_duration");
    logAverageFrame(timesToUpdatePosition);
  }
}
```

Move the scrollTop / 1250 outside of the loop

```
function updatePositions() {
  frame++;
  window.performance.mark("mark_start_frame");

  var items = document.querySelectorAll('.mover');
  var top = (document.body.scrollTop / 1250);
  
  for (var i = items.length; i--;) {
    var phase = Math.sin( top + (i % 5));
    //items[i].style.left = items[i].basicLeft + 100 * phase + 'px';
    var left = -items[i].basicLeft + 1000 * phase + 'px';
 		items[i].style.transform = "translateX("+left+") translateZ(0)";
  }

  // User Timing API to the rescue again. Seriously, it's worth learning.
  // Super easy to create custom metrics.
  window.performance.mark("mark_end_frame");
  window.performance.measure("measure_frame_duration", "mark_start_frame", "mark_end_frame");
  if (frame % 10 === 0) {
    var timesToUpdatePosition = window.performance.getEntriesByName("measure_frame_duration");
    logAverageFrame(timesToUpdatePosition);
  }
}
```

Remove height and width styles from pizza elements generated in the DOMContentLoaded function. Resize pizza image and name pizza-slider.png.

```
document.addEventListener('DOMContentLoaded', function() {
  var cols = 8;
  var s = 256;
  for (var i = 31; i--;) {
    var elem = document.createElement('img');
    elem.className = 'mover';
    elem.src = "../public/img/pizza-slider.png";
    elem.basicLeft = (i % cols) * s;
    elem.style.top = (Math.floor(i / cols) * s) + 'px';
    document.querySelector("#movingPizzas1").appendChild(elem);
  }
  updatePositions();
});
```

Added request animation frame to on scroll event.

```
window.addEventListener('scroll', function() {
	window.requestAnimationFrame(updatePositions);
});
```

###Resized Pizzas

Moved the determineDx function out of loop. Selected only the first .randomPizzaContainer in the document.

```
function changePizzaSizes(size) {
	var dx = determineDx(document.querySelector(".randomPizzaContainer"), size);
  for (var i = 0; i < document.querySelectorAll(".randomPizzaContainer").length; i++) {
    var newwidth = (document.querySelectorAll(".randomPizzaContainer")[i].offsetWidth + dx) + 'px';
    document.querySelectorAll(".randomPizzaContainer")[i].style.width = newwidth;
  }
}
```

Moved the newwidth calculation out of loop. Again, selected only the first .randomPizzaContainer element in the document.

```
function changePizzaSizes(size) {
	var dx = determineDx(document.querySelector(".randomPizzaContainer"), size);
  var newwidth = (document.querySelector(".randomPizzaContainer").offsetWidth + dx) + 'px';
  for (var i = 0; i < document.querySelectorAll(".randomPizzaContainer").length; i++) {
    document.querySelectorAll(".randomPizzaContainer")[i].style.width = newwidth;
  }
}
```

Create a new variable to hold all of the .randomPizzaContainer elements in the document. Loop through them.

```
function changePizzaSizes(size) {
	var dx = determineDx(document.querySelector(".randomPizzaContainer"), size);
  var newwidth = (document.querySelector(".randomPizzaContainer").offsetWidth + dx) + 'px';
  var elements = document.querySelectorAll(".randomPizzaContainer");
  for (var i = 0; i < elements.length; i++) {
    elements[i].style.width = newwidth;
  }
}
```

Optimized loop to a reduce checks by iterating backwards through the elements.

```
function changePizzaSizes(size) {
	var dx = determineDx(document.querySelector(".randomPizzaContainer"), size);
  var newwidth = (document.querySelector(".randomPizzaContainer").offsetWidth + dx) + 'px';
  var elements = document.querySelectorAll(".randomPizzaContainer");
  for (var i = elements.length; i--;) {
    elements[i].style.width = newwidth;
  }
}
```



##Optimization Breakdown (tl;dr)

###Sliding Pizzas

######FPS Before any fixes

![Breakdown Image 01](readme_images/breakdown-01.png)

######After fixing misspelled adjective array value

![Breakdown Image 02](readme_images/breakdown-02.png)

######After optimizing loops 

![Breakdown Image 03](readme_images/breakdown-03.png)

######After reducing the number of sliding pizzas generated from 200 to 31

![Breakdown Image 04](readme_images/breakdown-04.png)

######After applying translateX() and translateZ(0) transform functions to the sliding pizza elements

![Breakdown Image 05](readme_images/breakdown-05.png)

######After moving a calculation utlizing the scrollTop property outside of a loop

![Breakdown Image 06](readme_images/breakdown-06.png)

######After removing height & width styles from pizza image tag and resizing the image

![Breakdown Image 07](readme_images/breakdown-07.png)

######After including window.requestAnimationFrame method within scroll event handler

![Breakdown Image 08](readme_images/breakdown-08.png)

###Resized Pizzas

######Resize time before fixes

![Breakdown Image 09](readme_images/breakdown-09.png)

######Resize time after fixes

![Breakdown Image 10](readme_images/breakdown-10.png)


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

######JavaScript DOM Traversal

- [Mozilla Developer Network: document.querySelector](https://developer.mozilla.org/en-US/docs/Web/API/document.querySelector)
- [Mozilla Developer Network: document.querySelectorAll](https://developer.mozilla.org/en/docs/Web/API/Document.querySelectorAll)

#####CSS Transform

- [CSS Tricks - Transform](http://css-tricks.com/almanac/properties/t/transform/)

#####requestAnimationFrame

- [Fixing a parallax scrolling website to run in 60 FPS](http://kristerkari.github.io/adventures-in-webkit-land/blog/2013/08/30/fixing-a-parallax-scrolling-website-to-run-in-60-fps/) By Krister Kari
- [Mozilla Developer Network: window.requestAnimationFrame](https://developer.mozilla.org/en-US/docs/Web/API/window.requestAnimationFrame)

#####Chrome Devtools

- [Cheatsheet](http://anti-code.com/devtools-cheatsheet/)
- [Performance profiling with the Timeline](https://developer.chrome.com/devtools/docs/timeline)

#####Chrome Office Hours

- [[VIDEO] Paul Lewis & Paul Irish investigate rendering problems](https://www.youtube.com/watch?v=z0_jD8nO5Zw)