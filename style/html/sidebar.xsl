<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext">


<!--~~~~~~~~~~~~~~~~~~~~
        Sidebar panel
    ~~~~~~~~~~~~~~~~~~~~-->

  <xsl:template name="html.sidebar">
    <xsl:param name="content" /><!-- node-set (nav) -->

    <!-- convert parameter to node-set -->
    <xsl:variable name="content.nav" select="ext:node-set($content)/nav" />

    <!-- bootstrap panel component -->
    <div class="[ panel panel-default ]">
      <nav class="panel-body">

        <!-- sidebar nav links -->
        <ul class="nav">

          <!-- iterate over all nav links -->
          <xsl:for-each select="$content.nav/link">

            <li>
              <a class="x2b-sdbr-lnk" href="{@href}">
                <xsl:value-of select="@title" />
              </a>
            </li>

          </xsl:for-each>

          <!-- iterate over all nav sections -->
          <xsl:for-each select="$content.nav/section">

            <li class="x2b-sdbr-sctn">
              <xsl:value-of select="@title" />

              <!-- section nav links -->
              <ul class="nav">

                <!-- iterate over all nav links in section -->
                <xsl:for-each select="link">

                  <li>
                    <a class="x2b-sdbr-lnk" href="{@href}">
                      <xsl:value-of select="@title" />
                    </a>
                  </li>

                </xsl:for-each>

              </ul><!-- /section nav links -->

            </li>

          </xsl:for-each>

        </ul><!-- /sidebar nav links -->

      </nav><!-- /panel-body -->
    </div><!-- /panel -->

  </xsl:template>

</xsl:stylesheet>
