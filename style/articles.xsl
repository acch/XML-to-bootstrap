<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  xmlns:math="http://exslt.org/math"
  extension-element-prefixes="ext math">


<!--~~~~~~~~~~~~~~~~~~~~
       Article pages
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="articles">

    <!-- generate article overview page -->
    <ext:document
      href="articles.html"
      method="xml"
      omit-xml-declaration="yes"
      encoding="utf-8"
      indent="yes">

      <xsl:call-template name="html.page">
        <xsl:with-param name="title">Articles</xsl:with-param>
        <xsl:with-param name="subtitle" select="/site/articles/introduction" />
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

      <!-- compute filename -->
      <xsl:variable name="filename">
        <xsl:call-template name="format.filename">
          <xsl:with-param name="string" select="title" />
        </xsl:call-template>
      </xsl:variable>

      <!-- generate article detail page -->
      <ext:document
        href="article.{$filename}.html"
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


<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Article overview page contents
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template match="articles">

    <!-- navigation breadcrumps -->
    <xsl:call-template name="element.breadcrumps">
      <xsl:with-param name="current">Articles</xsl:with-param>
    </xsl:call-template>

    <p class="x2b-gry">
      Click on the title to continue reading...
    </p>

    <!-- iterate over all articles -->
    <xsl:for-each select="article">
      <xsl:sort select="date" order="descending" />

      <!-- compute filename -->
      <xsl:variable name="filename">
        <xsl:call-template name="format.filename">
          <xsl:with-param name="string" select="title" />
        </xsl:call-template>
      </xsl:variable>

      <!-- compute date -->
      <xsl:variable name="date">
        <xsl:call-template name="format.date">
          <xsl:with-param name="date" select="date" />
        </xsl:call-template>
      </xsl:variable>

      <!-- article short description -->
      <div class="row">
        <div class="col-sm-12">

          <h2 id="{@id}">
            <a href="article.{$filename}.html">
              <xsl:value-of select="title" />

              <br />

              <small><xsl:value-of select="subtitle" /></small>
            </a>
          </h2>

          <p>
            <xsl:value-of select="short" />
            <xsl:text> </xsl:text>
            <a href="article.{$filename}.html">
              //<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text><xsl:value-of select="$date" />
            </a>
          </p>

        </div> <!-- /column -->
      </div> <!-- /row -->

      <!-- divider -->
      <xsl:if test="position() != last()">
        <hr />
      </xsl:if>

    </xsl:for-each>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Article overview page sidebar
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="articles.sidebar">
    <xsl:param name="content" /><!-- node-set (articles) -->

    <nav>
      <xsl:for-each select="$content/article[@id]">
        <xsl:sort select="date" order="descending" />

        <link title="{title}" href="{@id}" />

      </xsl:for-each>
    </nav>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Article detail page contents
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template match="article">

    <!-- compute date -->
    <xsl:variable name="date">
      <xsl:call-template name="format.date">
        <xsl:with-param name="date" select="date" />
      </xsl:call-template>
    </xsl:variable>

    <!-- navigation breadcrumps -->
    <xsl:call-template name="element.breadcrumps">
      <xsl:with-param name="parent">
        <page title="Articles" href="/articles.html" />
      </xsl:with-param>
      <xsl:with-param name="current" select="title" />
    </xsl:call-template>

    <!-- article introduction -->
    <p>
      <span class="x2b-gry">
        //<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text><xsl:value-of select="$date" />
      </span>

      <br />

      <strong>
        <xsl:value-of select="short" />
      </strong>
    </p>

    <!-- divider -->
    <hr />

    <!-- copy content from XML directly -->
    <xsl:call-template name="copy.content">
      <xsl:with-param name="content" select="content" />
    </xsl:call-template>

    <!-- previous and next article -->
    <!-- TODO: sort articles by date to select next / prev one -->
    <xsl:variable name="prev" select="preceding-sibling::article[1]/title" />
    <xsl:variable name="next" select="following-sibling::article[1]/title" />

    <!-- pager navigation -->
    <xsl:call-template name="element.pager">

      <xsl:with-param name="prev">
        <xsl:if test="$prev">
          <page title="{$prev}">
            <xsl:attribute name="href">article.<xsl:call-template name="format.filename">
              <xsl:with-param name="string" select="$prev" />
            </xsl:call-template>.html</xsl:attribute>
          </page>
        </xsl:if>
      </xsl:with-param>

      <xsl:with-param name="next">
        <xsl:if test="$next">
          <page title="{$next}">
            <xsl:attribute name="href">article.<xsl:call-template name="format.filename">
              <xsl:with-param name="string" select="$next" />
            </xsl:call-template>.html</xsl:attribute>
          </page>
        </xsl:if>
      </xsl:with-param>

    </xsl:call-template>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Article detail page sidebar
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="article.sidebar">
    <xsl:param name="content" /><!-- node-set (article) -->

    <nav>
      <xsl:for-each select="$content/content/*[@id]">

        <link title="{.}" href="{@id}" />

      </xsl:for-each>
    </nav>

  </xsl:template>

</xsl:stylesheet>
