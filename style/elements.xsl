<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">


<!--~~~~~~~~~~~~~~~~~~~~
         Breadcrumps
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="element.breadcrumps">
    <xsl:param name="parent" />
    <xsl:param name="current" />

    <!-- Convert parent parameter to node-set -->
    <xsl:variable name="parent.page" select="ext:node-set($parent)/page" />

    <!-- Bootstrap breadcrump component -->
    <ol class="breadcrumb">

      <li>
        <a href="/">Home</a>
      </li>

      <xsl:if test="$parent.page">
        <li>
          <a href="{$parent.page/@href}">
            <xsl:value-of select="$parent.page/@title" />
          </a>
        </li>
      </xsl:if>

      <li class="active">
        <xsl:value-of select="$current" />
      </li>

    </ol><!-- /breadcrump -->

  </xsl:template>


<!--~~~~~~~~~~~~~~~~~~~~
            Pager
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="element.pager">
    <xsl:param name="next" />
    <xsl:param name="prev" />

    <!-- Convert parameters to node-sets -->
    <xsl:variable name="next.page" select="ext:node-set($next)/page" />
    <xsl:variable name="prev.page" select="ext:node-set($prev)/page" />

    <!-- Check if there is a next page -->
    <xsl:variable name="next.disabled">
      <xsl:if test="not($next.page)"> disabled</xsl:if>
    </xsl:variable>

    <!-- Check if there is a previous page -->
    <xsl:variable name="prev.disabled">
      <xsl:if test="not($prev.page)"> disabled</xsl:if>
    </xsl:variable>

    <!-- Bootstrap pager component -->
    <nav>
      <ul class="pager">

        <li class="previous{$prev.disabled}">
          <xsl:choose>
            <xsl:when test="$prev.page">
              <a title="{$prev.page/@title}" href="{$prev.page/@href}">
                Previous
              </a>
            </xsl:when>
            <xsl:otherwise>
              <a>Previous</a>
            </xsl:otherwise>
          </xsl:choose>
        </li>

        <li class="next{$next.disabled}">
          <xsl:choose>
            <xsl:when test="$next.page">
              <a title="{$next.page/@title}" href="{$next.page/@href}">
                Next
              </a>
            </xsl:when>
            <xsl:otherwise>
              <a>Next</a>
            </xsl:otherwise>
          </xsl:choose>
        </li>

      </ul><!-- /pager -->
    </nav>

  </xsl:template>

</xsl:stylesheet>
