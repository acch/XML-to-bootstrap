<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Icons
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2017 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Normal icon (fixed-width)
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template name="component.icon">
    <xsl:param name="icon" /><!-- string-->
    <xsl:param name="size">fa-1x</xsl:param><!-- string -->

    <!-- fontawesome icon -->
    <span class="fa {$icon} {$size} fa-fw" aria-hidden="true">
      <xsl:text> </xsl:text><!-- prevent tag from collapsing -->
    </span>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Icon in circle (inverted)
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template name="component.icon.circled">
    <xsl:param name="icon" /><!-- string-->
    <xsl:param name="size">fa-lg</xsl:param><!-- string -->

    <!-- two fontawesome icons stacked onto each other -->
    <span class="fa-stack {$size}" aria-hidden="true">

      <span class="fa fa-circle fa-stack-2x">
        <xsl:text> </xsl:text><!-- prevent tag from collapsing -->
      </span>

      <span class="fa {$icon} fa-stack-1x fa-inverse">
        <xsl:text> </xsl:text><!-- prevent tag from collapsing -->
      </span>

    </span>

  </xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Icon in button (squared box)
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template name="component.icon.button">
    <xsl:param name="title" /><!-- string-->
    <xsl:param name="href" /><!-- string-->
    <xsl:param name="icon" /><!-- string-->
    <xsl:param name="size">fa-lg</xsl:param><!-- string -->
    <xsl:param name="disabled" select="false()" /><!-- boolean -->

    <!-- style depends on disabled state -->
    <xsl:variable name="btn.class">
      <xsl:choose>
        <xsl:when test="$disabled">btn-secondary disabled</xsl:when>
        <xsl:otherwise>btn-primary</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Bootstrap button with fontawesome icon inside -->
    <a role="button" class="btn {$btn.class}">

      <!-- optional title -->
      <xsl:if test="$title != ''">
        <xsl:attribute name="title">
          <xsl:value-of select="$title" />
        </xsl:attribute>
      </xsl:if>

      <!-- optional href -->
      <xsl:if test="$href != ''">
        <xsl:attribute name="href">
          <xsl:value-of select="$href" />
        </xsl:attribute>
      </xsl:if>

      <!-- optional disabled state -->
      <xsl:if test="$disabled">
        <xsl:attribute name="aria-disabled">true</xsl:attribute>
      </xsl:if>

      <span class="fa {$icon} {$size} fa-fw" aria-hidden="true">
        <xsl:text> </xsl:text><!-- prevent tag from collapsing -->
      </span>

    </a>

  </xsl:template>

</xsl:stylesheet>
