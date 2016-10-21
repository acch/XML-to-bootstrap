<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Articles overview page
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Article overview page contents
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="articles">

    <!-- navigation breadcrumps -->
    <xsl:call-template name="element.breadcrumps">
      <xsl:with-param name="current" select="title" />
    </xsl:call-template>

    <!-- spacing -->
    <!--hr class="invisible my-1" /-->

    <!--p class="text-muted">
      Click on the title to continue reading&#8230;
    </p-->

    <!-- spacing -->
    <hr class="invisible mt-2 mb-0" />

    <xsl:choose>
      <xsl:when test="not(article)">

        <p><strong>
          There are no articles, yet. Why don't you create one?
        </strong></p>

      </xsl:when>
      <xsl:otherwise>

        <!-- iterate over all articles -->
        <xsl:for-each select="article[not(@draft)]">
          <xsl:sort select="date" order="descending" />

          <!-- format filename -->
          <xsl:variable name="filename">
            <xsl:call-template name="format.filename">
              <xsl:with-param name="string" select="title" />
            </xsl:call-template>
          </xsl:variable>

          <!-- format date -->
          <xsl:variable name="date">
            <xsl:call-template name="format.date">
              <xsl:with-param name="date" select="date" />
            </xsl:call-template>
          </xsl:variable>

          <!-- TODO: add semantic vocabulary/description -->
          <article>

            <!-- article title -->
            <h3 class="x2b-anchr" id="{@id}">
              <a class="x2b-alt-lnk" href="{$site.url}article/{$filename}.html">
                <xsl:value-of select="title" />
              </a>
            </h3>

            <a class="x2b-sbtl-lnk" href="{$site.url}article/{$filename}.html">

              <!-- article subtitle -->
              <p><strong>
                <xsl:value-of select="subtitle" />
              </strong></p>

              <!-- article description -->
              <p>
                <xsl:value-of select="short" />

                <xsl:text> </xsl:text>

                <span class="text-muted">
                  //&#160;<xsl:value-of select="$date" />
                </span>
              </p>

            </a>

          </article>

          <!-- divider -->
          <xsl:if test="position() != last()">
            <hr class="mt-3 mb-2" />
          </xsl:if>

        </xsl:for-each>

      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Article overview page sidebar
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template name="articles.sidebar">
    <xsl:param name="content" /><!-- node-set (articles) -->

    <nav>

      <!-- find all years -->
      <xsl:variable name="years">
        <xsl:call-template name="date.years">
          <xsl:with-param name="elements" select="ext:node-set($content)/article[@id][not(@draft)]" />
        </xsl:call-template>
      </xsl:variable>

      <!-- iterate over all distinct years -->
      <xsl:for-each select="ext:node-set($years)/year">
        <xsl:sort order="descending" />

        <!-- nav link section -->
        <section title="{text()}">

          <!-- find all articles from current year -->
          <xsl:for-each select="ext:node-set($content)/article[@id][not(@draft)][starts-with(date, current())]">
            <xsl:sort select="date" order="descending" />

            <!-- nav link -->
            <link title="{title}" href="#{@id}" />

          </xsl:for-each>
        </section>

      </xsl:for-each>

    </nav>

  </xsl:template>

</xsl:stylesheet>
