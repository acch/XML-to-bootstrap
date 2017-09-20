<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Basic HTML page
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- import other HTML templates -->
  <xsl:import href="html/meta.xsl" />
  <xsl:import href="html/banner.xsl" />
  <xsl:import href="html/navbar.xsl" />
  <xsl:import href="html/sidebar.xsl" />
  <xsl:import href="html/footer.xsl" />

  <!-- this template generates HTML code for the basic page and its grid layout,
       and calls other templates as required -->
  <xsl:template name="html.page">
    <xsl:param name="title" /><!-- string -->
    <xsl:param name="subtitle" /><!-- string -->
    <xsl:param name="head.title" select="true()" /><!-- boolean -->
    <xsl:param name="head.subtitle" select="true()" /><!-- boolean -->
    <xsl:param name="content" /><!-- node-set -->
    <xsl:param name="content.sidebar" /><!-- node-set (nav) -->
    <xsl:param name="banner.style" /><!-- string -->
    <xsl:param name="url" /><!-- string -->
    <xsl:param name="meta" /><!-- node-set -->

    <!-- check for sidebar content -->
    <xsl:variable name="sidebar" select="ext:node-set($content.sidebar)/nav/*" />

    <!-- render HTML page -->
    <xsl:call-template name="html.doctype" />
    <html lang="en">

      <!-- generate document head -->
      <xsl:call-template name="html.head">
        <xsl:with-param name="page.title">
          <xsl:if test="$head.title">
            <xsl:value-of select="$title" />
          </xsl:if>
        </xsl:with-param>
        <xsl:with-param name="page.subtitle">
          <xsl:if test="$head.subtitle">
            <xsl:value-of select="$subtitle" />
          </xsl:if>
        </xsl:with-param>
        <xsl:with-param name="page.url" select="$url" />
        <xsl:with-param name="meta" select="$meta" />
      </xsl:call-template>

      <!-- document body -->
      <body itemscope="itemscope" itemtype="http://schema.org/WebPage">

        <!-- navbar -->
        <xsl:call-template name="html.navbar">
          <xsl:with-param name="title" select="$title" />
        </xsl:call-template>

        <!-- banner -->
        <xsl:call-template name="html.banner">
          <xsl:with-param name="title" select="$title" />
          <xsl:with-param name="subtitle" select="$subtitle" />
          <xsl:with-param name="style" select="$banner.style" />
        </xsl:call-template>

        <!-- main content area -->
        <div class="container">

          <div class="row">

            <!-- width of main column depends on sidebar -->
            <xsl:variable name="maincolumn">
              <xsl:choose>
                <xsl:when test="$sidebar">
                 <xsl:value-of select="$grid.sidebar.maincolumn" />
               </xsl:when>
               <xsl:otherwise>
                 <xsl:value-of select="$grid.maincolumn" />
               </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>

            <!-- main column -->
            <div class="{$maincolumn}">

              <!-- main content -->
              <xsl:apply-templates select="ext:node-set($content)" />

            </div><!-- /main column -->

            <xsl:if test="$sidebar">
              <!-- sidebar column -->
              <div class="{$grid.sidebar.sidecolumn}">

                <!-- sidebar -->
                <xsl:call-template name="html.sidebar">
                  <xsl:with-param name="content" select="ext:node-set($content.sidebar)" />
                </xsl:call-template>

              </div><!-- /sidebar column -->
            </xsl:if>

          </div><!-- /row -->

          <!-- footer -->
          <xsl:call-template name="html.footer" />

        </div><!-- /container -->

        <!-- scripts -->
        <xsl:call-template name="html.script" />

      </body>
    </html>

  </xsl:template>

</xsl:stylesheet>
