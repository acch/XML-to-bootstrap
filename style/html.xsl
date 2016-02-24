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
     (https://github.com/acch/scrollpos-styler/blob/master/LICENSE)

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
    <xsl:param name="content" /><!-- node-set -->
    <xsl:param name="content.sidebar" /><!-- node-set (nav) -->
    <xsl:param name="banner.style" /><!-- string -->

    <!-- check for sidebar content -->
    <xsl:variable name="sidebar" select="ext:node-set($content.sidebar)/nav/*" />

    <!-- render HTML page -->
    <xsl:call-template name="html.doctype" />
    <html lang="en">

      <!-- generate document head -->
      <xsl:call-template name="html.head">
        <xsl:with-param name="page.title" select="$title" />
      </xsl:call-template>

      <!-- document body -->
      <body class="x2b-bdy">

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
              <xsl:if test="$sidebar">
               <xsl:text> </xsl:text>
               <xsl:value-of select="$style.sidebar.maincolumn" />
              </xsl:if>
            </xsl:variable>

            <!-- main column -->
            <article class="{$style.maincolumn}{$maincolumn}">

              <!-- main content -->
              <xsl:apply-templates select="$content" />

            </article><!-- /main column -->

            <xsl:if test="$sidebar">
              <!-- sidebar column -->
              <aside class="x2b-sdbr {$style.sidebar.sidecolumn}">

                <!-- sidebar -->
                <xsl:call-template name="html.sidebar">
                  <xsl:with-param name="content" select="$content.sidebar" />
                </xsl:call-template>

              </aside><!-- /sidebar column -->
            </xsl:if>

          </div><!-- /row -->
        </div><!-- /container -->

        <!-- footer -->
        <xsl:call-template name="html.footer" />

        <!-- scripts -->
        <xsl:call-template name="html.script" />

      </body>
    </html>

  </xsl:template>

</xsl:stylesheet>
