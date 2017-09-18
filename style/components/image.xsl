<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Responsive and non-responsive images
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2017 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Responsive picture
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- replace img element with responsive picture -->
  <xsl:template match="img">

    <!-- check for internal-, or external URL -->
    <xsl:choose>
      <xsl:when test="starts-with(@src, '//') or starts-with(@src, 'http')">

        <!-- external resource -->

        <!-- copy img element -->
        <img>

          <!-- center img -->
          <xsl:attribute name="class">
            <xsl:text>d-block mx-auto</xsl:text>

            <!-- copy remaining classes -->
            <xsl:if test="@class">
              <xsl:text> </xsl:text>
              <xsl:value-of select="@class" />
            </xsl:if>
          </xsl:attribute>

          <!-- copy remaining img attributes -->
          <xsl:apply-templates select="@*[local-name() != 'class']" />

        </img>

      </xsl:when>
      <xsl:otherwise><!-- not(starts-with(@src, '//')) and not(starts-with(@src, 'http')) -->

        <!-- internal resource -->

        <!-- options -->
        <xsl:variable name="sizes" select="/site/options/export[@type = 'grunt']/option[@name = 'responive_image.size']" />

        <!-- compute base URL -->
        <xsl:variable name="baseurl">

          <!-- site (static) URL -->
          <xsl:value-of select="$site.assets.url" />

          <!-- path of category (articles|projects|galleries) -->
          <xsl:call-template name="format.path">
            <xsl:with-param name="path" select="ancestor::content/../../path" />
          </xsl:call-template>

          <!-- path of entry (id or filename of article|project|gallery) -->
          <xsl:choose>
            <xsl:when test="ancestor::content/../@id">
              <xsl:value-of select="ancestor::content/../@id" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="format.filename">
                <xsl:with-param name="string" select="ancestor::content/../title" />
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>

          <!-- slash if necessary -->
          <xsl:if test="not(starts-with(@src, '/'))">
            <xsl:text>/</xsl:text>
          </xsl:if>

          <!-- remove name suffix -->
          <xsl:value-of select="substring-before(@src, '.')" />

        </xsl:variable>

        <!-- name suffix -->
        <xsl:variable name="suffix">
          <xsl:value-of select="substring-after(@src, '.')" />
        </xsl:variable>

        <!-- responsive image resources -->
        <img>

          <!-- responsive img 'srcset' attribute -->
          <xsl:attribute name="srcset">

            <!-- for all responsive image sizes -->
            <xsl:for-each select="$sizes">

              <!-- compute image names and width descriptors -->
              <xsl:value-of select="$baseurl" />
              <xsl:text>-</xsl:text>
              <xsl:value-of select="current()" />
              <xsl:text>.</xsl:text>
              <xsl:value-of select="$suffix" />
              <xsl:text> </xsl:text>
              <xsl:value-of select="current()" />
              <xsl:text>w</xsl:text>

              <xsl:if test="position() != last()">
                <xsl:text>, </xsl:text>
              </xsl:if>

            </xsl:for-each>

          </xsl:attribute>

          <!-- responsive img 'sizes' attribute -->
          <xsl:attribute name="sizes">

            <!-- breakpoint image sizes depending on sidebar -->
            <xsl:choose>
              <xsl:when test="ancestor::content/*[@id]">
                <xsl:value-of select="$img.sizes.sidebar" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$img.sizes" />
              </xsl:otherwise>
            </xsl:choose>

          </xsl:attribute>

          <!-- img (fallback) 'src' attribute -->
          <xsl:attribute name="src">
            <xsl:value-of select="$baseurl" />
            <xsl:text>-</xsl:text>
            <xsl:value-of select="$sizes[last()]" />
            <xsl:text>.</xsl:text>
            <xsl:value-of select="$suffix" />
          </xsl:attribute>

          <!-- center img -->
          <xsl:attribute name="class">
            <xsl:text>d-block mx-auto</xsl:text>

            <!-- copy remaining classes -->
            <xsl:if test="@class">
              <xsl:text> </xsl:text>
              <xsl:value-of select="@class" />
            </xsl:if>
          </xsl:attribute>

          <!-- copy remaining img attributes -->
          <xsl:apply-templates select="@*[local-name() != 'class' and local-name() != 'src']" />

        </img>

      </xsl:otherwise><!-- /not(starts-with(@src, '//')) -->
    </xsl:choose>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Non-responsive image
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- this template generates (non-responsive) images -->
  <xsl:template name="component.image">
    <xsl:param name="img" /><!-- node-set (with 'src' attribute) -->

    <xsl:variable name="image" select="ext:node-set($img)" />

    <!-- colorized overlay -->
    <span class="x2b-clrzd">

      <!-- (non-responsive) image element -->
      <img class="nonresponsive mx-1">

        <!-- img 'src' attribute -->
        <xsl:attribute name="src">

          <!-- site (static) URL -->
          <xsl:value-of select="$site.assets.url" />

          <!-- image resource -->
          <xsl:value-of select="$image/@src" />

        </xsl:attribute>

        <!-- copy remaining image attributes -->
        <xsl:apply-templates select="$image/@*[local-name() != 'src']" />

      </img>

    </span><!-- /clrzd -->

  </xsl:template>

</xsl:stylesheet>
