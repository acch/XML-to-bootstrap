<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Breadcrumb
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2017 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template name="component.breadcrumb">
    <xsl:param name="parent" /><!-- node-set (page) -->
    <xsl:param name="current" /><!-- string -->

    <!-- convert parent parameter to node-set -->
    <xsl:variable name="parent.page" select="ext:node-set($parent)/page" />

    <!-- Bootstrap breadcrumb -->
    <div role="navigation" class="breadcrumb" itemscope="itemscope" itemtype="http://schema.org/SiteNavigationElement">

      <!-- home -->
      <a class="breadcrumb-item" href="{$site.url}" title="Home">Home</a>

      <!-- optional category page -->
      <xsl:if test="$parent.page">
        <a class="breadcrumb-item" href="{$parent.page/@href}" title="{$parent.page/@title}">
          <xsl:value-of select="$parent.page/@title" />
        </a>
      </xsl:if>

      <!-- current page -->
      <span class="breadcrumb-item active" title="{$current}">
        <xsl:value-of select="$current" />
      </span>

    </div><!-- /breadcrumb -->

  </xsl:template>

</xsl:stylesheet>
