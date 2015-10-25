(function() {
  // construct Headroom
  var headroom  = new Headroom(document.querySelector(".js-nvbr"), {
    "offset": Options.navbarOffset,
    "tolerance": Options.navbarTolerance
  });

  // initialize Headroom
  headroom.init();
})();
