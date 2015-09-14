<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Import all other templates -->
  <xsl:import href="common.xsl" />
  <xsl:import href="html.xsl" />
  <xsl:import href="elements.xsl" />
  <xsl:import href="home.xsl" />
  <xsl:import href="articles.xsl" />
  <!--xsl:import href="projects.xsl" /-->
  <!--xsl:import href="gallery.xsl" /-->


<!--~~~~~~~~~~~~~~~~~~~~
         Index page
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:output
    method="xml"
    omit-xml-declaration="yes"
    encoding="utf-8"
    indent="yes" />


<!--~~~~~~~~~~~~~~~~~~~~
        Main template
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template match="/">

    <!-- generate home page -->
    <xsl:call-template name="home" />

    <!-- generate article pages -->
    <xsl:call-template name="articles" />

    <!-- generate project pages -->
    <!--xsl:call-template name="projects" /-->

    <!-- generate gallery pages -->
    <!--xsl:call-template name="gallery" /-->

  </xsl:template>

</xsl:stylesheet>
