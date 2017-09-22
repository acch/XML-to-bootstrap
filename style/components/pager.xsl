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

  <!-- this template generates HTML code for the navigation pager -->
  <xsl:template name="component.pager">
    <xsl:param name="next" /><!-- node-set (page) -->
    <xsl:param name="prev" /><!-- node-set (page) -->

    <!-- convert parameters to node-sets -->
    <xsl:variable name="next.page" select="ext:node-set($next)/page" />
    <xsl:variable name="prev.page" select="ext:node-set($prev)/page" />

    <!-- check if pager is necessary -->
    <xsl:if test="$next.page or $prev.page">

      <!-- flexbox container -->
      <div role="navigation" class="d-flex" itemscope="itemscope" itemtype="http://schema.org/SiteNavigationElement">

        <!-- check if there is a previous page -->
        <xsl:if test="$prev.page">

          <!-- previous button -->
          <a role="button" class="btn btn-outline-primary" rel="prev" title="{$prev.page/@title}" href="{$prev.page/@href}">
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
          <a role="button" class="[ btn btn-outline-primary ] ml-auto" rel="next" title="{$next.page/@title}" href="{$next.page/@href}">
            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
            <xsl:text>Next&#160;</xsl:text>
            <xsl:call-template name="component.icon">
              <xsl:with-param name="icon">fa-arrow-right</xsl:with-param>
            </xsl:call-template>
          </a><!-- /next -->

        </xsl:if>

      </div>

    </xsl:if>

  </xsl:template>

</xsl:stylesheet>
