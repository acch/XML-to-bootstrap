<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Sitemap
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- this template generates XML code for the sitemap -->
  <xsl:template name="sitemap">

    <!-- generate sitemap.xml -->
    <ext:document
      href="sitemap.xml"
      method="xml"
      omit-xml-declaration="no"
      encoding="utf-8"
      indent="yes">

      <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">

        <!-- home page uri -->
        <url>
          <loc>
            <xsl:text>https:</xsl:text>
            <xsl:value-of select="$site.url" />
          </loc>
        </url>

        <!-- index article pages -->
        <xsl:if test="$articles">
          <xsl:for-each select="/site/articles/article[not(@draft)]">

            <!-- format filename -->
            <xsl:variable name="filename">
              <xsl:call-template name="format.filename">
                <xsl:with-param name="string" select="title" />
              </xsl:call-template>
            </xsl:variable>

            <!-- article detail page uri -->
            <url>
              <loc>
                <xsl:text>https:</xsl:text>
                <xsl:value-of select="$site.url" />
                <xsl:value-of select="$article.path" />
                <xsl:value-of select="$filename" />
                <xsl:text>.html</xsl:text>
              </loc>
              <lastmod>
                <xsl:value-of select="date" />
              </lastmod>
            </url>

          </xsl:for-each>
        </xsl:if>

        <!-- index project pages -->
        <xsl:if test="$projects">
          <xsl:for-each select="/site/projects/project[not(@draft)]">

            <!-- format filename -->
            <xsl:variable name="filename">
              <xsl:call-template name="format.filename">
                <xsl:with-param name="string" select="title" />
              </xsl:call-template>
            </xsl:variable>

            <!-- project detail page uri -->
            <url>
              <loc>
                <xsl:text>https:</xsl:text>
                <xsl:value-of select="$site.url" />
                <xsl:value-of select="$project.path" />
                <xsl:value-of select="$filename" />
                <xsl:text>.html</xsl:text>
              </loc>
              <lastmod>
                <xsl:value-of select="date" />
              </lastmod>
            </url>

          </xsl:for-each>
        </xsl:if>

        <!-- index gallery pages -->
        <xsl:if test="$galleries">
          <xsl:for-each select="/site/galleries/gallery[not(@draft)]">

            <!-- format filename -->
            <xsl:variable name="filename">
              <xsl:call-template name="format.filename">
                <xsl:with-param name="string" select="title" />
              </xsl:call-template>
            </xsl:variable>

            <!-- article detail page uri -->
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
        </xsl:if>

      </urlset>

    </ext:document>

  </xsl:template>

</xsl:stylesheet>
