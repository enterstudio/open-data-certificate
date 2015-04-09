<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:local="#local"
	exclude-result-prefixes="xs local">

<xsl:strip-space elements="*"/>
<xsl:output method="text"/>

<xsl:template match="/">
	<xsl:apply-templates select="*">
		<xsl:with-param name="path" select="''" />
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="*">
	<xsl:param name="path" required="yes" />
	<xsl:variable name="path" select="concat($path, '/', position())" />
  <xsl:choose>
    <xsl:when test=".[not(text())]">
      <xsl:apply-templates select="@*|*">
        <xsl:with-param name="path" select="$path" />
      </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$path"/>
      <xsl:text>,</xsl:text>
      <xsl:text>"</xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>"</xsl:text>
      <xsl:text>&#10;</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="@display|@placeholder|@yes|@no">
	<xsl:param name="path" required="yes" />
  <xsl:value-of select="concat($path, '/@', local-name())"/>
  <xsl:text>,</xsl:text>
  <xsl:text>"</xsl:text>
  <xsl:value-of select="."/>
  <xsl:text>"</xsl:text>
  <xsl:text>&#10;</xsl:text>
</xsl:template>

<xsl:template match="@*|text()"/>

</xsl:stylesheet>
