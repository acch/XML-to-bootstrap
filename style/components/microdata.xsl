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
     information (Schema.org microdata) -->

  <xsl:template name="component.microdata">
    <xsl:param name="title" /><!-- string-->
    <xsl:param name="subtitle" /><!-- string-->

    <!-- options -->
    <xsl:variable name="author" select="/site/options/option[@name = 'site.author']" />
    <xsl:variable name="publisher" select="/site/options/option[@name = 'site.title']" />

    <!-- optional title -->
    <xsl:if test="$title != ''">
      <meta itemprop="name" content="{$title}" />
    </xsl:if>

    <!-- optional subtitle -->
    <xsl:if test="$subtitle != ''">
      <meta itemprop="headline" content="{substring($subtitle,1,110)}" />
    </xsl:if>

    <div itemprop="author" itemscope="itemscope" itemtype="http://schema.org/Person">
      <meta itemprop="name" content="{$author}" />
    </div>

    <div itemprop="publisher" itemscope="itemscope" itemtype="http://schema.org/Organization">
      <meta itemprop="name" content="{$publisher}" />
    </div>

  </xsl:template>

</xsl:stylesheet>
