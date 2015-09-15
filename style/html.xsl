<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">


<!--~~~~~~~~~~~~~~~~~~~~
          HTML page
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.page">
    <xsl:param name="title" /><!-- string -->
    <xsl:param name="subtitle" /><!-- string -->
    <xsl:param name="content" /><!-- node-set -->
    <xsl:param name="content.sidebar" /><!-- node-set (nav) -->

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
        <xsl:call-template name="html.navbar" />

        <!-- banner -->
        <xsl:call-template name="html.banner">
          <xsl:with-param name="title" select="$title" />
          <xsl:with-param name="subtitle" select="$subtitle" />
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

      </body>
    </html>

  </xsl:template>


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
      <xsl:call-template name="html.head.script" />
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
    <link rel="stylesheet" href="css/style.css" />

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
        HTML scripts
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.head.script">

    <xsl:text><![CDATA[
]]></xsl:text>

    <!-- scripts from options (CDN) -->
    <xsl:for-each select="/site/options/option[@name = 'cdn.scripts']/script">
      <script src="{@src}"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></script>
    </xsl:for-each>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
      Banner jumbotron
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.banner">
    <xsl:param name="title" /><!-- string -->
    <xsl:param name="subtitle" /><!-- string -->

    <header class="jumbotron">
      <div class="container">

        <h1 class="x2b-nwrp">
          <xsl:value-of select="$title" />
        </h1>

        <p class="x2b-nwrp">
          <xsl:value-of select="$subtitle" />
        </p>

      </div><!-- /container -->
    </header><!-- /jumbotron -->

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~~~~
    Animated navigation bar
    ~~~~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.navbar">

    <!-- options -->
    <xsl:variable name="site.title" select="/site/options/option[@name = 'site.title']" />
    <xsl:variable name="site.author" select="/site/options/option[@name = 'site.author']" />
    <xsl:variable name="navbar.offset" select="/site/options/option[@name = 'navbar.offset']" />
    <xsl:variable name="navbar.tolerance" select="/site/options/option[@name = 'navbar.tolerance']" />

    <nav class="[ navbar navbar-default navbar-fixed-top ] x2b-nvbr affix-top" data-spy="affix" data-offset-top="1">
      <div class="container">

        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
            <span class="icon-bar"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
            <span class="icon-bar"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
          </button>
          <a class="navbar-brand" href="#"><xsl:value-of select="$site.title" /></a>
        </div> <!-- /navbar-header -->

        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#contact">Contact</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Dropdown <span class="caret"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span></a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></li>
                <li class="dropdown-header">Nav header</li>
                <li><a href="#">Separated link</a></li>
                <li><a href="#">One more separated link</a></li>
              </ul>
            </li>
          </ul>
          <p class="hidden-xs [ navbar-text navbar-right ] x2b-nvbr-txt">by <xsl:value-of select="$site.author" /></p>
        </div> <!-- /navbar-collapse -->

      </div> <!-- /container -->
    </nav>

    <script type="application/javascript">
      var headroom  = new Headroom(document.querySelector(".navbar"), {
        "offset": <xsl:value-of select="$navbar.offset" />,
        "tolerance": <xsl:value-of select="$navbar.tolerance" />
      });
      headroom.init();
    </script>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
        Sidebar panel
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.sidebar">
    <xsl:param name="content" /><!-- node-set (nav) -->

    <!-- options -->
    <xsl:variable name="sidebar.offset" select="/site/options/option[@name = 'sidebar.offset']" />

    <!-- convert parameter to node-set -->
    <xsl:variable name="content.nav" select="ext:node-set($content)/nav" />

    <!-- bootstrap panel component -->
    <div class="[ panel panel-default ]">
      <nav class="panel-body">

        <!-- sidebar nav links -->
        <ul class="nav">

          <!-- iterate over all nav links -->
          <xsl:for-each select="$content.nav/link">

            <li>
              <a class="x2b-sdbr-lnk" href="{@href}">
                <xsl:value-of select="@title" />
              </a>
            </li>

          </xsl:for-each>

          <!-- iterate over all nav sections -->
          <xsl:for-each select="$content.nav/section">

            <li class="x2b-sdbr-sctn">
              <xsl:value-of select="@title" />

              <!-- section nav links -->
              <ul class="nav">

                <!-- iterate over all nav links in section -->
                <xsl:for-each select="link">

                  <li>
                    <a class="x2b-sdbr-lnk" href="{@href}">
                      <xsl:value-of select="@title" />
                    </a>
                  </li>

                </xsl:for-each>

              </ul><!-- /section nav links -->

            </li>

          </xsl:for-each>

        </ul><!-- /sidebar nav links -->

      </nav><!-- /panel-body -->
    </div> <!-- /panel -->

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
         Page footer
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.footer">

    <footer class="x2b-ftr">
      <div class="container">

        <p class="x2b-gry">Generated using <a href="https://github.com/acch/XML-to-bootstrap">XML-to-Bootstrap</a> for your reading pleasure.</p>
        <p class="x2b-gry">This site uses <a href="http://getbootstrap.com">Bootstrap</a> and <a href="http://wicky.nillia.ms/headroom.js/">Headroom.js</a>.</p>

      </div><!-- /container -->
    </footer>

  </xsl:template>

</xsl:stylesheet>
