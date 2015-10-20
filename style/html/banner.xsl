<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!--~~~~~~~~~~~~~~~~~~~~
      Banner jumbotron
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.banner">
    <xsl:param name="title" /><!-- string -->
    <xsl:param name="subtitle" /><!-- string -->
    <xsl:param name="style" /><!-- string -->

    <!-- check if there is a custom style -->
    <xsl:variable name="header.style">
      <xsl:if test="$style">
        <xsl:text> </xsl:text>
        <xsl:value-of select="$style" />
      </xsl:if>
    </xsl:variable>

    <header class="jumbotron{$header.style}">
      <div class="container">

        <h1>
          <xsl:value-of select="$title" />
        </h1>

        <p>
          <xsl:value-of select="$subtitle" />
        </p>

      </div><!-- /container -->
    </header><!-- /jumbotron -->

  </xsl:template>

</xsl:stylesheet>
