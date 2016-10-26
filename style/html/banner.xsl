<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     Banner jumbotron
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     This file is part of XML-to-bootstrap.
     https://github.com/acch/XML-to-bootstrap

     Copyright 2016 Achim Christ
     Released under the MIT license
     (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- this template generates HTML code for the top banner jumbotron -->
  <xsl:template name="html.banner">
    <xsl:param name="title" /><!-- string -->
    <xsl:param name="subtitle" /><!-- string -->
    <xsl:param name="style" /><!-- string -->

    <!-- check if there is a custom style -->
    <xsl:variable name="style.class">
      <xsl:if test="$style">
        <xsl:text> </xsl:text>
        <xsl:value-of select="$style" />
      </xsl:if>
    </xsl:variable>

    <!-- Bootstrap jumbotron -->
    <header class="[ jumbotron jumbotron-fluid ] x2b-bnnr{$style.class}" role="banner">
      <div class="container">

        <!-- main title -->
        <h1 class="display-3 x2b-shdw">
          <xsl:value-of select="$title" />
        </h1>

        <!-- subtitle -->
        <p class="lead">
          <xsl:value-of select="$subtitle" />
        </p>

      </div><!-- /container -->
    </header>

  </xsl:template>

</xsl:stylesheet>
