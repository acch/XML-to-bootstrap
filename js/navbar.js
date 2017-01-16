/* -------------------------------------------------------------------------- *\
   JavaScript for animated navigation bar
   --------------------------------------------------------------------------

   This file is part of XML-to-bootstrap.
   https://github.com/acch/XML-to-bootstrap

   Copyright 2016 Achim Christ
   Released under the MIT license
   (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

\* -------------------------------------------------------------------------- */

(function() {

  // construct Headroom
  var headroom  = new Headroom(document.querySelector(".js-nvbr"), {
    "offset": Options.navbarOffset,
    "tolerance": Options.navbarTolerance
  });

  // initialize Headroom
  headroom.init();

  // add click events to sidebar nav links
  document.addEventListener("DOMContentLoaded", function() {

    // choose elements to add click event to
    var elements = document.getElementsByClassName("js-sdbr-itm");

    // iterate over elements
    for (var i = 0; elements[i]; ++i) {

      // add click event
      elements[i].addEventListener("click", function() {

        // fudge scroll position to make Headroom pin
        headroom.lastKnownScrollY = headroom.getScrollerHeight();

        // make Headroom pin even if scroll position has not changed
        window.requestAnimationFrame(function() { headroom.pin() });
      });
    }
  });
})();
