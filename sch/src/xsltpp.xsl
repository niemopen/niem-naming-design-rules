<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Identity template: copy everything by default -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Template to resolve xsl:include -->
  <xsl:template match="xsl:include">
    <xsl:variable name="included-doc" select="document(@href)"/>
    <xsl:apply-templates select="$included-doc/xsl:stylesheet/node()"/>
  </xsl:template>

</xsl:stylesheet>
