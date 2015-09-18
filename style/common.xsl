<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  xmlns:math="http://exslt.org/math"
  xmlns:set="http://exslt.org/sets"
  extension-element-prefixes="ext math set">


<!--~~~~~~~~~~~~~~~~~~~~
         Date format
    ~~~~~~~~~~~~~~~~~~~~-->
<!-- will turn 2001-12-31 into 31.12.2001 -->

  <xsl:template name="format.date">
    <xsl:param name="date" /><!-- string (format 'YYYY-MM-DD') -->

    <xsl:variable name="year" select="substring-before($date, '-')" />
    <xsl:variable name="month" select="format-number(substring-before(substring-after($date, '-'), '-'), '00')" />
    <xsl:variable name="day" select="format-number(substring-after(substring-after($date, '-'), '-'), '0')" />

    <xsl:value-of select="concat($day, '.', $month, '.', $year)" />

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
       Filename format
    ~~~~~~~~~~~~~~~~~~~~-->
<!-- make string lowercase and mask special characters -->

  <xsl:template name="format.filename">
    <xsl:param name="string" /><!-- string -->

    <xsl:value-of select="translate($string, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ äöüÄÖÜ', 'abcdefghijklmnopqrstuvwxyz_aouaou')" />

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
        Copy contents
    ~~~~~~~~~~~~~~~~~~~~-->
<!-- helper for copying child element nodes and attributes (but no namespaces)
     from XML. also, adds anchor CSS class to elements with id attribute -->

  <xsl:template name="copy.content">
    <xsl:param name="content" /><!-- node-set -->
    <xsl:param name="exclude" /><!-- string -->

    <!-- find all child elements excluding specific names -->
    <xsl:for-each select="$content/*[not(name() = $exclude)]">

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


<!--~~~~~~~~~~~~~~~~~~~~
       Distinct years
    ~~~~~~~~~~~~~~~~~~~~-->
<!-- find distinct years of elements with a date -->

  <xsl:template name="date.years">
    <xsl:param name="elements" /><!-- node-set (with 'date' child) -->

    <!-- find all years -->
    <xsl:variable name="years">
      <xsl:for-each select="$elements/date">
        <year><xsl:value-of select="substring-before(text(), '-')" /></year>
      </xsl:for-each>
    </xsl:variable>

    <!-- find distinct years -->
    <xsl:for-each select="set:distinct(ext:node-set($years)/year)">
      <year><xsl:value-of select="text()" /></year>
    </xsl:for-each>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
      Previous element
    ~~~~~~~~~~~~~~~~~~~~-->
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


<!--~~~~~~~~~~~~~~~~~~~~
        Next element
    ~~~~~~~~~~~~~~~~~~~~-->
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
