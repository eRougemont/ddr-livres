<?xml version="1.0" encoding="UTF-8"?>
<!--

LGPL  http://www.gnu.org/licenses/lgpl.html
© 2016 Frederic.Glorieux@fictif.org et LABEX OBVIL

XML TEI allégé, par exemple pièce de théâtre sans didascalies, ou critique sans citations
-->
<xsl:transform version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei"
  >
  <xsl:output omit-xml-declaration="yes" encoding="UTF-8" indent="yes" method="text"/>
  <xsl:variable name="lf" select="'&#10;'"/>
  <xsl:variable name="tab" select="'&#9;'"/>
  <xsl:template match="/">
    <xsl:text>id</xsl:text>
    <xsl:value-of select="$tab"/>
    <xsl:text>Année</xsl:text>
    <xsl:value-of select="$tab"/>
    <xsl:text>Type</xsl:text>
    <xsl:value-of select="$lf"/>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="tei:TEI | tei:text | tei:body | tei:listBibl">
    <xsl:apply-templates select="*"/>
  </xsl:template>
  <xsl:template match="tei:bibl[@xml:id]">
    <xsl:variable name="id" select="@xml:id"/>
    <xsl:value-of select="$id"/>
    <xsl:value-of select="$tab"/>
    <xsl:value-of select="substring($id, 5, 4)"/>
    <xsl:value-of select="$tab"/>
    <xsl:value-of select="@type"/>
    <xsl:value-of select="$lf"/>
  </xsl:template>
  <xsl:template match="tei:bibl"/>
  <xsl:template match="tei:head"/>
</xsl:transform>
  