<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Sidebar panel
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/scrollpos-styler/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- this template generates HTML code for the fixed sidebar -->
  <xsl:template name="html.sidebar">
    <xsl:param name="content" /><!-- node-set (nav) -->

    <!-- convert parameter to node-set -->
    <xsl:variable name="content.nav" select="ext:node-set($content)/nav" />

    <!-- bootstrap card component -->
    <nav class="card card-block">

      <!-- top-level nav links -->
      <ul class="nav">

        <!-- iterate over all nav links -->
        <xsl:for-each select="$content.nav/link">

          <!-- nav link -->
          <li class="nav-item">
            <a class="nav-link x2b-sdbr-lnk" href="{@href}">
              <xsl:value-of select="@title" />
            </a>
          </li>

        </xsl:for-each>

        <!-- iterate over all nav sections -->
        <xsl:for-each select="$content.nav/section">

          <!-- nav section -->
          <li class="x2b-sdbr-sctn">
            <xsl:value-of select="@title" />

            <!-- section nav links -->
            <ul class="nav">

              <!-- iterate over all nav links in section -->
              <xsl:for-each select="link">

                <!-- nav link inside section -->
                <li class="nav-item">
                  <a class="nav-link x2b-sdbr-lnk" href="{@href}">
                    <xsl:value-of select="@title" />
                  </a>
                </li>

              </xsl:for-each>

            </ul><!-- /section nav links -->

          </li>

        </xsl:for-each>

      </ul><!-- /top-level nav links -->

    </nav><!-- /card -->

  </xsl:template>

</xsl:stylesheet>
