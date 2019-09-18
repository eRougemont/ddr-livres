<?xml version="1.0" encoding="UTF-8"?>
<!--

LGPL  http://www.gnu.org/licenses/lgpl.html
© 2016 Frederic.Glorieux@fictif.org et LABEX OBVIL

XML TEI allégé, par exemple pièce de théâtre sans didascalies, ou critique sans citations
-->
<xsl:transform version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei"
  >
  <xsl:output omit-xml-declaration="yes" encoding="UTF-8" indent="yes" method="html"/>
  <xsl:variable name="lf" select="'&#10;'"/>
  <xsl:variable name="tab" select="'&#9;'"/>
  <xsl:template match="/">
    <meta charset="UTF-8"/>
    <table>
      <thead>
        <tr>
          <th>id</th>
          <th>Année</th>
          <th>Journal</th>
          <th>Titre</th>
          <th>Type</th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates/>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="tei:TEI | tei:text | tei:body | tei:listBibl">
    <xsl:apply-templates select="*"/>
  </xsl:template>
  <xsl:template match="tei:bibl[@xml:id]">
    <xsl:variable name="id" select="@xml:id"/>
    <xsl:variable name="children" select="not(../@type)"/>
    <tr>
      <td>
        <xsl:value-of select="substring-before(concat($id, '_'), '_')"/>
      </td>
      <td>
        <xsl:value-of select="substring($id, 4, 4)"/>
      </td>
      <td>
        <xsl:value-of select="tei:title[@level='j'][1]"/>
      </td>
      <td>
        <xsl:value-of select="tei:title[1]"/>
      </td>
      
      <td>
        <xsl:choose>
          <xsl:when test="not($children)">
            <xsl:value-of select="@type"/>
          </xsl:when>
          <xsl:when test="../tei:listBibl//tei:bibl[@type='reprise']">
            <xsl:text>repris</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@type"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <!-- Rééditions -->
      <!--
      <td>
        <xsl:if test="$children">
          <xsl:value-of select="count(../tei:listBibl//tei:bibl)"/>
        </xsl:if>
      </td>
      -->
      <!-- traductions -->
      <!--
      <td>
        <xsl:if test="$children">
          <xsl:variable name="n">
            <xsl:value-of select="count(../tei:listBibl//tei:bibl[@xml:lang])"/>
          </xsl:variable>
          <xsl:if test="$n &gt; 0">
            <xsl:value-of select="$n"/>
          </xsl:if>
        </xsl:if>
      </td>
      -->
      <!--
      <td>
        <xsl:value-of select="tei:ref/@target"/>
      </td>
      <td>
        <xsl:variable name="txt">
          <xsl:apply-templates/>
        </xsl:variable>
        <xsl:value-of select="normalize-space($txt)"/>
      </td>
      <td>
        <xsl:value-of select="tei:note"/>
      </td>
      -->
    </tr>
    <xsl:value-of select="$lf"/>
  </xsl:template>
  <xsl:template match="tei:hi[@rend='sup']">
    <sup>
      <xsl:apply-templates/>
    </sup>
  </xsl:template>
  <xsl:template match="tei:hi[@rend='i']">
    <em>
      <xsl:apply-templates/>
    </em>
  </xsl:template>
  <xsl:template match="tei:hi">
    <i>
      <xsl:apply-templates/>
    </i>
  </xsl:template>
  <xsl:template match="tei:title">
    <i class="title">
      <xsl:attribute name="class">
        <xsl:text>title</xsl:text>
        <xsl:value-of select="@level"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </i>
  </xsl:template>
  <xsl:template match="tei:title[@level='a']">
    <span class="titlea">
      <xsl:text>« </xsl:text>
      <xsl:apply-templates/>
      <xsl:text> »</xsl:text>
    </span>
  </xsl:template>
  <xsl:template match="*">
    <xsl:text>@</xsl:text>
    <xsl:value-of select="local-name()"/>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="tei:ref"/>
  <xsl:template match="tei:bibl"/>
  <xsl:template match="tei:head"/>
  <xsl:template match="tei:note"/>
  <xsl:template match="tei:TODO"/>
</xsl:transform>
