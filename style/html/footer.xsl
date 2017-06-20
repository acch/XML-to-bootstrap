<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Page footer
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- this template generates HTML code for the page footer with social links
       and credits -->
  <xsl:template name="html.footer">

    <!-- spacing to main content -->
    <hr class="invisible [ my-4 py-5 ]" />

    <!-- generate social links -->
    <xsl:call-template name="html.sociallinks" />

    <!-- credits -->
    <footer role="contentinfo">

      <!-- centered -->
      <div class="text-center text-muted">

        <p class="my-0">Generated using <a href="//github.com/acch/XML-to-bootstrap#readme">XML-to-Bootstrap</a> for your viewing pleasure.</p>

        <p class="my-0">This site uses <a href="//www.bryanbraun.com/anchorjs/">AnchorJS</a>, <a href="//getbootstrap.com">Bootstrap</a>, <a href="//fontawesome.io">Font Awesome</a> and <a href="//wicky.nillia.ms/headroom.js/">Headroom.js</a>.</p>

      </div><!-- /centered -->

    </footer>

  </xsl:template>


  <!-- social links -->
  <xsl:template name="html.sociallinks">

    <!-- centered -->
    <div class="text-center">

      <!-- iterate over all social links -->
      <xsl:for-each select="/site/options/option[@name = 'footer.sociallinks']/link">
        <a class="x2b-alt-lnk">

          <!-- copy attributes from XML directly -->
          <xsl:copy-of select="@*" />

          <xsl:choose>
            <xsl:when test="icon">

              <!-- generate icon -->
              <xsl:call-template name="component.icon">
                <xsl:with-param name="icon" select="icon/@src" />
                <xsl:with-param name="size">fa-2x</xsl:with-param>
              </xsl:call-template>

            </xsl:when>
            <xsl:when test="img">

              <!-- generate (non-responsive) image -->
              <xsl:call-template name="component.image">
                <xsl:with-param name="img" select="img" />
              </xsl:call-template>

            </xsl:when>
            <xsl:when test="child::text()">

              <!-- copy text -->
              <span><xsl:copy-of select="child::text()" /></span>

            </xsl:when>
            <xsl:otherwise>

              <!-- copy any other child nodes -->
              <xsl:call-template name="copy.content">
                <xsl:with-param name="content" select="current()" />
              </xsl:call-template>

            </xsl:otherwise>
          </xsl:choose>

        </a>
      </xsl:for-each>

    </div><!-- /centered -->

  </xsl:template>

</xsl:stylesheet>
