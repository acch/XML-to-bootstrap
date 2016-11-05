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
     - Icons (normal / in circle / in button)
     - Semantic data (microdata)
     - Responsive picture -->

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Breadcrumbs
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template name="element.breadcrumbs">
    <xsl:param name="parent" /><!-- node-set (page) -->
    <xsl:param name="current" /><!-- string -->

    <!-- convert parent parameter to node-set -->
    <xsl:variable name="parent.page" select="ext:node-set($parent)/page" />

    <!-- Bootstrap breadcrumbs -->
    <nav class="breadcrumb x2b-brdcrmb">

      <!-- home -->
      <a class="breadcrumb-item" href="{$site.url}">Home</a>

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
          <xsl:value-of select="$grid.sidebar.textcolumn" />
        </xsl:when>

        <xsl:otherwise>
          <xsl:value-of select="$grid.textcolumn" />
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

    <!-- check if pager is necessary -->
    <xsl:if test="$next.page or $prev.page">

      <!-- Bootstrap buttons used as pager -->
      <nav>

        <!-- check if there is a previous page -->
        <xsl:if test="$prev.page">

          <!-- previous button -->
          <a class="[ btn btn-outline-primary ] x2b-bttn" rel="prev" title="{$prev.page/@title}" href="{$prev.page/@href}" role="button">
            <xsl:call-template name="element.icon">
              <xsl:with-param name="icon">fa-arrow-left</xsl:with-param>
            </xsl:call-template>&#160;<xsl:text>Previous</xsl:text>
            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
          </a><!-- /prev -->

        </xsl:if>

        <!-- check if there is a next page -->
        <xsl:if test="$next.page">

          <!-- next button -->
          <a class="float-xs-right [ btn btn-outline-primary ] x2b-bttn" rel="next" title="{$next.page/@title}" href="{$next.page/@href}" role="button">
            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
            <xsl:text>Next</xsl:text>&#160;<xsl:call-template name="element.icon">
              <xsl:with-param name="icon">fa-arrow-right</xsl:with-param>
            </xsl:call-template>
          </a><!-- /next -->

        </xsl:if>

      </nav>

    </xsl:if>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Icons
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- normal icon (fixed-width) -->
  <xsl:template name="element.icon">
    <xsl:param name="icon" /><!-- string-->
    <xsl:param name="size">fa-1x</xsl:param><!-- string -->

    <!-- fontawesome icon -->
    <span class="fa {$icon} {$size} fa-fw" aria-hidden="true">
      <xsl:text> </xsl:text><!-- prevent tag from collapsing -->
    </span>

  </xsl:template>


  <!-- icon in circle (inverted) -->
  <xsl:template name="element.icon.circled">
    <xsl:param name="icon" /><!-- string-->
    <xsl:param name="size">fa-lg</xsl:param><!-- string -->

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


  <!-- icon in button (squared box) -->
  <xsl:template name="element.icon.button">
    <xsl:param name="title" /><!-- string-->
    <xsl:param name="href" /><!-- string-->
    <xsl:param name="icon" /><!-- string-->
    <xsl:param name="size">fa-lg</xsl:param><!-- string -->
    <xsl:param name="disabled" select="false()" /><!-- boolean -->

    <!-- style depends on disabled state -->
    <xsl:variable name="btn.class">
      <xsl:choose>
        <xsl:when test="$disabled">btn-secondary disabled</xsl:when>
        <xsl:otherwise>btn-primary</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Bootstrap button with fontawesome icon inside -->
    <a class="[ btn {$btn.class} ] x2b-bttn" role="button">

      <!-- optional title -->
      <xsl:if test="$title != ''">
        <xsl:attribute name="title">
          <xsl:value-of select="$title" />
        </xsl:attribute>
      </xsl:if>

      <!-- optional href -->
      <xsl:if test="$href != ''">
        <xsl:attribute name="href">
          <xsl:value-of select="$href" />
        </xsl:attribute>
      </xsl:if>

      <span class="fa {$icon} {$size} fa-fw" aria-hidden="true">
        <xsl:text> </xsl:text><!-- prevent tag from collapsing -->
      </span>

    </a>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Semantic data (microdata)
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- this template generates (invisible) meta tags with semantic
       information -->
  <xsl:template name="element.data.meta">
    <xsl:param name="title" /><!-- string-->
    <xsl:param name="subtitle" /><!-- string-->

    <!-- Schema.org microdata -->
    <meta itemprop="name headline">
      <xsl:attribute name="content">

        <!-- page title -->
        <xsl:value-of select="$title" />

        <!-- optional subtitle -->
        <xsl:if test="$subtitle != ''">
          <xsl:text>: </xsl:text>
          <xsl:value-of select="subtitle" />
        </xsl:if>

      </xsl:attribute>
    </meta>

    <xsl:variable name="author" select="/site/options/option[@name = 'site.author']" />
    <xsl:variable name="publisher" select="/site/options/option[@name = 'site.title']" />

    <div itemprop="author" itemscope="itemscope" itemtype="http://schema.org/Person">
      <meta itemprop="name" content="{$author}" />
    </div>
    <div itemprop="publisher" itemscope="itemscope" itemtype="http://schema.org/Organization">
      <meta itemprop="name" content="{$publisher}" />
    </div>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Responsive picture
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template name="element.picture">
    <xsl:param name="src" /><!-- string -->
    <xsl:param name="alt" /><!-- string -->

    <!-- responsive image element -->
    <picture>

      <!-- fallback and default -->
      <img alt="{$alt}">

        <!-- add prefix to src attribute -->
        <xsl:attribute name="src">

          <!-- prepend static URL if necessary -->
          <xsl:if test="not(starts-with($src, '//'))">
            <xsl:value-of select="$site.static.url" />
          </xsl:if>

          <!-- remove trailing slash if necessary -->
          <xsl:choose>
            <xsl:when test="starts-with($src, '/') and not(starts-with($src, '//'))">
              <xsl:value-of select="substring-after($src, '/')" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$src" />
            </xsl:otherwise>
          </xsl:choose>

        </xsl:attribute>

      </img>

    </picture>

  </xsl:template>

</xsl:stylesheet>
