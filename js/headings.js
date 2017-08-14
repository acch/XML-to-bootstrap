/* -------------------------------------------------------------------------- *\
   JavaScript for headings with deep anchor links
   --------------------------------------------------------------------------

   This file is part of XML-to-bootstrap.
   https://github.com/acch/XML-to-bootstrap

   Copyright 2017 Achim Christ
   Released under the MIT license
   (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

\* -------------------------------------------------------------------------- */

(function() {

  // check if document is already loaded
  if (document.readyState !== "loading") {

    // add anchors immediately
    window.setTimeout(function() {

      // choose elements to add anchors to
      anchors.add('.anchored');

    }, 1);

  } else {

    // add anchors on DOMContentLoaded
    document.addEventListener("DOMContentLoaded", function() {

      // choose elements to add anchors to
      anchors.add('.anchored');

    });

  }

})();
