<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">

  <!-- Import other HTML templates -->
  <xsl:import href="html/meta.xsl" />
  <xsl:import href="html/banner.xsl" />
  <xsl:import href="html/navbar.xsl" />
  <xsl:import href="html/sidebar.xsl" />
  <xsl:import href="html/footer.xsl" />


<!--~~~~~~~~~~~~~~~~~~~~
          HTML page
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.page">
    <xsl:param name="title" /><!-- string -->
    <xsl:param name="subtitle" /><!-- string -->
    <xsl:param name="content" /><!-- node-set -->
    <xsl:param name="content.sidebar" /><!-- node-set (nav) -->
    <xsl:param name="banner.style" /><!-- string -->

    <!-- check for sidebar content -->
    <xsl:variable name="sidebar" select="ext:node-set($content.sidebar)/nav/*" />

    <!-- compute width of main column -->
    <xsl:variable name="maincolumn.class">
      <xsl:if test="$sidebar"> col-sm-9 col-md-8</xsl:if>
    </xsl:variable>

    <!-- render HTML page -->
    <xsl:call-template name="html.doctype" />
    <html lang="en">

      <xsl:call-template name="html.head">
        <xsl:with-param name="page.title" select="$title" />
      </xsl:call-template>

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

        <div class="container">
          <!-- content area -->
          <div class="row">

            <!-- main column -->
            <article class="col-xs-12{$maincolumn.class}">

              <!-- main content -->
              <xsl:apply-templates select="$content" />

            </article><!-- /main column -->

            <xsl:if test="$sidebar">
              <!-- sidebar column -->
              <aside class="hidden-xs [ col-sm-3 col-md-offset-1 ] x2b-sdbr">

                <!-- sidebar -->
                <xsl:call-template name="html.sidebar">
                  <xsl:with-param name="content" select="$content.sidebar" />
                </xsl:call-template>

              </aside><!-- /sidebar column -->
            </xsl:if>

          </div><!-- /content area -->
        </div><!-- /container -->

        <!-- footer -->
        <xsl:call-template name="html.footer" />

        <!-- scripts -->
        <xsl:call-template name="html.script" />

      </body>
    </html>

  </xsl:template>

</xsl:stylesheet>
