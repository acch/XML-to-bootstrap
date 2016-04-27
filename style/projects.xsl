<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Project pages
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- this template generates HTML code for project overview and detail
       pages -->
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


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Project overview page contents
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="projects">

    <!-- navigation breadcrumps -->
    <xsl:call-template name="element.breadcrumps">
      <xsl:with-param name="current" select="title" />
    </xsl:call-template>

    <!-- spacing -->
    <!--hr class="invisible m-y-1" /-->

    <!--p class="text-muted">
      Click on the title to continue reading&#8230;
    </p-->

    <!-- spacing -->
    <hr class="invisible m-y-1" />

    <xsl:if test="not(project)">
      <p><strong>
        There are no projects, yet. Why don't you create one?
      </strong></p>
    </xsl:if>

    <!-- project cards -->
    <div class="row">

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

        <!-- responsive column -->
        <div class="{$style.cardcolumn}">

          <!-- project card -->
          <!-- TODO: add semantic vocabulary/description -->
          <article class="card card-block">

            <!-- project title -->
            <h3 class="card-title">
              <a href="{$site.url}project/{$filename}.html">
                <xsl:value-of select="title" />
              </a>
            </h3>

            <a class="x2b-txt-lnk" href="{$site.url}project/{$filename}.html">

              <!-- project subtitle -->
              <p class="card-text"><strong>
                <xsl:value-of select="subtitle" />
              </strong></p>

              <!-- project description -->
              <p class="card-text">
                <xsl:value-of select="short" />

                <xsl:text> </xsl:text>

                <span class="text-muted">
                  //&#160;<xsl:value-of select="$date" />
                </span>
              </p>

            </a>

          </article><!-- /card -->

        </div><!-- /column -->

      </xsl:for-each>

    </div><!-- /project cards -->

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Project detail page contents
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

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
        <page title="{/site/projects/title}" href="{$site.url}projects.html" />
      </xsl:with-param>
      <xsl:with-param name="current" select="title" />
    </xsl:call-template>

    <!-- spacing -->
    <hr class="invisible m-y-1" />

    <!-- TODO: add semantic vocabulary/description -->
    <article>

      <!-- put introduction in a text column -->
      <xsl:call-template name="element.textcolumn">
        <xsl:with-param name="sidebar" select="content/*[@id]" />

        <!-- project introduction -->
        <xsl:with-param name="content">
          <p>
            <span class="text-muted">
              //&#160;<xsl:value-of select="$date.formatted" />
            </span>

            <br />

            <strong>
              <xsl:value-of select="short" />
            </strong>
          </p>

          <!-- spacing -->
          <hr class="invisible m-y-1" />

          <!-- copy actual content from XML -->
          <xsl:call-template name="copy.content">
            <xsl:with-param name="content" select="content" />
          </xsl:call-template>

        </xsl:with-param>

      </xsl:call-template>

    </article>

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
            <xsl:attribute name="href"><xsl:value-of select="$site.url" />project/<xsl:call-template name="format.filename">
              <xsl:with-param name="string" select="$prev" />
            </xsl:call-template>.html</xsl:attribute>
          </page>
        </xsl:if>
      </xsl:with-param>

      <!-- next project -->
      <xsl:with-param name="next">
        <xsl:if test="$next != ''">
          <page title="{$next}">
            <xsl:attribute name="href"><xsl:value-of select="$site.url" />project/<xsl:call-template name="format.filename">
              <xsl:with-param name="string" select="$next" />
            </xsl:call-template>.html</xsl:attribute>
          </page>
        </xsl:if>
      </xsl:with-param>

    </xsl:call-template>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Project detail page sidebar
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template name="project.sidebar">
    <xsl:param name="content" /><!-- node-set (project) -->

    <nav>

      <!-- find all elements with id attribute -->
      <xsl:for-each select="ext:node-set($content)/content/*[@id]">

        <!-- nav link -->
        <link title="{text()}" href="#{@id}" />

      </xsl:for-each>

    </nav>

  </xsl:template>

</xsl:stylesheet>
