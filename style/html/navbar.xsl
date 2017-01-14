<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Animated navigation bar
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- this template generates HTML code for the fixed-top navbar -->
  <xsl:template name="html.navbar">
    <xsl:param name="title" /><!-- string -->

    <!-- options -->
    <xsl:variable name="site.title" select="/site/options/option[@name = 'site.title']" />
    <xsl:variable name="site.author" select="/site/options/option[@name = 'site.author']" />

    <!-- Bootstrap navbar -->
    <nav class="[ navbar navbar-toggleable-sm fixed-top navbar-light ] js-nvbr [ sps sps--abv ] headroom--pinned">
      <div class="container">

        <!-- toggler -->
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#cllpsNvbr" aria-controls="cllpsNvbr" aria-expanded="false" aria-label="Toggle navigation">
          <!--xsl:text>MENU</xsl:text-->
          <span class="navbar-toggler-icon">
            <xsl:text> </xsl:text><!-- prevent tag from collapsing -->
          </span>
        </button>

        <!-- site title -->
        <a class="navbar-brand" href="{$site.url}">
          <xsl:value-of select="$site.title" />
        </a>

        <!-- collapsing navbar -->
        <div class="collapse navbar-collapse" id="cllpsNvbr">

          <!-- divider -->
          <div class="navbar-divider hidden-sm-down">
            <xsl:text> </xsl:text><!-- prevent tag from collapsing -->
          </div>

          <ul class="navbar-nav mr-auto">

            <!-- optional articles component -->
            <xsl:if test="$articles">

              <!-- check if current page is articles -->
              <xsl:variable name="active">
                <xsl:if test="$title = /site/articles/title"> active</xsl:if>
              </xsl:variable>

              <li class="nav-item{$active} mx-2">
                <a class="nav-link" href="{$site.url}articles.html">

                  <!-- icon and title -->
                  <xsl:call-template name="element.icon">
                    <xsl:with-param name="icon">fa-newspaper-o</xsl:with-param>
                  </xsl:call-template>
                  <xsl:text>&#160;</xsl:text>
                  <xsl:value-of select="/site/articles/title" />

                  <!-- mark active item for screen readers -->
                  <xsl:if test="$title = /site/articles/title">
                    <span class="sr-only"> (current)</span>
                  </xsl:if>

                </a>
              </li>

            </xsl:if><!-- $articles -->

            <!-- optional projects component -->
            <xsl:if test="$projects">

              <!-- check if current page is projects -->
              <xsl:variable name="active">
                <xsl:if test="$title = /site/projects/title"> active</xsl:if>
              </xsl:variable>

              <li class="nav-item{$active} mx-2">
                <a class="nav-link" href="{$site.url}projects.html">

                  <!-- icon and title -->
                  <xsl:call-template name="element.icon">
                    <xsl:with-param name="icon">fa-rocket</xsl:with-param>
                  </xsl:call-template>
                  <xsl:text>&#160;</xsl:text>
                  <xsl:value-of select="/site/projects/title" />

                  <!-- mark active item for screen readers -->
                  <xsl:if test="$title = /site/projects/title">
                    <span class="sr-only"> (current)</span>
                  </xsl:if>

                </a>
              </li>

            </xsl:if><!-- $projects -->

            <!-- optional galleries component -->
            <xsl:if test="$galleries">

              <!-- check if current page is galleries -->
              <xsl:variable name="active">
                <xsl:if test="$title = /site/galleries/title"> active</xsl:if>
              </xsl:variable>

              <li class="nav-item{$active} mx-2">
                <a class="nav-link" href="{$site.url}galleries.html">

                  <!-- icon and title -->
                  <xsl:call-template name="element.icon">
                    <xsl:with-param name="icon">fa-picture-o</xsl:with-param>
                  </xsl:call-template>
                  <xsl:text>&#160;</xsl:text>
                  <xsl:value-of select="/site/galleries/title" />

                  <!-- mark active item for screen readers -->
                  <xsl:if test="$title = /site/galleries/title">
                    <span class="sr-only"> (current)</span>
                  </xsl:if>
                </a>
              </li>

            </xsl:if><!-- $galleries -->

          </ul>

          <!-- author info -->
          <span class="navbar-text hidden-sm-down text-muted">
            <xsl:text>by </xsl:text>
            <xsl:value-of select="$site.author" />
          </span>

        </div><!-- /collapse -->

      </div><!-- /container -->
    </nav>

  </xsl:template>

</xsl:stylesheet>
