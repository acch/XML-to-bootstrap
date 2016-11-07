<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Project detail page
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

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

    <!-- navigation breadcrumbs -->
    <xsl:call-template name="element.breadcrumbs">
      <xsl:with-param name="parent">
        <page title="{/site/projects/title}" href="{$site.url}projects.html" />
      </xsl:with-param>
      <xsl:with-param name="current" select="title" />
    </xsl:call-template>

    <!-- spacing -->
    <hr class="invisible my-1" />

    <!-- put content inside a text column -->
    <xsl:call-template name="element.textcolumn">
      <xsl:with-param name="sidebar" select="content/*[@id]" />
      <xsl:with-param name="content">

        <!-- semantic vocabulary 'CreativeWork' -->
        <main itemscope="itemscope" itemtype="http://schema.org/CreativeWork" role="main">

          <!-- add meta tags -->
          <xsl:call-template name="element.data.meta">
            <xsl:with-param name="title" select="title" />
            <xsl:with-param name="subtitle" select="subtitle" />
          </xsl:call-template>

          <!-- project introduction -->
          <header itemprop="description"><p>
            <time class="text-muted" itemprop="datePublished dateModified" datetime="{date}">
              <xsl:text>//&#160;</xsl:text>
              <xsl:value-of select="$date.formatted" />
            </time>

            <xsl:if test="short">
              <br />
              <strong><xsl:value-of select="short" /></strong>
            </xsl:if>
          </p></header><!-- /description -->

          <!-- spacing -->
          <hr class="invisible my-1" />

          <!-- copy actual content from XML -->
          <xsl:call-template name="copy.content">
            <xsl:with-param name="content" select="content" />
          </xsl:call-template>

        </main>

        <!-- spacing -->
        <hr class="invisible my-1" />

        <!-- find latest project before current one -->
        <xsl:variable name="prev">
          <xsl:call-template name="date.prev.title">
            <xsl:with-param name="date" select="date" />
            <xsl:with-param name="elements" select="../project[not(@draft)]" />
          </xsl:call-template>
        </xsl:variable>

        <!-- find earliest project after current one -->
        <xsl:variable name="next">
          <xsl:call-template name="date.next.title">
            <xsl:with-param name="date" select="date" />
            <xsl:with-param name="elements" select="../project[not(@draft)]" />
          </xsl:call-template>
        </xsl:variable>

        <!-- pager navigation -->
        <xsl:call-template name="element.pager">

          <!-- previous project -->
          <xsl:with-param name="prev">
            <xsl:if test="$prev != ''">
              <page title="{$prev}">
                <xsl:attribute name="href">
                  <xsl:value-of select="$site.url" />
                  <xsl:value-of select="$project.path" />
                  <xsl:call-template name="format.filename">
                    <xsl:with-param name="string" select="$prev" />
                  </xsl:call-template>
                  <xsl:text>.html</xsl:text>
                </xsl:attribute>
              </page>
            </xsl:if>
          </xsl:with-param>

          <!-- next project -->
          <xsl:with-param name="next">
            <xsl:if test="$next != ''">
              <page title="{$next}">
                <xsl:attribute name="href">
                  <xsl:value-of select="$site.url" />
                  <xsl:value-of select="$project.path" />
                  <xsl:call-template name="format.filename">
                    <xsl:with-param name="string" select="$next" />
                  </xsl:call-template>
                  <xsl:text>.html</xsl:text>
                </xsl:attribute>
              </page>
            </xsl:if>
          </xsl:with-param>

        </xsl:call-template>

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
