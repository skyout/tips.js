tips.js
=========

tips.js is a simple jQuery tooltip plugin.

Demo
----

A demo of the plugin in action can be found <a href="http://scott-lanning.com/tips">here</a>.


Installation
------------

Include <a href="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js">jQuery</a> and the `tips.min.js` scripts:

```
<script src="jquery.min.js" type="text/javascript"></script>
<script src="tips.min.js" type="text/javascript"></script>
```

Include the `tips.css` stylesheet:

```
<link href="assets/css/tips.css" media="screen" rel="stylesheet" type="text/css" />
```

**Note:** This plugin utilizes the new jQuery on method, and therefore require jQuery 1.7 or newer. Also tips.js uses the HTML5 element of `aside` for tooltips. It is recommended to include <a href="http://code.google.com/p/html5shiv/">html5shiv</a> if working with browsers that do not natively support HTML5.


Using tips.js
-------------

All of the files for the plugin can be found in the `build` directory. Add a `data-tooltip` attribute with the content of the tooltip.

```
<input type="email" id="email" data-tooltip="Please enter an email address" />
```

Specify the optional direction of the tooltip by adding the `data-tooltip-direction` attribute with the direction you'd like. The default is right, however acceptable values are top, bottom, left, and right.

```
<input type="email" id="email" data-tooltip="Please enter an email address" data-tooltip-direction="top" />
```

Then invoke `$.tips` passing the selectors(s) you'd like to show tooltips.

```
$.tips({
    element: '.error'
});
```


Options
-------

Below are the supported options and their default values:

```
settings = {
    action: 'focus',        // tooltip display event (click, focus, hover)
    debug: false,           // debug console
    element: '.error'       // selector to run the tooltip on
    fadeSpeed: 200,         // fade speed
    preventDefault: false,  // prevent default event when element is clicked on
    tailLength: 14,         // width/length of tooltip tail
    tooltipClass: null      // class to add to tooltip
}
```

There are several built in CSS styles for the tooltips. Currently there are styles for error, warning, and informational tooltips. Utilize the `tooltipClass` option to set one of the aforementioned classes. You can also add or modify styles in the CSS to file to tailor the tooltips to your site.

Contributing and Updates
------------------------

This is an early version of the plugin. I would definitely appreciate any feedback. I'm working on some ideas for the next version:

1. Detecting edge of screen and repositioning tooltips
2. Adding options for tooltip location in relation to the element
3. Adding more pre-defined CSS tooltip colors and classes

Please fork and send pull requests, or create an <a href="https://github.com/slanningGH/tips.js/issues">issue</a>.



License (MIT)
-------------

tips.js is distributed under the MIT License:

```
Copyright (c) 2013 Scott Lanning

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```