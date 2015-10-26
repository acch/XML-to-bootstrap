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
    var elements = document.getElementsByClassName("x2b-sdbr-lnk");

    // iterate over elements
    for (var i = 0; elements[i]; ++i) {
      // add click event
      elements[i].onclick = function() {
        // fudge scroll position to make Headroom pin
        headroom.lastKnownScrollY = headroom.getScrollerHeight();

        // make Headroom pin even if scroll position has not changed
        window.requestAnimationFrame(function() { headroom.pin() });
      }
    }
  });
})();
