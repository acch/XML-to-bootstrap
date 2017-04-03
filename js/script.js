var Options={navbarOffset:300,navbarTolerance:5};!function(a,b){"use strict";"function"==typeof define&&define.amd?define([],b):"object"==typeof exports?module.exports=b():a.Headroom=b()}(this,function(){"use strict";function a(a){this.callback=a,this.ticking=!1}function b(a){return a&&"undefined"!=typeof window&&(a===window||a.nodeType)}function c(a){if(arguments.length<=0)throw new Error("Missing arguments in extend function");var d,e,f=a||{};for(e=1;e<arguments.length;e++){var g=arguments[e]||{};for(d in g)"object"!=typeof f[d]||b(f[d])?f[d]=f[d]||g[d]:f[d]=c(f[d],g[d])}return f}function d(a){return a===Object(a)?a:{down:a,up:a}}function e(a,b){b=c(b,e.options),this.lastKnownScrollY=0,this.elem=a,this.tolerance=d(b.tolerance),this.classes=b.classes,this.offset=b.offset,this.scroller=b.scroller,this.initialised=!1,this.onPin=b.onPin,this.onUnpin=b.onUnpin,this.onTop=b.onTop,this.onNotTop=b.onNotTop,this.onBottom=b.onBottom,this.onNotBottom=b.onNotBottom}var f={bind:!!function(){}.bind,classList:"classList"in document.documentElement,rAF:!!(window.requestAnimationFrame||window.webkitRequestAnimationFrame||window.mozRequestAnimationFrame)};return window.requestAnimationFrame=window.requestAnimationFrame||window.webkitRequestAnimationFrame||window.mozRequestAnimationFrame,a.prototype={constructor:a,update:function(){this.callback&&this.callback(),this.ticking=!1},requestTick:function(){this.ticking||(requestAnimationFrame(this.rafCallback||(this.rafCallback=this.update.bind(this))),this.ticking=!0)},handleEvent:function(){this.requestTick()}},e.prototype={constructor:e,init:function(){if(e.cutsTheMustard)return this.debouncer=new a(this.update.bind(this)),this.elem.classList.add(this.classes.initial),setTimeout(this.attachEvent.bind(this),100),this},destroy:function(){var a=this.classes;this.initialised=!1,this.elem.classList.remove(a.unpinned,a.pinned,a.top,a.notTop,a.initial),this.scroller.removeEventListener("scroll",this.debouncer,!1)},attachEvent:function(){this.initialised||(this.lastKnownScrollY=this.getScrollY(),this.initialised=!0,this.scroller.addEventListener("scroll",this.debouncer,!1),this.debouncer.handleEvent())},unpin:function(){var a=this.elem.classList,b=this.classes;!a.contains(b.pinned)&&a.contains(b.unpinned)||(a.add(b.unpinned),a.remove(b.pinned),this.onUnpin&&this.onUnpin.call(this))},pin:function(){var a=this.elem.classList,b=this.classes;a.contains(b.unpinned)&&(a.remove(b.unpinned),a.add(b.pinned),this.onPin&&this.onPin.call(this))},top:function(){var a=this.elem.classList,b=this.classes;a.contains(b.top)||(a.add(b.top),a.remove(b.notTop),this.onTop&&this.onTop.call(this))},notTop:function(){var a=this.elem.classList,b=this.classes;a.contains(b.notTop)||(a.add(b.notTop),a.remove(b.top),this.onNotTop&&this.onNotTop.call(this))},bottom:function(){var a=this.elem.classList,b=this.classes;a.contains(b.bottom)||(a.add(b.bottom),a.remove(b.notBottom),this.onBottom&&this.onBottom.call(this))},notBottom:function(){var a=this.elem.classList,b=this.classes;a.contains(b.notBottom)||(a.add(b.notBottom),a.remove(b.bottom),this.onNotBottom&&this.onNotBottom.call(this))},getScrollY:function(){return void 0!==this.scroller.pageYOffset?this.scroller.pageYOffset:void 0!==this.scroller.scrollTop?this.scroller.scrollTop:(document.documentElement||document.body.parentNode||document.body).scrollTop},getViewportHeight:function(){return window.innerHeight||document.documentElement.clientHeight||document.body.clientHeight},getElementPhysicalHeight:function(a){return Math.max(a.offsetHeight,a.clientHeight)},getScrollerPhysicalHeight:function(){return this.scroller===window||this.scroller===document.body?this.getViewportHeight():this.getElementPhysicalHeight(this.scroller)},getDocumentHeight:function(){var a=document.body,b=document.documentElement;return Math.max(a.scrollHeight,b.scrollHeight,a.offsetHeight,b.offsetHeight,a.clientHeight,b.clientHeight)},getElementHeight:function(a){return Math.max(a.scrollHeight,a.offsetHeight,a.clientHeight)},getScrollerHeight:function(){return this.scroller===window||this.scroller===document.body?this.getDocumentHeight():this.getElementHeight(this.scroller)},isOutOfBounds:function(a){var b=a<0,c=a+this.getScrollerPhysicalHeight()>this.getScrollerHeight();return b||c},toleranceExceeded:function(a,b){return Math.abs(a-this.lastKnownScrollY)>=this.tolerance[b]},shouldUnpin:function(a,b){var c=a>this.lastKnownScrollY,d=a>=this.offset;return c&&d&&b},shouldPin:function(a,b){var c=a<this.lastKnownScrollY,d=a<=this.offset;return c&&b||d},update:function(){var a=this.getScrollY(),b=a>this.lastKnownScrollY?"down":"up",c=this.toleranceExceeded(a,b);this.isOutOfBounds(a)||(a<=this.offset?this.top():this.notTop(),a+this.getViewportHeight()>=this.getScrollerHeight()?this.bottom():this.notBottom(),this.shouldUnpin(a,c)?this.unpin():this.shouldPin(a,c)&&this.pin(),this.lastKnownScrollY=a)}},e.options={tolerance:{up:0,down:0},offset:0,scroller:window,classes:{pinned:"headroom--pinned",unpinned:"headroom--unpinned",top:"headroom--top",notTop:"headroom--not-top",bottom:"headroom--bottom",notBottom:"headroom--not-bottom",initial:"headroom"}},e.cutsTheMustard=void 0!==f&&f.rAF&&f.bind&&f.classList,e});var ScrollPosStyler=function(a,b){"use strict";function c(){g||(f=b.pageYOffset,h&&f>i?(g=!0,h=!1,b.requestAnimationFrame(e)):!h&&f<=i&&(g=!0,h=!0,b.requestAnimationFrame(d)))}function d(){for(var a=0;j[a];++a)j[a].classList.add(k),j[a].classList.remove(l);g=!1}function e(){for(var a=0;j[a];++a)j[a].classList.add(l),j[a].classList.remove(k);g=!1}var f=0,g=!1,h=!0,i=1,j=a.getElementsByClassName("sps"),k="sps--abv",l="sps--blw",m={init:function(){g=!0,f=b.pageYOffset,f>i?(h=!1,b.requestAnimationFrame(e)):(h=!0,b.requestAnimationFrame(d))}};return a.addEventListener("DOMContentLoaded",function(){b.setTimeout(m.init,1)}),b.addEventListener("scroll",c),m}(document,window);!function(a,b){"use strict";"function"==typeof define&&define.amd?define([],b):"object"==typeof module&&module.exports?module.exports=b():(a.AnchorJS=b(),a.anchors=new a.AnchorJS)}(this,function(){"use strict";function a(a){function b(a){a.icon=a.hasOwnProperty("icon")?a.icon:"",a.visible=a.hasOwnProperty("visible")?a.visible:"hover",a.placement=a.hasOwnProperty("placement")?a.placement:"right",a.class=a.hasOwnProperty("class")?a.class:"",a.truncate=a.hasOwnProperty("truncate")?Math.floor(a.truncate):64}function c(a){var b;if("string"==typeof a||a instanceof String)b=[].slice.call(document.querySelectorAll(a));else{if(!(Array.isArray(a)||a instanceof NodeList))throw new Error("The selector provided to AnchorJS was invalid.");b=[].slice.call(a)}return b}function d(){if(null===document.head.querySelector("style.anchorjs")){var a,b=document.createElement("style");b.className="anchorjs",b.appendChild(document.createTextNode("")),a=document.head.querySelector('[rel="stylesheet"], style'),void 0===a?document.head.appendChild(b):document.head.insertBefore(b,a),b.sheet.insertRule(" .anchorjs-link {   opacity: 0;   text-decoration: none;   -webkit-font-smoothing: antialiased;   -moz-osx-font-smoothing: grayscale; }",b.sheet.cssRules.length),b.sheet.insertRule(" *:hover > .anchorjs-link, .anchorjs-link:focus  {   opacity: 1; }",b.sheet.cssRules.length),b.sheet.insertRule(" [data-anchorjs-icon]::after {   content: attr(data-anchorjs-icon); }",b.sheet.cssRules.length),b.sheet.insertRule(' @font-face {   font-family: "anchorjs-icons";   src: url(data:n/a;base64,AAEAAAALAIAAAwAwT1MvMg8yG2cAAAE4AAAAYGNtYXDp3gC3AAABpAAAAExnYXNwAAAAEAAAA9wAAAAIZ2x5ZlQCcfwAAAH4AAABCGhlYWQHFvHyAAAAvAAAADZoaGVhBnACFwAAAPQAAAAkaG10eASAADEAAAGYAAAADGxvY2EACACEAAAB8AAAAAhtYXhwAAYAVwAAARgAAAAgbmFtZQGOH9cAAAMAAAAAunBvc3QAAwAAAAADvAAAACAAAQAAAAEAAHzE2p9fDzz1AAkEAAAAAADRecUWAAAAANQA6R8AAAAAAoACwAAAAAgAAgAAAAAAAAABAAADwP/AAAACgAAA/9MCrQABAAAAAAAAAAAAAAAAAAAAAwABAAAAAwBVAAIAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAMCQAGQAAUAAAKZAswAAACPApkCzAAAAesAMwEJAAAAAAAAAAAAAAAAAAAAARAAAAAAAAAAAAAAAAAAAAAAQAAg//0DwP/AAEADwABAAAAAAQAAAAAAAAAAAAAAIAAAAAAAAAIAAAACgAAxAAAAAwAAAAMAAAAcAAEAAwAAABwAAwABAAAAHAAEADAAAAAIAAgAAgAAACDpy//9//8AAAAg6cv//f///+EWNwADAAEAAAAAAAAAAAAAAAAACACEAAEAAAAAAAAAAAAAAAAxAAACAAQARAKAAsAAKwBUAAABIiYnJjQ3NzY2MzIWFxYUBwcGIicmNDc3NjQnJiYjIgYHBwYUFxYUBwYGIwciJicmNDc3NjIXFhQHBwYUFxYWMzI2Nzc2NCcmNDc2MhcWFAcHBgYjARQGDAUtLXoWOR8fORYtLTgKGwoKCjgaGg0gEhIgDXoaGgkJBQwHdR85Fi0tOAobCgoKOBoaDSASEiANehoaCQkKGwotLXoWOR8BMwUFLYEuehYXFxYugC44CQkKGwo4GkoaDQ0NDXoaShoKGwoFBe8XFi6ALjgJCQobCjgaShoNDQ0NehpKGgobCgoKLYEuehYXAAAADACWAAEAAAAAAAEACAAAAAEAAAAAAAIAAwAIAAEAAAAAAAMACAAAAAEAAAAAAAQACAAAAAEAAAAAAAUAAQALAAEAAAAAAAYACAAAAAMAAQQJAAEAEAAMAAMAAQQJAAIABgAcAAMAAQQJAAMAEAAMAAMAAQQJAAQAEAAMAAMAAQQJAAUAAgAiAAMAAQQJAAYAEAAMYW5jaG9yanM0MDBAAGEAbgBjAGgAbwByAGoAcwA0ADAAMABAAAAAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAH//wAP) format("truetype"); }',b.sheet.cssRules.length)}}this.options=a||{},this.elements=[],b(this.options),this.isTouchDevice=function(){return!!("ontouchstart"in window||window.DocumentTouch&&document instanceof DocumentTouch)},this.add=function(a){var e,f,g,h,i,j,k,l,m,n,o,p,q=[];if(b(this.options),p=this.options.visible,"touch"===p&&(p=this.isTouchDevice()?"always":"hover"),a||(a="h1, h2, h3, h4, h5, h6"),e=c(a),0===e.length)return!1;for(d(),f=document.querySelectorAll("[id]"),g=[].map.call(f,function(a){return a.id}),i=0;i<e.length;i++)if(this.hasAnchorJSLink(e[i]))q.push(i);else{if(e[i].hasAttribute("id"))h=e[i].getAttribute("id");else{l=this.urlify(e[i].textContent),m=l,k=0;do{void 0!==j&&(m=l+"-"+k),j=g.indexOf(m),k+=1}while(-1!==j);j=void 0,g.push(m),e[i].setAttribute("id",m),h=m}n=h.replace(/-/g," "),o=document.createElement("a"),o.className="anchorjs-link "+this.options.class,o.href="#"+h,o.setAttribute("aria-label","Anchor link for: "+n),o.setAttribute("data-anchorjs-icon",this.options.icon),"always"===p&&(o.style.opacity="1"),""===this.options.icon&&(o.style.font="1em/1 anchorjs-icons","left"===this.options.placement&&(o.style.lineHeight="inherit")),"left"===this.options.placement?(o.style.position="absolute",o.style.marginLeft="-1em",o.style.paddingRight="0.5em",e[i].insertBefore(o,e[i].firstChild)):(o.style.paddingLeft="0.375em",e[i].appendChild(o))}for(i=0;i<q.length;i++)e.splice(q[i]-i,1);return this.elements=this.elements.concat(e),this},this.remove=function(a){for(var b,d,e=c(a),f=0;f<e.length;f++)(d=e[f].querySelector(".anchorjs-link"))&&(b=this.elements.indexOf(e[f]),-1!==b&&this.elements.splice(b,1),e[f].removeChild(d));return this},this.removeAll=function(){this.remove(this.elements)},this.urlify=function(a){return this.options.truncate||b(this.options),a.trim().replace(/\'/gi,"").replace(/[& +$,:;=?@"#{}|^~[`%!'\]\.\/\(\)\*\\]/g,"-").replace(/-{2,}/g,"-").substring(0,this.options.truncate).replace(/^-+|-+$/gm,"").toLowerCase()},this.hasAnchorJSLink=function(a){var b=a.firstChild&&(" "+a.firstChild.className+" ").indexOf(" anchorjs-link ")>-1,c=a.lastChild&&(" "+a.lastChild.className+" ").indexOf(" anchorjs-link ")>-1;return b||c||!1}}return a}),function(){document.addEventListener("DOMContentLoaded",function(){anchors.add(".anchored")})}(),function(){var a=new Headroom(document.querySelector(".js-nvbr"),{offset:Options.navbarOffset,tolerance:Options.navbarTolerance});a.init(),document.addEventListener("DOMContentLoaded",function(){function b(b){for(var c=0;b[c];++c)b[c].addEventListener("click",function(){a.lastKnownScrollY=a.getScrollerHeight(),window.requestAnimationFrame(function(){a.pin()})})}b(document.getElementsByClassName("js-sdbr-itm")),b(document.getElementsByClassName("anchorjs-link"))})}();