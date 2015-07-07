<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!--~~~~~~~~~~~~~~~~~~~~
          HTML page
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.page">
    <xsl:param name="title" />
    <xsl:param name="subtitle" />
    <xsl:param name="content" />

    <xsl:call-template name="html.doctype" />
    <html lang="en">

      <xsl:call-template name="html.head">
        <xsl:with-param name="pagetitle"><xsl:value-of select="$title" /></xsl:with-param>
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
            <article class="col-sm-9 col-md-8">
              <!-- content -->
              <xsl:apply-templates select="$content" />
            </article><!-- /main column -->

            <!-- sidebar column -->
            <aside class="hidden-xs [ col-sm-3 col-md-offset-1 ]">
              <!-- sidebar -->
              <xsl:call-template name="html.sidebar" />
            </aside> <!-- /sidebar column -->

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
    <xsl:param name="pagetitle" />

    <!-- options -->
    <xsl:variable name="sitetitle" select="/site/options/option[@name = 'sitetitle']" />

    <head>
      <title>
        <xsl:value-of select="$sitetitle" /> · <xsl:value-of select="$pagetitle" />
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
    <xsl:variable name="siteauthor" select="/site/options/option[@name = 'siteauthor']" />

    <xsl:text disable-output-escaping="yes">
<![CDATA[<meta charset="utf-8" />
<meta name="author" content="]]></xsl:text>
    <xsl:value-of select="$siteauthor" />
    <xsl:text disable-output-escaping="yes"><![CDATA[" />
<meta name="viewport" content="width=device-width" />]]></xsl:text>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
      HTML stylesheets
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.head.link">

    <!-- TODO: these should be (json?) options -->
    <xsl:text disable-output-escaping="yes">
<![CDATA[<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/bootstrap-theme.min.css" />
<link rel="stylesheet" href="css/style.css" />]]></xsl:text>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
        HTML scripts
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.head.script">

    <!-- TODO: these should be (json?) options -->
    <xsl:text disable-output-escaping="yes">
<![CDATA[<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/headroom/0.7.0/headroom.min.js"></script>]]></xsl:text>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
      Banner jumbotron
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.banner">
    <xsl:param name="title" />
    <xsl:param name="subtitle" />

    <header class="jumbotron">
      <div class="container">

        <h1>
          <xsl:value-of select="$title" />
        </h1>

        <p class="x2b-nwrp">
          <xsl:value-of select="$subtitle" />
        </p>

      </div>
    </header>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~~~~
    Animated navigation bar
    ~~~~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.navbar">

    <!-- options -->
    <xsl:variable name="sitetitle" select="/site/options/option[@name = 'sitetitle']" />
    <xsl:variable name="siteauthor" select="/site/options/option[@name = 'siteauthor']" />
    <xsl:variable name="navbaroffset" select="/site/options/option[@name = 'navbaroffset']" />
    <xsl:variable name="navbartolerance" select="/site/options/option[@name = 'navbartolerance']" />

    <nav class="[ navbar navbar-default navbar-fixed-top ] x2b-nvbr affix-top" data-spy="affix" data-offset-top="1">
      <div class="container">

        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
            <span class="icon-bar"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
            <span class="icon-bar"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
          </button>
          <a class="navbar-brand" href="#"><xsl:value-of select="$sitetitle" /></a>
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
          <p class="[ navbar-text navbar-right ] hidden-xs">by <xsl:value-of select="$siteauthor" /></p>
        </div> <!-- /navbar-collapse -->

      </div> <!-- /container -->
    </nav>

    <script type="application/javascript">
      var headroom  = new Headroom(document.querySelector(".navbar"), {
        "offset": <xsl:value-of select="$navbaroffset" />,
        "tolerance": <xsl:value-of select="$navbartolerance" />
      });
      headroom.init();
    </script>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
        Sidebar panel
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.sidebar">

    <!-- options -->
    <xsl:variable name="sidebaroffset" select="/site/options/option[@name = 'sidebaroffset']" />

    <div class="[ panel panel-default ] x2b-sdbr affix-top" data-spy="affix" data-offset-top="{$sidebaroffset}">
      <div class="panel-body">
        Nulla facilisi. Pellentesque vulputate sapien risus, eu pulvinar est bibendum at. Nam dictum feugiat nisi ut bibendum. Aliquam ut facilisis ipsum, non blandit libero. Proin lobortis consectetur tortor, sed cursus leo scelerisque non. Nullam rhoncus est libero. In hac habitasse platea dictumst. Nam egestas risus urna, sit amet condimentum massa bibendum ut.
      </div><!-- /panel-body -->
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
      </div>
    </footer>

  </xsl:template>

</xsl:stylesheet>
