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
      <xsl:when test="not(article[not(@draft)])">

        <p><strong>
          There are no articles, yet. Why don't you create one?
        </strong></p>

      </xsl:when>
      <xsl:otherwise>
        <main><!-- articles -->

          <!-- iterate over all articles -->
          <xsl:for-each select="article[not(@draft)]">
            <xsl:sort select="date" order="descending" />

            <!-- format filename -->
            <xsl:variable name="filename">
              <xsl:call-template name="format.filename">
                <xsl:with-param name="string" select="title" />
              </xsl:call-template>
            </xsl:variable>

            <!-- compute id from filename unless explicitly specified -->
            <xsl:variable name="id">
              <xsl:choose>
                <xsl:when test="@id">
                  <xsl:value-of select="@id" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$filename" />
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>

            <!-- format date -->
            <xsl:variable name="date.formatted">
              <xsl:call-template name="format.date">
                <xsl:with-param name="date" select="date" />
              </xsl:call-template>
            </xsl:variable>

            <!-- article entry -->
            <article>

              <!-- main title -->
              <h2 id="{$id}">
                <a class="x2b-alt-lnk" href="{$site.url}{$article.path}{$filename}.html">
                  <xsl:value-of select="title" />
                </a>
              </h2>

              <a class="x2b-sbtl-lnk" href="{$site.url}{$article.path}{$filename}.html">

                <!-- optional subtitle -->
                <xsl:if test="subtitle">
                  <p><strong>
                    <xsl:value-of select="subtitle" />
                  </strong></p>
                </xsl:if>

                <!-- article description -->
                <p>
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

              <!-- article button -->
              <div class="d-flex">
                <a class="[ btn btn-outline-primary ] ml-auto" title="{title}" href="{$site.url}{$article.path}{$filename}.html" role="button">
                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                  <xsl:value-of select="title" />
                  <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                  <xsl:call-template name="component.icon">
                    <xsl:with-param name="icon">fa-arrow-right</xsl:with-param>
                  </xsl:call-template>
                </a>
              </div>

            </article>

          </xsl:for-each>

        </main><!-- /articles -->

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
          <xsl:with-param name="elements" select="ext:node-set($content)/article[not(@draft)]" />
        </xsl:call-template>
      </xsl:variable>

      <!-- iterate over all distinct years -->
      <xsl:for-each select="ext:node-set($years)/year">
        <xsl:sort order="descending" />

        <!-- nav link section -->
        <section title="{text()}">

          <!-- find all articles from current year -->
          <xsl:for-each select="ext:node-set($content)/article[not(@draft)][starts-with(date, current())]">
            <xsl:sort select="date" order="descending" />

            <!-- format filename -->
            <xsl:variable name="filename">
              <xsl:call-template name="format.filename">
                <xsl:with-param name="string" select="title" />
              </xsl:call-template>
            </xsl:variable>

            <!-- compute id from filename unless explicitly specified -->
            <xsl:variable name="id">
              <xsl:choose>
                <xsl:when test="@id">
                  <xsl:value-of select="@id" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$filename" />
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>

            <!-- nav link -->
            <link title="{title}" href="#{$id}" />

          </xsl:for-each>
        </section>

      </xsl:for-each>

    </nav>

  </xsl:template>

</xsl:stylesheet>
