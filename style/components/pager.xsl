<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Pager
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2017 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template name="component.pager">
    <xsl:param name="next" /><!-- node-set (page) -->
    <xsl:param name="prev" /><!-- node-set (page) -->

    <!-- convert parameters to node-sets -->
    <xsl:variable name="next.page" select="ext:node-set($next)/page" />
    <xsl:variable name="prev.page" select="ext:node-set($prev)/page" />

    <!-- check if pager is necessary -->
    <xsl:if test="$next.page or $prev.page">

      <!-- flexbox container -->
      <nav class="d-flex">

        <!-- check if there is a previous page -->
        <xsl:if test="$prev.page">

          <!-- previous button -->
          <a class="btn btn-outline-primary" rel="prev" title="{$prev.page/@title}" href="{$prev.page/@href}" role="button">
            <xsl:call-template name="component.icon">
              <xsl:with-param name="icon">fa-arrow-left</xsl:with-param>
            </xsl:call-template>
            <xsl:text>&#160;Previous</xsl:text>
            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
          </a><!-- /prev -->

        </xsl:if>

        <!-- check if there is a next page -->
        <xsl:if test="$next.page">

          <!-- next button -->
          <a class="[ btn btn-outline-primary ] ml-auto" rel="next" title="{$next.page/@title}" href="{$next.page/@href}" role="button">
            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
            <xsl:text>Next&#160;</xsl:text>
            <xsl:call-template name="component.icon">
              <xsl:with-param name="icon">fa-arrow-right</xsl:with-param>
            </xsl:call-template>
          </a><!-- /next -->

        </xsl:if>

      </nav>

    </xsl:if>

  </xsl:template>

</xsl:stylesheet>
