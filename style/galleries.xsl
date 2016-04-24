<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Gallery pages
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/scrollpos-styler/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- this template generates HTML code for gallery overview and detail
       pages -->
  <xsl:template name="galleries">

    <!-- generate gallery overview page -->
    <ext:document
      href="galleries.html"
      method="xml"
      omit-xml-declaration="yes"
      encoding="utf-8"
      indent="yes">

      <xsl:call-template name="html.page">
        <xsl:with-param name="title" select="/site/galleries/title" />
        <xsl:with-param name="subtitle" select="/site/galleries/subtitle" />
        <xsl:with-param name="content" select="/site/galleries" />
      </xsl:call-template>

    </ext:document>

    <!-- iterate over all galleries -->
    <xsl:for-each select="/site/galleries/gallery">

      <!-- format filename -->
      <xsl:variable name="filename">
        <xsl:call-template name="format.filename">
          <xsl:with-param name="string" select="title" />
        </xsl:call-template>
      </xsl:variable>

      <!-- generate gallery detail page -->
      <ext:document
        href="gallery/{$filename}.html"
        method="xml"
        omit-xml-declaration="yes"
        encoding="utf-8"
        indent="yes">

        <xsl:call-template name="html.page">
          <xsl:with-param name="title" select="title" />
          <xsl:with-param name="subtitle" select="subtitle" />
          <xsl:with-param name="content" select="." />
        </xsl:call-template>

      </ext:document>

    </xsl:for-each>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Gallery overview page contents
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="galleries">

    <!-- navigation breadcrumps -->
    <xsl:call-template name="element.breadcrumps">
      <xsl:with-param name="current" select="title" />
    </xsl:call-template>

    <!-- spacing -->
    <!--hr class="invisible m-y-1" /-->

    <!--p class="text-muted">
      Click on the title to view gallery<xsl:text disable-output-escaping="yes">&amp;hellip;</xsl:text>
    </p-->

    <!-- spacing -->
    <hr class="invisible m-y-1" />

    <xsl:if test="not(gallery)">
      <p><strong>
        There are no galleries, yet. Why don't you create one?
      </strong></p>
    </xsl:if>

    <!-- project cards -->
    <div class="row">

      <!-- iterate over all galleries -->
      <xsl:for-each select="gallery">
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

          <!-- gallery card -->
          <div class="card card-block">

            <!-- gallery title -->
            <h3 class="card-title">
              <a href="{$site.url}gallery/{$filename}.html">
                <xsl:value-of select="title" />
              </a>
            </h3>

            <a class="x2b-txt-lnk" href="{$site.url}gallery/{$filename}.html">

              <!-- gallery description -->
              <p class="card-text">
                <xsl:value-of select="short" />

                <xsl:text> </xsl:text>

                <span class="text-muted">
                  //<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text><xsl:value-of select="$date" />
                </span>
              </p>

            </a>

          </div><!-- /card -->

        </div><!-- /column -->

      </xsl:for-each>

    </div><!-- /gallery cards -->

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Gallery detail page contents
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="gallery">

    <!-- format date -->
    <xsl:variable name="date.formatted">
      <xsl:call-template name="format.date">
        <xsl:with-param name="date" select="date" />
      </xsl:call-template>
    </xsl:variable>

    <!-- navigation breadcrumps -->
    <xsl:call-template name="element.breadcrumps">
      <xsl:with-param name="parent">
        <page title="{/site/galleries/title}" href="{$site.url}galleries.html" />
      </xsl:with-param>
      <xsl:with-param name="current" select="title" />
    </xsl:call-template>

    <!-- spacing -->
    <hr class="invisible m-y-1" />

    <!-- gallery introduction -->
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

    <!-- find latest gallery before current one -->
    <xsl:variable name="prev">
      <xsl:call-template name="date.prev.title">
        <xsl:with-param name="date" select="date" />
        <xsl:with-param name="elements" select="../gallery" />
      </xsl:call-template>
    </xsl:variable>

    <!-- find earliest gallery after current one -->
    <xsl:variable name="next">
      <xsl:call-template name="date.next.title">
        <xsl:with-param name="date" select="date" />
        <xsl:with-param name="elements" select="../gallery" />
      </xsl:call-template>
    </xsl:variable>

    <!-- pager navigation -->
    <xsl:call-template name="element.pager">

      <!-- previous gallery -->
      <xsl:with-param name="prev">
        <xsl:if test="$prev != ''">
          <page title="{$prev}">
            <xsl:attribute name="href"><xsl:value-of select="$site.url" />gallery/<xsl:call-template name="format.filename">
              <xsl:with-param name="string" select="$prev" />
            </xsl:call-template>.html</xsl:attribute>
          </page>
        </xsl:if>
      </xsl:with-param>

      <!-- next gallery -->
      <xsl:with-param name="next">
        <xsl:if test="$next != ''">
          <page title="{$next}">
            <xsl:attribute name="href"><xsl:value-of select="$site.url" />gallery/<xsl:call-template name="format.filename">
              <xsl:with-param name="string" select="$next" />
            </xsl:call-template>.html</xsl:attribute>
          </page>
        </xsl:if>
      </xsl:with-param>

    </xsl:call-template>

  </xsl:template>

</xsl:stylesheet>
