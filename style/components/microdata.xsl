<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Semantic data (microdata)
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2017 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

<!-- this template generates (invisible) meta tags with semantic
     information -->

  <xsl:template name="component.microdata">
    <xsl:param name="title" /><!-- string-->
    <xsl:param name="subtitle" /><!-- string-->

    <!-- options -->
    <xsl:variable name="author" select="/site/options/option[@name = 'site.author']" />
    <xsl:variable name="publisher" select="/site/options/option[@name = 'site.title']" />

    <!-- Schema.org microdata -->
    <meta itemprop="name headline">
      <xsl:attribute name="content">

        <!-- page title -->
        <xsl:value-of select="$title" />

        <!-- optional subtitle -->
        <xsl:if test="$subtitle != ''">
          <xsl:text>: </xsl:text>
          <xsl:value-of select="subtitle" />
        </xsl:if>

      </xsl:attribute>
    </meta>

    <div itemprop="author" itemscope="itemscope" itemtype="http://schema.org/Person">
      <meta itemprop="name" content="{$author}" />
    </div>
    <div itemprop="publisher" itemscope="itemscope" itemtype="http://schema.org/Organization">
      <meta itemprop="name" content="{$publisher}" />
    </div>

  </xsl:template>

</xsl:stylesheet>
