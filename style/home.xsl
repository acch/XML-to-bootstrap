<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Home page
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

<!-- this template generates HTML code for the start (home) page -->

  <xsl:template name="home">

    <!-- generate home page -->
    <xsl:call-template name="html.page">
      <xsl:with-param name="title" select="/site/home/title" />
      <xsl:with-param name="subtitle" select="/site/home/subtitle" />
      <xsl:with-param name="head.title" select="false()" /><!-- don't promote title in head -->
      <xsl:with-param name="head.subtitle" select="false()" /><!-- don't promote subtitle in head -->
      <xsl:with-param name="content" select="/site/home" />
      <xsl:with-param name="banner.style">text-center</xsl:with-param>
      <xsl:with-param name="uri">/</xsl:with-param>
    </xsl:call-template>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Home page contents
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="home">

    <!-- put content inside a text column -->
    <xsl:call-template name="component.textcolumn">
      <xsl:with-param name="content">

        <!-- introduction -->
        <main role="main" class="text-center" itemprop="description">

          <!-- copy introduction from XML, excluding collapsed text -->
          <xsl:call-template name="copy.content">
            <xsl:with-param name="content" select="introduction" />
            <xsl:with-param name="exclude">collapse</xsl:with-param>
          </xsl:call-template>

          <!-- collapsed section -->
          <div class="collapse" id="intrdctn">
            <!-- copy collapsed introduction from XML -->
            <xsl:call-template name="copy.content">
              <xsl:with-param name="content" select="introduction/collapse" />
            </xsl:call-template>
          </div>

          <!-- link to expand collapsed section -->
          <a class="x2b-expnd collapsed" data-toggle="collapse" href="#intrdctn" aria-expanded="false" aria-controls="intrdctn">
            <xsl:text>More&#8230;</xsl:text>
          </a>

        </main><!-- /introduction -->

      </xsl:with-param>
    </xsl:call-template>

    <!-- section cards -->
    <div role="navigation" class="row text-sm-center" itemscope="itemscope" itemtype="http://schema.org/SiteNavigationElement">

      <!-- responsive column -->
      <div class="{$grid.cardcolumn}">

        <!-- articles card as flexbox container -->
        <div class="[ card card-block ] [ d-flex flex-row flex-sm-column justify-content-between align-items-center ]">

          <!-- flexbox item -->
          <div>

            <!-- card heading -->
            <h2 class="card-title">
              <xsl:choose>
                <xsl:when test="$articles">
                  <a class="x2b-alt-lnk" href="{$site.url}articles.html">
                    <xsl:value-of select="/site/articles/title" />
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="/site/articles/title" />
                </xsl:otherwise>
              </xsl:choose>
            </h2>

            <!-- card body -->
            <p class="card-text">
              <xsl:choose>
                <xsl:when test="$articles">
                  <xsl:value-of select="/site/articles/introduction" />
                </xsl:when>
                <xsl:otherwise>
                  <span class="text-muted">
                    <xsl:text>Coming soon&#8230;</xsl:text>
                  </span>
                </xsl:otherwise>
              </xsl:choose>
            </p>

          </div><!-- /flex item -->

          <!-- flexbox divider -->
          <div class="m-2">
            <xsl:text> </xsl:text><!-- prevent tag from collapsing -->
          </div>

          <!-- flexbox item -->
          <div>

            <!-- icon -->
            <xsl:call-template name="component.icon.button">
              <xsl:with-param name="title">
                <xsl:if test="$articles">
                  <xsl:value-of select="/site/articles/title" />
                </xsl:if>
              </xsl:with-param>
              <xsl:with-param name="href">
                <xsl:if test="$articles">
                  <xsl:value-of select="$site.url" />
                  <xsl:text>articles.html</xsl:text>
                </xsl:if>
              </xsl:with-param>
              <xsl:with-param name="icon">fa-newspaper-o</xsl:with-param>
              <xsl:with-param name="size">fa-3x</xsl:with-param>
              <xsl:with-param name="disabled" select="not($articles)" />
            </xsl:call-template>

          </div><!-- /flex item -->

        </div><!-- /card -->

      </div><!-- /column -->
      <div class="{$grid.cardcolumn}">

        <!-- projects card as flexbox container -->
        <div class="[ card card-block ] [ d-flex flex-row flex-sm-column justify-content-between align-items-center ]">

          <!-- flexbox item -->
          <div>

            <!-- card heading -->
            <h2 class="card-title">
              <xsl:choose>
                <xsl:when test="$projects">
                  <a class="x2b-alt-lnk" href="{$site.url}projects.html">
                    <xsl:value-of select="/site/projects/title" />
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="/site/projects/title" />
                </xsl:otherwise>
              </xsl:choose>
            </h2>

            <!-- card body -->
            <p class="card-text">
              <xsl:choose>
                <xsl:when test="$projects">
                  <xsl:value-of select="/site/projects/introduction" />
                </xsl:when>
                <xsl:otherwise>
                  <span class="text-muted">
                    <xsl:text>Coming soon&#8230;</xsl:text>
                  </span>
                </xsl:otherwise>
              </xsl:choose>
            </p>

          </div><!-- /flex item -->

          <!-- flexbox divider -->
          <div class="m-2">
            <xsl:text> </xsl:text><!-- prevent tag from collapsing -->
          </div>

          <!-- flexbox item -->
          <div>

            <!-- icon -->
            <xsl:call-template name="component.icon.button">
              <xsl:with-param name="title">
                <xsl:if test="$projects">
                  <xsl:value-of select="/site/projects/title" />
                </xsl:if>
              </xsl:with-param>
              <xsl:with-param name="href">
                <xsl:if test="$projects">
                  <xsl:value-of select="$site.url" />
                  <xsl:text>projects.html</xsl:text>
                </xsl:if>
              </xsl:with-param>
              <xsl:with-param name="icon">fa-rocket</xsl:with-param>
              <xsl:with-param name="size">fa-3x</xsl:with-param>
              <xsl:with-param name="disabled" select="not($projects)" />
            </xsl:call-template>

          </div><!-- /flex item -->

        </div><!-- /card -->

      </div><!-- /column -->
      <div class="{$grid.cardcolumn}">

        <!-- galleries card as flexbox container -->
        <div class="[ card card-block ] [ d-flex flex-row flex-sm-column justify-content-between align-items-center ]">

          <!-- flex item -->
          <div>

            <!-- card heading -->
            <h2 class="card-title">
              <xsl:choose>
                <xsl:when test="$galleries">
                  <a class="x2b-alt-lnk" href="{$site.url}galleries.html">
                    <xsl:value-of select="/site/galleries/title" />
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="/site/galleries/title" />
                </xsl:otherwise>
              </xsl:choose>
            </h2>

            <!-- card body -->
            <p class="card-text">
              <xsl:choose>
                <xsl:when test="$galleries">
                  <xsl:value-of select="/site/galleries/introduction" />
                </xsl:when>
                <xsl:otherwise>
                  <span class="text-muted">
                    <xsl:text>Coming soon&#8230;</xsl:text>
                  </span>
                </xsl:otherwise>
              </xsl:choose>
            </p>

          </div><!-- /flex item -->

          <!-- flexbox divider -->
          <div class="m-2">
            <xsl:text> </xsl:text><!-- prevent tag from collapsing -->
          </div>

          <!-- flex item -->
          <div>

            <!-- icon -->
            <xsl:call-template name="component.icon.button">
              <xsl:with-param name="title">
                <xsl:if test="$galleries">
                  <xsl:value-of select="/site/galleries/title" />
                </xsl:if>
              </xsl:with-param>
              <xsl:with-param name="href">
                <xsl:if test="$galleries">
                  <xsl:value-of select="$site.url" />
                  <xsl:text>galleries.html</xsl:text>
                </xsl:if>
              </xsl:with-param>
              <xsl:with-param name="icon">fa-picture-o</xsl:with-param>
              <xsl:with-param name="size">fa-3x</xsl:with-param>
              <xsl:with-param name="disabled" select="not($galleries)" />
            </xsl:call-template>

          </div><!-- /flex item -->

        </div><!-- /card -->

      </div><!-- /column -->

    </div><!-- /section cards -->

  </xsl:template>

</xsl:stylesheet>
