<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Anchored headings
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2017 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

<!-- replace headings with anchored equivalent -->

  <xsl:template match="h2|h3|h4|h5|h6">

    <xsl:copy>

      <!-- add .anchored class -->
      <xsl:attribute name="class">
        <xsl:text>anchored</xsl:text>
      </xsl:attribute>

      <!-- copy attributes and child nodes -->
      <xsl:apply-templates select="node()|@*" />

    </xsl:copy>

  </xsl:template>

</xsl:stylesheet>
