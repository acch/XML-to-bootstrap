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

<!-- templates herein generate various elements which can optionally be used on
     pages. this currently includes:
     - Breadcrumbs
     - Responsive text column
     - Pager
     - Icons (normal / on circle / in box) -->

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Breadcrumbs
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template name="element.breadcrumbs">
    <xsl:param name="parent" /><!-- node-set (page) -->
    <xsl:param name="current" /><!-- string -->

    <!-- convert parent parameter to node-set -->
    <xsl:variable name="parent.page" select="ext:node-set($parent)/page" />

    <!-- bootstrap breadcrumbs -->
    <nav class="breadcrumb x2b-brdcrmb">

      <!-- home -->
      <a class="breadcrumb-item" href="{$site.url}">
        Home
      </a>

      <!-- optional category page -->
      <xsl:if test="$parent.page">
        <a class="breadcrumb-item" href="{$parent.page/@href}">
          <xsl:value-of select="$parent.page/@title" />
        </a>
      </xsl:if>

      <!-- current page -->
      <span class="breadcrumb-item active">
        <xsl:value-of select="$current" />
      </span>

    </nav><!-- /breadcrumb -->

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Responsive text column
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

    <!-- ensure that text lines don't get too long -->
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

    <!-- bootstrap buttons used as pager -->
    <nav>

      <!-- check if there is a previous page -->
      <xsl:if test="$prev.page">

        <!-- previous button -->
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

        <!-- next button -->
        <a rel="next" title="{$next.page/@title}" href="{$next.page/@href}">
          <button type="button" class="float-xs-right [ btn btn-outline-primary ] x2b-bttn">
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

    <!-- fontawesome icon -->
    <span class="fa {$icon} {$size} fa-fw" aria-hidden="true">
      <xsl:text> </xsl:text><!-- prevent tag from collapsing -->
    </span>

  </xsl:template>


  <!-- icon in circle (inverted) -->
  <xsl:template name="element.icon.circled">
    <xsl:param name="icon" /><!-- string-->
    <xsl:param name="size" select="fa-lg" /><!-- string -->

    <!-- two fontawesome icons stacked onto each other -->
    <span class="fa-stack {$size}" aria-hidden="true">

      <span class="fa fa-circle fa-stack-2x">
        <xsl:text> </xsl:text><!-- prevent tag from collapsing -->
      </span>

      <span class="fa {$icon} fa-stack-1x fa-inverse">
        <xsl:text> </xsl:text><!-- prevent tag from collapsing -->
      </span>

    </span>

  </xsl:template>


  <!-- icon in squared box (button) -->
  <xsl:template name="element.icon.squared">
    <xsl:param name="icon" /><!-- string-->
    <xsl:param name="size" select="fa-lg" /><!-- string -->
    <xsl:param name="disabled" select="false()" /><!-- boolean -->

    <!-- style depends on disabled state -->
    <xsl:variable name="btn.class">
      <xsl:choose>
        <xsl:when test="$disabled">btn-secondary</xsl:when>
        <xsl:otherwise>btn-primary</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- bootstrap button with fontawesome icon inside -->
    <button type="button" class="[ btn {$btn.class} ] x2b-bttn">

      <xsl:if test="$disabled">
        <xsl:attribute name="disabled" />
      </xsl:if>

      <span class="fa {$icon} {$size} fa-fw" aria-hidden="true">
        <xsl:text> </xsl:text><!-- prevent tag from collapsing -->
      </span>

    </button>

  </xsl:template>

</xsl:stylesheet>
