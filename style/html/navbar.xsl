<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!--~~~~~~~~~~~~~~~~~~~~~~~
    Animated navigation bar
    ~~~~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.navbar">
    <xsl:param name="title" /><!-- string -->

    <!-- options -->
    <xsl:variable name="site.title" select="/site/options/option[@name = 'site.title']" />
    <xsl:variable name="site.author" select="/site/options/option[@name = 'site.author']" />

    <nav class="[ navbar navbar-default navbar-fixed-top ] x2b-nvbr js-nvbr [ sps sps--abv ] headroom--pinned">
      <div class="container">

        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
            <span class="icon-bar"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
            <span class="icon-bar"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></span>
          </button>
          <a class="navbar-brand" href="/"><xsl:value-of select="$site.title" /></a>
        </div><!-- /navbar-header -->

        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">

            <xsl:if test="$articles">
              <li>
                <xsl:if test="$title = /site/articles/title">
                  <xsl:attribute name="class">active</xsl:attribute>
                </xsl:if>
                <a href="/articles.html">
                  <xsl:call-template name="element.icon">
                    <xsl:with-param name="icon">fa-newspaper-o</xsl:with-param>
                  </xsl:call-template>
                  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                  <xsl:value-of select="/site/articles/title" />
                </a>
              </li>
            </xsl:if>

            <xsl:if test="$projects">
              <li>
                <xsl:if test="$title = /site/projects/title">
                  <xsl:attribute name="class">active</xsl:attribute>
                </xsl:if>
                <a href="/projects.html">
                  <xsl:call-template name="element.icon">
                    <xsl:with-param name="icon">fa-rocket</xsl:with-param>
                  </xsl:call-template>
                  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                  <xsl:value-of select="/site/projects/title" />
                </a>
              </li>
            </xsl:if>

            <xsl:if test="$galleries">
              <li>
                <xsl:if test="$title = /site/galleries/title">
                  <xsl:attribute name="class">active</xsl:attribute>
                </xsl:if>
                <a href="/galleries.html">
                  <xsl:call-template name="element.icon">
                    <xsl:with-param name="icon">fa-picture-o</xsl:with-param>
                  </xsl:call-template>
                  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                  <xsl:value-of select="/site/galleries/title" />
                </a>
              </li>
            </xsl:if>

          </ul>
          <p class="hidden-xs [ navbar-text navbar-right ] x2b-nvbr-txt">by <xsl:value-of select="$site.author" /></p>
        </div><!-- /navbar-collapse -->

      </div><!-- /container -->
    </nav>

  </xsl:template>

</xsl:stylesheet>
