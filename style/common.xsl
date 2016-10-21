<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  xmlns:math="http://exslt.org/math"
  xmlns:set="http://exslt.org/sets"
  extension-element-prefixes="ext math set">


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Common components
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

<!-- variables herein represent global constants, such as the ones used for the
     grid layout. templates herein are helper functions used in other
     templates. -->

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Constants
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- define our grid layout -->
  <xsl:variable name="style.maincolumn">col-xs-12</xsl:variable>
  <xsl:variable name="style.sidebar.maincolumn">col-xs-12 col-md-8</xsl:variable>
  <xsl:variable name="style.sidebar.sidecolumn">hidden-sm-down [ col-md-4 col-lg-3 offset-lg-1 ]</xsl:variable>
  <xsl:variable name="style.textcolumn">col-xs-12 col-lg-10 offset-lg-1 col-xl-8 offset-xl-2</xsl:variable>
  <xsl:variable name="style.sidebar.textcolumn">col-xs-12</xsl:variable>
  <xsl:variable name="style.cardcolumn">col-xs-12 col-md-6 col-lg-4</xsl:variable>

  <!-- generate the site's base URL -->
  <xsl:variable name="site.url">

    <!-- get base URL from options -->
    <xsl:variable name="url">
      <xsl:value-of select="/site/options/option[@name = 'site.url']" />
    </xsl:variable>

    <!-- prepend leading slashes if necessary -->
    <xsl:if test="not(starts-with($url, '//'))">
      <xsl:text>//</xsl:text>
    </xsl:if>

    <xsl:value-of select="$url" />

    <!-- append trailing slash if necessary -->
    <xsl:if test="not(substring($url, string-length($url)) = '/')"><!-- ends-with($url, '/') -->
      <xsl:text>/</xsl:text>
    </xsl:if>

  </xsl:variable>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Date format
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- will turn 2001-12-31 into 31.12.2001 -->
  <xsl:template name="format.date">
    <xsl:param name="date" /><!-- string (format 'YYYY-MM-DD') -->

    <!-- extract date -->
    <xsl:variable name="year" select="substring-before($date, '-')" />
    <xsl:variable name="month" select="format-number(substring-before(substring-after($date, '-'), '-'), '00')" />
    <xsl:variable name="day" select="format-number(substring-after(substring-after($date, '-'), '-'), '0')" />

    <!-- generate format (D)D.MM.YYYY -->
    <xsl:value-of select="concat($day, '.', $month, '.', $year)" />

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Filename format
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- make string lowercase and mask special characters -->
  <xsl:template name="format.filename">
    <xsl:param name="string" /><!-- string -->

    <xsl:value-of select="translate($string, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ äöüÄÖÜ', 'abcdefghijklmnopqrstuvwxyz-aouaou')" />

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Copy contents
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- helper for copying child element nodes and attributes (but no namespaces)
       from XML. also, adds anchor CSS class to elements with id attribute. -->
  <xsl:template name="copy.content">
    <xsl:param name="content" /><!-- node-set -->
    <xsl:param name="exclude" /><!-- string -->

    <!-- find all child elements excluding specific names -->
    <xsl:for-each select="ext:node-set($content)/*[not(name() = $exclude)]">

      <!-- generate element without namespace -->
      <xsl:element name="{name()}">

        <!-- add anchor class to elements with id attribute -->
        <xsl:if test="@id">
          <xsl:attribute name="class">x2b-anchr</xsl:attribute>
        </xsl:if>

        <!-- copy attributes and child nodes -->
        <xsl:apply-templates select="node()|@*" />

      </xsl:element>

    </xsl:for-each>

  </xsl:template>

  <xsl:template match="node()|@*" priority="-1">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" />
    </xsl:copy>
  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Replace strings
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- replace all occurences of one string with another -->
  <xsl:template name="string.replace">
    <xsl:param name="string" /><!-- string -->
    <xsl:param name="search" /><!-- string -->
    <xsl:param name="replace" /><!-- string -->

    <xsl:choose>

      <!-- check if one of the parameters is empty -->
      <xsl:when test="$string = '' or $search = ''">
        <!-- prevent this routine from hanging -->
        <xsl:value-of select="$string" disable-output-escaping="yes" />
      </xsl:when>

      <!-- check if text contains string -->
      <xsl:when test="contains($string, $search)">

        <!-- replace first occurence -->
        <xsl:value-of select="substring-before($string, $search)" disable-output-escaping="yes" />
        <xsl:value-of select="$replace" disable-output-escaping="yes" />

        <!-- continue with remaining text -->
        <xsl:call-template name="string.replace">
          <xsl:with-param name="string" select="substring-after($string, $search)" />
          <xsl:with-param name="search" select="$search" />
          <xsl:with-param name="replace" select="$replace" />
        </xsl:call-template>

      </xsl:when>

      <!-- string not found (any more) -->
      <xsl:otherwise>
        <xsl:value-of select="$string" disable-output-escaping="yes" />
      </xsl:otherwise>

    </xsl:choose>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Find distinct years
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- find distinct years of elements with a date -->
  <xsl:template name="date.years">
    <xsl:param name="elements" /><!-- node-set (with 'date' child) -->

    <!-- find all years -->
    <xsl:variable name="years">
      <xsl:for-each select="ext:node-set($elements)/date">
        <year><xsl:value-of select="substring-before(text(), '-')" /></year>
      </xsl:for-each>
    </xsl:variable>

    <!-- find distinct years -->
    <xsl:for-each select="set:distinct(ext:node-set($years)/year)">
      <year><xsl:value-of select="text()" /></year>
    </xsl:for-each>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Previous element by date
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- find title of element with a date closest before the specified date -->
  <xsl:template name="date.prev.title">
    <xsl:param name="date" /><!-- string (format 'YYYY-MM-DD') -->
    <xsl:param name="elements" /><!-- node-set (with 'title' and 'date' children) -->

    <xsl:variable name="date.raw" select="translate($date, '-', '')" />

    <!-- find all elements with a date before the specified date -->
    <xsl:variable name="elements.before">
      <xsl:for-each select="ext:node-set($elements)[translate(date, '-', '') &lt; $date.raw]">
        <element title="{title}">
          <xsl:value-of select="translate(date, '-', '')" />
        </element>
      </xsl:for-each>
    </xsl:variable>

    <!-- find title of latest element -->
    <xsl:value-of select="math:highest(ext:node-set($elements.before)/element)/@title" />

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Next element by date
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- find title of element with a date closest after the specified date -->
  <xsl:template name="date.next.title">
    <xsl:param name="date" /><!-- string (format 'YYYY-MM-DD') -->
    <xsl:param name="elements" /><!-- node-set (with 'title' and 'date' children) -->

    <xsl:variable name="date.raw" select="translate($date, '-', '')" />

    <!-- find all elements with a date after the specified date -->
    <xsl:variable name="elements.after">
      <xsl:for-each select="ext:node-set($elements)[translate(date, '-', '') &gt; $date.raw]">
        <element title="{title}">
          <xsl:value-of select="translate(date, '-', '')" />
        </element>
      </xsl:for-each>
    </xsl:variable>

    <!-- find title of earliest element -->
    <xsl:value-of select="math:lowest(ext:node-set($elements.after)/element)/@title" />

  </xsl:template>

</xsl:stylesheet>
