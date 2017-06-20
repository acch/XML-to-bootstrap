<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Galleries sitemap
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2017 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template name="galleries.sitemap">

    <xsl:for-each select="/site/galleries/gallery[not(@draft)]">

      <!-- format filename -->
      <xsl:variable name="filename">
        <xsl:call-template name="format.filename">
          <xsl:with-param name="string" select="title" />
        </xsl:call-template>
      </xsl:variable>

      <!-- gallery detail page URL -->
      <url>
        <loc>
          <xsl:text>https:</xsl:text>
          <xsl:value-of select="$site.url" />
          <xsl:value-of select="$gallery.path" />
          <xsl:value-of select="$filename" />
          <xsl:text>.html</xsl:text>
        </loc>
        <lastmod>
          <xsl:value-of select="date" />
        </lastmod>
      </url>

    </xsl:for-each>

  </xsl:template>

</xsl:stylesheet>
