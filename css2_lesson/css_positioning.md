# CSS Layouts & Positioning

## Setup
If you haven't already, clone the [student resources](https://github.com/wyncode/student-resources) repo.
```sh
git clone https://github.com/wyncode/student-resources.git
cd student-resources/css2_lesson
```

If you've already cloned the repo, then `cd` into it, `pull` any updates, then `cd` into the `css2_lesson` subdir.
```sh
cd student-resources
git pull
cd css2_lesson
```

Once you're in the correct folder, open the HTML file in a browser
```sh
open index.html
```

You should keep these notes and the `index.html` file open in separate tabs. 

Refer to these notes if you get lost. You should be able to copy-and-paste code from here if you type too slowly to keep up.

We'll be hitting refresh on `index.html` frequently.

## CSS Length Units

You can't position HTML elements on a page without knowing how to specify length units in CSS.

### Pixels (px)

Traditionally the most common CSS distance unit, the pixel (`px`) attempts to represent one pixel on the screen of your particular device.

Back when there weren't many devices with access to the Internet, this wasn't a problem. If your design worked at 800x600 and 1024x768 resolutions, you were ok.

But, [starting in the mid-00s](http://www.w3schools.com/browsers/browsers_display.asp), new high-density displays were introduced, reaching 57% of the market by 2009. In the 10s, the introduction of mobile devices saw a proliferation of assorted mid-level resolutions. The two previously standard sizes are now in the single-digits.

It's not only the variety, but the increasing density of newer screens that's also a problem. High DPI screens like the Apple Retina Display have such tiny pixels that such devices and monitors typically treat 1 CSS `px` as multiple on-screen pixels to compensate, allowing older sites using pixel-based layouts to layout reasonably.

The new standard of CSS length is the `em`. The "M" is still a relative measurement, but rather than being relative to the device, it's relative to the user's preferred default font size - a better measurement of readability.

A larger default font results in a more "zoomed in" site - for example, more whitespace between components.


### Ems & Rems

Try this sample code in `style.css`:

```css
p {
  padding-left: 5em;
  border: 1px solid gray;
}

.one {
  font-size: 0.5em;￼￼
}
.two {
  font-size: 1em;
}
.three {
  font-size: 2em;
}
```

Open this is your browser by using `open index.html` from terminal (or just hit refresh if it's already open).

In this example, every `<p>` inherits a `padding-left: 5em;` style, but not every `5em` of padding is the same. The size of an `em` is relative to the element's `font-size` property. The `em` represents the width of the capital letter `M` character. So 5 letter Ms are included above each `<p>` as a reference.

Similarly, you can use the `ex` unit of measurement, which represents the height and width of the lowercase letter `x`.

This style of padding, in combination with the `::first-line` psuedo-element, is prefect for indenting paragraphs. The size of an indent should be relative to the size of the font of the paragraph. A paragraph with a large font should have a large indent, a small font a small indent - another publishing industry handout.

Along with the `ex`, another alternative to the `em` is the `rem`. 

Note the difference with this small CSS change:

```css
p {
  padding-left: 5rem;
}
```

The `rem` is also relative to the capital-M, but instead of deferring to the `font-size` of the element, it defers to the `font-size` of the document (the `font-size` of the `<body>` tag). `rem`s are preferred by some CSS developers for whitespace lengths, like paddings and margins.

### Other Length Values

There are serveral other lesser used ways to specify length values as well, but we won't go over them all.

* `ch` - the size of the character `0`
* `mm`- millimeter
* `in` - inch
* `pt` - point (1/72 of a inch)
* `pc` - pica (12 points)

### Relative Lengths

You may want to specify a CSS length relative to some other CSS length in your document.

If you'd like a component to take up only half the width of your page, you can use `width: 50%`. But be careful. Percentage widths mean percentage of the parent container, not percentage of the entire page.

Let's delete everything in `style.css` and replace it with this.

```css
.one {
  font-size: 0.5em;
  width: 50%;
}

.two {
  font-size: 0.5em;
  width: 50%;
}

#paragraph-two {
  border: 2px solid red;
}
```

Both paragraphs appear to take up 50% of the width of the screen, but it's a little off.

A more reliable way to guarantee a component takes up 50% of the page is the `vw` (viewport width) unit.
Change the CSS for `.one` to look like this:

```css
.one {
  font-size: 0.5em;
  width: 50vw;
}
```

Note how the widths of each paragraphs one and two are slightly different. There's a difference between half the page and half the `paragraph-two` `<div>`. The `<div>` has some default margins being applied by the user agent stylesheet. The sum of those margins correspond to the difference in width.

To make this more noticeable, let's add a width to paragraph two.

```css
#paragraph-two {
  ...
  width: 600px;
}
```

The second paragraph should be 300px wide, while the first should be half the viewport. The first paragraph changes width as we change the width of the screen, but the second doesn't.


## Display/Hiding Elements

Let's reset `style.css` again and replace it with this
```css
p {
  border: 1px solid gray;
}
```

Now let's make the first paragraph disappear by adding this:

```css
...

.one {
  display: none;
}
```

The `display: none;` property removes the element from the document display. It still exists in the HTML, but it leaves no trace on the rendered page.

Another way to make an element disappear is to change it's `visibility`.
Let's try that out by change the CSS for `.one` to look like this:

```css
.one {
  visibility: hidden;
}
```

Paragraph one disappears, but the space it would have occupied remains.

## Box Model

### Margins

Let's reset the `style.css` again.

```css
#paragraph-two {
  border: 2px solid red;
  width: 16em;
  height: 16em;
  background-color: lightgray;
}
```

We've put paragraph two into a box. Take a look at it. 

Now add a `margin: 1em` to the style block:

```css
#paragraph-two {
  ...
  margin: 1em;
}
```

The margin property adds some space around the `div`. The area inside the `div` doesn’t shrink, but the total area taken up by the element increases. 

The margin is always transparent; it doesn’t inherit the background color of the element.

The `margin` CSS property is a shorthand for "margin all around". You can also specify each margin separately. Each of these examples are equivalent.

```css
/* margin: [top] [right] [bottom] [left];  */
margin: 0em 10em 0em 10em;  
```

```css
/* margin: [top&bottom] [right&left]; */
margin: 0em 10em;  
```

```css
margin-top: 0em;  
margin-right: 10em;  
margin-bottom: 0em;    
margin-left: 10em;  
```

#### Margin Collapse

Let's turn paragraph three into a box as well. Add the following to the end of your stylesheet:

```css
#paragraph-three {
  border: 2px solid green;
  width: 16em;
  height: 16em;
  background-color: lightblue;
}
```

And now remove the `margin: 1em` property on paragraph two. Note that both paragraph boxes lie flush with each other.

When two adjacent elements specify a margin, the margins overlap.

Add a `margin-bottom: 1em` to paragraph two and `margin-top: 2em` to paragraph three. What do you think the amount of space between paragraphs two and three will be?

The resulting amount of whitepsace is `2em` (the overlap or max) not `3em` (the sum).

This can cause frustration when laying out elements on a page. If you set `margin-bottom: 5em`, then `margin-top:` values between `0` and `5em` will appear to do nothing - all the margins get swallowed up by its neighbor.

So padding is more often used as a more predictable way to "push" elements apart.

#### Auto Margins

Each of our square `div`s have defined widths. Otherwise, by default, a `div` uses up 100% of the width of the page.

But each of our `div`s are also left-aligned by default. To horizontally center our divs, we can add a `margin-left`, but whatever value we pick will break as soon as we resize the browser window.

The appropriate way to horizontally center a block-level element is to let the browser automatically calculate the correct margins.

```css
#paragraph-two {
  ...
  margin: 0 auto;
}
#paragraph-three {
  ...
  margin: 0 auto;
}
```

When the `margin-left` and `margin-right` are set to `auto`, the browser will automatically keep the element centered. Think of an `auto` margin like a spring. If you add one spring on each side of an element, their combined force will keep the element centered.

Quiz:
* What happens when only `margin-left` is set to `auto`?  
  * The element is right-aligned
* What happens when only `margin-right` is set to `auto`?  
  * Nothing. The element is left-aligned by default.
* What's the difference between `margin: 0 auto;` and `text-align: center;`?
  * The text can be centered even if the box that contains it isn't, and vice versa.

### Padding

Now let’s try padding. Leave paragraph three as is, but add padding for paragraph-two

```css
#paragraph-two {
  ...
  padding: 2em;
}
```

The CSS `padding` property adds space around the text, but within the `div` border. As before, the `div` grows larger, but the text pushes away the edges.  

Just like `margin`, `padding` is shorthand for “padding all around”. You can also specify each side individually.  

```css
/* padding: [top] [right] [bottom] [left];  */
padding: 0em 10em 0em 10em;  
```

```css
/* padding: [top&bottom] [right&left];  */
padding: 0em 10em;  
```

```css
padding-top: 0em;  
padding-right: 10em;     
padding-bottom: 0em;   
padding-left: 10em;
```

Unlike margin, padding does not “collapse”. If two elements are adjacent and padded, the space between them will be the _sum_ of their respective paddings. This effect tends to be easier to understand, so padding is more popular than margin for positioning between elements.

Let's add `padding: 1em;` to both boxes and remove the margin

```css
#paragraph-two {
  ...
  padding: 1em;
}
#paragraph-three {
  ...
  padding: 1em;
}
```

Each box maintains its own padding. `1em` of padding on the top and bottom of each box create a total of `2em`s of padding between each elements' contents.

### Border

You've already seen the `border` property used. It styles the border between the margin and the padding. The shorthand syntax for the border property is:

```css
/* border: style (required), color, width; */
border: solid #1a86a1 5px;
```

The additional fields in most CSS shorthands are optional. That means if they are left out, default values are used instead. Therefore this:

```css
border: solid;
```

will generate a solid border. The default color is black and the default width is 2px.

Unlike margin and padding, the border property order can be rearranged. In fact, the most commonly used syntax is actually:

```css
/* border: width, style (required), color; */
border: 5px solid red;
```

CSS is smart enough to tell the difference between a length value (`5px`), a border style (`solid`), and a border color (`red`), no matter what order they appear in. Just make sure a `border-style` appears somewhere in the list (because the default value is `border-style: none;`).

The `border` CSS shorthand can be expanded into lots of different sub-properties for different levels of control, but they're not very common.

You can specify each value separately.
```css
border-style: solid;
border-width: 5px;
border-color: red;
```

You can specify the top, bottom, left, and right values separately.
```css
border-top: 5px solid red;
```

And you can combine top/bottom/left/right with style/width/color.
```css
border-top-style: solid; /* border-top-width, border-top-color */
border-bottom-style: dashed; /* border-bottom-style, border-bottom-color */
border-left-style: dotted; /* border-left-style, border-left-color */
border-right-style: ridged; /* border-right-style, border-right-color */
```

So the `border` shorthand represents up to 12 different separate styles in one.

```css
#paragraph-two {
  border-top: 5px dashed red;
  ...
}
```

## Element Dimensions

The total size of an element (the actual height and width it consumes) is the sum of the sizes of its constituent parts:
* content: internal organs  
* padding: fat  
* border: skin  
* margin: personal space  

This can lead to some confusion. For example, even if I specify a CSS `width` for my `div`, the actual, real world, on page width of the element will be greater: the contents width (which I control) + the padding + the border width + the margin.

...unless you’re using IE6. Then the width you specify is the actual width of the element. This can cause some huge layout problems on older versions of IE. (For some tips, check [this](https://csstricks.com/iecssbugsthatllgetyoueverytime/) out.)

With all the trash we talk about IE6, the way it treats the `width` CSS property actually makes a lot of sense. Unfortunately, that's just not how the CSS spec was written.

So, for example, if I want to display a grid of 4 `div`s, I want each `div` to take up exactly 25% of the page. So I set `width: 25%`. And it doesn't work. Because as soon as I add padding, margin, or a border, the actual element width is 25% plus... some more. And the default user agent stylesheet may add these things to your `div`s even if you don't.

There are some JavaScript libraries that you can use to force elements to stick to 25% of the width of the page.

There is a better way. The CSS3 [box sizing property](https://developer.mozilla.org/enUS/docs/Web/CSS/boxsizing) will force elements declared to be `width: 25%`; to remain 25% of the width - the border and padding will be forced _within_ the element dimensions instead of adding to the outside of the element.

Here are some additional resources on how to use it:
* https://css-tricks.com/international-box-sizing-awareness-day/
* http://learnlayout.com/box-sizing.html

Note that this CSS3 style has not reached recommendation status. [Browser support is good](http://caniuse.com/#feat=css3-boxsizing), but there are issues and the spec may change.

Let's replace all of the css to look like this:

```css
#paragraph-two {
  border: 2px dashed blue;
  width: 600px;
  padding: 1em;
}

#paragraph-three {
  border: 2px dashed green;
  width: 600px;
  padding: 1em;
}
```

Take a quick look at the page. 

Now let's add `box-sizing: border-box` to paragraph two.

Notice how it gets smaller. That's because the boxes weren't actually 600px wide before. They were 600px + 2px + 1em. Only after applying the `border-box` does the box actually shrink down to 600px.

For consistent sizing, it is a good practice to set all of your elements to have this type of sizing by default. This can be set at the top of your stylesheet (along with your other CSS resets) as follows:

```css
body {
  box-sizing: border-box;
}
```

You can override it later if necessary.

Now let's reset `style.css` again and move on.

## Float

The CSS `float` property demonstrates once again the publishing industry's hold on CSS. It’s most common use case is to allow an image to "float" within a block of text, typically to the left or right edge, allowing paragraph text to flow around it. 

The best example is probably the Wall Street Journal's hedcut image:

![this should be an internal link](http://www.jerrynewton.com/images/wallstreet.jpg "Wall Street Journal article")

Just like a CSS `float`ed element, the image tries to appear as close as possible to the reference of the person's name in the article. 

A floated element is taken out of the _normal flow_ of text. The floated element sits like a heavy rock in a river, allowing the paragraph text to flow around it.

Let's try an example:

```css
#paragraph-four {
  background: #1a86a1;
}

#floater {
  width: 10em;
  background: #31D3FD;
  float: left;
  margin: 5px;
}
```

The `#floater` `div` is within the `#paragraph-four` `div`. The `<p class="four">` is also within `#paragraph-four`. So `.four` and `#floater` are siblings. Nonetheless, the text within `.four` flows around the `#floater`.

Now change the `float` to `float: right` to see the change of it's position within the block of text.

### Floats Obey Their Parent's Dimensions

By adding some padding to `paragraph-four`:

```css
#paragraph-four {
  ...
  padding: 2em;
}
```

... we can see how the square’s padding wraps around `#floater`, pushing it away from the edge as if it were part of the text.

### Floats Can Have Dimensions Themselves

The floater can specify it’s own margin and padding.

By changing `#floater` to have  `margin: 1em;` we can see that property being applied only to the `#floater`, clearing some space around it within the paragraph block.

This also shows margin transparency. The container's background color is visible through the margin.

### Floated Elements Effect Siblings

Floated elements don't need to be contained within another element to effect them. Let's *delete all of the css for `# floater`* and set the fifth paragraph to `float: left;` instead.

```css
.five {
  width: 10em;
  background: #31D3FD;
  float: left;
  margin: 1em;
}
```

And set the sixth to `float: right;` ...

```css
.six {
  width: 10em;
  background: #31D3FD;
  float: right;
  margin: 1em;
}
```

Paragraphs 5 and 6 are siblings inside `<body>`, and yet the text in paragraphs 7-9 will still float around them.

### Float Overflow

A floated element tries to start itself close to where it is referenced in the HTML. But a float can end wherever it wants, even if that means overflowing its container.

Let's edit the size of paragraph `.five` so that the text overflows its container.

```css
.five {
  ...
  height: 30em;
}
```

The effect is jarring, as the text overflows the container and overlaps the bordering text.

To prevent a float from overflowing its container, you can use the infamous "clearfix hack".

```css
.five {
  ...
  overflow: auto;
  zoom: 1; /* IE6 */
}
```

Setting `overflow: auto;` (and `zoom: 1;` for IE6) prevents the float from overflowing it's container, either by strectching it, adding a scroll bar (`overflow: scroll;`) or clipping it (`overflow: hidden`). This works in most browsers but the world of "clearfixing" can be [treacherous](http://learnlayout.com/clearfix.html). There are many variations of this hack, none of them fully satisfying.

### Clearing Floats

Let's delete these last few lines...

```css
height: 30em;
overflow: auto;
zoom: 1; /* IE6 */
```

And let's go ahead and set the last paragraph (nine) like so:

```css
.nine {
  clear: left;
  background: #1a86a1;
  padding: 2em;
}
```

Asking an element to `clear: left;` prevents any items from floating to its left. The result is like a "newline" placed after a stack of floated elements. Other options are 'clear: right;' and 'clear: both;'.

Combining floats and clears allows us to create a basic version of "the Holy Grail layout" explored in the "Flexbox" exercise - appropriate for browsers that don't yet support the new CSS3 flexbox.

## Display

`div`s, by default, are _block level_ elements. They stretch left and right to take up a whole horizontal line of your document. `p` and `form` are also common block level elements. Add a border to any `<p>` element to confirm.

But this property of `div`s and `p`s can be changed by setting the CSS `display` property.

For example, `<li>` elements are also block-level by default, meaning every item in a list wants to take up 100% of the width of your page. To make a list display horizontally instead of vertically (such as within a `<nav>` container) we use `display:inline`.
Copy the following into `style.css`:

```css
li {
  display:inline;
}
```

Notice that the first word of the lists in our document are still indented. This is a default style for `<ul>` elements. Simply override it by resetting padding to 0.

```css
ul {
  padding: 0;
}
```

## Position

When it comes to laying elements out onto a page, perhaps the most powerful CSS style is `position`. Wrestling control of element positioning from the browser can be tough, but it’s the only way to have full control.  

The default position value of most elements is `static`.  An element styled with `position: static;` is said to be not positioned.  

### Relative Positioning
Relative positioning gives you the ability to move an item "relative" to its original position.

To see this in action lets modify the title of the page.

```css
.title {
  border: 3px solid red;
  position:relative;
}
```

We've added a border to the title, but nothing else has changed. That's because `position: relative;` doesn't do anything on it's own. It just unlocks the ability to use `top`, `right`, `bottom`, and `left`. to shove an element wherever you'd like.

```css
.title {
  ...
  top: 2em;
  left: 2em;
}
```

Now we can see that the title has shifted down `2em` and left `2em` from its original position. Use negative values to push elements backwards.

Go ahead and delete that CSS to return the title to its original location and styling.


### Fixed Positioning

Fixed positioning allows you to place an element wherever you’d like relative to the viewport - the current portion of a web page visible through a browser window.

Let's set the bottom navigation links to be fixed.

```css
.bottom-links {
  background-color: white;
  width: 100%;
  position: fixed;
  bottom: 0;
}
```

This snippet locks the footer to the bottom of the screen. The element is removed entirely from the normal flow of text in the document and hovers along the bottom, even as you scroll the window.

Hovering an element over your page with `position: fixed;` may cause it to overlap other elements, hiding them. Whenever you hover elements this way, you typically have to add some extra whitespace to allow you to scroll those covered elements into view.

```css
body {
  margin-bottom: 3em;
}
```

### Absolute Positioning

Absolute positioning is tricky. As the name implies, it lets you position an element absolutely anywhere you’d like on a page.  

Unlike fixed positioning, absolute positioned elements can scroll away.

And unlike relative positioning, absolute positioned elements aren’t _necessarily_ positioned relative to location.

The confusing part is that absolute positioning is still relative positioning. There are just complicated rules about what it is relative to.  

An element which has a position of absolute will be positioned *relative* to the nearest positioned ancestor. If an absolute positioned element has no ancestors that are positioned, it will be positioned according to the `body`.  

Lets set paragraph four to have a position of relative and move it up a little.  

```css
#paragraph-four {
  ...
  background: lightblue;
  position:relative;
  top: -5em;
}
```

Now lets position the `#floater` element to the top right of its parent and change its color so we can see it better.

```css
#floater {
  background-color: white;
  position: absolute;
  top: 1em;
  right: 1em;
}
```

`#floater` is positioned absolutely, but, in this example, that means it's position relative to `#paragraph-four`. It's in the top-right corner of it's parent.

Now comment out paragraph four's positioning:

```css
#paragraph-four {
  ...
  background: lightblue;
  /*position:relative;*/
  top: -5em;
}
```

Now the `#floater` element is positioned relative to the `body`. It's now located in the upper right corner of the entire page.

Absolute positioning crawls through the list of ancestors looking for the first ancestor to have a non-`static` position. Whichever one it finds serves as the root of it's position. If no non-`static` ancestors are found, the element is positions "absolutely" relative to the entire page.


Now that you've learned a little more about CSS you should be able to confidently position elements on the page and build some great things!
