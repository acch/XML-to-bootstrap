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
  <xsl:import href="projects.xsl" />
  <xsl:import href="galleries.xsl" />

  <xsl:import href="options.xsl" />


<!--~~~~~~~~~~~~~~~~~~~~~~
    Commandline parameters
    ~~~~~~~~~~~~~~~~~~~~~~-->

  <xsl:param name="articles" select="true()" />
  <xsl:param name="projects" select="true()" />
  <xsl:param name="galleries" select="true()" />


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
    <xsl:if test="$articles">
      <xsl:call-template name="articles" />
    </xsl:if>

    <!-- generate project pages -->
    <xsl:if test="$projects">
      <xsl:call-template name="projects" />
    </xsl:if>

    <!-- generate gallery pages -->
    <xsl:if test="$galleries">
      <xsl:call-template name="galleries" />
    </xsl:if>

    <!-- export options -->
    <xsl:call-template name="options" />

  </xsl:template>

</xsl:stylesheet>
