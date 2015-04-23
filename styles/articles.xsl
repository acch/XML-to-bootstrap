<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">

  <!-- Article pages -->
  <xsl:template name="articles">

    <!-- Article overview page -->
    <ext:document
      href="articles.html"
      method="xml"
      omit-xml-declaration="yes"
      encoding="utf-8"
      indent="yes">

      <xsl:call-template name="html.page">
        <xsl:with-param name="title">Articles</xsl:with-param>
        <xsl:with-param name="content" select="/site/articles" />
      </xsl:call-template>

    </ext:document>

    <!-- Article detail pages -->
    <xsl:for-each select="/site/articles/article">

      <xsl:variable name="filename">
        <xsl:call-template name="format.filename">
          <xsl:with-param name="string" select="title" />
        </xsl:call-template>
      </xsl:variable>

      <ext:document
        href="article.{$filename}.html"
        method="xml"
        omit-xml-declaration="yes"
        encoding="utf-8"
        indent="yes">

        <xsl:call-template name="html.page">
          <xsl:with-param name="content" select="." />
        </xsl:call-template>

      </ext:document>

    </xsl:for-each>

  </xsl:template>

  <!-- Article overview content -->
  <xsl:template match="articles">

    <xsl:for-each select="article">
      <xsl:sort select="date" order="descending" />

      <div class="row">
        <div class="col-sm-12" style="background-color:lavender;">
          <h2><xsl:value-of select="title" /><xsl:text> </xsl:text><small><xsl:value-of select="subtitle" /></small></h2>
          <p class="small"><xsl:value-of select="short" /></p>
          <p><xsl:value-of select="content" /></p>
          <p>// <xsl:call-template name="format.date">
            <xsl:with-param name="date" select="date" />
          </xsl:call-template></p>
        </div>
      </div>

      <xsl:if test="position()!=last()">
        <hr />
      </xsl:if>

    </xsl:for-each>

  </xsl:template>

</xsl:stylesheet>
