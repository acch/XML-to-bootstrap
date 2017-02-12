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

  // add click events on DOMContentLoaded
  document.addEventListener("DOMContentLoaded", function() {

    // private function to add click event to elements
    function addClickEvent(elements) {

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
    };

    // choose elements to add click event to
    addClickEvent(document.getElementsByClassName("js-sdbr-itm"));
    addClickEvent(document.getElementsByClassName("anchorjs-link"));

  });
})();
