<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei"
  >
  <xsl:variable name="lf">
    <xsl:text>&#10;</xsl:text>
  </xsl:variable>
  <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
  <xsl:template match="/">
    <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html></xsl:text>
    <xsl:value-of select="$lf"/>
    <html>
      <head>
        <title>Bibliographie, Denis de Rougemont</title>
        <style>
body {}
main {max-width: 90ex; margin-left: auto; margin-right:auto;}
small {font-family: sans-serif; color: #888; }
div.note{margin-left: 40px; color: #800000; }
div.TODO{margin-left: 40px; color:red;}
        </style>
      </head>
      <body>
        <main>
          <xsl:apply-templates select="/tei:TEI/tei:text/tei:body/*"/>
        </main>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="tei:listBibl">
    <xsl:apply-templates select="tei:head"/>
    <ul>
      <xsl:apply-templates select="tei:bibl|tei:listBibl"/>
    </ul>
  </xsl:template>
  <xsl:template match="tei:head">
    <h1>
      <xsl:apply-templates/>
    </h1>
  </xsl:template>
  <xsl:template match="tei:bibl">
    <li class="bibl">
      <xsl:apply-templates select="@xml:id|node()"/>
    </li>
  </xsl:template>
  <xsl:template match="tei:listBibl[count(*)=2][name(*[1])='bibl'][name(*[2])='listBibl']">
    <li>
      <div class="bibl">
        <xsl:apply-templates select="tei:bibl/@xml:id"/>
        <xsl:apply-templates select="tei:bibl/node()"/>
      </div>
      <xsl:apply-templates select="tei:listBibl"/>
    </li>
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
  <xsl:template match="tei:bibl/@xml:id">
    <small class="id">[<xsl:value-of select="."/>]</small>
    <xsl:text> </xsl:text>
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
  <xsl:template match="tei:ref">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="@target"/>
      </xsl:attribute>
      <xsl:text>fac-similé</xsl:text>
    </a>
  </xsl:template>
  <xsl:template match="tei:note">
    <div class="note">
      <xsl:text>!NOTE </xsl:text>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="*">
    <xsl:text>@</xsl:text>
    <xsl:value-of select="local-name()"/>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="tei:TODO">
    <div class="TODO">[???] <xsl:apply-templates/></div>
  </xsl:template>
  
</xsl:transform>