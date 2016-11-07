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

    <!-- navigation breadcrumbs -->
    <xsl:call-template name="element.breadcrumbs">
      <xsl:with-param name="current" select="title" />
    </xsl:call-template>

    <!-- spacing -->
    <!--hr class="invisible my-1" /-->

    <!--p class="text-muted">
      Click on the title to continue reading&#8230;
    </p-->

    <!-- spacing -->
    <hr class="invisible my-1" />

    <xsl:choose>
      <xsl:when test="not(project[not(@draft)])">

        <p><strong>
          There are no projects, yet. Why don't you create one?
        </strong></p>

      </xsl:when>
      <xsl:otherwise>

        <!-- project cards -->
        <div class="row">

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
              <article class="[ card card-block ] x2b-crd">

                <!-- main title -->
                <h3 class="card-title">
                  <a class="x2b-alt-lnk" href="{$site.url}{$project.path}{$filename}.html">
                    <xsl:value-of select="title" />
                  </a>
                </h3>

                <a class="x2b-sbtl-lnk" href="{$site.url}{$project.path}{$filename}.html">

                  <!-- optional subtitle -->
                  <xsl:if test="subtitle">
                    <p class="card-text"><strong>
                      <xsl:value-of select="subtitle" />
                    </strong></p>
                  </xsl:if>

                  <!-- project description -->
                  <p class="card-text">
                    <xsl:value-of select="short" />

                    <xsl:text> </xsl:text>

                    <time class="text-muted" datetime="{date}">
                      <xsl:text>//</xsl:text>&#160;<xsl:value-of select="$date.formatted" />
                    </time>
                  </p>

                </a>

              </article><!-- /card -->

            </div><!-- /column -->

          </xsl:for-each>

        </div><!-- /project cards -->

      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

</xsl:stylesheet>
