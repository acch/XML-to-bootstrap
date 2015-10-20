<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!--~~~~~~~~~~~~~~~~~~~~
        HTML5 doctype
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.doctype">

    <xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html>
]]></xsl:text>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
     HTML head elements
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.head">
    <xsl:param name="page.title" /><!-- string -->

    <!-- options -->
    <xsl:variable name="site.title" select="/site/options/option[@name = 'site.title']" />

    <head>
      <title>
        <xsl:value-of select="$site.title" /> · <xsl:value-of select="$page.title" />
      </title>

      <xsl:call-template name="html.head.meta" />
      <xsl:call-template name="html.head.link" />
    </head>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
     HTML meta elements
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.head.meta">

    <!-- options -->
    <xsl:variable name="site.author" select="/site/options/option[@name = 'site.author']" />

    <xsl:text><![CDATA[
]]></xsl:text>

    <meta charset="utf-8" />
    <meta name="author" content="{$site.author}" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
      HTML stylesheets
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.head.link">

    <xsl:text><![CDATA[
]]></xsl:text>

    <!-- stylesheets from options (CDN) -->
    <xsl:call-template name="copy.content">
      <xsl:with-param name="content" select="/site/options/option[@name = 'cdn.stylesheets']" />
    </xsl:call-template>

    <!-- custom stylesheet -->
    <link rel="stylesheet" href="/css/style.css" />

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
        HTML scripts
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.script">

    <xsl:text><![CDATA[
]]></xsl:text>

    <!-- scripts from options (CDN) -->
    <xsl:for-each select="/site/options/option[@name = 'cdn.scripts']/script">
      <script src="{@src}">;</script>
    </xsl:for-each>

    <!-- custom script -->
    <script src="/js/script.js">;</script>

  </xsl:template>

</xsl:stylesheet>
