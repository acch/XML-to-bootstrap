<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="common.xsl" />
  <xsl:import href="html.xsl" />
  <xsl:import href="elements.xsl" />
  <xsl:import href="articles.xsl" />


  <!-- Index page -->
  <xsl:output
    method="xml"
    omit-xml-declaration="yes"
    encoding="utf-8"
    indent="yes" />


  <!-- Main Template -->
  <xsl:template match="/">

    <!-- Generate article pages -->
    <xsl:call-template name="articles" />

    <!-- Generate project pages -->
    <!--xsl:call-template name="projects" /-->

    <!-- Generate generic pages -->
    <!--xsl:call-template name="pages" /-->

  </xsl:template>

</xsl:stylesheet>
