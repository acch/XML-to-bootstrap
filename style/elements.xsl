<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Reusable page elements
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

<!-- Currently includes:
     - Breadcrumps
     - Text column
     - Pager
     - Icons (normal / on circle / in box) -->

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Breadcrumps
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
  <xsl:template name="element.breadcrumps">
    <xsl:param name="parent" /><!-- node-set (page) -->
    <xsl:param name="current" /><!-- string -->

    <!-- convert parent parameter to node-set -->
    <xsl:variable name="parent.page" select="ext:node-set($parent)/page" />

    <!-- bootstrap breadcrumps -->
    <nav class="breadcrumb x2b-brdcrmb">

      <a class="breadcrumb-item" href="{$site.url}">
        Home
      </a>

      <xsl:if test="$parent.page">
        <a class="breadcrumb-item" href="{$parent.page/@href}">
          <xsl:value-of select="$parent.page/@title" />
        </a>
      </xsl:if>

      <span class="breadcrumb-item active">
        <xsl:value-of select="$current" />
      </span>

    </nav><!-- /breadcrump -->

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Text column
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
  <xsl:template name="element.textcolumn">
    <xsl:param name="content" /><!-- node-set -->
    <xsl:param name="exclude" /><!-- string -->
    <xsl:param name="sidebar" select="false()" /><!-- boolean -->

    <!-- width of text column depends on sidebar -->
    <xsl:variable name="textcolumn">
      <xsl:choose>
        <xsl:when test="$sidebar">
          <xsl:value-of select="$style.sidebar.textcolumn" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$style.textcolumn" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- ensure that text lines don't get to long -->
    <div class="row">
      <div class="{$textcolumn}">

        <!-- copy content directly -->
        <xsl:copy-of select="ext:node-set($content)" />

      </div>
    </div>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Pager
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
  <xsl:template name="element.pager">
    <xsl:param name="next" /><!-- node-set (page) -->
    <xsl:param name="prev" /><!-- node-set (page) -->

    <!-- convert parameters to node-sets -->
    <xsl:variable name="next.page" select="ext:node-set($next)/page" />
    <xsl:variable name="prev.page" select="ext:node-set($prev)/page" />

    <!-- bootstrap buttons as pager -->
    <nav>

      <!-- check if there is a previous page -->
      <xsl:if test="$prev.page">
        <a rel="prev" title="{$prev.page/@title}" href="{$prev.page/@href}">
          <button type="button" class="[ btn btn-outline-primary ] x2b-bttn">
            <xsl:call-template name="element.icon">
              <xsl:with-param name="icon">fa-arrow-left</xsl:with-param>
            </xsl:call-template>
            Previous
            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
          </button>
        </a><!-- /prev -->
      </xsl:if>

      <!-- check if there is a next page -->
      <xsl:if test="$next.page">
        <a rel="next" title="{$next.page/@title}" href="{$next.page/@href}">
          <button type="button" class="pull-xs-right [ btn btn-outline-primary ] x2b-bttn">
            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
            Next
            <xsl:call-template name="element.icon">
              <xsl:with-param name="icon">fa-arrow-right</xsl:with-param>
            </xsl:call-template>
          </button>
        </a><!-- /next -->
      </xsl:if>

    </nav>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Icons
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- normal icon (fixed-width) -->
  <xsl:template name="element.icon">
    <xsl:param name="icon" /><!-- string-->
    <xsl:param name="size" select="fa-lg" /><!-- string -->

    <span class="fa {$icon} {$size} fa-fw" aria-hidden="true">
      <!-- prevent tag from collapsing -->
      <xsl:text> </xsl:text>
    </span>

  </xsl:template>

  <!-- icon on circle (inverted) -->
  <xsl:template name="element.icon.circled">
    <xsl:param name="icon" /><!-- string-->
    <xsl:param name="size" select="fa-lg" /><!-- string -->

    <span class="fa-stack {$size}" aria-hidden="true">
      <span class="fa fa-circle fa-stack-2x">
        <!-- prevent tag from collapsing -->
        <xsl:text> </xsl:text>
      </span>
      <span class="fa {$icon} fa-stack-1x fa-inverse">
        <!-- prevent tag from collapsing -->
        <xsl:text> </xsl:text>
      </span>
    </span>

  </xsl:template>

  <!-- icon in squared box (button) -->
  <xsl:template name="element.icon.squared">
    <xsl:param name="icon" /><!-- string-->
    <xsl:param name="size" select="fa-lg" /><!-- string -->
    <xsl:param name="disabled" select="false()" /><!-- boolean -->

    <xsl:variable name="btn.class">
      <xsl:choose>
        <xsl:when test="$disabled">btn-secondary</xsl:when>
        <xsl:otherwise>btn-primary</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <button type="button" class="[ btn {$btn.class} ] x2b-bttn">
      <xsl:if test="$disabled">
        <xsl:attribute name="disabled" />
      </xsl:if>
      <span class="fa {$icon} {$size} fa-fw" aria-hidden="true">
        <!-- prevent tag from collapsing -->
        <xsl:text> </xsl:text>
      </span>
    </button>

  </xsl:template>

</xsl:stylesheet>
