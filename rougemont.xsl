<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei">
  <xsl:include href="https://erougemont.github.io/teinte_xsl/tei_html.xsl"/>
  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <meta name="modified" content="{$date}"/>
        <link rel="preconnect" href="https://fonts.googleapis.com"/>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="crossorigin"/>
        <link rel="stylesheet" media="all" onload="this.media='all'" href="https://fonts.googleapis.com/css2?family=EB+Garamond:ital@0;1&amp;family=Fira+Sans:ital,wght@0,300;0,400;0,500;1,300;1,400;1,500&amp;display=swap"/>

        <link rel="stylesheet" type="text/css" href="{$theme}teinte.css"/>
        <link rel="stylesheet" type="text/css" href="{$theme}teinte.layout.css"/>
        <link rel="stylesheet" type="text/css" href="{$theme}teinte.tree.css"/>
        <link rel="stylesheet" type="text/css" href="rougemont_html.css"/>
      </head>
      <body>
        <div class="container" id="viewport">
          <div id="text">
            <xsl:apply-templates select="/tei:TEI/*"/>
          </div>
          <aside id="sidebar">
            <xsl:call-template name="side-header"/>
            <nav>
              <xsl:call-template name="toc"/>
            </nav>
          </aside>
        </div>
        <script type="text/javascript" charset="utf-8" src="{$theme}teinte.tree.js">//</script>
      </body>
    </html>
  </xsl:template>
</xsl:transform>