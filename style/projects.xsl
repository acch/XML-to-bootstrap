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

  <!-- import other project templates -->
  <xsl:import href="projects/overview.xsl" />
  <xsl:import href="projects/detail.xsl" />

  <!-- generate project path -->
  <xsl:variable name="project.path">
    <xsl:choose>
      <xsl:when test="/site/projects/path">
        <xsl:call-template name="format.path">
          <xsl:with-param name="path" select="/site/projects/path" />
        </xsl:call-template>
      </xsl:when>
      <!-- default path -->
      <xsl:otherwise>project/</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- this template generates HTML code for project overview and detail
       pages -->
  <xsl:template name="projects">

    <!-- generate projects overview page -->
    <ext:document
      href="projects.html"
      method="xml"
      omit-xml-declaration="yes"
      encoding="utf-8"
      indent="no">

      <xsl:call-template name="html.page">
        <xsl:with-param name="title" select="/site/projects/title" />
        <xsl:with-param name="subtitle" select="/site/projects/subtitle" />
        <xsl:with-param name="head.subtitle" select="false()" /><!-- don't promote subtitle in head -->
        <xsl:with-param name="content" select="/site/projects" />
        <xsl:with-param name="url">projects.html</xsl:with-param>
        <xsl:with-param name="meta" select="$meta.noindex.follow" />
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
        href="{$project.path}{$filename}.html"
        method="xml"
        omit-xml-declaration="yes"
        encoding="utf-8"
        indent="no">

        <xsl:call-template name="html.page">
          <xsl:with-param name="title" select="title" />
          <xsl:with-param name="subtitle" select="subtitle" />
          <xsl:with-param name="content" select="current()" />
          <xsl:with-param name="content.sidebar">
            <xsl:call-template name="project.sidebar">
              <xsl:with-param name="content" select="current()" />
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="url">
            <xsl:value-of select="$project.path" />
            <xsl:value-of select="$filename" />
            <xsl:text>.html</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="meta">
            <xsl:if test="@draft">
              <xsl:copy-of select="$meta.noindex" />
            </xsl:if>
          </xsl:with-param>
        </xsl:call-template>

      </ext:document>

    </xsl:for-each>

  </xsl:template>

</xsl:stylesheet>
