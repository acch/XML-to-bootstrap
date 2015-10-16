<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">


<!--~~~~~~~~~~~~~~~~~~~~
       Export Options
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="options">

    <!-- generate javascript options -->
    <ext:document
      href="../js/options.json"
      method="text"
      omit-xml-declaration="yes"
      encoding="utf-8"
      indent="yes">var Options = {
<xsl:for-each select="/site/options/export[@type = 'js']/option">
  "<xsl:value-of select="@name" />": <xsl:value-of select="." /><xsl:choose>
    <xsl:when test="position() != last()">,</xsl:when>
  </xsl:choose>
</xsl:for-each>
};</ext:document>

  </xsl:template>

</xsl:stylesheet>
