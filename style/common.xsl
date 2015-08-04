<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!--~~~~~~~~~~~~~~~~~~~~
         Date format
    ~~~~~~~~~~~~~~~~~~~~-->
<!-- will turn 2001-12-31 into 31.12.2001 -->

  <xsl:template name="format.date">
    <xsl:param name="date" /><!-- string (format 'YYYY-MM-DD') -->

    <xsl:variable name="year" select="substring-before($date, '-')" />
    <xsl:variable name="month" select="format-number(substring-before(substring-after($date, '-'), '-'), '00')" />
    <xsl:variable name="day" select="format-number(substring-after(substring-after($date, '-'), '-'), '0')" />

    <xsl:value-of select="concat($day, '.', $month, '.', $year)" />

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
       Filename format
    ~~~~~~~~~~~~~~~~~~~~-->
<!-- make string lowercase and mask special characters -->

  <xsl:template name="format.filename">
    <xsl:param name="string" /><!-- string -->

    <xsl:value-of select="translate($string, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ äöüÄÖÜ', 'abcdefghijklmnopqrstuvwxyz_aouaou')" />

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
        Copy contents
    ~~~~~~~~~~~~~~~~~~~~-->
<!-- helper for copying child element nodes and attributes (but no namespaces)
     from XML -->

  <xsl:template name="copy.content">
    <xsl:param name="content" /><!-- node-set -->

    <xsl:for-each select="$content/*">
      <xsl:element name="{name()}">
        <xsl:apply-templates select="node()|@*"/>
      </xsl:element>
    </xsl:for-each>

  </xsl:template>

  <xsl:template match="node()|@*" priority="-1">
    <xsl:copy />
  </xsl:template>

</xsl:stylesheet>
