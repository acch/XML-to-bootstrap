<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Article pages
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/scrollpos-styler/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- this template generates HTML code for article overview and detail
       pages -->
  <xsl:template name="articles">

    <!-- generate article overview page -->
    <ext:document
      href="articles.html"
      method="xml"
      omit-xml-declaration="yes"
      encoding="utf-8"
      indent="yes">

      <xsl:call-template name="html.page">
        <xsl:with-param name="title" select="/site/articles/title" />
        <xsl:with-param name="subtitle" select="/site/articles/subtitle" />
        <xsl:with-param name="content" select="/site/articles" />
        <xsl:with-param name="content.sidebar">
          <xsl:call-template name="articles.sidebar">
            <xsl:with-param name="content" select="/site/articles" />
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>

    </ext:document>

    <!-- iterate over all articles -->
    <xsl:for-each select="/site/articles/article">

      <!-- format filename -->
      <xsl:variable name="filename">
        <xsl:call-template name="format.filename">
          <xsl:with-param name="string" select="title" />
        </xsl:call-template>
      </xsl:variable>

      <!-- generate article detail page -->
      <ext:document
        href="article/{$filename}.html"
        method="xml"
        omit-xml-declaration="yes"
        encoding="utf-8"
        indent="yes">

        <xsl:call-template name="html.page">
          <xsl:with-param name="title" select="title" />
          <xsl:with-param name="subtitle" select="subtitle" />
          <xsl:with-param name="content" select="." />
          <xsl:with-param name="content.sidebar">
            <xsl:call-template name="article.sidebar">
              <xsl:with-param name="content" select="." />
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>

      </ext:document>

    </xsl:for-each>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Article overview page contents
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="articles">

    <!-- navigation breadcrumps -->
    <xsl:call-template name="element.breadcrumps">
      <xsl:with-param name="current" select="title" />
    </xsl:call-template>

    <!-- spacing -->
    <!--hr class="invisible m-y-1" /-->

    <!--p class="text-muted">
      Click on the title to continue reading<xsl:text disable-output-escaping="yes">&amp;hellip;</xsl:text>
    </p-->

    <!-- spacing -->
    <hr class="invisible m-t-2 m-b-0" />

    <xsl:if test="not(article)">
      <p><strong>
        There are no articles, yet. Why don't you create one?
      </strong></p>
    </xsl:if>

    <!-- iterate over all articles -->
    <xsl:for-each select="article">
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

      <!-- article title -->
      <h3 class="x2b-anchr" id="{@id}">
        <a href="{$site.url}article/{$filename}.html">
          <xsl:value-of select="title" />
        </a>
      </h3>

      <a class="x2b-txt-lnk" href="{$site.url}article/{$filename}.html">

        <!-- article subtitle -->
        <p><strong>
          <xsl:value-of select="subtitle" />
        </strong></p>

        <!-- article description -->
        <p>
          <xsl:value-of select="short" />

          <xsl:text> </xsl:text>

          <span class="text-muted">
            //<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text><xsl:value-of select="$date" />
          </span>
        </p>

      </a>

      <!-- divider -->
      <xsl:if test="position() != last()">
        <hr class="m-t-3 m-b-2" />
      </xsl:if>

    </xsl:for-each>

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
          <xsl:with-param name="elements" select="$content/article" />
        </xsl:call-template>
      </xsl:variable>

      <!-- iterate over all distinct years -->
      <xsl:for-each select="ext:node-set($years)/year">
        <xsl:sort order="descending" />

        <!-- nav link section -->
        <section title="{text()}">

          <!-- find all articles from current year -->
          <xsl:for-each select="$content/article[@id][starts-with(date, current())]">
            <xsl:sort select="date" order="descending" />

            <!-- nav link -->
            <link title="{title}" href="#{@id}" />

          </xsl:for-each>
        </section>

      </xsl:for-each>

    </nav>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Article detail page contents
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="article">

    <!-- format date -->
    <xsl:variable name="date.formatted">
      <xsl:call-template name="format.date">
        <xsl:with-param name="date" select="date" />
      </xsl:call-template>
    </xsl:variable>

    <!-- navigation breadcrumps -->
    <xsl:call-template name="element.breadcrumps">
      <xsl:with-param name="parent">
        <page title="{/site/articles/title}" href="{$site.url}articles.html" />
      </xsl:with-param>
      <xsl:with-param name="current" select="title" />
    </xsl:call-template>

    <!-- spacing -->
    <hr class="invisible m-y-1" />

    <!-- article introduction -->
    <p>
      <span class="text-muted">
        //<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text><xsl:value-of select="$date.formatted" />
      </span>

      <br />

      <strong>
        <xsl:value-of select="short" />
      </strong>
    </p>

    <!-- spacing -->
    <hr class="invisible m-y-1" />

    <!-- copy content from XML directly -->
    <xsl:call-template name="copy.content">
      <xsl:with-param name="content" select="content" />
    </xsl:call-template>

    <!-- spacing -->
    <hr class="invisible m-y-1" />

    <!-- find latest article before current one -->
    <xsl:variable name="prev">
      <xsl:call-template name="date.prev.title">
        <xsl:with-param name="date" select="date" />
        <xsl:with-param name="elements" select="../article" />
      </xsl:call-template>
    </xsl:variable>

    <!-- find earliest article after current one -->
    <xsl:variable name="next">
      <xsl:call-template name="date.next.title">
        <xsl:with-param name="date" select="date" />
        <xsl:with-param name="elements" select="../article" />
      </xsl:call-template>
    </xsl:variable>

    <!-- pager navigation -->
    <xsl:call-template name="element.pager">

      <!-- previous article -->
      <xsl:with-param name="prev">
        <xsl:if test="$prev != ''">
          <page title="{$prev}">
            <xsl:attribute name="href"><xsl:value-of select="$site.url" />article/<xsl:call-template name="format.filename">
              <xsl:with-param name="string" select="$prev" />
            </xsl:call-template>.html</xsl:attribute>
          </page>
        </xsl:if>
      </xsl:with-param>

      <!-- next article -->
      <xsl:with-param name="next">
        <xsl:if test="$next != ''">
          <page title="{$next}">
            <xsl:attribute name="href"><xsl:value-of select="$site.url" />article/<xsl:call-template name="format.filename">
              <xsl:with-param name="string" select="$next" />
            </xsl:call-template>.html</xsl:attribute>
          </page>
        </xsl:if>
      </xsl:with-param>

    </xsl:call-template>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Article detail page sidebar
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template name="article.sidebar">
    <xsl:param name="content" /><!-- node-set (article) -->

    <nav>

      <!-- find all elements with id attribute -->
      <xsl:for-each select="$content/content/*[@id]">

        <!-- nav link -->
        <link title="{text()}" href="#{@id}" />

      </xsl:for-each>

    </nav>

  </xsl:template>

</xsl:stylesheet>
