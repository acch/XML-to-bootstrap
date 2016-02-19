<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!--~~~~~~~~~~~~~~~~~~~~
          Home page
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="home">

    <!-- generate home page -->
    <xsl:call-template name="html.page">
      <xsl:with-param name="title" select="/site/home/title" />
      <xsl:with-param name="subtitle" select="/site/home/subtitle" />
      <xsl:with-param name="content" select="/site/home" />
      <xsl:with-param name="banner.style">text-center</xsl:with-param>
    </xsl:call-template>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
     Home page contents
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template match="home">

    <div class="row text-center">

      <!-- copy introduction from XML, excluding collapsed text -->
      <xsl:call-template name="copy.content">
        <xsl:with-param name="content" select="introduction" />
        <xsl:with-param name="exclude">collapse</xsl:with-param>
      </xsl:call-template>

      <!-- collapsed section -->
      <div class="collapse" id="intrdctn">
        <!-- copy collapsed introduction text from XML directly -->
        <xsl:call-template name="copy.content">
          <xsl:with-param name="content" select="introduction/collapse" />
        </xsl:call-template>
      </div>

      <!-- link to expand collapsed section -->
      <p>
        <a class="x2b-expnd collapsed" data-toggle="collapse" href="#intrdctn" aria-expanded="false" aria-controls="intrdctn">More...</a>
      </p>

    </div><!-- /row -->

    <div class="row text-center">

      <!-- articles panel -->
      <div class="col-sm-4 x2b-hm-pnl">
        <div class="panel panel-default">

          <!-- panel heading -->
          <div class="panel-heading">
            <h3 class="panel-title">
              <xsl:choose>
                <xsl:when test="$articles">
                  <a href="articles.html">
                    <xsl:value-of select="/site/articles/title" />
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="/site/articles/title" />
                </xsl:otherwise>
              </xsl:choose>
            </h3>
          </div><!-- /panel-heading -->

          <!-- panel body -->
          <div class="panel-body">
            <xsl:choose>
              <xsl:when test="$articles">
                <xsl:value-of select="/site/articles/introduction" />
              </xsl:when>
              <xsl:otherwise>
                <span class="text-muted">
                  Coming soon...
                </span>
              </xsl:otherwise>
            </xsl:choose>

            <!-- spacing -->
            <hr class="invisible" />

            <!-- panel icon -->
            <xsl:choose>
              <xsl:when test="$articles">
                <a href="articles.html" class="x2b-shdw">
                  <xsl:call-template name="element.icon.squared">
                    <xsl:with-param name="icon">fa-newspaper-o</xsl:with-param>
                    <xsl:with-param name="size">fa-3x</xsl:with-param>
                  </xsl:call-template>
                </a>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="element.icon.squared">
                  <xsl:with-param name="icon">fa-newspaper-o</xsl:with-param>
                  <xsl:with-param name="size">fa-3x</xsl:with-param>
                  <xsl:with-param name="disabled" select="true()" />
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>

          </div><!-- /panel-body -->

        </div><!-- /panel -->
      </div><!-- /column -->

      <!-- projects panel -->
      <div class="col-sm-4 x2b-hm-pnl">
        <div class="panel panel-default">

          <!-- panel heading -->
          <div class="panel-heading">
            <h3 class="panel-title">
              <xsl:choose>
                <xsl:when test="$projects">
                  <a href="projects.html">
                    <xsl:value-of select="/site/projects/title" />
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="/site/projects/title" />
                </xsl:otherwise>
              </xsl:choose>
            </h3>
          </div><!-- /panel-heading -->

          <!-- panel body -->
          <div class="panel-body">
            <xsl:choose>
              <xsl:when test="$projects">
                <xsl:value-of select="/site/projects/introduction" />
              </xsl:when>
              <xsl:otherwise>
                <span class="text-muted">
                  Coming soon...
                </span>
              </xsl:otherwise>
            </xsl:choose>

            <!-- spacing -->
            <hr class="invisible" />

            <!-- panel icon -->
            <xsl:choose>
              <xsl:when test="$projects">
                <a href="projects.html" class="x2b-shdw">
                  <xsl:call-template name="element.icon.squared">
                    <xsl:with-param name="icon">fa-rocket</xsl:with-param>
                    <xsl:with-param name="size">fa-3x</xsl:with-param>
                  </xsl:call-template>
                </a>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="element.icon.squared">
                  <xsl:with-param name="icon">fa-rocket</xsl:with-param>
                  <xsl:with-param name="size">fa-3x</xsl:with-param>
                  <xsl:with-param name="disabled" select="true()" />
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>

          </div><!-- /panel-body -->

        </div><!-- /panel -->
      </div><!-- /column -->

      <!-- gallery panel -->
      <div class="col-sm-4 x2b-hm-pnl">
        <div class="panel panel-default">

          <!-- panel heading -->
          <div class="panel-heading">
            <h3 class="panel-title">
              <xsl:choose>
                <xsl:when test="$galleries">
                  <a href="galleries.html">
                    <xsl:value-of select="/site/galleries/title" />
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="/site/galleries/title" />
                </xsl:otherwise>
              </xsl:choose>
            </h3>
          </div><!-- /panel-heading -->

          <!-- panel body -->
          <div class="panel-body">
            <xsl:choose>
              <xsl:when test="$galleries">
                <xsl:value-of select="/site/galleries/introduction" />
              </xsl:when>
              <xsl:otherwise>
                <span class="text-muted">
                  Coming soon...
                </span>
              </xsl:otherwise>
            </xsl:choose>

            <!-- spacing -->
            <hr class="invisible" />

            <!-- panel icon -->
            <xsl:choose>
              <xsl:when test="$galleries">
                <a href="galleries.html" class="x2b-shdw">
                  <xsl:call-template name="element.icon.squared">
                    <xsl:with-param name="icon">fa-picture-o</xsl:with-param>
                    <xsl:with-param name="size">fa-3x</xsl:with-param>
                  </xsl:call-template>
                </a>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="element.icon.squared">
                  <xsl:with-param name="icon">fa-picture-o</xsl:with-param>
                  <xsl:with-param name="size">fa-3x</xsl:with-param>
                  <xsl:with-param name="disabled" select="true()" />
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>

          </div><!-- /panel-body -->

        </div><!-- /panel -->
      </div><!-- /column -->

    </div><!-- /row -->

  </xsl:template>

</xsl:stylesheet>
