<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Gallery detail page
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Gallery detail page contents
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="gallery">

    <!-- format date -->
    <xsl:variable name="date.formatted">
      <xsl:call-template name="format.date">
        <xsl:with-param name="date" select="date" />
      </xsl:call-template>
    </xsl:variable>

    <!-- navigation breadcrumbs -->
    <xsl:call-template name="element.breadcrumbs">
      <xsl:with-param name="parent">
        <page title="{/site/galleries/title}" href="{$site.url}galleries.html" />
      </xsl:with-param>
      <xsl:with-param name="current" select="title" />
    </xsl:call-template>

    <!-- spacing -->
    <hr class="invisible my-1" />

    <!-- gallery introduction -->
    <p>
      <span class="text-muted">
        //&#160;<xsl:value-of select="$date.formatted" />
      </span>

      <br />

      <xsl:value-of select="short" />
    </p>

    <!-- spacing -->
    <hr class="invisible my-1" />

    <!-- copy content from XML directly -->
    <xsl:call-template name="copy.content">
      <xsl:with-param name="content" select="content" />
    </xsl:call-template>

    <!-- spacing -->
    <hr class="invisible my-1" />

    <!-- find latest gallery before current one -->
    <xsl:variable name="prev">
      <xsl:call-template name="date.prev.title">
        <xsl:with-param name="date" select="date" />
        <xsl:with-param name="elements" select="../gallery" />
      </xsl:call-template>
    </xsl:variable>

    <!-- find earliest gallery after current one -->
    <xsl:variable name="next">
      <xsl:call-template name="date.next.title">
        <xsl:with-param name="date" select="date" />
        <xsl:with-param name="elements" select="../gallery" />
      </xsl:call-template>
    </xsl:variable>

    <!-- pager navigation -->
    <xsl:call-template name="element.pager">

      <!-- previous gallery -->
      <xsl:with-param name="prev">
        <xsl:if test="$prev != ''">
          <page title="{$prev}">
            <xsl:attribute name="href"><xsl:value-of select="$site.url" />gallery/<xsl:call-template name="format.filename">
              <xsl:with-param name="string" select="$prev" />
            </xsl:call-template>.html</xsl:attribute>
          </page>
        </xsl:if>
      </xsl:with-param>

      <!-- next gallery -->
      <xsl:with-param name="next">
        <xsl:if test="$next != ''">
          <page title="{$next}">
            <xsl:attribute name="href"><xsl:value-of select="$site.url" />gallery/<xsl:call-template name="format.filename">
              <xsl:with-param name="string" select="$next" />
            </xsl:call-template>.html</xsl:attribute>
          </page>
        </xsl:if>
      </xsl:with-param>

    </xsl:call-template>

  </xsl:template>

</xsl:stylesheet>
