<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!--~~~~~~~~~~~~~~~~~~~~
          Home page
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="home">

    <!-- generate home page -->
    <xsl:call-template name="html.page">
      <xsl:with-param name="title">Home</xsl:with-param>
      <xsl:with-param name="subtitle" select="/site/home/introduction" />
      <xsl:with-param name="content" select="/site/home" />
    </xsl:call-template>

  </xsl:template>

</xsl:stylesheet>
