<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Projects overview page
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Project overview page contents
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="projects">

    <!-- navigation breadcrumb -->
    <xsl:call-template name="component.breadcrumb">
      <xsl:with-param name="current" select="title" />
    </xsl:call-template>

    <!--p class="text-muted">
      Click on the title to continue reading&#8230;
    </p-->

    <!-- spacing -->
    <hr class="invisible" />

    <xsl:choose>
      <xsl:when test="not(project[not(@draft)])">

        <p><strong>
          There are no projects, yet. Why don't you create one?
        </strong></p>

      </xsl:when>
      <xsl:otherwise>

        <!-- project cards -->
        <main class="row">

          <!-- iterate over all projects -->
          <xsl:for-each select="project[not(@draft)]">
            <xsl:sort select="date" order="descending" />

            <!-- format filename -->
            <xsl:variable name="filename">
              <xsl:call-template name="format.filename">
                <xsl:with-param name="string" select="title" />
              </xsl:call-template>
            </xsl:variable>

            <!-- format date -->
            <xsl:variable name="date.formatted">
              <xsl:call-template name="format.date">
                <xsl:with-param name="date" select="date" />
              </xsl:call-template>
            </xsl:variable>

            <!-- responsive column -->
            <div class="{$grid.cardcolumn}">

              <!-- project card -->
              <article class="card card-block">

                <!-- main title -->
                <h2 class="card-title">
                  <a class="x2b-alt-lnk" href="{$site.url}{$project.path}{$filename}.html">
                    <xsl:value-of select="title" />
                  </a>
                </h2>

                <a class="x2b-sbtl-lnk" href="{$site.url}{$project.path}{$filename}.html">

                  <!-- optional subtitle -->
                  <xsl:if test="subtitle">
                    <p class="card-text"><strong>
                      <xsl:value-of select="subtitle" />
                    </strong></p>
                  </xsl:if>

                  <!-- project description -->
                  <p class="card-text">
                    <xsl:if test="short">
                      <xsl:value-of select="short" />
                      <xsl:text> </xsl:text>
                    </xsl:if>

                    <time class="text-muted" datetime="{date}">
                      <xsl:text>//&#160;</xsl:text>
                      <xsl:value-of select="$date.formatted" />
                    </time>
                  </p>

                </a>

                <!-- project button -->
                <div class="d-flex mt-3">
                  <a class="[ btn btn-outline-primary ] ml-auto" title="{title}" href="{$site.url}{$project.path}{$filename}.html" role="button">
                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                    <xsl:value-of select="title" />
                    <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                    <xsl:call-template name="component.icon">
                      <xsl:with-param name="icon">fa-arrow-right</xsl:with-param>
                    </xsl:call-template>
                  </a>
                </div>

              </article><!-- /card -->

            </div><!-- /column -->

          </xsl:for-each>

        </main><!-- /project cards -->

      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

</xsl:stylesheet>
