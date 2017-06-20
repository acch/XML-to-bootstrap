<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Responsive text column
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2017 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template name="component.textcolumn">
    <xsl:param name="content" /><!-- node-set -->
    <xsl:param name="exclude" /><!-- string -->
    <xsl:param name="sidebar" select="false()" /><!-- boolean -->

    <!-- width of text column depends on sidebar -->
    <xsl:variable name="textcolumn">

      <xsl:choose>
        <xsl:when test="$sidebar">
          <xsl:value-of select="$grid.sidebar.textcolumn" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$grid.textcolumn" />
        </xsl:otherwise>
      </xsl:choose>

    </xsl:variable>

    <!-- ensure that text lines don't get too long -->
    <div class="row justify-content-center">
      <div class="{$textcolumn}">

        <!-- copy content directly -->
        <xsl:copy-of select="ext:node-set($content)" />

      </div>
    </div><!-- /row -->

  </xsl:template>

</xsl:stylesheet>
