(function() {
  var headroom  = new Headroom(document.querySelector(".js-nvbr"), {
    "offset": Options.navbar_offset,
    "tolerance": Options.navbar_tolerance
  });
  headroom.init();
})();
