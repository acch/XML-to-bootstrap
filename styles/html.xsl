<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- HTML Page -->
  <xsl:template name="html.page">
    <xsl:param name="title" />
    <xsl:param name="content" />

    <xsl:call-template name="html.doctype" />
    <html lang="en">

      <xsl:call-template name="html.head">
        <xsl:with-param name="pagetitle"><xsl:value-of select="$title" /></xsl:with-param>
      </xsl:call-template>

      <body style="padding-top: 50px;">
        <div class="container">

          <xsl:call-template name="html.navbar" />

          <h1>My First Bootstrap Page <small>with some details</small></h1>
          <p>This is some text.</p>

          <div class="row">

            <!-- main column -->
            <div class="col-sm-9 col-md-8">

              <xsl:apply-templates select="$content" />

            </div><!-- /main column -->

            <!-- sidebar column -->
            <div class="col-sm-3 col-md-offset-1">
              <div class="panel panel-default">
                <div class="panel-body">
                  Nulla facilisi. Pellentesque vulputate sapien risus, eu pulvinar est bibendum at. Nam dictum feugiat nisi ut bibendum. Aliquam ut facilisis ipsum, non blandit libero. Proin lobortis consectetur tortor, sed cursus leo scelerisque non. Nullam rhoncus est libero. In hac habitasse platea dictumst. Nam egestas risus urna, sit amet condimentum massa bibendum ut.
                </div>
              </div>
            </div><!-- /sidebar column -->

          </div><!-- /row -->

        </div><!-- /container -->
      </body>

    </html>

  </xsl:template>

  <!-- HTML5 doctype -->
  <xsl:template name="html.doctype">

    <xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html>
]]></xsl:text>

  </xsl:template>

  <!-- HTML5 head elements -->
  <xsl:template name="html.head">
    <xsl:param name="pagetitle" />
    
    <xsl:variable name="sitetitle" select="/site/options/option[@name = 'sitetitle']" />

    <head>
      <title><xsl:value-of select="$sitetitle" /> · <xsl:value-of select="$pagetitle" /></title>
      <xsl:call-template name="html.head.meta" />
      <xsl:call-template name="html.head.link" />
      <xsl:call-template name="html.head.script" />
      <xsl:call-template name="html.head.css" />
    </head>

  </xsl:template>

  <!-- HTML5 meta elements -->
  <xsl:template name="html.head.meta">

    <xsl:text disable-output-escaping="yes">
<![CDATA[<meta charset="utf-8" />
<meta name="author" content="Achim Christ" />
<meta name="viewport" content="width=device-width, initial-scale=1" />]]></xsl:text>

  </xsl:template>

  <!-- HTML5 stylesheets -->
  <xsl:template name="html.head.link">

    <xsl:text disable-output-escaping="yes">
<![CDATA[<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css" />]]></xsl:text>

  </xsl:template>

  <!-- HTML5 scripts -->
  <xsl:template name="html.head.script">

    <!-- TODO: remove "http:" for web publishing -->
    <xsl:text disable-output-escaping="yes">
<![CDATA[<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/headroom/0.7.0/headroom.min.js"></script>]]></xsl:text>

  </xsl:template>

  <!-- Custom CSS -->
  <xsl:template name="html.head.css">

    <!-- TODO: get header size from bootstrap CSS -->
    <xsl:text disable-output-escaping="yes">
<![CDATA[<style type="text/css">
.navbar {
  top: 10px;
  border-width: 1px 0px;
  background-color: #FFF;
}
.headroom {
  -webkit-transition: -webkit-transform 250ms, background-position 0.5s;
  transition: transform 250ms, background-position 0.5s;
}
.headroom--pinned {
  -ms-transform: translateY(0%);
  -webkit-transform: translateY(0%);
  transform: translateY(0%);
}
.headroom--unpinned {
  -ms-transform: translateY(-120%);
  -webkit-transform: translateY(-120%);
  transform: translateY(-120%);
}
.affix-top { background-position: center 50px; box-shadow: none; }
.affix { background-position: center 0px; }
</style>]]>
    </xsl:text>

  </xsl:template>

  <!-- Responsive navigation bar -->
  <xsl:template name="html.navbar">

    <nav class="navbar navbar-default navbar-fixed-top affix-top" data-spy="affix" data-offset-top="1">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
            <span class="icon-bar"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
            <span class="icon-bar"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
          </button>
          <a class="navbar-brand" href="#">Byteshell</a>
        </div>
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
          <p class="navbar-text navbar-right hidden-xs" style="padding-right: 15px;">by Achim Christ</p>
        </div>
      </div>
    </nav>

    <script type="application/javascript">
      var headroom  = new Headroom(document.querySelector(".navbar"), {"offset": 205, "tolerance": 5});
      headroom.init();
    </script>

  </xsl:template>

</xsl:stylesheet>
