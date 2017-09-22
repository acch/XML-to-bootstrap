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

<!-- this template generates a JSON file holding options used in JavaScript
     code. the options are defined in the XML document. -->
  <xsl:template name="options">

    <!-- generate JavaScript (JSON) file -->
    <ext:document
      href="../js/options.json"
      method="text"
      omit-xml-declaration="yes"
      encoding="utf-8"
      indent="no">

      <!-- options object -->
      <xsl:text>var Options = { </xsl:text>

      <!-- for all JSON options -->
      <xsl:for-each select="/site/options/export[@type = 'json']/option">

        <!-- compute definition -->
        <xsl:text>"</xsl:text>
        <xsl:value-of select="@name" />
        <xsl:text>": </xsl:text>
        <xsl:value-of select="current()" />

        <xsl:if test="position() != last()">
          <xsl:text>, </xsl:text>
        </xsl:if>

      </xsl:for-each>

      <xsl:text> };</xsl:text>
    </ext:document>

  </xsl:template>

</xsl:stylesheet>
