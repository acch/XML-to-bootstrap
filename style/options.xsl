<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Export options
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- this template generates a JSON file holding options used in javascript
       code. the options are defined in the XML document. -->
  <xsl:template name="options">

    <!-- generate javascript options -->
    <ext:document
      href="../js/options.json"
      method="text"
      omit-xml-declaration="yes"
      encoding="utf-8"
      indent="no">var Options = {<xsl:for-each select="/site/options/export[@type = 'js']/option">
  "<xsl:value-of select="@name" />": <xsl:value-of select="current()" /><xsl:choose>
    <xsl:when test="position() != last()">,</xsl:when>
  </xsl:choose>
</xsl:for-each>
};</ext:document>

  </xsl:template>

</xsl:stylesheet>
