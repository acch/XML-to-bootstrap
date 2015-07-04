<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


  <!-- Breadcrumps for easier navigation -->
  <xsl:template name="element.breadcrumps">
    <xsl:param name="parent" />
    <xsl:param name="parent.href" />
    <xsl:param name="current" />

    <ol class="breadcrumb">
      <li>
        <a href="/">Home</a>
      </li>
      <xsl:if test="$parent">
        <li>
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="$parent.href" />
            </xsl:attribute>
            <xsl:value-of select="$parent" />
          </a>
        </li>
      </xsl:if>
      <li class="active">
        <xsl:value-of select="$current" />
      </li>
    </ol>

  </xsl:template>

</xsl:stylesheet>
