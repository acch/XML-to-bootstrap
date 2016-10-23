<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Gallery pages
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- import other gallery templates -->
  <xsl:import href="galleries/overview.xsl" />
  <xsl:import href="galleries/detail.xsl" />

  <!-- this template generates HTML code for gallery overview and detail
       pages -->
  <xsl:template name="galleries">

    <!-- generate gallery overview page -->
    <ext:document
      href="galleries.html"
      method="xml"
      omit-xml-declaration="yes"
      encoding="utf-8"
      indent="yes">

      <xsl:call-template name="html.page">
        <xsl:with-param name="title" select="/site/galleries/title" />
        <xsl:with-param name="subtitle" select="/site/galleries/subtitle" />
        <xsl:with-param name="content" select="/site/galleries" />
        <xsl:with-param name="url">galleries.html</xsl:with-param>
        <xsl:with-param name="meta" select="$meta.noindex.follow" />
      </xsl:call-template>

    </ext:document>

    <!-- iterate over all galleries -->
    <xsl:for-each select="/site/galleries/gallery">

      <!-- format filename -->
      <xsl:variable name="filename">
        <xsl:call-template name="format.filename">
          <xsl:with-param name="string" select="title" />
        </xsl:call-template>
      </xsl:variable>

      <!-- generate gallery detail page -->
      <ext:document
        href="gallery/{$filename}.html"
        method="xml"
        omit-xml-declaration="yes"
        encoding="utf-8"
        indent="yes">

        <xsl:call-template name="html.page">
          <xsl:with-param name="title" select="title" />
          <xsl:with-param name="subtitle" select="subtitle" />
          <xsl:with-param name="content" select="current()" />
          <xsl:with-param name="url">gallery/{$filename}.html</xsl:with-param>
          <xsl:with-param name="meta">
            <xsl:if test="@draft">
              <xsl:copy-of select="$meta.noindex" />
            </xsl:if>
          </xsl:with-param>
        </xsl:call-template>

      </ext:document>

    </xsl:for-each>

  </xsl:template>

</xsl:stylesheet>
