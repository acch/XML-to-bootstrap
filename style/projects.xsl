<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">


<!--~~~~~~~~~~~~~~~~~~~~
       Projects pages
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="projects">

    <!-- generate projects overview page -->
    <ext:document
      href="projects.html"
      method="xml"
      omit-xml-declaration="yes"
      encoding="utf-8"
      indent="yes">

      <xsl:call-template name="html.page">
        <xsl:with-param name="title" select="/site/projects/title" />
        <xsl:with-param name="subtitle" select="/site/projects/subtitle" />
        <xsl:with-param name="content" select="/site/projects" />
        <xsl:with-param name="content.sidebar">
          <xsl:call-template name="projects.sidebar">
            <xsl:with-param name="content" select="/site/projects" />
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>

    </ext:document>

    <!-- iterate over all projects -->
    <xsl:for-each select="/site/projects/project">

      <!-- format filename -->
      <xsl:variable name="filename">
        <xsl:call-template name="format.filename">
          <xsl:with-param name="string" select="title" />
        </xsl:call-template>
      </xsl:variable>

      <!-- generate project detail page -->
      <ext:document
        href="project/{$filename}.html"
        method="xml"
        omit-xml-declaration="yes"
        encoding="utf-8"
        indent="yes">

        <xsl:call-template name="html.page">
          <xsl:with-param name="title" select="title" />
          <xsl:with-param name="subtitle" select="subtitle" />
          <xsl:with-param name="content" select="." />
          <xsl:with-param name="content.sidebar">
            <xsl:call-template name="project.sidebar">
              <xsl:with-param name="content" select="." />
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>

      </ext:document>

    </xsl:for-each>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Project overview page contents
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template match="projects">

    <!-- navigation breadcrumps -->
    <xsl:call-template name="element.breadcrumps">
      <xsl:with-param name="current" select="title" />
    </xsl:call-template>

    <!-- spacing -->
    <hr class="invisible m-y-1" />

    <p class="text-muted">
      Click on the title to continue reading...
    </p>

    <!-- spacing -->
    <hr class="invisible m-t-1 m-b-0" />

    <!-- iterate over all projects -->
    <xsl:for-each select="project">
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

      <!-- project short description -->
      <h3 class="x2b-anchr" id="{@id}">
        <a href="/project/{$filename}.html">
          <xsl:value-of select="title" />
        </a>
      </h3>

      <p><strong>
        <xsl:value-of select="subtitle" />
      </strong></p>

      <p>
        <xsl:value-of select="short" />
        <xsl:text> </xsl:text>
        <a href="/project/{$filename}.html">
          //<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text><xsl:value-of select="$date" />
        </a>
      </p>

      <!-- divider -->
      <xsl:if test="position() != last()">
        <hr class="m-y-2" />
      </xsl:if>

    </xsl:for-each>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Project overview page sidebar
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="projects.sidebar">
    <xsl:param name="content" /><!-- node-set (projects) -->

    <nav>

      <!-- find all years -->
      <xsl:variable name="years">
        <xsl:call-template name="date.years">
          <xsl:with-param name="elements" select="$content/project" />
        </xsl:call-template>
      </xsl:variable>

      <!-- iterate over all distinct years -->
      <xsl:for-each select="ext:node-set($years)/year">
        <xsl:sort order="descending" />

        <!-- nav link section -->
        <section title="{text()}">

          <!-- find all projects from current year -->
          <xsl:for-each select="$content/project[@id][starts-with(date, current())]">
            <xsl:sort select="date" order="descending" />

            <!-- nav link -->
            <link title="{title}" href="#{@id}" />

          </xsl:for-each>
        </section>

      </xsl:for-each>

    </nav>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Project detail page contents
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template match="project">

    <!-- format date -->
    <xsl:variable name="date.formatted">
      <xsl:call-template name="format.date">
        <xsl:with-param name="date" select="date" />
      </xsl:call-template>
    </xsl:variable>

    <!-- navigation breadcrumps -->
    <xsl:call-template name="element.breadcrumps">
      <xsl:with-param name="parent">
        <page title="{/site/projects/title}" href="/projects.html" />
      </xsl:with-param>
      <xsl:with-param name="current" select="title" />
    </xsl:call-template>

    <!-- spacing -->
    <hr class="invisible m-y-1" />

    <!-- project introduction -->
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

    <!-- find latest project before current one -->
    <xsl:variable name="prev">
      <xsl:call-template name="date.prev.title">
        <xsl:with-param name="date" select="date" />
        <xsl:with-param name="elements" select="../project" />
      </xsl:call-template>
    </xsl:variable>

    <!-- find earliest project after current one -->
    <xsl:variable name="next">
      <xsl:call-template name="date.next.title">
        <xsl:with-param name="date" select="date" />
        <xsl:with-param name="elements" select="../project" />
      </xsl:call-template>
    </xsl:variable>

    <!-- pager navigation -->
    <xsl:call-template name="element.pager">

      <!-- previous project -->
      <xsl:with-param name="prev">
        <xsl:if test="$prev != ''">
          <page title="{$prev}">
            <xsl:attribute name="href">/project/<xsl:call-template name="format.filename">
              <xsl:with-param name="string" select="$prev" />
            </xsl:call-template>.html</xsl:attribute>
          </page>
        </xsl:if>
      </xsl:with-param>

      <!-- next project -->
      <xsl:with-param name="next">
        <xsl:if test="$next != ''">
          <page title="{$next}">
            <xsl:attribute name="href">/project/<xsl:call-template name="format.filename">
              <xsl:with-param name="string" select="$next" />
            </xsl:call-template>.html</xsl:attribute>
          </page>
        </xsl:if>
      </xsl:with-param>

    </xsl:call-template>

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Project detail page sidebar
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="project.sidebar">
    <xsl:param name="content" /><!-- node-set (project) -->

    <nav>

      <!-- find all elements with id attribute -->
      <xsl:for-each select="$content/content/*[@id]">

        <!-- nav link -->
        <link title="{text()}" href="#{@id}" />

      </xsl:for-each>

    </nav>

  </xsl:template>

</xsl:stylesheet>
