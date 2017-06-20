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

        <!-- home page URL -->
        <url>
          <loc>
            <xsl:text>https:</xsl:text>
            <xsl:value-of select="$site.url" />
          </loc>
        </url>

        <!-- index article pages if enabled -->
        <xsl:if test="$articles">
          <xsl:call-template name="articles.sitemap" />
        </xsl:if>

        <!-- index project pages if enabled -->
        <xsl:if test="$projects">
          <xsl:call-template name="projects.sitemap" />
        </xsl:if>

        <!-- index gallery pages if enabled -->
        <xsl:if test="$galleries">
          <xsl:call-template name="galleries.sitemap" />
        </xsl:if>

      </urlset>

    </ext:document>

  </xsl:template>

</xsl:stylesheet>
